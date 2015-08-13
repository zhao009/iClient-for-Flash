package com.supermap.web.mapping
{
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.service.supportClasses.SmMapService;
	import com.supermap.web.service.supportClasses.SmMapServiceInfo;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.ScaleUtil;
	import com.supermap.web.utils.serverTypes.OverlapDisplayedOptions;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	import mx.events.PropertyChangeEvent;
	import mx.rpc.AsyncResponder;
	import mx.utils.StringUtil;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_TiledDynamicRESTLayer_Title}.
	 * <p>${iServerJava6R_TiledDynamicRESTLayer_Description}</p> 
	 * 
	 * 
	 */	
	public class TiledDynamicRESTLayer extends TiledDynamicLayer
	{
		private var _adjustFactor:Number = 1.0;
		private var _time:Date;
		private var _enableServerCaching:Boolean = true;
		private var _url:String;
		private var _urlChanged:Boolean;
		private var _mapService:SmMapService;
		private var _mapServiceInfo:SmMapServiceInfo;
		private var _requestStatusCompleted:Boolean;
		private var _layersID:String = "";
		private var _encodedUrl:String;
		private var _customServiceParams:Object;
		private var _maxVisibleVertex:int;
		private var _clipRegion:GeoRegion;
		
		private var _isDynamicPrj:Boolean;
		
		private var _overlapDisplayed:Boolean = true;
		private var _overlapDisplayedOptions:OverlapDisplayedOptions;
		private var _redirect:Boolean = false;
		
		
		/**
		 * ${iServerJava6R_TiledDynamicRESTLayer_constructor_None_D} 
		 * 
		 */		
		public function TiledDynamicRESTLayer()
		{
			this._time=new Date();
			this._maxVisibleVertex = int.MAX_VALUE;
		}
		
		/**
		 * ${mapping_TiledDynamicRESTLayer_attribute_redirect_D} 
		 * @return 
		 * 
		 */	
		public function get redirect():Boolean
		{
			return _redirect;
		}

		public function set redirect(value:Boolean):void
		{
			_redirect = value;
		}

		/**
		 * ${mapping_TiledDynamicRESTLayer_attribute_overlapDisplayed_D} 
		 * @return 
		 * 
		 */	
		public function get overlapDisplayed():Boolean
		{
			return _overlapDisplayed;
		}

		public function set overlapDisplayed(value:Boolean):void
		{
			_overlapDisplayed = value;
		}

		/**
		 * ${mapping_TiledDynamicRESTLayer_attribute_overlapDisplayedOptions_D} 
		 * @return 
		 * 
		 */	
		public function get overlapDisplayedOptions():OverlapDisplayedOptions
		{
			return _overlapDisplayedOptions;
		}

		public function set overlapDisplayedOptions(value:OverlapDisplayedOptions):void
		{
			_overlapDisplayedOptions = value;
		}

		/**
		 * ${mapping_TiledDynamicRESTLayer_attribute_maxVisibleVertex_D} 
		 * @return 
		 * 
		 */		
		public function get maxVisibleVertex():int
		{
			return _maxVisibleVertex;
		}

		public function set maxVisibleVertex(value:int):void
		{
			_maxVisibleVertex = value;
		}

		/**
		 * ${mapping_TiledDynamicRESTLayer_layersID_D}.
		 * <p>${mapping_TiledDynamicRESTLayer_layersID_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get layersID():String
		{
			return _layersID;
		}

		public function set layersID(value:String):void
		{
			_layersID = value;
		}

		/**
		 * @copy DynamicRESTLayer#adjustFactor 
		 * @return 
		 * 
		 */		
		public function get adjustFactor():Number
		{
			return _adjustFactor;
		}
		
		public function set adjustFactor(value:Number):void
		{
			_adjustFactor = value;
		}
		
		/**
		 * ${iServerJava6R_DynamicRESTLayer_customServiceParams_D}.
		 * <p>${iServerJava6R_DynamicRESTLayer_customServiceParams_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get customServiceParams():Object
		{
			if(!_customServiceParams)
			{
				_customServiceParams = new Object();
			}
			return _customServiceParams;
		}
		
		public function set customServiceParams(value:Object):void
		{
			if (this._customServiceParams is IEventDispatcher)
			{
				IEventDispatcher(this._customServiceParams).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.customServerParams_changeHandler);
			}
			this._customServiceParams = value;
			if (this._customServiceParams is IEventDispatcher)
			{
				IEventDispatcher(this._customServiceParams).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.customServerParams_changeHandler, false, 0, true);
			}
		}
		
		[Bindable]
		/**
		 * ${mapping_TiledDynamicRESTLayer_attribute_urls_D} 
		 * @return 
		 * 
		 */			
		public function get urls():Array
		{
			return this._urls;
		}
		public function set urls(value:Array):void
		{
			if(value == null)
			{
				this._urls= null;
				return;
			}
			
			this._urls = [];
			var length:int = value.length;
			var tempUrl:String = null;
			var tempencodedUrl:String = null;
			
			for (var i:int = 0; i < value.length; i++)
			{		
				if (value[i] && value[i] != "")
				{ 
					tempUrl = value[i];
					var markIndex:int = tempUrl.lastIndexOf("/");
					var preUrl:String = tempUrl.substr(0, markIndex + 1);
					var mapName:String = tempUrl.substr(markIndex + 1);
					tempencodedUrl = preUrl + encodeURI(mapName);
					
					if(tempUrl.lastIndexOf("/") != tempUrl.length - 1)
					{
						tempUrl += "/";
						tempencodedUrl += "/";
					}
					
					this._urls.push(tempencodedUrl);
					if(i==0)
					{
						this._url = tempUrl;
						this._encodedUrl = tempencodedUrl;	
					}
				}
			}
			
			this._requestStatusCompleted = false;
			this._urlChanged = true;
			invalidateProperties();
		}
		
		/**
		 * @copy DynamicRESTLayer#enableServerCaching 
		 * @return 
		 * 
		 */		
		public function get enableServerCaching():Boolean
		{
			return _enableServerCaching;
		}
		
		public function set enableServerCaching(value:Boolean):void
		{
			_enableServerCaching = value;
		}
		
		/**
		 * @copy Layer#isScaleCentric  
		 * @return 
		 * 
		 */		
		override public function get isScaleCentric() : Boolean
		{
			return true;
		}
		
		/**
		 * @copy Layer#url 
		 * @return 
		 * 
		 */		
		public override function get url():String
		{	
			return this._url;
		}
		
		public override function set url(value:String):void
		{
			if (this._url != value)
			{			
				if (value && value != "")
				{ 
					this._url = value;
					var markIndex:int = this.url.lastIndexOf("/");
					var preUrl:String = this.url.substr(0, markIndex + 1);
					var mapName:String = this.url.substr(markIndex + 1);
					this._encodedUrl = preUrl + encodeURI(mapName);
					
					if(this._url.lastIndexOf("/") != this._url.length - 1)
					{
						this._url += "/";
						this._encodedUrl += "/";
					}
					this._requestStatusCompleted = false;
					this._urlChanged = true;
					invalidateProperties();
				}
				
			}
		}
		
		/**
		 * ${mapping_TiledDynamicRESTLayer_attribute_clipRegion_D} 
		 * @return 
		 * 
		 */		
		public function get clipRegion():GeoRegion
		{
			return _clipRegion;
		}
		
		public function set clipRegion(value:GeoRegion):void
		{
			_clipRegion = value;
		}
	

		/**
		 * @inheritDoc 
		 * 
		 */		
		public override function refresh():void
		{	
			this._time = new Date();
			super.refresh();
		}
		
		/**
		 * @private 
		 * 
		 */		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			if (this._urlChanged)
			{
				removeAllChildren();		
				this._urlChanged = false;
				setLoaded(false);
				this.loadIServiceInfo();
			}
		}
		
		/**
		 * ${mapping_TiledDynamicRESTLayer_method_protected_getTileURL_D}
		 * @param row ${mapping_TiledDynamicRESTLayer_method_protected_getTileURL_param_row}
		 * @param col ${mapping_TiledDynamicRESTLayer_method_protected_getTileURL_param_col}
		 * @param resolution ${mapping_TiledDynamicRESTLayer_method_protected_getTileURL_param_resolution}
		 * @return ${mapping_TiledDynamicRESTLayer_method_protected_getTileURL_return}
		 * 
		 */		
		protected override function getTileURL(row:int, col:int, resolution:Number):URLRequest
		{		
			if (resolution <= 0 || this.dpi == 0)
			{
				return null;
			}	
			//this._time=new Date();
//			var tempResolution:Number = resolution * ((Math.PI*2*6378137)/360);
//			var scale:Number = 0.0254 / resolution / this.dpi;//3.779527559055118
//			var scale:Number = 1/(tempResolution*3.7785*1000);//0.37785
			
			var scale:Number;
			if(this.CRS)
				scale = ScaleUtil.resolutionToScale(resolution,this.dpi,this.CRS.unit,this.CRS.datumAxis);
			else
				scale = ScaleUtil.resolutionToScale(resolution,this.dpi);
			
			var tempUrl:String; 
			tempUrl = this._encodedUrl;
			if(this._urls && this._urls.length>0)
			{
				tempUrl = selectUrls(row,col);
			}
			
			var serverURL:String=tempUrl + "tileImage." + imageFormat.toLowerCase() + "?scale=" + scale + "&x=" + col + "&y=" + row 
				+ "&width=" + tileSize + "&height=" + tileSize  + "&layersID=" + this.layersID + "&transparent=" + this.transparent + "&t=" + this._time.getTime();
			if (!this.enableServerCaching)
			{
				serverURL += "&cacheEnabled=" + this.enableServerCaching;
			}
			if(this._customServiceParams)
			{
				for (var prop:String in this.customServiceParams) 
				{
					serverURL += ("&" + prop + "=" + this.customServiceParams[prop]);
				}
			} 
			if(this._clipRegion)
			{
				serverURL += "&clipRegionEnabled=True";
				serverURL += "&clipRegion=" + ServerGeometry.toJson(ServerGeometry.fromGeometry(this._clipRegion));
			}
			if (this.maxVisibleVertex != int.MAX_VALUE && this.maxVisibleVertex >= 0)
			{ 
				serverURL += ("&maxVisibleVertex=" + this.maxVisibleVertex);
			} 
			if (_isDynamicPrj)
			{
				serverURL +="&prjCoordSys={\"epsgCode\":" + this.CRS.wkid +"}";
			}
			if(this.origin)
			{
				serverURL +="&origin={\"x\":"+this.origin.x+","+"\"y\":"+this.origin.y+"}";
			}
			//不管overlapDisplayed设置为true还是false都会向服务端发送请求，服务端默认为false,即默认使用标签避让
			if(_overlapDisplayed) 
			{
				serverURL += "&overlapDisplayed=true";
			}
			else
			{
				serverURL += "&overlapDisplayed=false";
				if(this.overlapDisplayedOptions){
					serverURL += "&overlapDisplayedOptions="+ this.overlapDisplayedOptions.toString();
				}
			}
			if(this.redirect)
			{
				serverURL +="&redirect=true";
			}
			return new URLRequest(serverURL);
		}
		
		private function loadIServiceInfo():void
		{
			if (this._url && !_requestStatusCompleted)
			{
				var url:String;
				var index:int = this._url.length - 1;
				if(this._url.slice(index) == "/")
				{
					url = this._url.slice(0, index);
				}
				if(this._mapService == null)
				{
					this._mapService = new SmMapService(url);
				}
				
				if(this.CRS && this.CRS.wkid>0)
				{
					//当 CRS 存在，且 WKID 大于0，则认为需要进行动态投影
					_isDynamicPrj = true;
					this._mapService.execute(new AsyncResponder(this.resultInfo, 
						function (object:Object, mark:Object = null) : void
						{
							dispatchEvent(new LayerEvent(LayerEvent.LOAD_ERROR, object as Layer));
						}
						, this._url),this.CRS.wkid);
				}
				else
					this._mapService.execute(new AsyncResponder(this.resultInfo, 
						function (object:Object, mark:Object = null) : void
						{
							dispatchEvent(new LayerEvent(LayerEvent.LOAD_ERROR, object as Layer));
						}
						, this._url),-1000);
			}
			
			if(this.hasOwnProperty("offlineStorage")  && this["offlineStorage"])
			{
				var settings:Object = this["offlineStorage"].getSettings();
				if(settings){
					var strBounds:String = StringUtil.trim(settings.bounds);
					strBounds = strBounds.slice(1, strBounds.length - 1);
					var aryBounds:Array = strBounds.split(",");
					var layerBounds:Rectangle2D = new Rectangle2D(aryBounds[0], aryBounds[1], aryBounds[2], aryBounds[3]);
					this.bounds = layerBounds;
					this.CRS = null;
					this.CRS = new CoordinateReferenceSystem(settings.wkid, settings.unit, settings.datumAxis);
					
					if(!this.origin)
						this.origin = new Point2D(this.bounds.left, this.bounds.top);
					
					this.dpi = settings.dpi;
					
					this.setLoaded(true);
					invalidateLayer(); 
				}
			}
		}
		
		private function resultInfo(object:Object, mark:Object = null):void
		{
			if (mark == url)
			{
				this._mapServiceInfo = object as SmMapServiceInfo;
				if (_mapServiceInfo)
				{            
					this.bounds = this._mapServiceInfo.bounds;
						this.CRS = null;
						this.CRS = new CoordinateReferenceSystem(this._mapServiceInfo.prjCoordSys.epsgCode, this._mapServiceInfo.prjCoordSys.coordUnit);//epsgCode默认为0，unit默认为degree	
						if(this._mapServiceInfo.prjCoordSys.coordSystem)
						{
							if(this._mapServiceInfo.prjCoordSys.coordSystem.datum)
							{
								if(this._mapServiceInfo.prjCoordSys.coordSystem.datum.spheroid)
								{
									this.CRS.datumAxis = this._mapServiceInfo.prjCoordSys.coordSystem.datum.spheroid.axis;//默认0
								}
							}
						}
					if(!this.origin)
					{
						this.origin = new Point2D(this.bounds.left, this.bounds.top);
					}
					
					this.dpi = ScaleUtil.getDpi(this._mapServiceInfo.viewBounds, this._mapServiceInfo.viewer, this._mapServiceInfo.scale, this.CRS.datumAxis) * adjustFactor;
					_requestStatusCompleted = true;
					if(this.hasOwnProperty("offlineStorage")  && this["offlineStorage"])
						this["offlineStorage"].putSettings(this.bounds, this.CRS.wkid, this.CRS.unit, this.CRS.datumAxis, this.origin, this.dpi);
					
					this.setLoaded(true);
					
					var visScales:Array = null;
					visScales = _mapServiceInfo.visibleScales;
					// 当用户未设置scales，visibleScales存在值、visibleScalesEnable为true时,使layer.scales=visibleScales。
					if(this.map && !this.map.scales && _mapServiceInfo.visibleScalesEnabled && (visScales &&visScales.length&&visScales.length>0))
					{
						this.map.scales=visScales;
					}
					invalidateLayer(); 
				}
			}
		}	
		
		private function customServerParams_changeHandler(event:Event) : void
		{		
			this.invalidateLayer();			
		}
		
	}
}