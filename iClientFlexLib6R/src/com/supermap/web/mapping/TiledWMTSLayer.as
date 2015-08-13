package com.supermap.web.mapping
{	
	import com.supermap.web.core.Point2D;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.ogc.wmts.*;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.MathUtil;
	use namespace sm_internal;
	
	import flash.net.URLRequest;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.events.WMTSResultEvent;
	import com.supermap.web.core.Rectangle2D;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.core.INavigatorContent;
	
	/**
	 * ${mapping_TiledWMTSLayer_Title}.
	 * <p>${mapping_TiledWMTSLayer_Description}</p> 
	 * @see #bounds
	 * @see #resolutions
	 * 
	 */	
	public class TiledWMTSLayer extends TiledCachedLayer
	{
		private var _url:String;
		private var urlChanged:Boolean = false;
		private var _layerName:String;
		private var _style:String;
		private var _tileMatrixSet:String;
		private var _format:String = "image/png";
		private var _requestEncoding:String = RequestEncoding.REST;// KVP && REST
		private var _enableGetCapabilities:Boolean = true;
//		private var _tileMatrixNameHeader:String = "";
		private var _version:String = "1.0.0";	
		private var _tileMatrixIdentifiers:Array;
		private var _tempScales:Array;
		private var _wellKnownScaleSet:String;
//		private var _bBox:Rectangle2D;
		sm_internal var wmtsManager:WMTSManager;
		
		private var preGlobalCRS84ScaleRes:Array = [1.25764139776733,0.628820698883665,0.251528279553466,
			0.125764139776733,0.0628820698883665,0.0251528279553466,0.0125764139776733,0.00628820698883665,
			0.00251528279553466,0.00125764139776733,0.000628820698883665,0.000251528279553466,	
			0.000125764139776733,0.0000628820698883665,0.0000251528279553466,0.0000125764139776733,
			0.00000628820698883665,0.00000251528279553466,0.00000125764139776733,0.000000628820698883665,0.000000251528279553466];
		private var preDefGlobalCRS84Scales:Array = [500000000,250000000,100000000,50000000,25000000,10000000,5000000,2500000,1000000,500000,
			250000,100000,50000,25000,10000,5000,2500,1000,500,250,100];
		
		private var preDefResPixel:Array = [240000, 120000, 60000, 40000, 20000, 10000, 4000, 2000, 1000, 500, 166, 100, 33, 16, 10, 3, 1, 0.33 ];		
		private var preDefResPixelScales:Array = [795139219.9519541, 397569609.9759771 , 198784804.9879885, 132523203.3253257 , 
			66261601.66266284, 33130800.83133142, 13252320.33253257, 6626160.166266284, 3313080.083133142, 1656540.041566571,
			552180.0138555236, 331308.0083133142, 110436.0027711047, 55218.00138555237, 33130.80083133142, 11043.60027711047, 
			3313.080083133142, 1104.360027711047];		
		
		private var preDefGoogleCRS84Quad:Array = [1.40625000000000,0.703125000000000,0.351562500000000,0.175781250000000,
			0.0878906250000000,0.0439453125000000,0.0219726562500000,0.0109863281250000,0.00549316406250000,0.00274658203125000,
			0.00137329101562500,0.000686645507812500,0.000343322753906250,0.000171661376953125,0.0000858306884765625,
			0.0000429153442382812,	0.0000214576721191406,0.0000107288360595703,0.00000536441802978516];
		private var preDefGoogleCRS84QuadScales:Array = [559082264.0287178,279541132.0143589,139770566.0071794,69885283.00358972,
			34942641.50179486,17471320.75089743,8735660.375448715,4367830.187724357,2183915.093862179,1091957.546931089,545978.7734655447,
			272989.3867327723,136494.6933663862,68247.34668319309,34123.67334159654,17061.83667079827,8530.918335399136,4265.459167699568,
			2132.729583849784 ];
		
		private var preDefGoogleMapsCompatible:Array = [156543.0339280410,78271.51696402048,39135.75848201023,19567.87924100512,
			9783.939620502561,4891.969810251280,2445.984905125640,1222.992452562820,611.4962262814100,305.7481131407048,
			152.8740565703525,76.43702828517624,38.21851414258813,19.10925707129406,9.554628535647032,4.777314267823516,
			2.388657133911758,1.194328566955879,0.5971642834779395];
		private var preDefGoogleMapsCompatibleScales:Array = [559082264.0287178,279541132.0143589,139770566.0071794,69885283.00358972,
			34942641.50179486,17471320.75089743,8735660.375448715,4367830.187724357,2183915.093862179,1091957.546931089,545978.7734655447,
			272989.3867327723,136494.6933663862,68247.34668319309,34123.67334159654,17061.83667079827,8530.918335399136,4265.459167699568,
			2132.729583849784];
		
		private var chinaWmtsScales:Array = [295829355.45,147914677.73,73957338.86,36978669.43,18489334.72,9244667.36,4622333.68,2311166.84,
			1155583.42,577791.71,288895.85,144447.93,72223.96,36111.98,18055.99,9028.00,4514.00,2257.00,1128.50,564.25];
		private var chinaWmtsResolutionsInMeter:Array = [78271.52,39135.76,19567.88,9783.94,4891.97,2445.98,1222.99,611.50,305.75,152.87,
			76.44,38.22,19.11,9.55,4.78,2.39,1.19,0.60,0.2986,0.1493];
	
		/**
		 * ${mapping_TiledWMTSLayer_constructor_D} 
		 * 
		 */		
		public function TiledWMTSLayer()
		{
		}
		
		/**
		 * ${mapping_TiledWMTSLayer_attribute_wellKownScaleSet_D}.
		 * <p>${mapping_TiledWMTSLayer_attribute_wellKownScaleSet_remarks}</p> 
		 * @return 
		 * @see #tileMatrixSet
		 * @see #enableGetCapabilities
		 * 
		 */		
		public function get wellKnownScaleSet():String
		{
			return _wellKnownScaleSet;
		}

		public function set wellKnownScaleSet(value:String):void
		{
			_wellKnownScaleSet = value;
		}

		/**
		 * ${mapping_TiledWMTSLayer_attribute_tileMatrixIdentifiers_D}.
		 * <p>${mapping_TiledWMTSLayer_attribute_tileMatrixIdentifiers_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get tileMatrixIdentifiers():Array
		{
			return _tileMatrixIdentifiers;
		}

		public function set tileMatrixIdentifiers(value:Array):void
		{
			_tileMatrixIdentifiers = value;
		}

		/**
		 * ${mapping_TiledWMTSLayer_attribute_url_D}
		 * @return 
		 * 
		 */		
		override public function get url():String
		{
			return this._url;				
		}
		
		override public function set url(value:String):void
		{
			if(this.url !== value && value)
			{
				this._url = value;
				urlChanged = true;				
				invalidateProperties();				
			}
		}
		
		/**
		 * ${mapping_TiledWMTSLayer_attribute_url_D}
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
			
			for (var i:int = 0; i < value.length; i++)
			{		
				if (value[i] && value[i] != "")
				{ 
					tempUrl = value[i];
					
					this._urls.push(tempUrl);
					if(i==0)
					{
						this._url = tempUrl;
					}
				}
			}
			
			urlChanged = true;				
			invalidateProperties();		
		}
		
		/**
		 * @private 
		 * 
		 */		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(urlChanged)
			{
				urlChanged = false;
//				this.setLoaded(true);
				init();	
			}			
		}		
		
		private function init():void
		{
			this.tileSize = 256;
			if(this.enableGetCapabilities)
			{				
				wmtsManager = new WMTSManager(this);
				wmtsManager.ProcessAsync();
				wmtsManager.addEventListener(WMTSResultEvent.GET_DATA, resultInfo);		
				wmtsManager.addEventListener(FaultEvent.FAULT, showErrorHandler);
			}
			else
			{	
				if((!this.bounds) || (this.bounds.width == 0 && this.bounds.height == 0))
				{
					this.bounds = new Rectangle2D(-180, -90, 180, 90);				
				}
				this.addEventListener(LayerEvent.LOADED, layerLoadHandler);
				this.setLoaded(true);
			}
		}
		
		private function layerLoadHandler(event:LayerEvent):void
		{
			this.resolutions = this.map.resolutions;//设置map的时候 这里为null 需要修改
			if((!this.bounds) || (this.bounds.width == 0 && this.bounds.height == 0))
			{
				this.bounds = new Rectangle2D(-180, -90, 180, 90);				
			}
			if(!this.origin)
			{
				this.origin = new Point2D(this.bounds.left, this.bounds.top);
			}
			
//			invalidateLayer();	
		}

		private var _tileMetrixIdentifiers:Array = new Array;
		private var _tileMetrixScales:Array = new Array;
		//获取图层信息：分辨率数组、地理范围、起始点坐标、坐标系统
		private function resultInfo(event:WMTSResultEvent):void
		{
			if(wmtsManager.hasEventListener(WMTSResultEvent.GET_DATA))
			{
				wmtsManager.removeEventListener(WMTSResultEvent.GET_DATA, resultInfo);
			}
			var wmtsManagerResult:WMTSManagerResult = event.wmtsCapabilitiesResult as WMTSManagerResult;
			if(wmtsManagerResult)
			{
				var count:int;
				if(wmtsManagerResult.wmtsTileMatrixSetInfo)
				{
					if(wmtsManagerResult.wmtsTileMatrixSetInfo.tileMatrixs)
						count = wmtsManagerResult.wmtsTileMatrixSetInfo.tileMatrixs.length;
				}
				//从TileMetrix中获取比例尺和标识信息
				if(count>0)
				{
					for(var j:int = 0; j < count; j++)
					{
						_tileMetrixIdentifiers.push((wmtsManagerResult.wmtsTileMatrixSetInfo.tileMatrixs[j] as TileMatrix).name);
						_tileMetrixScales.push((wmtsManagerResult.wmtsTileMatrixSetInfo.tileMatrixs[j] as TileMatrix).scaleDenominator);
					}
				}
				else
					return;
				
				if((!this.wellKnownScaleSet) || this.wellKnownScaleSet.length == 0)
				{
					if(wmtsManagerResult.wmtsTileMatrixSetInfo.wellKnownScaleSet)
					{
						this.wellKnownScaleSet = wmtsManagerResult.wmtsTileMatrixSetInfo.wellKnownScaleSet;
					}
				}
				this.getResolutionsAndScales(this.wellKnownScaleSet);
					
				
				if(!this.origin)
				{
					this.origin = new Point2D(this.bounds.left, this.bounds.top);
				}
				this.CRS = wmtsManagerResult.wmtsTileMatrixSetInfo.supportedCRS;
			}
			this.setLoaded(true);//获取到图层信息后可设置图层已加载完毕 by zyn
		}
		
		//OGC的标准不使用indexOf()?????????????????????????????????????????????
		private function getResolutionsAndScales(tempWellKnownScaleSet:String):void
		{
			var tempWKSSLow:String;
			if(tempWellKnownScaleSet)
				tempWKSSLow =tempWellKnownScaleSet.toLocaleLowerCase();
			
			if(tempWKSSLow == "globalcrs84scale")
			{
				this.resolutions = preGlobalCRS84ScaleRes;		
				_tempScales = preDefGlobalCRS84Scales;
				if((!this.bounds) || (this.bounds.width == 0 && this.bounds.height == 0))
					this.bounds = new Rectangle2D(-180,-90,180,90);
			}
			else if(tempWKSSLow == "globalcrs84pixel")
			{
				this.resolutions = preDefResPixel;
				_tempScales = this.preDefResPixelScales;
				if((!this.bounds) || (this.bounds.width == 0 && this.bounds.height == 0))
					this.bounds = new Rectangle2D(-180,-90,180,90);
			}
			else if(tempWKSSLow == "googlecrs84quad")
			{
				this.resolutions = preDefGoogleCRS84Quad;
				_tempScales = this.preDefGoogleCRS84QuadScales;
				if((!this.bounds) || (this.bounds.width == 0 && this.bounds.height == 0))
					this.bounds = new Rectangle2D(-180,-90,180,90);
			}
			else if(tempWKSSLow == "googlemapscompatible")
			{
				this.resolutions = preDefGoogleMapsCompatible;
				_tempScales = this.preDefGoogleMapsCompatibleScales;
				if((!this.bounds) || (this.bounds.width == 0 && this.bounds.height == 0))
					this.bounds = new Rectangle2D(-20037508.3427892,-20037508.3427892,20037508.3427892,20037508.3427892);
			}
			else
			{
				//国标 else if(tempWellKnownScaleSet == "custom" || tempWellKnownScaleSet.toLowerCase().indexOf("custom") >= 0)
				if(!this.resolutions)
				{
					this.resolutions = [0.7031249999891485,0.35156249999999994,0.17578124999999997,
						0.08789062500000014,0.04394531250000007,0.021972656250000007,0.01098632812500002,
						0.00549316406250001,0.0027465820312500017,0.0013732910156250009,0.000686645507812499,
						0.0003433227539062495,0.00017166137695312503,0.00008583068847656251,0.000042915344238281406,
						0.000021457672119140645,0.000010728836059570307,0.000005364418029785169,0.000002682210361715995,
						0.0000013411051808579975];//resInDegree;
					_tempScales = this.chinaWmtsScales;
					if((!this.bounds) || (this.bounds.width == 0 && this.bounds.height == 0))
						this.bounds = new Rectangle2D(-180,-90,180,90);
				}
				else
				{
					_tempScales = _tileMetrixScales;
					if((!this.bounds) || (this.bounds.width == 0 && this.bounds.height == 0))
						this.bounds = new Rectangle2D(-180,-90,180,90);
				}
			}
		}

		private function showErrorHandler(event:FaultEvent):void
		{
			var resultFault:Fault = new Fault(null, event.message as String);			
			dispatchEvent(new FaultEvent(FaultEvent.FAULT, false, true, resultFault));
		}
		
		/**
		 * @inheritDoc 
		 * @param row
		 * @param col
		 * @param level
		 * @return 
		 * 
		 */		
		protected override function getTileURL(row:int, col:int, level:int):URLRequest
		{			
			var serverURL:String = "";
			
			var tempUrl:String; 
			tempUrl = this.url;
			var tileFormat:String;
			
			if( -1 != this.format.lastIndexOf("/"))
			{
				tileFormat = this.format.split('/')[1];
			}
			else
			{
				tileFormat = this.format;
			}
			if(this._urls && this._urls.length>0)
			{
				tempUrl = selectUrls(row,col);
			}
			
			if(this.tileMatrixIdentifiers && this.tileMatrixIdentifiers.length)
			{
				if(this._requestEncoding == RequestEncoding.KVP)
				{
					serverURL = tempUrl + "?SERVICE=WMTS" + "&REQUEST=GetTile" + "&VERSION=" + this.version + "&LAYER=" + this.layerName + "&STYLE=" + this.style + "&TILEMATRIXSET=" + this.tileMatrixSet + 	"&TILEMATRIX=" + this.findMatrixLevel(level) + "&TILEROW=" + row + "&TILECOL=" + col + "&FORMAT=" + this.format;
				}
				else if(this._requestEncoding == RequestEncoding.REST)
				{
					serverURL = tempUrl + "/" + this.layerName + "/" + this.style + "/" + this.tileMatrixSet + "/" +  this.findMatrixLevel(level) + "/" + row + "/" + col + "." + tileFormat;
				}
			}
			else
			{
				if(this._requestEncoding == RequestEncoding.KVP)
				{
					serverURL = tempUrl + "?SERVICE=WMTS" + "&REQUEST=GetTile" + "&VERSION=" + this.version + "&LAYER=" + this.layerName + "&STYLE=" + this.style + "&TILEMATRIXSET=" + this.tileMatrixSet + "&TILEMATRIX=" + this.findMatrixLevel(level) + "&TILEROW=" + row + "&TILECOL=" + col + "&FORMAT=" + this.format;
				}
				else if(this._requestEncoding == RequestEncoding.REST)
				{
					serverURL = tempUrl + "/" + this.layerName + "/" + this.style + "/" + this.tileMatrixSet + "/" +  this.findMatrixLevel(level) + "/" + row + "/" + col + "." + tileFormat;
				}				
			}						
			return new URLRequest(encodeURI(serverURL));
		}			

		sm_internal function findMatrixLevel(level:int):String
		{
			if(this.enableGetCapabilities)
			{
				if(_tempScales && _tempScales.length>0)
				{
					for(var i:int; i<_tileMetrixScales.length; i++)
					{
						//判断整数相等，即认为约等，这样的精度是否可以满足？？？？？？？
						//Math.floor(_tempScales[level]）== Math.floor(_tileMetrixScales[i])
						var tempNum1:Number = Math.floor(_tempScales[level]);
						var tempNum2:Number = Math.floor(_tileMetrixScales[i]);
						
						if(tempNum1==tempNum2)
						{
							var curIdentifier:String = _tileMetrixIdentifiers[i];
							if(this.tileMatrixIdentifiers && this.tileMatrixIdentifiers.length)
							{
								for each(var str:String in tileMatrixIdentifiers)
								{
									if(curIdentifier == str)
										return curIdentifier;
								}
							}
							else
								return curIdentifier;
						}
					}
				}
			}
			else if(this.resolutions && this.tileMatrixIdentifiers)
			{
				return tileMatrixIdentifiers[level];
			}
			
			return "";
		}

		/**
		 * ${mapping_TiledWMTSLayer_attribute_version_D} 
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
		 * ${mapping_TiledWMTSLayer_attribute_tileMatrixNameHeader_D} 
		 * @return 
		 * 
		 */		
//		public function get tileMatrixNameHeader():String
//		{
//			return _tileMatrixNameHeader;
//		}
//
//		public function set tileMatrixNameHeader(value:String):void
//		{
//			_tileMatrixNameHeader = value;
//		}

		/**
		 * ${mapping_TiledWMTSLayer_attribute_enableGetCapabilities_D}.
		 * <p>${mapping_TiledWMTSLayer_attribute_enableGetCapabilities_remarks}</p> 
		 * @see #tileMatrixIdentifiers
		 * @return 
		 * 
		 */		
		public function get enableGetCapabilities():Boolean
		{
			return _enableGetCapabilities;
		}

		public function set enableGetCapabilities(value:Boolean):void
		{
			_enableGetCapabilities = value;
		}

		/**
		 * ${mapping_TiledWMTSLayer_attribute_requestEncoding_D}
		 * @see com.supermap.web.mapping.OGC.WMTS.RequestEncoding 
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

		//supermap iserver 只支持png
		/**
		 * ${mapping_TiledWMTSLayer_attribute_format_D} 
		 * @return 
		 * 
		 */		
		public function get format():String
		{
			return _format;
		}

		public function set format(value:String):void
		{
			_format = value;
		}

		/**
		 * ${mapping_TiledWMTSLayer_attribute_tileMatrixSet_D}.
		 * <p>${mapping_TiledWMTSLayer_attribute_tileMatrixSet_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get tileMatrixSet():String
		{
			return _tileMatrixSet;
		}

		public function set tileMatrixSet(value:String):void
		{
			_tileMatrixSet = value;
		}

		/**
		 * ${mapping_TiledWMTSLayer_attribute_style_D} 
		 * @return 
		 * 
		 */		
		public function get style():String
		{
			return _style;
		}

		public function set style(value:String):void
		{
			_style = value;
		}

		/**
		 * ${mapping_TiledWMTSLayer_attribute_layerName_D} 
		 * @return 
		 * 
		 */		
		public function get layerName():String
		{
			return _layerName;
		}

		public function set layerName(value:String):void
		{
			_layerName = value;
		}

	}
}