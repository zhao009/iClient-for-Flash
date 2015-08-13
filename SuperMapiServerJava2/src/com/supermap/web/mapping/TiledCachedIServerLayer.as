package com.supermap.web.mapping
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.iServerJava2.mapServices.GetMapStatusParameters;
	import com.supermap.web.iServerJava2.mapServices.GetMapStatusResult;
	import com.supermap.web.iServerJava2.mapServices.GetMapStatusService;
	import com.supermap.web.mapping.ImageFormat;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.utils.ScaleUtil;
	import com.supermap.web.utils.Unit;
	
	import flash.net.URLRequest;
	
	import mx.rpc.AsyncResponder;

	use namespace sm_internal;


	/**
	 * ${iServerJava2_TiledCachedIServerLayer_Title}.
	 * ${iServerJava2_TiledCachedIServerLayer_Description} 
	 * 
	 * 
	 */	
	public class TiledCachedIServerLayer extends TiledCachedLayer
	{
		private var _mapStatusResult:GetMapStatusResult;
		private var _requestStatusCompleted:Boolean = false;
		private var _cachedUrl:String;
		private var _mapServiceAddress:String;
		private var _mapServicePort:String;
		private var _url:String;
		private var _mapName:String;
		private var _cachedUrlChanged:Boolean;
		private var _urlChanged:Boolean;
		private var _mapNameChanged:Boolean;
		private var _mapServiceAddressChanged:Boolean;
		private var _mapServicePortChanged:Boolean;
		
		
		/**
		 * ${iServerJava2_TiledCachedIServerLayer_constructor_None_D} 
		 * 
		 */		
		public function TiledCachedIServerLayer()
		{
			this.isIServer2Layer = true;
		}
		
		//必设参数
		/**
		 * ${iServerJava2_TiledCachedIServerLayer_cachedUrl_D} 
		 * @return 
		 * 
		 */		
		public function get cachedUrl():String
		{
			return this._cachedUrl;
		}
		public function set cachedUrl(value:String):void
		{
			if (this._cachedUrl != value)
			{
				if (value && value != "")
				{
					this._cachedUrl = value;		
					this._requestStatusCompleted = false;
					this._cachedUrlChanged = true;
					if(this._cachedUrl.lastIndexOf("/") != this._cachedUrl.length - 1)
					{
						this._cachedUrl += "/";
					}
					invalidateProperties();
				}
			}
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
					invalidateProperties();
				}
				
			}
		}	
		//end 必设参数
		
		/**
		 *@private 
		 * 
		 */		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			if (this._cachedUrlChanged || this._urlChanged || this._mapNameChanged || this._mapServiceAddressChanged || this._mapServicePortChanged)
			{
				removeAllChildren();	
				this._cachedUrlChanged = false;
				this._urlChanged = false;
				this._mapNameChanged = false;
				this._mapServiceAddressChanged = false;
				this._mapServicePortChanged = false;
				setLoaded(false);
				this.loadIServiceInfo();
			}
		}
		
		private function loadIServiceInfo():void
		{
			if (this._cachedUrl && this._url && this._mapName && this._mapServiceAddress && this._mapServicePort && !_requestStatusCompleted)
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
					if(!this.origin)
					{
						this.origin = new Point2D(this.bounds.left, this.bounds.top);
					}
					this.dpi = ScaleUtil.getDpi2(_mapStatusResult.referViewBounds, _mapStatusResult.referViewer, _mapStatusResult.referScale);
	                _requestStatusCompleted = true;
	 //          		dispatchEvent(new LayerEvent(LayerEvent.STATUS_INFO_LOADED, this));   
	           		
	           		//获得dpi后，根据scales计算resolutions
					if(this.dpi != 0)
					{
						this.resolutions = ScaleUtil.scalesToResolutions(this.scales, this.dpi, null);
					}		
					this.setLoaded(true);
					invalidateLayer();
		        }
		    }
		}
		
			
		/**
		 * @copy TiledCachedLayer#getTileURL() 
		 * @param row
		 * @param col
		 * @param level
		 * @return 
		 * 
		 */		
		protected override function getTileURL(row:int, col:int, level:int):URLRequest
		{
			if (level < 0)
			{
				return null;
			}
			var serverURL:String;
			var scale:Number;
			
			if(this.cacheOutputScales && this.cacheOutputScales.length)
				scale =  this.cacheOutputScales[level];
			else
			{
				scale =  scales[level];
				if(scale <= 0)
				{
					return null;
				}
				
				scale = Math.round(1.0 / scale);   //iserver2需要传scale:1的格式
			}
			
			serverURL = this._cachedUrl +  encodeURI(this.mapName) + "_" + tileSize + "x" + tileSize + "/" + scale + "/" + col + "/" + row + "." + imageFormat;	
		
			return new URLRequest(serverURL);
		}
	}
}