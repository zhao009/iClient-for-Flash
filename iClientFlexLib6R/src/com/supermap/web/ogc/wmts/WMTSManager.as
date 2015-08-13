package com.supermap.web.ogc.wmts
{
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.mapping.TiledWMTSLayer;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;

	[Event(name="getData", type="com.supermap.web.events.WMTSResultEvent")]	
	[Event(name="processComplete", type="com.supermap.web.events.WMTSResultEvent")]
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${mapping_OGC_WMTSManager_Title}.
	 * <p>${mapping_OGC_WMTSManager_Description}</p> 
	 * @see com.supermap.web.ogc.wmts.GetWMTSCapabilities
	 * 
	 */	
	public class WMTSManager extends GetWMTSCapabilities
	{
		private var wmtsLayer:TiledWMTSLayer;
		
		/**
		 * ${mapping_OGC_WMTSManager_constructor_string_D} 
		 * @param layer ${mapping_OGC_WMTSManager_constructor_string_param_layer}
		 * 
		 */		
		public function WMTSManager(layer:TiledWMTSLayer = null)
		{
			wmtsLayer = layer;
			url = layer.url;
//			super();
		}
		
		/**
		 * ${mapping_OGC_WMTSManager_method_getWMTSCapabilities_D}
		 * @param responseData ${mapping_OGC_WMTSManager_method_getWMTSCapabilities_param_responseData}
		 * @return ${mapping_OGC_WMTSManager_method_getWMTSCapabilities_return}
		 * 
		 */		
		override protected function getWMTSCapabilities(responseData:XML):WMTSCapabilitiesResult
		{
			var wmtsManagerResult:WMTSManagerResult = new WMTSManagerResult();
			
			var ns:Namespace = new Namespace("http://www.opengis.net/wmts/1.0");
			default xml namespace = ns;
			var gml:Namespace = new Namespace(responseData.namespace("gml"));
			var ows:Namespace = new Namespace(responseData.namespace("ows"));
			var xlink:Namespace = new Namespace(responseData.namespace("xlink"));
			var xsi:Namespace = new Namespace(responseData.namespace("xsi"));			
			
			var layerList:XMLList = responseData.Contents.Layer;
			var layerListLen:int = layerList.length();
			//图层信息
			for(var i:int = 0; i < layerListLen; i++)
			{
				var xmlChild:XML = layerList[i] as XML;	
				
				var lowerCorner:String = xmlChild.ows::WGS84BoundingBox.ows::LowerCorner; 	
				var upperCorner:String = xmlChild.ows::WGS84BoundingBox.ows::UpperCorner;
				
				
				var identifier:String = xmlChild.ows::Identifier;
				
				if(identifier == this.wmtsLayer.layerName)
				{
					var wmtsLayerInfo:WMTSLayerInfo = new WMTSLayerInfo();
					wmtsLayerInfo.bounds = getWGS84BoundingBox(lowerCorner, upperCorner);				
					wmtsLayerInfo.name = identifier;
					wmtsManagerResult.wmtsLayerInfo = wmtsLayerInfo;
				}			
			}
			
			var tileMatrixSetList:XMLList = responseData.Contents.TileMatrixSet;
			var tileMatrixSetListLen:int = tileMatrixSetList.length();
			//矩阵集信息
			for(var j:int = 0; j < tileMatrixSetListLen; j++)
			{
				var xmlTileChild:XML = tileMatrixSetList[j] as XML;	
				
				var name:String = xmlTileChild.ows::Identifier;				
				if(name == this.wmtsLayer.tileMatrixSet)
				{
					var wellKnownScaleSet:String = xmlTileChild.WellKnownScaleSet;
					var supportedCRS:String = xmlTileChild.ows::SupportedCRS;
					var wkids:Array = supportedCRS.split(":");
					var wkid:int = wkids[wkids.length - 1];
					
					var tileMatrixSetInfo:WMTSTileMatrixSetInfo = new WMTSTileMatrixSetInfo();
					tileMatrixSetInfo.name = name;
					tileMatrixSetInfo.supportedCRS = new CoordinateReferenceSystem(wkid);
					tileMatrixSetInfo.wellKnownScaleSet = wellKnownScaleSet;
					tileMatrixSetInfo.tileMatrixs = [];
					
					var tileMatrixList:XMLList = xmlTileChild.TileMatrix;
					var tileMatrixListLen:int = tileMatrixList.length();
					//矩阵信息
					for(var k:int = 0; k < tileMatrixListLen; k++)
					{					
						var tileMatrixXML:XML = tileMatrixList[k] as XML;
						
						var identifierTile:String = tileMatrixXML.ows::Identifier;
						var topLeft:String = tileMatrixXML.TopLeftCorner;
						var pts:Array = topLeft.split(" ");
						var topLeftCorner:Point2D = new Point2D(pts[0], pts[1]);
						
						var tileMatrix:TileMatrix = new TileMatrix();
						tileMatrix.name = identifierTile;
						tileMatrix.scaleDenominator = tileMatrixXML.ScaleDenominator;
						tileMatrix.topLeftCorner = topLeftCorner;
						tileMatrix.tileWidth = tileMatrixXML.TileWidth;
						tileMatrix.tileHeight = tileMatrixXML.TileHeight;
						tileMatrix.matrixWidth = tileMatrixXML.MatrixWidth;
						tileMatrix.matrixHeight = tileMatrixXML.MatrixHeight;
						
						tileMatrixSetInfo.tileMatrixs.push(tileMatrix);
					}
					wmtsManagerResult.wmtsTileMatrixSetInfo = tileMatrixSetInfo;
				}
				else
				{
					//trace("false");
				}
			}			
			return wmtsManagerResult;
		}
		
		override protected function faultHandler(event:FaultEvent,asyncToken:AsyncToken):void
		{
			dispatchEvent(event);
		}
	}
	
}