package com.supermap.web.mapping
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.iServerJava2.mapServices.GetMapStatusParameters;
	import com.supermap.web.iServerJava2.mapServices.GetMapStatusResult;
	import com.supermap.web.iServerJava2.mapServices.GetMapStatusService;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.utils.ScaleUtil;
	import com.supermap.web.utils.Unit;
	
	import flash.display.Loader;
	import flash.net.URLRequest;
	
	import mx.rpc.AsyncResponder;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava2_DynamicIServerLayer_Title}.
	 * ${iServerJava2_DynamicIServerLayer_Description}
	 * @see #url 
	 * @see #mapName 
	 * 
	 * 
	 */	
	public class DynamicIServerLayer extends DynamicLayer
	{
		private var _subLayers:Array;
		private var _time:Date;
		private var _requestStatusCompleted:Boolean = false;
		private var _layersKey:String = "0";
		private var _mapServiceAddress:String;
		private var _mapServicePort:String;
		private var _mapStatusResult:GetMapStatusResult;
		private var _url:String;
		private var _urlRequest:URLRequest;
		private var _mapName:String;
		private var _urlChanged:Boolean;
		private var _mapNameChanged:Boolean;
		private var _mapServiceAddressChanged:Boolean;
		private var _mapServicePortChanged:Boolean;
		private var _layersKeyChanged:Boolean;
		

		/**
		 * ${iServerJava2_DynamicIServerLayer_constructor_None_D} 
		 * 
		 */		
		public function DynamicIServerLayer()
		{
			this._urlRequest = new URLRequest();
			this._time=new Date();
			this.isIServer2Layer = true;
		}	

		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override public function get isScaleCentric() : Boolean
		{
			return true;
		}
		
		
		/**
		 * ${iServerJava2_DynamicIServerLayer_layersKey_D}.
		 * ${iServerJava2_DynamicIServerLayer_layersKey_remarks_D} 
		 * @return 
		 * 
		 */		
		public function get layersKey():String
		{
			return this._layersKey ;
		}	
		public function set layersKey(value:String):void
		{
			if (value && value != "")
			{
				this._layersKey = value;		
				this._layersKeyChanged = true;
				invalidateProperties();
			}
		}
		
		//必设参数
		/**
		 * ${iServerJava2_DynamicIServerLayer_mapServiceAddress_D} 
		 * @return 
		 * 
		 */		
		public function get mapServiceAddress():String
		{
			return this._mapServiceAddress;
		}
		public function set mapServiceAddress(value:String):void
		{
			if (this._mapServiceAddress != value)
			{
				if (value && value != "")
				{
					this._mapServiceAddress = value;		
					this._requestStatusCompleted = false;
					this._mapServiceAddressChanged = true;
					invalidateProperties();
				}
			}
		}		
		
		/**
		 * ${iServerJava2_DynamicIServerLayer_mapServicePort_D} 
		 * @return 
		 * 
		 */		
		public function get mapServicePort():String
		{
			return this._mapServicePort;
		}
		public function set mapServicePort(value:String):void
		{
			if (this._mapServicePort != value)
			{
				if (value && value != "")
				{
					this._mapServicePort = value;		
					this._requestStatusCompleted = false;
					this._mapServicePortChanged = true;
					invalidateProperties();
				}
			}
		}	
		
			
		/**
		 * ${iServerJava2_DynamicIServerLayer_mapName_D} 
		 * @return 
		 * 
		 */		
		public function get mapName():String
		{
			return this._mapName;
		} 
		public function set mapName(value:String):void
		{
			if (this._mapName != value)
			{
				if (value && value != "")
				{
					this._mapName = value;		
					this._requestStatusCompleted = false;
					this._mapNameChanged = true;
					invalidateProperties();
				}
			}
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
					this._requestStatusCompleted = false;
					this._urlChanged = true;
					if(this._url.lastIndexOf("/") != this._url.length - 1)
					{
						this._url += "/";
					}
					invalidateProperties();
				}
					
			}
		}
		
		public override function refresh():void
		{	
			this._time = new Date();
			super.refresh();
		}

		
		//end 必设参数
		/**
		 * @private 
		 * 
		 */		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			if (this._urlChanged || this._mapNameChanged || this._mapServiceAddressChanged || this._mapServicePortChanged)
			{
				removeAllChildren();		
				this._urlChanged = false;
				this._mapNameChanged = false;
				this._mapServiceAddressChanged = false;
				this._mapServicePortChanged = false;
				setLoaded(false);
				this.loadIServiceInfo();
			}
			if(_layersKeyChanged)
			{		
				this._layersKeyChanged = false;
				this.invalidateLayer();
			}
		}
		
		/**
		 * @copy DynamicLayer#loadMapImage() 
		 * @param loader
		 * 
		 */		
		override protected function loadMapImage(loader:Loader) : void
		{
			if (this.resolution <= 0 || this.dpi == 0)
			{
				return;
			}	  	
			var width:Number = this.map.width;
			var height:Number = this.map.height;
			var centerX:Number = this.map.center.x;
			var centerY:Number = this.map.center.y;
			var scale:Number = ScaleUtil.resolutionToScale(this.resolution, this.dpi, null);
			var mapHandler:String="maphandler";
			var serverURL:String=this.url + mapHandler + "?mapName=" + encodeURI(this.mapName) + "&width=" + width + "&height=" + height 
				+ "&imageFormat=" + this.imageFormat + "&mapCenterX=" + centerX + "&mapCenterY=" + centerY + "&mapScale=" + scale + "&layersKey=" 
				+ this._layersKey + "&transparent=" + this.transparent + "&method=getImage&t=" + this._time.getTime();	
			this._urlRequest.url = serverURL;
			loader.load(this._urlRequest);
		}
		
		private function loadIServiceInfo():void
		{
			if (this._url && this._mapName && this._mapServiceAddress && this._mapServicePort && !_requestStatusCompleted)
			{
				var service:GetMapStatusService = new GetMapStatusService(this._url);
				var mapStatusParams:GetMapStatusParameters = new GetMapStatusParameters(this._mapName,this._mapServiceAddress,this._mapServicePort);		
				service.execute(new AsyncResponder(this.resultInfo, 
					function (object:Object, mark:Object = null) : void
					{
						dispatchEvent(new LayerEvent(LayerEvent.LOAD_ERROR, object as Layer));
					}
					, this._url), mapStatusParams);
			}
		}
		
		private function resultInfo(object:Object, mark:Object = null):void
		{
			if (mark == url)
			{
				_mapStatusResult = object as GetMapStatusResult;
				if (_mapStatusResult)
				{            
					// 初始化信息
					// -- 设置层的baounds
					this.bounds = _mapStatusResult.mapBounds;
					if(this.CRS == null || this.CRS.wkid <= 0)
					{
						this.CRS = new CoordinateReferenceSystem(_mapStatusResult.coordsSys.wkid, _mapStatusResult.coordsSys.unit);
					}
					this.dpi = ScaleUtil.getDpi2(_mapStatusResult.referViewBounds, _mapStatusResult.referViewer, _mapStatusResult.referScale);
					
					_requestStatusCompleted = true;  
								
					this.setLoaded(true);
					invalidateLayer();
				}
			}
		}

	}
}