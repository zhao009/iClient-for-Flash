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
	
	import flash.net.URLRequest;
	
	import mx.rpc.AsyncResponder;

	use namespace sm_internal;


	/**
	 * ${iServerJava2_TiledDynamicIServerLayer_Title}.
	 * ${iServerJava2_TiledDynamicIServerLayer_Description} 
	 * 
	 * 
	 */	
	public class TiledDynamicIServerLayer extends TiledDynamicLayer
	{
		private var _subLayers:Array;
		private var _time:Date;
		private var _requestStatusCompleted:Boolean = false;
		private var _layersKey:String = "0";
		private var _mapServiceAddress:String;
		private var _mapServicePort:String;
		private var _mapStatusResult:GetMapStatusResult;
		private var _url:String;
		private var _mapName:String;
		private var _urlChanged:Boolean;
		private var _mapNameChanged:Boolean;
		private var _mapServiceAddressChanged:Boolean;
		private var _mapServicePortChanged:Boolean;
		private var _layersKeyChanged:Boolean;
		

		/**
		 * ${iServerJava2_TiledDynamicIServerLayer_constructor_None_D} 
		 * 
		 */		
		public function TiledDynamicIServerLayer()
		{
			_time=new Date();
			this.isIServer2Layer = true;
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
		 * @copy DynamicIServerLayer#layersKey 
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
		 * @copy DynamicIServerLayer#mapServiceAddress  
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
		 * @copy DynamicIServerLayer#mapServicePort
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
		 * @copy DynamicIServerLayer#mapName 
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
			if (mark == this._url)
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
					if(!this.origin)
					{
						this.origin = new Point2D(this.bounds.left, this.bounds.top);
					}
					this.dpi = ScaleUtil.getDpi2(_mapStatusResult.referViewBounds, _mapStatusResult.referViewer, _mapStatusResult.referScale);
					_requestStatusCompleted = true;						
					this.setLoaded(true);
//					invalidateLayer();   layer加到map里面后会给它设置map 属性，那是也会调用此方法  袁林道  2011-6-8
				}
			}
		}	

		/**
		 * @copy TiledDynamicLayer#getTileURL() 
		 * @param row
		 * @param col
		 * @param resolution
		 * @return 
		 * 
		 */		
		protected override function getTileURL(row:int, col:int, resolution:Number):URLRequest
		{
			if (resolution <= 0 || this.dpi == 0)
			{
				return null;
			}	
			var scale:Number = ScaleUtil.resolutionToScale(resolution, this.dpi, null);
			var mapHandler:String="maphandler";
			var serverURL:String=this.url + mapHandler + "?mapName=" + encodeURI(this.mapName) + "&x=" + col + "&y=" + row 
				               + "&imageFormat=" + imageFormat + "&width=" + tileSize + "&height=" + tileSize + "&mapScale=" + scale + "&layersKey=" 
							   + this._layersKey + "&transparent=" + this.transparent + "&method=gettiledimage&t=" + this._time.getTime();	
			return new URLRequest(serverURL);
		}

	}
}