package com.supermap.web.mapping
{
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.events.CloudLayerEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.serialization.json.*;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLRequest;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	use namespace sm_internal;
	
	
	/**
	 * @private
	 */	
	[Event(name="keyError", type="com.supermap.web.events.CloudLayerEvent")]
	
	/**
	 * @private
	 */	
	[Event(name="keySuccess", type="com.supermap.web.events.CloudLayerEvent")]
	
	/**
	 * ${mapping_CloudLayer_Title}.
	 * <p>${mapping_CloudLayer_Description}</p> 
	 * @see #levels
	 * 
	 */	
	public class CloudLayer extends TiledCachedLayer
	{				
		private var _cachedUrl:String;			
		private var _urlChanged:Boolean = false;
		private var _key:String = "";
		private var _keyChanged:Boolean = false;
		private var _url:String = "";
		private const urlOrigin:String = "http://www.supermapcloud.com";
		private var _cacheUrl:String = "http://t1.supermapcloud.com/FileService/image";
		private var _mapName:String = "quanguo";
		private var _mapNameChanged:Boolean = false;
		//private var _resolutionsChanged:Boolean = false;
		//private var _scalesChanged:Boolean = false;
		private var defaultLen:int;
		private var _type:String = "web";
		private var _levels:Array;
		
		//sm_internal var defaultScales:Array = [470000000, 235000000,117500000, 58750000, 29375000, 14687500, 7343750, 3671875,  1835937, 917968, 458984, 229492, 114746, 57373, 28686, 14343, 7171, 3585, 1792];
		//sm_internal var defaultResolutions:Array = [156697.2575744, 78348.6287872, 39174.3143936, 19587.1571968, 9793.5785984, 4896.7892992, 2448.3946496, 1224.1973248, 612.0986624, 306.0493312, 153.0246656, 76.5123328, 38.2561664, 19.1280832, 9.5640416, 4.7820208, 2.3910104, 1.1955052, 0.5977526];
		
		//第19级分辨率为0.298817952474，但由于绝大部分城市和地区在此级别都无图，所以暂不增加
		sm_internal var defaultResolutions:Array =[156543.033928041, 78271.5169640203, 39135.7584820102,
			19567.8792410051, 9783.93962050254, 4891.96981025127, 2445.98490512563,
			1222.99245256282, 611.496226281409, 305.748113140704, 152.874056570352,
			76.4370282851761, 38.218514142588, 19.109257071294, 9.55462853564701,
			4.77731426782351, 2.38865713391175, 1.19432856695588, 0.597164283477938];
		sm_internal var cloudUrl:String = ""; 
		
		/**
		 * ${mapping_CloudLayer_constructor_None_D} 
		 * 
		 */		
		public function CloudLayer()
		{
			this.tileSize = 256;
			this.url = urlOrigin;
			this._resolutions = defaultResolutions;
			//this._scales = defaultScales;
			//defaultLen = defaultScales.length;
		}
		
		/**
		 * ${mapping_CloudLayer_attribute_levels_D} 
		 * @return 
		 * 
		 */		
		public function get levels():Array
		{
			return _levels;
		}
		
		public function set levels(value:Array):void
		{
			if(value)
			{
				_levels = value;
				var tempRes:Array = new Array();
				for(var i:int; i<value.length; i++)
				{
					var j:int = value[i];
					tempRes.push(defaultResolutions[j]);
				}
				this._resolutions = tempRes;
			}
		}
		
		/**
		 * ${mapping_CloudLayer_attribute_cacheUrl_D} 
		 * @return 
		 * 
		 */		
		public function get cacheUrl():String
		{
			return _cacheUrl;
		}
		
		public function set cacheUrl(value:String):void
		{
			_cacheUrl = value;
		}
		
		/**
		 * ${mapping_CloudLayer_attribute_MapName_D} 
		 * @return 
		 * 
		 */		
		public function get mapName():String
		{
			return _mapName;
		}
		
		/**
		 * ${mapping_CloudLayer_attribute_url_D} 
		 * @return 
		 * @see #key
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
					this._urlChanged = true;
					invalidateProperties();
				}				
			}
			if(!this._urlChanged)//如果用户没有设置那么 直接用默认的url
			{
				this._urlChanged = true;					
				invalidateProperties();
			}
		}	
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			if (this._urlChanged || this._mapNameChanged)
			{
				removeAllChildren();				
				
				if(this._url)
				{
					if(this._url.indexOf("http") >= 0)
					{
						cloudUrl = this._url + "/iserver/api?key=";
					}
					else
					{
						cloudUrl = "http://" + this._url + "/iserver/api?key=";
					}	
				}
				_cachedUrl = this._cacheUrl + "?";
				
				if(this._urlChanged)
					this._urlChanged = false;
				if(this._mapNameChanged)
					this._mapNameChanged = false;
			}
			
			isHasKeyHandler();
		}
		
		private function isHasKeyHandler():void
		{		
			resultInfo();
		}
		
		private function retrunKeyFaultHandler(event:FaultEvent):void
		{
			//throw new SmError(SmResource.CLOUD_URL_ERROR);//120511byzyn
		}
		
		private function resultInfo():void
		{	    
			this.bounds = new Rectangle2D(-2.00375083427892E7,-2.00375083427892E7,2.00375083427892E7,2.00375083427892E7);				
			this.origin = new Point2D(this.bounds.left, this.bounds.top);
			this.CRS = new CoordinateReferenceSystem(0, "meter");
			this.setLoaded(true);
			//map.resolutions = this._resolutions;
			
			// ICL-694 云地图初始化完成后，第一次调用map zoom相关方法，在缩放动画前，重绘了一次图层，造成了两次刷新，屏蔽下面的代码解决此问题
			// invalidateLayer();
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		protected override function getTileURL(row:int, col:int, level:int):URLRequest
		{
			if (level < 0)
			{
				return null;
			}
			var finalLevel:int;
			if(_levels)
				finalLevel = _levels[level];
			else
				finalLevel = level;
			var serverURL:String = this._cachedUrl + "map=" + this._mapName + "&type=" + this._type + "&x=" + col + "&y=" + row + "&z=" + finalLevel;
			return new URLRequest(serverURL);
		}
		
		sm_internal function getCachedUrl():String
		{
			return _cachedUrl;
		}
	}
}