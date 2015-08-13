package com.supermap.web.mapping
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.styles.PictureMarkerStyle;
	import com.supermap.web.iServerJava6R.layerServices.GetLayersInfoResult;
	import com.supermap.web.iServerJava6R.layerServices.GetLayersInfoService;
	import com.supermap.web.iServerJava6R.layerServices.LayerStatus;
	import com.supermap.web.iServerJava6R.layerServices.SetLayerResult;
	import com.supermap.web.iServerJava6R.layerServices.SetLayerStatusParameters;
	import com.supermap.web.iServerJava6R.layerServices.SetLayerStatusService;
	import com.supermap.web.iServerJava6R.layerServices.SetLayerStyleParameters;
	import com.supermap.web.iServerJava6R.layerServices.SetLayerStyleService;
	import com.supermap.web.iServerJava6R.serviceEvents.GOIsEvent;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.utils.serverTypes.ServerStyle;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	
	/**
	 * ${mapping_GOIs_event_initialized_D} 
	 * 
	 */	
	[Event(name="initialized", type="com.supermap.web.iServerJava6R.serviceEvents.GOIsEvent")]
	
	/**
	 * ${mapping_GOIs_event_initializeFailed_D} 
	 * 
	 */	
	[Event(name="initializeFailed", type="com.supermap.web.iServerJava6R.serviceEvents.GOIsEvent")]
	
	/**
	 * ${mapping_GOIs_event_click_D} 
	 * 
	 */	
	[Event(name="click", type="com.supermap.web.iServerJava6R.serviceEvents.GOIsEvent")]
	
	/**
	 * ${mapping_GOIs_event_mouseover_D} 
	 * 
	 */	
	[Event(name="mouseover", type="com.supermap.web.iServerJava6R.serviceEvents.GOIsEvent")]
	
	use namespace sm_internal;
	
	/**
	 * ${mapping_GOIs_Title}.
	 * <p>${mapping_GOIs_Description}</p> 
	 * 
	 */	
	public class GOIs extends EventDispatcher
	{
		private var _url:String = "";
		//用于创建麻点图的数据集名字
		private var _datasetName:String = "";
		//设置SetLayerStatusService生成临时图层的显示风格
		private var _style:ServerStyle = null;
		//设置SetLayerStatusService生成临时图层的显示过滤条件
		private var _filter:String = "";
		//获取或设置是否使用服务端的缓存
		private var _enableServerCaching:Boolean = true;
		//获取或设置载入 ImageLayer 的图片格式，默认为 png 格式。
		private var _imageFormat:String = "png";
		//投影
		private var _CRS:CoordinateReferenceSystem = null;
		//瓦片中每个单元格的像素宽度, 默认为8
		private var _pixcell:int = 8;
		//poi点hover状态下的样式。 仅对点图层有效。
		private var _highlightMarkerStyle:PictureMarkerStyle = null;
		//是否高亮,默认为false，当设置为true时，需要设置highlightIcon，才能看到高亮效果。仅对点图层有效。
		private var _isHighlight:Boolean = false;
		//获取或者设置图层分块大小，单位为像素，默认值为256.
		private var _tileSize:int = 256;
		
		//当前图层的最大显示分辨率。即当图层缩放至该分辨率时就不能再放大。
		private var curHoverFeature:Feature = null;	
		private var curClickMarker:Feature = null;
		private var utfResultDict_point:Dictionary = null;	
		
		private var tiledDynamicRESTLayer:TiledDynamicRESTLayer = null;
		private var utfgridLayer:UTFGridLayer = null;
		private var featuresLayer:FeaturesLayer = null;
		//是否是点图层
		private var isPoi:String = "";
		//麻点图图层数组，包含tiledDynamicRESTLayer、utfgridLayer和featuresLayer
		private var layers:Array = null;
		private var curHoverIdx:String = "";//当前hover point的标记
		private var curHoverData:Object = null;//存储hover point的数据
		
		/**
		 * ${mapping_GOIs_constructor_D} 
		 * @param url ${mapping_GOIs_constructor_param_url}
		 * @param datasetName ${mapping_GOIs_constructor_param_datasetName}
		 * 
		 */		
		public function GOIs(url:String,datasetName:String)
		{
			if(url && datasetName)
			{
				this._url = url;
				this._datasetName = datasetName;
				getLayersInfo();
			}		
		}
		
		/**
		 * ${mapping_GOIs_attribute_url_D} 
		 * @return 
		 * 
		 */		
		public function get url():String
		{
			return _url;
		}	
		
		/**
		 * ${mapping_GOIs_attribute_datasetName_D} 
		 * @return 
		 * 
		 */		
		public function get datasetName():String
		{
			return _datasetName;
		}	
		
		/**
		 * ${mapping_GOIs_attribute_style_D} 
		 * @return 
		 * 
		 */		
		public function get style():ServerStyle
		{
			return _style;
		}
		public function set style(value:ServerStyle):void
		{
			_style = value;
		}
		
		/**
		 * ${mapping_GOIs_attribute_filter_D} 
		 * @return 
		 * 
		 */		
		public function get filter():String
		{
			return _filter;
		}
		public function set filter(value:String):void
		{
			_filter = value;
		}
		
		/**
		 * ${mapping_GOIs_attribute_enableServerCaching_D} 
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
		 * ${mapping_GOIs_attribute_imageFormat_D} 
		 * @return 
		 * 
		 */		
		public function get imageFormat():String
		{
			return _imageFormat;
		}
		public function set imageFormat(value:String):void
		{
			_imageFormat = value;
		}
		
		/**
		 * ${mapping_GOIs_attribute_CRS_D} 
		 * @return 
		 * 
		 */		
		public function get CRS():CoordinateReferenceSystem
		{
			return _CRS;
		}
		public function set CRS(value:CoordinateReferenceSystem):void
		{
			_CRS = value;
		}
		
		/**
		 * ${mapping_GOIs_attribute_pixcell_D} 
		 * @return 
		 * 
		 */		
		public function get pixcell():int
		{
			return _pixcell;
		}
		public function set pixcell(value:int):void
		{
			_pixcell = value;
		}
		
		/**
		 * ${mapping_GOIs_attribute_highlightMarkerStyle_D} 
		 * @return 
		 * 
		 */		
		public function get highlightMarkerStyle():PictureMarkerStyle
		{
			return _highlightMarkerStyle;
		}
		public function set highlightMarkerStyle(value:PictureMarkerStyle):void
		{
			_highlightMarkerStyle = value;
		}
		
		/**
		 * ${mapping_GOIs_attribute_isHighlight_D} 
		 * @return 
		 * 
		 */		
		public function get isHighlight():Boolean
		{
			return _isHighlight;
		}
		public function set isHighlight(value:Boolean):void
		{
			_isHighlight = value;
		}
		
		/**
		 * ${mapping_GOIs_attribute_tileSize_D} 
		 * @return 
		 * 
		 */		
		public function get tileSize():int
		{
			return _tileSize;
		}
		public function set tileSize(value:int):void
		{
			_tileSize = value;
		}
		
		
		/**
		 * ${mapping_GOIs_method_getLayers_D} 
		 * @return ${mapping_GOIs_method_getLayers_return} 
		 * 
		 */	
		public function getLayers():Array
		{
			return layers;
		}
		
		/**
		 * ${mapping_GOIs_method_destroy_D} 
		 * @return
		 * 
		 */	
		public function destroy():void
		{
			this.style = null;
			this.filter = "";
			this.enableServerCaching = true;
			this.imageFormat = "png";
			this.CRS = null;
			this.pixcell = 8;
			this.highlightMarkerStyle = null;
			this.isHighlight = false;
			
			this.curHoverFeature = null;	
			this.curClickMarker = null;
			this.utfResultDict_point = null;	
			this.tileSize = 256;
			
			this.tiledDynamicRESTLayer = null;	
			if(this.utfgridLayer)this.utfgridLayer.UTFGridMouseMoveHandler = function(data:Object, x:Number, y:Number):void{};
			this.utfgridLayer = null;
			this.featuresLayer = null;
			this.isPoi = "";
			this.layers = null;
			this.curHoverIdx = "";
			this.curHoverData = null;
		}
		
		/**
		 * ${mapping_GOIs_method_hide_D} 
		 * @return
		 * 
		 */	
		public function hide():void
		{
			if(this.tiledDynamicRESTLayer) tiledDynamicRESTLayer.visible = false;
			if(this.utfgridLayer) utfgridLayer.visible = false;
			if(this.featuresLayer) featuresLayer.visible = false;
		}
		
		/**
		 * ${mapping_GOIs_method_show_D} 
		 * @return
		 * 
		 */	
		public function show():void
		{
			if(this.tiledDynamicRESTLayer) tiledDynamicRESTLayer.visible = true;
			if(this.utfgridLayer) utfgridLayer.visible = true;
			if(this.featuresLayer) featuresLayer.visible = true;
		}	
		
		/**
		 * ${mapping_GOIs_method_setOpacity_D} 
		 * @param alpha ${mapping_GOIs_method_setOpacity_param_alpha}
		 * @return
		 * 
		 */	
		public function setOpacity(alpha:Number):void
		{
			if(0<=alpha && alpha<=1)
			{
				if(this.tiledDynamicRESTLayer) tiledDynamicRESTLayer.alpha = alpha;
				if(this.utfgridLayer) utfgridLayer.alpha = alpha;
				if(this.featuresLayer) featuresLayer.alpha = alpha;
			}
		}
		
		/**
		 * ${mapping_GOIs_method_removeClickedPoint_D} 
		 * @return
		 * 
		 */	
		public function removeClickedPoint():void
		{	
			if(this.curClickMarker)
			{
				var index:int = this.featuresLayer.getFeatureIndex(this.curClickMarker);
				if(index>=0)
				{
					this.featuresLayer.removeFeatureAt(index);
				}
			}
		}
		
		//获取图层信息
		private function getLayersInfo():void
		{
			var getLayersInfoService:GetLayersInfoService = new GetLayersInfoService(this.url);
			getLayersInfoService.processAsync(new AsyncResponder(this.getLayerInfoCompleted,this.getLayerInfoFailed,null))
		}
		
		//获取图层信息成功
		private function getLayerInfoCompleted(result:GetLayersInfoResult,mark:Object = null):void
		{
			var layerList:Array = new Array();
			
			if(this.datasetName)
			{
				if (result) 
				{
					var subLayers:Array = result.layersInfo;
					if(subLayers)
					{ 
						var layers:Array = subLayers;
						
						for(var i:int = 0;i <layers.length ; i++)
						{
							var layerStatus:LayerStatus = new LayerStatus();
							if(layers[i].name == this.datasetName)
							{
								if(layers[i].datasetInfo && layers[i].datasetInfo.type)
								{
									var type:String = layers[i].datasetInfo.type;
									if(type)
									{
										type = type.toUpperCase();
										if(type=="LINE"||type=="REGION")
										{
											layerStatus.isVisible = false;
											layerStatus.layerName = layers[i].name;
											this.isPoi = "false"
										}
										else
										{
											layerStatus.isVisible = true;
											layerStatus.layerName = layers[i].name;
											layerStatus.maxScale = 0;
											layerStatus.minScale = 0;
											if(this.filter) layerStatus.displayFilter = filter;
											this.isPoi = "true";
										}
									}
								}
							}
							else
							{
								layerStatus.isVisible = false;
								layerStatus.layerName = layers[i].name;
							}
							layerList.push(layerStatus);
						}
					}
					var setLayerStatusParameters:SetLayerStatusParameters = new SetLayerStatusParameters();
					setLayerStatusParameters.layerStatusList = layerList;
					var setLayerStatusService:SetLayerStatusService = new SetLayerStatusService(this.url);
					setLayerStatusService.processAsync(setLayerStatusParameters, new AsyncResponder(this.setLayerStyleService,this.setLayerStatusFailed,null));
				}
			}
		}		
		
		//获取图层信息失败
		private function getLayerInfoFailed(error:FaultEvent, token:Object = null):void
		{
			dispatchEvent(new GOIsEvent(GOIsEvent.INITIALIZE_FAILED,null,null,error));
		}
		
		//设置图层可见性失败
		private function setLayerStatusFailed(error:FaultEvent, token:Object = null):void
		{
			dispatchEvent(new GOIsEvent(GOIsEvent.INITIALIZE_FAILED,null,null,error));	
		}
		
		//设置图层风格失败
		private function setLayerStyleFailed(error:FaultEvent, token:Object = null):void
		{
			dispatchEvent(new GOIsEvent(GOIsEvent.INITIALIZE_FAILED,null,null,error));
		}
		
		//设置图层可见性成功后设置Style
		private function setLayerStyleService(result:SetLayerResult,mark:Object = null):void
		{
			var setLayerStyleParameters:SetLayerStyleParameters = new SetLayerStyleParameters();
			setLayerStyleParameters.layerName = this.datasetName;
			if(this.style) setLayerStyleParameters.style = style;
			setLayerStyleParameters.resourceID = result.newResourceID;
			var setLayerStyleService:SetLayerStyleService = new SetLayerStyleService(this.url);
			setLayerStyleService.processAsync(setLayerStyleParameters, new AsyncResponder(this.setLayerStyleCompleted, this.setLayerStyleFailed,null));
		}
		
		//设置图层风格成功
		private function setLayerStyleCompleted(result:SetLayerResult,mark:Object = null):void
		{
			if(result && result.newResourceID){
				//创建TiledDynamicRESTLayer，显示临时图层（麻点图底图）	
				this.tiledDynamicRESTLayer = new TiledDynamicRESTLayer();
				this.tiledDynamicRESTLayer.url = this.url;
				this.tiledDynamicRESTLayer.transparent = true;
				this.tiledDynamicRESTLayer.redirect = true;
				if(this.tileSize) this.tiledDynamicRESTLayer.tileSize = this.tileSize;
				this.tiledDynamicRESTLayer.layersID = result.newResourceID;
				if(this.enableServerCaching) this.tiledDynamicRESTLayer.enableServerCaching = this.enableServerCaching;
				if(this.CRS) tiledDynamicRESTLayer.CRS = this.CRS;
				if(this.imageFormat) tiledDynamicRESTLayer.imageFormat = this.imageFormat;
				
				//创建UTFGridLayer，使用UTFGridMouseMoveHandler在TiledDynamicRESTLayer有数据的地方添加一个feature（feature添加到this.featuresLayer）
				this.utfgridLayer = new UTFGridLayer();
				this.utfgridLayer.url = this.url;
				this.utfgridLayer.layerName = this.datasetName;
				this.utfgridLayer.pixcell = this.pixcell;
				if(this.tileSize) this.utfgridLayer.tileSize = this.tileSize;
				if(this.enableServerCaching) this.utfgridLayer.enableServerCaching = this.enableServerCaching;
				if(CRS) utfgridLayer.CRS = this.CRS;
				if(this.filter) this.utfgridLayer.filter = this.filter; //flex-UTFGridLayer暂时不支持该属性
				
				if(this.isPoi)
				{
					if(this.isPoi == "true") 
					{
						this.utfgridLayer.UTFGridMouseMoveHandler = mouseOverUTFGrid_point;
						this.utfgridLayer.UTFGridMouseClickHandler = mouseClickUTFGrid_point;
					}
					else
					{
						this.utfgridLayer.UTFGridMouseMoveHandler = mouseOverUTFGrid_lineArea;
					}
				}
				
				this.featuresLayer = new FeaturesLayer();
				featuresLayer.isPanEnableOnFeature = true;
				if(CRS) featuresLayer.CRS = this.CRS;
				
				//组织麻点图的图层
				layers = new Array();
				layers.push(this.tiledDynamicRESTLayer);
				layers.push(this.utfgridLayer);
				layers.push(this.featuresLayer);
				
				if(layers)
				{
					dispatchEvent(new GOIsEvent(GOIsEvent.INITIALIZED));
				}
			}
		}
		
		//utfgridlayer鼠标平移事件回调函数（point）
		private function mouseOverUTFGrid_point(data:Object, x:Number, y:Number):void
		{
			removeHoverFeature();
			if (data)
			{					
				var dataUp:Object=new Object();
				for(var s in data)
				{
					dataUp[s.toUpperCase()] = data[s];
				}
				
				if(isHighlight)
				{
					if(highlightMarkerStyle)
					{
						this.curHoverFeature = new Feature(new GeoPoint(dataUp.SMX, dataUp.SMY), highlightMarkerStyle);	
						this.featuresLayer.addFeature(curHoverFeature);
					}
				}
				var poiInfo:Object = new Object();
				poiInfo["data"] = data;
				poiInfo["x"] = dataUp.SMX;
				poiInfo["y"] = dataUp.SMY;
				dispatchEvent(new GOIsEvent(GOIsEvent.MOUSEOVER, poiInfo));
			}
		}
		
		private function mouseClickUTFGrid_point(data:Object, x:Number, y:Number):void
		{
			if (data)
			{					
				removeClickedPoint();
				
				var dataUp:Object=new Object();
				for(var s in data)
				{
					dataUp[s.toUpperCase()] = data[s];
				}
				
				if(isHighlight)
				{
					if(highlightMarkerStyle)
					{
						this.curClickMarker = new Feature(new GeoPoint(dataUp.SMX, dataUp.SMY), highlightMarkerStyle);	
						this.featuresLayer.addFeature(curClickMarker);
					}
				}
				var poiInfo:Object = new Object();
				poiInfo["data"] = data;
				poiInfo["x"] = dataUp.SMX;
				poiInfo["y"] = dataUp.SMY;
				dispatchEvent(new GOIsEvent(GOIsEvent.CLICK,poiInfo));
			}
		}
		
		//utfgridlayer鼠标平移事件回调函数（lineArea）
		private function mouseOverUTFGrid_lineArea(data:Object, x:Number, y:Number):void
		{
			//...
		}
		
		//删除当前hover的Feature
		private function removeHoverFeature():void
		{
			var index:int = this.featuresLayer.getFeatureIndex(this.curHoverFeature);
			if(index>=0)
			{
				this.featuresLayer.removeFeatureAt(index);
			}
		}		
	}
}