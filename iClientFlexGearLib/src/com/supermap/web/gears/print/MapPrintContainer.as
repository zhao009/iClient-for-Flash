package com.supermap.web.gears.print
{
	import com.supermap.web.core.Element;
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.mapping.CloudLayer;
	import com.supermap.web.mapping.DynamicLayer;
	import com.supermap.web.mapping.DynamicRESTLayer;
	import com.supermap.web.mapping.DynamicWMSLayer;
	import com.supermap.web.mapping.ElementsLayer;
	import com.supermap.web.mapping.FeaturesLayer;
	import com.supermap.web.mapping.HighlightLayer;
	import com.supermap.web.mapping.ImageLayer;
	import com.supermap.web.mapping.ImageLoader;
	import com.supermap.web.mapping.Layer;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.mapping.TiledDynamicRESTLayer;
	import com.supermap.web.mapping.TiledLayer;
	import com.supermap.web.mapping.TiledWMSLayer;
	import com.supermap.web.mapping.TiledWMTSLayer;
	import com.supermap.web.mapping.WMSParams;
	import com.supermap.web.mapping.supportClasses.LayerContainer;
	import com.supermap.web.ogc.wmts.RequestEncoding;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	import com.supermap.web.utils.ScaleUtil;
	import com.supermap.web.utils.TileUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.controls.SWFLoader;
	import mx.core.IVisualElementContainer;
	import mx.core.UIComponent;
	import mx.events.DragEvent;
	import mx.events.FlexEvent;
	import mx.graphics.ImageSnapshot;
	import mx.logging.Log;
	
	import spark.components.Group;
	import spark.layouts.TileLayout;

	use namespace sm_internal;
	
	/**
	 * ${gears_print_MapPrintContainer_Title}.
	 * <p>${gears_print_MapPrintContainer_Description}</p> 
	 * @see #getTiledURL()
	 * @see #getDynamicURL()
	 * 
	 */	
	public class MapPrintContainer extends Group
	{
		
		/**
		 * ${gears_print_MapPrintContainer_event_PRINT_PREPARE_COMPLETE_D} 
		 */		
		public static const PRINT_PREPARE_COMPLETE:String = "print_prepare_complete";
		
		private var imageFormat:String = "png";
		
		private var _dynamicImageSize:Number = 2880;
		
		private var _layersID:Array = null;
		
		private var _imagesID:Array = null;
		
		private var _groupMain:Group = null;
		
		//打印地图的比例尺
		private var _resolution:Number = 0;
		
		private var _viewbounds:Rectangle2D = null;
		
		
		/**
		 * ${gears_print_MapPrintContainer_constructor_D} 
		 * 
		 */		
		public function MapPrintContainer()
		{
			super();
		}
		
		/**
		 * ${gears_print_MapPrintContainer_property_resolution_D} 
		 * @return 
		 * 
		 */		
		public function get resolution():Number
		{
			return _resolution;
		}

		/**
		 * 处理图层加载显示完毕事件
		 * */
		private function layerEnterFrameHandler(event:Event):void
		{
			if(event.target is Group)
			{
				var layer:Group = event.target as Group;
				layer.removeEventListener(Event.ENTER_FRAME, layerEnterFrameHandler);
				
				var layerID:String = layer.id;
				var index:int = _layersID.indexOf(layerID,0);
				if(-1 != index)
				{
					_layersID.splice(index, 1);
				}
				if(0 == _layersID.length)
				{
					checkAll();
				}
			}
		}
		
		/**
		 * 检查打印所需所有元素的加载情况
		 * */
		private function checkAll():void
		{
			if(_layersID)
			{
				if(_imagesID)
				{
					if((0 == _layersID.length) && (0 == _imagesID.length))
					{
						this.dispatchEvent(new Event(PRINT_PREPARE_COMPLETE));
					}
				}
				else
				{
					if(0 == _layersID.length)
					{
						//允许没有image图层
						this.dispatchEvent(new Event(PRINT_PREPARE_COMPLETE));
					}
				}
			}
		}
		
		private function reset():void
		{
			_layersID = new Array;
			_imagesID = new Array;
			this.removeAllElements();
		}
		
//		/**
//		 * 根据分辨率，map对象，范围信息等生成要打印的地图显示
//		 * @param map需要打印的地图对象
//		 * @param resolution 地图分辨率
//		 * @param viewBounds 打印范围的地理坐标,(为null则默认全图打印)
//		 * @param bitmapSize 返回图片对象的规格大小，如果图片大于该范围则会别切割成多组正方形数组
//		 * */
		/**
		 * ${gears_print_MapPrintContainer_method_makeMapBitmapData_D} 
		 * @param map ${gears_print_MapPrintContainer_method_makeMapBitmapData_param_map_D}
		 * @param resolution ${gears_print_MapPrintContainer_method_makeMapBitmapData_param_resolution_D}
		 * @param viewBounds ${gears_print_MapPrintContainer_method_makeMapBitmapData_param_viewBounds_D}
		 * 
		 */		
		public function makeMapBitmapData(map:Map, resolution:Number, viewBounds:Rectangle2D = null):void
		{
			if(null == map)
			{
				return;
			}
			//初始化，重置
			reset()
			var bounds:Rectangle2D = map.bounds;
			if(null == viewBounds)
			{
				_viewbounds = viewBounds = bounds;
			}
			_resolution = resolution;
			//预计算打印区域的实际像素大小
			var imageWidth:Number = (viewBounds.right - viewBounds.left)/resolution;
			var imageHeight:Number = (viewBounds.top - viewBounds.bottom)/resolution;
			
			//针对Map图层集合，求一个最合适的Resolution值，然后再次计算显示宽高值
			//？或许有点没用，以后好好测一测
			var closet:Object = TileUtil.getClosestResolutionAndLevel(imageWidth, imageHeight, viewBounds.width, viewBounds.height, map.resolutions);
			_resolution = closet.resolution;
			
			//修改重复计算
			imageWidth = (viewBounds.right - viewBounds.left)/resolution;
			imageHeight = (viewBounds.top - viewBounds.bottom)/resolution;
			
			//虚拟一个map对象，供元素，要素显示时计算坐标使用
			var newMap:Map = new Map;
			newMap.viewBounds = viewBounds;
			newMap.width = imageWidth;
			newMap.height = imageHeight;
			newMap._layerContainer.scrollRect = new Rectangle;
			newMap.resolutions = map.resolutions;
			
			_groupMain = new Group;
			_groupMain.width = imageWidth;
			_groupMain.height = imageHeight;
			_groupMain.clipAndEnableScrolling = true;
			_groupMain.alpha = map.alpha;
			this.addElement(_groupMain);
//			this.addEventListener(PRINT_PREPARE_COMPLETE,printPrepareCompleteHandler);
//			遍历图层，根据不同图层采用不同方法获取显示
			var layerCon:LayerContainer = map.layerContainer;
			var layer:Layer = null;
			var layersID:String = null;
			for each( layer in layerCon.layers)
			{
				if(!layer.visible)
				{
					continue;
				}
				if(layer is ImageLayer)
				{
					getMapImage(layer, newMap);
				}
				else if(layer is FeaturesLayer)
				{
					_layersID.push(layer.id);
					getFeatureLayer(layer as FeaturesLayer, newMap);
				}
				else if(layer is ElementsLayer)
				{
					_layersID.push(layer.id);
					getElementLayer(layer as ElementsLayer, newMap);
				}
				else
				{
					continue;
				}
			}
		}
		
		/**
		 * 获取图片
		 * */
		private function getMapImage(layer:Layer, newMap:Map):void
		{
			if (this._resolution <= 0)
			{
				return;
			}
			var layerCon:Group = new Group;
			layerCon.id = layer.id;
			layerCon.alpha = layer.alpha;
			_groupMain.addElement(layerCon);
			//动态图和分块图采用不同方式加载
			if(layer is DynamicLayer)
			{
				getDynamicLayerImage(layerCon, layer as DynamicLayer, newMap);
			}
			else if(layer is TiledLayer)
			{
				getTiledLayerImage(layerCon, layer as TiledLayer, newMap);
			}
		}
		
		private function getDynamicLayerImage(layerCon:Group, layer:DynamicLayer, newMap:Map):void
		{
			
			//地图超过_dynamicImageSize像素后自动做简单分块逐快查询
			var row:int = Math.ceil(newMap.height / _dynamicImageSize);
			var col:int = Math.ceil(newMap.width / _dynamicImageSize);
			for (var c:int = 0; c < col; c++)
			{
				for (var r:int = 0; r < row; r++)
				{
					var mapInfo:MapInfo = getMapInfo(r, c, newMap);
					var serverURL:String = getDynamicURL(layer, mapInfo);
					if("" == serverURL)
					{
						return;
					}
					var imageID:String = layer.id + "_dynamic_" + r + "_" + c;
					this._imagesID.push(imageID);
					this.addDynamicImage(layerCon, imageID, serverURL, r, c);
				}
			}
		}
		
		private function getMapInfo(r:int, c:int, newMap:Map):MapInfo
		{
			var mapInfo:MapInfo = new MapInfo;
			mapInfo.width = _dynamicImageSize;
			mapInfo.height = _dynamicImageSize;
			if( ((r + 1) * _dynamicImageSize - newMap.height) > 0)
			{
				mapInfo.height = newMap.height - r * _dynamicImageSize;
			}
			if( ((c + 1) * _dynamicImageSize - newMap.width) > 0)
			{
				mapInfo.width = newMap.width - c * _dynamicImageSize;
			}
			var left:Number = newMap.screenToMapX(c * _dynamicImageSize);
			var right:Number = newMap.screenToMapX(c * _dynamicImageSize + mapInfo.width);
			var top:Number = newMap.screenToMapY(r * _dynamicImageSize);
			var bottom:Number = newMap.screenToMapY(r * _dynamicImageSize + mapInfo.height);
			mapInfo.viewBounds = new Rectangle2D(left, bottom, right, top);
			return mapInfo;
		}
		
		private function addDynamicImage(layerCon:Group, imageID:String, serverURL:String, r:int, c:int):void
		{
			var img:SWFLoader = new SWFLoader;
			img.id = imageID;
			img.x = c * _dynamicImageSize;
			img.y = r * _dynamicImageSize;
			img.addEventListener(Event.COMPLETE, onImageComplete);
			img.addEventListener(IOErrorEvent.IO_ERROR, onImageIOError, false, 0, true);
			//添加图层透明度属性
			layerCon.addElement(img);
			img.load(serverURL);
		}
		
		private function getTiledLayerImage(layerCon:Group, layer:TiledLayer, newMap:Map):void
		{
			//计算但因范围分块显示的行列序号
			var tiledInfo:TiledInfo = getTiledInfo(layer, newMap);
			var mapInfo:MapInfo = new MapInfo;
			mapInfo.width = newMap.width;
			mapInfo.height = newMap.height;
			mapInfo.viewBounds = newMap.viewBounds.clone();
			//遍历添加图片
			var c:int = (tiledInfo.startCol >= 0) ? tiledInfo.startCol : 0;
			while(c < tiledInfo.endCol)
			{
				var r:int = (tiledInfo.startRow >= 0) ? tiledInfo.startRow : 0;
				while(r < tiledInfo.endRow)
				{
					var tileURL:String = getTiledURL(layer, mapInfo, r, c , tiledInfo.level);
					if("" == tileURL)
					{
						break;
					}
					var tileId:String = layer.id + "_tiledImage_" + r + "_" + c;
					this._imagesID.push(tileId);
					this.addTiledImage(layerCon, tileURL, r, c , tileId, tiledInfo.offsets, (layer as TiledLayer).tileSize);
					r++;
				}
				c++;
			}	
		}
		
		private function getTiledInfo(layer:TiledLayer, newMap:Map):TiledInfo
		{
			var result:TiledInfo = new TiledInfo;
			var tileSize:Number = layer.tileSize;
			//实际出图范围，通过当前layer的bounds和设置的打印范围viewbounds求交集
			var actualBounds:Rectangle2D = layer.bounds.intersection(newMap.viewBounds);
			var offsetx:Number = newMap.width * (newMap.viewBounds.left - layer.bounds.left)/ newMap.viewBounds.width;
			var offsety:Number = newMap.height * (layer.bounds.top - newMap.viewBounds.top)/ newMap.viewBounds.height;
			
			result.startCol = Math.floor(offsetx / layer.tileSize);
			result.startRow = Math.floor(offsety / layer.tileSize);
			
			var endx:Number = offsetx + (actualBounds.right - newMap.viewBounds.left) * newMap.width / newMap.viewBounds.width;
			var endy:Number = offsety + ( newMap.viewBounds.top - actualBounds.bottom) * newMap.height / newMap.viewBounds.height;
			
			result.endCol = Math.ceil(endx / layer.tileSize);
			result.endRow = Math.ceil(endy / layer.tileSize);
			
			result.offsets = new Point(offsetx, offsety);
			result.level = getTiledLevel(layer);
			//计算level
			return result;
		}
		
		
		private function getTiledLevel(layer:TiledLayer):int
		{
			var level:int = -1;
			var resolutions:Array = layer.getResolutions();
			if(null != resolutions)
			{
				level = resolutions.indexOf(_resolution);
			}
			return level;
		}
		
		/**
		 * ${gears_print_MapPrintContainer_method_getTiledURL_D} 
		 * @param layer ${gears_print_MapPrintContainer_method_getTiledURL_param_layer_D}
		 * @param mapInfo ${gears_print_MapPrintContainer_method_getTiledURL_param_mapInfo_D}
		 * @param row ${gears_print_MapPrintContainer_method_getTiledURL_param_row_D}
		 * @param col ${gears_print_MapPrintContainer_method_getTiledURL_param_col_D}
		 * @param level ${gears_print_MapPrintContainer_method_getTiledURL_param_level_D}
		 */	
		protected function getTiledURL(layer:Layer, mapInfo:MapInfo, row:Number, col:Number, level:int):String
		{
			if (_resolution <= 0)
			{
				return "";
			}

			var tileURL:String = "";
			var mapURL:String = layer.url;
			var dpi:Number = layer.getDpi();//暂时不考虑iserver2的图层
			var transparent:Boolean = (layer as ImageLayer).transparent;
			var scale:Number;
			
			if(layer is TiledDynamicRESTLayer)
			{
				var layersID:String = (layer as TiledDynamicRESTLayer).layersID;
				if(layer.CRS)
					scale = ScaleUtil.resolutionToScale(_resolution,dpi,layer.CRS.unit,layer.CRS.datumAxis);//0.0254 / _resolution / dpi;
				else
					scale = ScaleUtil.resolutionToScale(_resolution,dpi);//0.0254 / _resolution / dpi;
				tileURL = mapURL + "tileImage." + imageFormat.toLowerCase() + "?scale=" + scale + "&x=" + col + "&y=" + row 
					+ "&width=" + (layer as TiledDynamicRESTLayer).tileSize + "&height=" + (layer as TiledDynamicRESTLayer).tileSize  + "&layersID=" + layersID + "&transparent=" + transparent + "&t=" + new Date().getTime();
			}
			else if(layer is TiledWMSLayer)
			{
				var tiledwmsLayer:TiledWMSLayer = layer as TiledWMSLayer;
				var bounds:Rectangle2D = mapInfo.viewBounds;
				var left:Number = bounds.left + tiledwmsLayer.tileSize * col * _resolution;	
				var right:Number = bounds.left + tiledwmsLayer.tileSize * (col+1) * _resolution;	
				var bottom:Number = bounds.top - tiledwmsLayer.tileSize * (row+1) * _resolution;	
				var top:Number = bounds.top - tiledwmsLayer.tileSize * row * _resolution;	
				
				var bbox:Rectangle2D = new Rectangle2D(left, bottom, right, top);
				var wmsParasString:String = tiledwmsLayer.getWmsParasString(bbox);
				
				tileURL = mapURL + "?" + wmsParasString;
			}
			else
			{
				if(-1 == level)
				{
					return "";
				}
				if(layer is CloudLayer)
				{
					var resolution:Number = (layer as CloudLayer).resolutions[level];
					if(resolution <= 0)
					{
						return "";
					}
					if(resolution < 1)
						resolution = Math.round(1.0 / resolution);		
					//tileURL = (layer as CloudLayer).getCachedUrl() + "map=" + (layer as CloudLayer).mapName + "_" + (layer as CloudLayer).tileSize + "x" + (layer as CloudLayer).tileSize + "/" + scale + "/" + col + "/" + row + "." + imageFormat;
					
					var finalLevel:int;
					var cloudLayer:CloudLayer = layer as CloudLayer;
					var levels:Array = cloudLayer.levels;
					if(levels && levels.length)
						finalLevel = levels[level];
					else
						finalLevel = level;
					var _type:String = "web";
					
					tileURL = cloudLayer.getCachedUrl() + "map="  + cloudLayer.mapName + "&type=" + _type + "&x=" + col + "&y=" + row + "&z=" + finalLevel;
				}
				else if(layer is TiledWMTSLayer)
				{
					var tiledWmtsLayer:TiledWMTSLayer = layer as TiledWMTSLayer;
					if(tiledWmtsLayer.tileMatrixIdentifiers && tiledWmtsLayer.tileMatrixIdentifiers.length)
					{
						if(tiledWmtsLayer.requestEncoding == RequestEncoding.KVP)
						{
							tileURL = mapURL + "?SERVICE=WMTS" + "&REQUEST=GetTile" + "&VERSION=" + tiledWmtsLayer.version + "&LAYER=" + tiledWmtsLayer.layerName + "&STYLE=" + tiledWmtsLayer.style + "&TILEMATRIXSET=" + tiledWmtsLayer.tileMatrixSet + "&TILEMATRIX=" + tiledWmtsLayer.findMatrixLevel(level) + "&TILEROW=" + row + "&TILECOL=" + col + "&FORMAT=image/" + tiledWmtsLayer.format;
						}
						else if(tiledWmtsLayer.requestEncoding == RequestEncoding.REST)
						{
							tileURL = mapURL + "/" + tiledWmtsLayer.layerName + "/" + tiledWmtsLayer.style + "/" + tiledWmtsLayer.tileMatrixSet + "/" +  tiledWmtsLayer.findMatrixLevel(level) + "/" + row + "/" + col + "." + tiledWmtsLayer.format;
						}
					}
					else
					{
						if(tiledWmtsLayer.requestEncoding == RequestEncoding.KVP)
						{
							tileURL = mapURL + "?SERVICE=WMTS" + "&REQUEST=GetTile" + "&VERSION=" + tiledWmtsLayer.version + "&LAYER=" + tiledWmtsLayer.layerName + "&STYLE=" + tiledWmtsLayer.style + "&TILEMATRIXSET=" + tiledWmtsLayer.tileMatrixSet + "&TILEMATRIX=" + tiledWmtsLayer.findMatrixLevel(level) + "&TILEROW=" + row + "&TILECOL=" + col + "&FORMAT=image/" + tiledWmtsLayer.format;
						}
						else if(tiledWmtsLayer.requestEncoding == RequestEncoding.REST)
						{
							tileURL = mapURL + "/" + tiledWmtsLayer.layerName + "/" + tiledWmtsLayer.style + "/" + tiledWmtsLayer.tileMatrixSet + "/" +  tiledWmtsLayer.findMatrixLevel(level) + "/" + row + "/" + col + "." + tiledWmtsLayer.format;
						}				
					}
				}
			}
			return tileURL;
		}
		
		/**
		 * ${gears_print_MapPrintContainer_method_getDynamicURL_D} 
		 * @param layer ${gears_print_MapPrintContainer_method_getDynamicURL_param_layer_D}
		 * @param mapInfo ${gears_print_MapPrintContainer_method_getDynamicURL_param_mapInfo_D}
		 */	
		protected function getDynamicURL(layer:Layer, mapInfo:MapInfo):String
		{
			var serverURL:String = "";
			if(layer is DynamicRESTLayer)
			{
				serverURL = getDynamicRESTLayerURL(layer as DynamicRESTLayer, mapInfo)
			}
			else if(layer is HighlightLayer)
			{
				serverURL = getHighlightLayerURL(layer as HighlightLayer, mapInfo);
			}
			else if(layer is DynamicWMSLayer)
			{
				serverURL = getDynamicWMSLayerURL(layer as DynamicWMSLayer, mapInfo);
			}
			return serverURL;
		}
		
		private function getDynamicRESTLayerURL(layer:DynamicRESTLayer, mapInfo:MapInfo):String
		{
			var mapURL:String = layer.url;
			var layersID:String = layer.layersID;
			var trans:Boolean = layer.transparent
			var viewBounds:String = JsonUtil.fromRectangle2D(mapInfo.viewBounds);
			var width:Number = Math.ceil(mapInfo.width);
			var height:Number = Math.ceil(mapInfo.height);
			
			var serverURL:String = mapURL + "image." + this.imageFormat + "?viewBounds=" + viewBounds + "&width=" + width + 
				"&height=" + height + "&layersID=" + layersID + "&transparent=" + trans + "&t=" + (new Date()).getTime();	
			if (!layer.enableServerCaching)
			{
			serverURL += ("&cacheEnabled=" + layer.enableServerCaching.toString().toLowerCase());
			}
			if(layer.customServiceParams)
			{
			for (var prop:String in layer.customServiceParams) 
			{
			serverURL += ("&" + prop + "=" + layer.customServiceParams[prop]);
			}
			}
			if(layer.maxVisibleVertex != int.MAX_VALUE && layer.maxVisibleVertex > 0)
			{
			serverURL += ("&maxVisibleVertex=" + layer.maxVisibleVertex); 
			} 
			return serverURL;
		}
		
		private function getHighlightLayerURL(layer:HighlightLayer, mapInfo:MapInfo):String
		{
			var serverURL:String = "";
			if (this._resolution <= 0)
			{
				return "";
			}	  	
			var viewBounds:String = JsonUtil.fromRectangle2D(mapInfo.viewBounds);
			var width:Number = mapInfo.width;
			var height:Number = mapInfo.height;
			
			var transparent:Boolean = layer.transparent;
			var mapURL:String = layer.url;
			
			serverURL = mapURL + "highlightImage." + "png" +"?viewBounds=" + viewBounds + "&width=" + width + 
				"&height=" + height + "&transparent=" + transparent;				
			
			if (layer.queryResultID != null)
			{
				serverURL += "&queryResultID=" + layer.queryResultID;
			}
			else
			{
				serverURL += "&highlightTargetSetID=" + layer.highlightTargetsetID;
			}
			if(layer.style)
				serverURL += "&style=" + layer.style.toJSON();			
			else
				serverURL += "&style=" + "null";	
			
			serverURL += "&redirect=" + layer.redirect;
			
			if(layer.customServiceParams)
			{
				for (var prop:String in layer.customServiceParams) 
				{
					serverURL += ("&" + prop + "=" + layer.customServiceParams[prop]);
				}
			}
			if(layer.maxVisibleVertex != int.MAX_VALUE && layer.maxVisibleVertex > 0)
			{
				serverURL += ("&maxVisibleVertex=" + layer.maxVisibleVertex); 
			} 
			
			return serverURL;
		}
		
		private function getDynamicWMSLayerURL(layer:DynamicWMSLayer, mapInfo:MapInfo):String
		{
			var serverURL:String = "";
			var wmsParasString:String = layer.getWmsParasString(mapInfo.viewBounds, mapInfo.width, mapInfo.height);
			serverURL = layer.url + "?" + wmsParasString;
			return serverURL;
		}
		
		private function getFeatureLayer(layer:FeaturesLayer, newMap:Map):void
		{
			//要素图层容器
			var layerGroup:Group = new Group;
			layerGroup.id = layer.id;
			layerGroup.alpha = layer.alpha;
			layerGroup.addEventListener(Event.ENTER_FRAME, layerEnterFrameHandler);
			_groupMain.addElement(layerGroup);
			
			var feature:Feature = null;
			var bContained:Boolean;
			var geometry:Geometry;
			for each(feature in layer.features)
			{
				if(!feature || !feature.visible)
				{
					continue;
				}
				//添加过滤判断
				if(feature.geometry)
				{
					geometry = feature.geometry;
					if(geometry is GeoPoint)
					{
						bContained = newMap.viewBounds.contains(GeoPoint(geometry).x, GeoPoint(geometry).y);
					}
					else
					{
						bContained = newMap.viewBounds.intersects(geometry.bounds);
					}
					if(bContained)
					{
						var ui:Feature = new Feature;
						layerGroup.addElement(ui);
						if(feature.style)
						{
							feature.style.draw(ui, feature.geometry,feature.attributes,newMap);
						}
						else
						{
							feature.getActiveStyle(layer).draw(ui, feature.geometry,feature.attributes,newMap);
						}
						
					}
				}
			}
		}
		
		private function getElementLayer(layer:ElementsLayer, newMap:Map):void
		{
			var layerGroup:Group = new Group;
			layerGroup.id = layer.id;
			layerGroup.alpha = layer.alpha;
			layerGroup.addEventListener(Event.ENTER_FRAME, layerEnterFrameHandler);
			_groupMain.addElement(layerGroup);
			
			var element:Element = null;
			var elementBounds:Rectangle2D;
			var bContained:Boolean = false;
			for each(element in layer.elements)
			{
				if(!element || !element.component || !element.component.visible)
				{
					continue;
				}
				//范围校验
				elementBounds = element.bounds;
				if(elementBounds.width && elementBounds.height)
					bContained = newMap.viewBounds.intersects(elementBounds);
				else
					bContained = newMap.viewBounds.contains(elementBounds.left, elementBounds.bottom);
				if(bContained)
				{
					var image:Image = new Image;
					var component:DisplayObject = element.component;
					var rect2D:Rectangle2D = element.bounds;
					var _screenBox:Rectangle = new Rectangle;
					if(newMap)
					{  
						_screenBox.left = newMap.mapToContainerX(rect2D.left);
						_screenBox.right = newMap.mapToContainerX(rect2D.right);
						_screenBox.top = newMap.mapToContainerY(rect2D.top);
						_screenBox.bottom = newMap.mapToContainerY(rect2D.bottom); 
					} 
					//坐标设置
					if(0 != _screenBox.width)
					{
						image.x = _screenBox.left;
					}
					else
					{
						image.x = (_screenBox.left + _screenBox.right) * 0.5 - component.width * 0.5;
					}
					if( 0 != _screenBox.height)
					{
						image.y = _screenBox.top; 
					}
					else
					{
						image.y = (_screenBox.top + _screenBox.bottom) * 0.5 - component.height * 0.5;
					}
					//获取显示元素快照作为元素的地图显示
					var bitmap:Bitmap = new Bitmap(ImageSnapshot.captureBitmapData(component));
					image.height = bitmap.height;
					image.width = bitmap.width;
					image.source = bitmap;
					layerGroup.addElement(image);
				}
			}
		}
		
		private function addTiledImage(layerCon:Group, tileURL:String, row:Number, col:Number, id:String, offsets:Point, tileSize:Number) : void
		{
			var imgLoder:SWFLoader = new SWFLoader();
			imgLoder.id = id;
			imgLoder.x = tileSize * col - offsets.x;
			imgLoder.y = tileSize * row - offsets.y;
			imgLoder.addEventListener(Event.COMPLETE, this.onImageComplete, false, 0, true);
			imgLoder.addEventListener(IOErrorEvent.IO_ERROR, this.onImageIOError, false, 0, true);
			imgLoder.load(tileURL);
			layerCon.addElement(imgLoder);
		}
		
		private function onImageComplete(event:Event):void
		{
			var img:SWFLoader = event.target as SWFLoader;
			var index:Number = _imagesID.indexOf(img.id);
			if (index != -1)
			{
				_imagesID.splice(index, 1);
			}
			img.removeEventListener(Event.COMPLETE, this.onImageComplete);
			img.removeEventListener(IOErrorEvent.IO_ERROR, this.onImageIOError);
			if (0 == _imagesID.length)
			{
				checkAll();
			}
		}
		
		/**
		 * 图片加载错误时候抛出错误事件
		 * */
		private function onImageIOError(event:IOErrorEvent):void
		{
			//如果加载失败，则不显示当前图块，移除对应的swfloader对象
			if(event.target is SWFLoader)
			{
				var imgLoader:SWFLoader = event.target as SWFLoader;
				var parent:IVisualElementContainer = imgLoader.parent as IVisualElementContainer;
				//移除id记录
				var index:Number = _imagesID.indexOf(imgLoader.id);
				if (index != -1)
				{
					_imagesID.splice(index, 1);
				}
				parent.removeElement(imgLoader);
			}
			
			//触发事件，提示出图失败
			var evt:ImageLoadIOEvent = new ImageLoadIOEvent(ImageLoadIOEvent.IMAGELOAD_IOERROR, event.toString());
			this.dispatchEvent(evt);
			
			if (0 == _imagesID.length)
			{
				checkAll();
			}
		}
		
		/**
		 * ${gears_print_MapPrintContainer_method_clear_D} 
		 * 
		 */		
		public function clear():void
		{
			this.removeAllElements();
		}
	}
}