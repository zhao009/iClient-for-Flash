package com.supermap.web.mapping
{
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.core.Credential;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.service.supportClasses.SmMapService;
	import com.supermap.web.service.supportClasses.SmMapServiceInfo;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	import com.supermap.web.utils.ScaleUtil;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	import mx.events.PropertyChangeEvent;
	import mx.rpc.AsyncResponder;
	
	use namespace sm_internal;

	/**
	 * ${iServerJava6R_DynamicRESTLayer_Title}.
	 * <p>${iServerJava6R_DynamicRESTLayer_Description}</p>
	 * 
	 * 
	 */	
	public class DynamicRESTLayer extends DynamicLayer
	{
		private var _adjustFactor:Number = 1.0;
		private var _time:Date;
		private var _enableServerCaching:Boolean = true;
		private var _url:String;
		private var _urlRequest:URLRequest;
		private var _urlChanged:Boolean;
		private var _mapService:SmMapService;
		private var _mapServiceInfo:SmMapServiceInfo;
		private var _requestStatusCompleted:Boolean;
		private var _encodedUrl:String;
		private var _customServiceParams:Object;
		private var _layersID:String = "";
		private var _clipRegion:GeoRegion;
		
		private var _maxVisibleVertex:int;
		private var  _isDynamicPrj:Boolean;
		/**
		 * ${iServerJava6R_DynamicRESTLayer_constructor_None_D} 
		 * 
		 */		
		public function DynamicRESTLayer()
		{
			this._urlRequest = new URLRequest();
			this._time=new Date();
			this.maxVisibleVertex = int.MAX_VALUE;
		}
		
		/**
		 * ${iServerJava6R_DynamicRESTLayer_layersID_D}.
		 * <p>${iServerJava6R_DynamicRESTLayer_layersID_remarks}</p> 
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
		 * ${iServerJava6R_DynamicRESTLayer_attribute_maxVisibleVertex_D} 
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
		 * ${iServerJava6R_DynamicRESTLayer_adjustFactor_D}
		 * @default 1.0
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
		
		/**
		 * ${iServerJava6R_DynamicRESTLayer_enableServerCaching_D} 
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
					super.url = value;
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
		 * ${iServerJava6R_DynamicRESTLayer_attribute_clipRegion_D} 
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
		 * @copy DynamicLayer#loadMapImage() 
		 * @param loader
		 * 
		 */		
		override protected function loadMapImage(loader:Loader) : void
		{
			if (this.resolution <= 0)
			{
				return;
			}
			//this._time = new Date();
			var viewBounds:String = JsonUtil.fromRectangle2D(this.map.viewBounds);
			var width:Number = this.map.width;
			var height:Number = this.map.height;
	
			var serverURL:String=this._encodedUrl + "image." + this.imageFormat + "?viewBounds=" + viewBounds + "&width=" + width + 
				"&height=" + height + "&layersID=" + this.layersID + "&transparent=" + this.transparent + "&t=" + this._time.getTime();	
			if (!this.enableServerCaching)
			{
				serverURL += ("&cacheEnabled=" + this.enableServerCaching.toString().toLowerCase());
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
			if(this.maxVisibleVertex != int.MAX_VALUE && this.maxVisibleVertex > 0)
			{
		    	serverURL += ("&maxVisibleVertex=" + this.maxVisibleVertex); 
			} 
			if(_isDynamicPrj)
			{
				serverURL +="&prjCoordSys={\"epsgCode\":" + this.CRS.wkid +"}";
			}
			if(Credential.CREDENTIAL)
			{
				serverURL += "&" + Credential.CREDENTIAL.getUrlParameters();
			}
			this._urlRequest.url = serverURL;
			loader.load(this._urlRequest);
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
						, this._url));
			}
		}
		
		private function resultInfo(object:Object, mark:Object = null):void
		{
			if (mark == url)
			{
				this._mapServiceInfo = object as SmMapServiceInfo;
				if (_mapServiceInfo)
				{            
					// 初始化信息
					// -- 设置层的baounds
					this.bounds = this._mapServiceInfo.bounds;	
					
//					if(!this.CRS || _flag)
//					{
//						if(this.CRS && this.CRS.wkid>0)
//							_isDynamicPrj = true;
						
						this.CRS = null;
						this.CRS= new CoordinateReferenceSystem(this._mapServiceInfo.prjCoordSys.epsgCode, this._mapServiceInfo.prjCoordSys.coordUnit);	
						
//						if(noDynamicPrj)
//							_flag =false;
						
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
//					}
					this.dpi = ScaleUtil.getDpi(this._mapServiceInfo.viewBounds, this._mapServiceInfo.viewer, this._mapServiceInfo.scale, this.CRS.datumAxis) * adjustFactor;	
					_requestStatusCompleted = true;  
					this.setLoaded(true);
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