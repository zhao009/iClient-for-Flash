package com.supermap.web.ogc.wmts
{
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.core.Credential;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.events.WMTSResultEvent;
	import com.supermap.web.resources.SmResource;
	
	import flash.events.EventDispatcher;
	
	import mx.resources.ResourceManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	/**
	 * ${mapping_OGC_GetWMTSCapabilities_Title}.
	 * <p>${mapping_OGC_GetWMTSCapabilities_Description}</p> 
	 * 
	 */	
	public class GetWMTSCapabilities extends EventDispatcher
	{
		private var _url:String;
		private var _version:String = "1.0.0";
		private var _requestEncoding:String = RequestEncoding.REST;

		/**
		 * ${mapping_OGC_GetWMTSCapabilities_constructor_string_D} 
		 * @param url ${mapping_OGC_GetWMTSCapabilities_constructor_string_param_url}
		 * 
		 */		
		public function GetWMTSCapabilities(url:String = "")
		{			
			this._url = url;
		}

		/**
		 * ${mapping_OGC_GetWMTSCapabilities_attribute_requestEncoding_D} 
		 * @return 
		 * 
		 */		
		public function get requestEncoding():String
		{
			return _requestEncoding;
		}

		public function set requestEncoding(value:String):void
		{
			_requestEncoding = value;
		}

		/**
		 * ${mapping_OGC_GetWMTSCapabilities_attribute_version_D} 
		 * @return 
		 * 
		 */		
		public function get version():String
		{
			return _version;
		}

		public function set version(value:String):void
		{
			_version = value;
		}

		/**
		 * ${mapping_OGC_GetWMTSCapabilities_attribute_url_D} 
		 * @return 
		 * 
		 */		
		public function get url():String
		{
			return _url;
		}

		public function set url(value:String):void
		{
			_url = value;
		}

		/**
		 * ${mapping_OGC_GetWMTSCapabilities_method_ProcessAsync_D} 
		 * 
		 */	
		public function ProcessAsync(responder:IResponder = null):void
		{
			var asyncToken:AsyncToken;
			asyncToken = new AsyncToken(null);
			if (responder)
			{
				asyncToken.addResponder(responder);
			}
			
			if(this._url && this._url.lastIndexOf("/") == (this._url.length - 1) )
			{
				this._url.substr(0, this._url.length - 2);
			}
			var urlEncoding:String = "";
			if(this._requestEncoding == RequestEncoding.REST)
			{
				urlEncoding += "?SERVICE=WMTS";
				urlEncoding += ("&VERSION=" + this._version);
				urlEncoding += "&REQUEST=GetCapabilities";
				
			}
			else if(this._requestEncoding == RequestEncoding.KVP)
			{
				urlEncoding += ("/" + this._version);
				urlEncoding += "/WMTSCapabilities.xml" ;				
			}
			if(Credential.CREDENTIAL)
			{
				urlEncoding += "&" + Credential.CREDENTIAL.getUrlParameters();
			}
			this._url += urlEncoding;
			var httpService:HTTPService = new HTTPService();
			httpService.url = this._url;
			httpService.resultFormat="e4x";

			var httpServiceAsyncToken:AsyncToken = httpService.send();
			httpServiceAsyncToken.addResponder(new Responder(
				function (event:ResultEvent) : void
				{
					getResponseValuesHandler(event, asyncToken);
				}
				,
				function (event:FaultEvent) : void
				{
					faultHandler(event, asyncToken);
				}
			));
		}
		
		//返回数据成功
		
		private function getResponseValuesHandler(event:ResultEvent,asyncToken:AsyncToken):void
		{
			if(event.result == "")
			{
				this.handleStringError(ResourceManager.getInstance().getString("SuperMapMessage",SmResource.RESULT_NULL), asyncToken);
			}
			else
			{
				var wmtCapResult:WMTSCapabilitiesResult = getWMTSCapabilities(event.result as XML);
				var responder:IResponder;
				for each (responder in asyncToken.responders)
				{
					responder.result(wmtCapResult);
				}
				
				dispatchEvent(new WMTSResultEvent(WMTSResultEvent.GET_DATA, wmtCapResult));
				dispatchEvent(new WMTSResultEvent(WMTSResultEvent.PROCESS_COMPLETE, wmtCapResult));
				
			}
		}

		private function handleStringError(errorString:String, asyncToken:AsyncToken) : void
		{
			var responder:IResponder;
			var fault:Fault = new Fault(null, errorString);
			if(asyncToken)
			{
				for each (responder in asyncToken.responders)
				{
					responder.fault(fault);
				}
			}
			dispatchEvent(new FaultEvent(FaultEvent.FAULT, false, true, fault));
		}

		/**
		 * ${mapping_OGC_GetWMTSCapabilities_method_getWMTSCapabilities_D} 
		 * @param responseData ${mapping_OGC_GetWMTSCapabilities_method_getWMTSCapabilities_param_responseData}
		 * @return ${mapping_OGC_GetWMTSCapabilities_method_getWMTSCapabilities_return}
		 * 
		 */		
		protected function getWMTSCapabilities(responseData:XML):WMTSCapabilitiesResult
		{
			var wmtsCapabilitiesResult:WMTSCapabilitiesResult = new WMTSCapabilitiesResult();
			
			var ns:Namespace = new Namespace("http://www.opengis.net/wmts/1.0");
			default xml namespace = ns;
			
			var gml:Namespace = new Namespace(responseData.namespace("gml"));
			var ows:Namespace = new Namespace(responseData.namespace("ows"));
			var xlink:Namespace = new Namespace(responseData.namespace("xlink"));
			var xsi:Namespace = new Namespace(responseData.namespace("xsi"));
			
			var version:String = responseData.@version;
			wmtsCapabilitiesResult.version = version;
			wmtsCapabilitiesResult.layerInfos = [];
			var layerList:XMLList = responseData.Contents.Layer;
			var layerListLen:int = layerList.length();
			//图层信息 
			for(var i:int = 0; i < layerListLen; i++)
			{
				var xmlChild:XML = layerList[i] as XML;	
				
				var lowerCorner:String = xmlChild.ows::WGS84BoundingBox.ows::LowerCorner; 	
				var upperCorner:String = xmlChild.ows::WGS84BoundingBox.ows::UpperCorner;
				
				var wmtsLayerInfo:WMTSLayerInfo = new WMTSLayerInfo();
				wmtsLayerInfo.bounds = getWGS84BoundingBox(lowerCorner, upperCorner);
				wmtsLayerInfo.imageFormat = xmlChild.Format;
				wmtsLayerInfo.name = xmlChild.ows::Identifier;
				wmtsLayerInfo.style = xmlChild.Style.ows::Identifier;
				wmtsLayerInfo.tileMatrixSetLinks = [];
				
				var tileMatrixList:XMLList = xmlChild.TileMatrixSetLink;
				var tileMatrixLen:int = tileMatrixList.length();
				for(var k:int = 0; k < tileMatrixLen; k++)
				{
					var tileMatrixXML:XML =  tileMatrixList[k] as XML;
					var tileMatrixSet:String = tileMatrixXML.TileMatrixSet;
					
					var tileMatrixSetLinks:TileMatrixSetLink = new TileMatrixSetLink();
					tileMatrixSetLinks.tileMatrixSet = tileMatrixSet;
					tileMatrixSetLinks.tileMatrixSetLimits =[];
					var linkLimitXML:XMLList = tileMatrixXML.TileMatrixSetLimits.TileMatrixLimits;
					if(linkLimitXML && linkLimitXML.length())
					{
						var linkLimitXMLLen:int = linkLimitXML.length();
						for(var m:int = 0; m < linkLimitXMLLen; m++)
						{
							var limitXML:XML = linkLimitXML[m] as XML;
							var tileMatrixLimits:TileMatrixLimits = new TileMatrixLimits();
							tileMatrixLimits.maxTileCol = limitXML.MaxTileCol;
							tileMatrixLimits.maxTileRow = limitXML.MaxTileRow;
							tileMatrixLimits.minTileCol = limitXML.MinTileCol;
							tileMatrixLimits.minTileRow = limitXML.MinTileRow;
							tileMatrixLimits.tileMatrixName = limitXML.TileMatrix;
							
							tileMatrixSetLinks.tileMatrixSetLimits.push(tileMatrixLimits);
						}						
					}
					wmtsLayerInfo.tileMatrixSetLinks.push(tileMatrixSetLinks);
				}	
				//var tileMatrixSetLimits:Array = xmlChild.TileMatrixSetLink.TileMatrixSetLimits;
				wmtsCapabilitiesResult.layerInfos.push(wmtsLayerInfo);	
				
			}
			
			var tileMatrixSetList:XMLList = responseData.Contents.TileMatrixSet;
			var tileMatrixSetListLen:int = tileMatrixSetList.length();
			wmtsCapabilitiesResult.WMTSTileMatrixSetInfos = [];
			//矩阵集信息
			for(var j:int = 0; j < tileMatrixSetListLen; j++)
			{
				var xmlTileChild:XML = tileMatrixSetList[j] as XML;	
				
				var name:String = xmlTileChild.ows::Identifier; 	
				var wellKnownScaleSet:String = xmlTileChild.WellKnownScaleSet;
				var supportedCRS:String = xmlTileChild.ows::SupportedCRS;
				var wkids:Array = supportedCRS.split(":");
				var wkid:int = wkids[wkids.length - 1];
				
				var tileMatrixSetInfo:WMTSTileMatrixSetInfo = new WMTSTileMatrixSetInfo();
				tileMatrixSetInfo.name = name;
				tileMatrixSetInfo.supportedCRS = new CoordinateReferenceSystem(wkid);
				tileMatrixSetInfo.wellKnownScaleSet = wellKnownScaleSet;
				tileMatrixSetInfo.tileMatrixs = [];
				
				var tileMatrixs:XMLList = tileMatrixSetList.TileMatrix;
				var tileMatrixListLen:int = tileMatrixs.length();
				//矩阵信息
				for(var n:int = 0; n < tileMatrixListLen; n++)
				{					
					var matrixXML:XML = tileMatrixs[n] as XML;
					
					var identifier:String = matrixXML.ows::Identifier;
					var topLeft:String = matrixXML.TopLeftCorner;
					var pts:Array = topLeft.split(" ");
					var topLeftCorner:Point2D = new Point2D(pts[0], pts[1]);
					
					var tileMatrix:TileMatrix = new TileMatrix();
					tileMatrix.name = identifier;
					tileMatrix.scaleDenominator = matrixXML.ScaleDenominator;
					tileMatrix.topLeftCorner = topLeftCorner;
					tileMatrix.tileWidth = matrixXML.TileWidth;
					tileMatrix.tileHeight = matrixXML.TileHeight;
					tileMatrix.matrixWidth = matrixXML.MatrixWidth;
					tileMatrix.matrixHeight = matrixXML.MatrixHeight;
					
					tileMatrixSetInfo.tileMatrixs.push(tileMatrix);
				}			
				
				wmtsCapabilitiesResult.WMTSTileMatrixSetInfos.push(tileMatrixSetInfo);
			}
			
			return wmtsCapabilitiesResult;
		}
		
		//TODO:返回数据失败
		protected function faultHandler(event:FaultEvent,asyncToken:AsyncToken):void
		{			
			var responder:IResponder = null;
			for each (responder in asyncToken.responders)
			{	
				responder.fault(event);
			}
			dispatchEvent(event);
		}
		
		/**
		 * ${mapping_OGC_GetWMTSCapabilities_method_getWGS84BoundingBox_D} 
		 * @param lowerCorner ${mapping_OGC_GetWMTSCapabilities_method_getWGS84BoundingBox_param_lowerCorner}
		 * @param upperCorner ${mapping_OGC_GetWMTSCapabilities_method_getWGS84BoundingBox_param_upperCorner}
		 * @return ${mapping_OGC_GetWMTSCapabilities_method_getWGS84BoundingBox_return}
		 * 
		 */		
		protected function getWGS84BoundingBox(lowerCorner:String, upperCorner:String):Rectangle2D
		{
			var rect:Rectangle2D;
			if(lowerCorner == "" || upperCorner == "")
			{
				rect = new Rectangle2D();			
			}
			else
			{
				var leftBottom:Array = lowerCorner.split(" ");
				var rightTop:Array = upperCorner.split(" ");
				rect = new Rectangle2D(leftBottom[0], leftBottom[1], rightTop[0], rightTop[1]);				
			}
			return rect;
		}		
	}
}