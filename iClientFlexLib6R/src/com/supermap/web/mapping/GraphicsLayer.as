package com.supermap.web.mapping
{
	import com.supermap.web.actions.MapAction;
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Graphic;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.styles.graphicStyles.GraphicFillStyle;
	import com.supermap.web.core.styles.graphicStyles.GraphicLineStyle;
	import com.supermap.web.core.styles.graphicStyles.GraphicMarkerStyle;
	import com.supermap.web.events.DrawEvent;
	import com.supermap.web.events.GraphicsLayerEvent;
	import com.supermap.web.events.PanEvent;
	import com.supermap.web.events.ViewBoundsEvent;
	import com.supermap.web.events.ZoomEvent;
	import com.supermap.web.mapping.supportClasses.LayerContainer;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.GeoUtil;
	import com.supermap.web.utils.Unit;
	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	
	use namespace sm_internal;
	
	/**
	 * ${mapping_GraphicsLayer_event_addComplete_D} 
	 */	
	[Event(name = "addComplete", type = "com.supermap.web.events.GraphicsLayerEvent")]
	/**
	 * ${mapping_GraphicsLayer_event_removeComplete_D} 
	 */	
	[Event(name = "removeComplete", type = "com.supermap.web.events.GraphicsLayerEvent")]
	/**
	 * ${mapping_GraphicsLayer_event_removeAllComplete_D} 
	 */	
	[Event(name = "removeAllComplete", type = "com.supermap.web.events.GraphicsLayerEvent")]
	[IconFile("/designIcon/GraphicsLayer.png")]
	/**
	 * ${mapping_GraphicsLayer_Title}.
	 * <p>${mapping_GraphicsLayer_Description}</p> 
	 * @see com.supermap.web.core.Graphic
	 * @see com.supermap.web.events.GraphicsLayerEvent
	 * 
	 */	
	public class GraphicsLayer extends Layer
	{
		private var _graphics:Array;
		private var _preLayer:UIComponent;
		private var _behindPanLayer:UIComponent;
		private var _behindLayer:UIComponent;
		private var _bmd:BitmapData;
		private var _bmdChanged:Boolean = true;
		private var _fDictionary:Dictionary = new Dictionary();
		
		private var _graphicClickHandler:Function;
		private var _graphicItemClickHandler:Function;
		
		private var _needPick:Boolean = false;
		
		private var _index:int = 0;
		private var _isPaning:Boolean = false;
		private var _gfAddedDispatched:Boolean = true;	
		
		private var _startPoint:Point = new Point();
		private var _endPoint:Point = new Point();
		
		
		/**
		 * ${mapping_GraphicsLayer_constructor_None_D} 
		 * 
		 */		
		public function GraphicsLayer()
		{
			super();
			this._graphics = [];
			_preLayer = new UIComponent();
			_behindPanLayer = new UIComponent;
			_behindLayer = new UIComponent();
			_behindPanLayer.alpha = 0.001;
			
			addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, behindLayerMouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, behindLayerMouseUpHandler);
		}
		
		/**
		 * ${mapping_GraphicsLayer_attribute_graphicItems_D} 
		 * @return 
		 * 
		 */	
		public function get graphicItems():Array
		{
			return _graphics;
		}
		
		sm_internal function get graphicItemClickHandler():Function
		{
			return _graphicItemClickHandler;
		}
		
		sm_internal function set graphicItemClickHandler(value:Function):void
		{
			if (value != null)
			{
				_needPick = true;
				_graphicItemClickHandler = value;
			}
			else
				_needPick = false;
		}
		
		/**
		 * ${mapping_GraphicsLayer_attribute_graphicClickHandler_D}.
		 * <p>${mapping_GraphicsLayer_attribute_graphicClickHandler_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get graphicClickHandler():Function
		{
			return _graphicClickHandler;
		}
		
		public function set graphicClickHandler(value:Function):void
		{
			if (value != null)
			{
				_needPick = true;
				_graphicClickHandler = value;
			}
			else
				_needPick = false;
		}
		
		/**
		 * @inheritDoc
		 * 
		 */		
		override protected function viewBoundsChangedHandler(event:ViewBoundsEvent):void
		{
			super.viewBoundsChangedHandler(event);
			_bmdChanged = true;
		}
		
		private function behindLayerMouseDownHandler(event:MouseEvent):void
		{
			this._startPoint.x = event.stageX;
			this._startPoint.y = event.stageY;
		}
		
		private function behindLayerMouseUpHandler(event:MouseEvent):void
		{
			this._endPoint.x = event.stageX;
			this._endPoint.y = event.stageY;
			var isPanMap:Boolean = (Math.abs(_endPoint.x - this._startPoint.x) >= 2) && (Math.abs(_endPoint.y - this._startPoint.y) >= 2);
			if (!isPanMap && (graphicClickHandler != null || graphicItemClickHandler != null))
			{
				var tar:GraphicsLayer = event.currentTarget as GraphicsLayer;
				var currentF1:Graphic = this.getGraphicByPoint(this._endPoint);
				if(currentF1)
				{
					//触发两个点击事件，一个为提供给GraphicDataGrid使用，一个提供给用户使用，注意触发的先后顺序
					if(graphicItemClickHandler != null)
					{
						graphicItemClickHandler(currentF1);
					}
					if(graphicClickHandler != null)
					{
						graphicClickHandler(currentF1);
					}
				}
				
			}
		}
		
		private function getIconBounds(points:Array):GeoRegion
		{
			var geoRegion:GeoRegion = new GeoRegion;
			var part:Array = new Array;
			for(var i:int=0; i<points.length; i++)
			{
				var point:Point = points[i] as Point;
				//				part.push(this.map.screenToMap(point));
				var point2D:Point2D = new Point2D;
				point2D.x = this.map.containerToMapX(point.x);
				point2D.y = this.map.containerToMapY(point.y);
				part.push(point2D);
			}
			geoRegion.addPart(part);
			return geoRegion;
		}
		
		private function getPointBounds(point:Point,xOffset:Number,yOffset:Number,half:Number):Rectangle2D
		{
			var leftPixel:Number = point.x - half + xOffset; 
			var rightPixel:Number = point.x + half + xOffset;
			var topPixel:Number = point.y - half + yOffset;
			var bottomPixel:Number = point.y + half + yOffset;
			var leftBottom:Point2D = this.map.screenToMap(new Point(leftPixel,bottomPixel));
			var rightTop:Point2D = this.map.screenToMap(new Point(rightPixel,topPixel));
			var pointBounds:Rectangle2D = new Rectangle2D(leftBottom.x,leftBottom.y,rightTop.x,rightTop.y);
			
			//			var left:Number = this.map.containerToMapX(leftPixel);
			//			var bottom:Number = this.map.containerToMapY(bottomPixel);
			//			var top:Number = this.map.containerToMapY(topPixel);
			//			var right:Number = this.map.containerToMapX(rightPixel);
			//			var pointBounds:Rectangle2D = new Rectangle2D(left,bottom,right,top);
			return pointBounds;
		}
		
		private function creationCompleteHandler(event:FlexEvent):void
		{
			removeEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			setLoaded(true);
			drawGraphics();
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function addMapListeners():void
		{
			super.addMapListeners();
			if (this.map)
			{
				this.map.addEventListener(PanEvent.PAN_START, panStartHandler);
				this.map.addEventListener(PanEvent.PAN_END, panEndHandler);
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function removeMapListeners():void
		{
			super.removeMapListeners();
			if (this.map)
			{
				this.map.removeEventListener(PanEvent.PAN_START, panStartHandler);
				this.map.removeEventListener(PanEvent.PAN_END, panEndHandler);
			}
		}
		
		private function panStartHandler(event:PanEvent):void
		{
			super.zoomStartHandler(new ZoomEvent(ZoomEvent.ZOOM_END));
			_preLayer.visible = false;
			_behindLayer.graphics.clear();
			_behindLayer.visible = false;
			_isPaning = true;
		}
		
		private function panEndHandler(event:PanEvent):void
		{
			this._preLayer.visible = true;
			_behindLayer.visible = true;
			this.clearBitMapData();
			
			this.graphics.clear();
			_isPaning = false;
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function draw():void
		{
			if (!_isPaning)
				drawGraphics();
			else
				_isPaning = false;
		}
		
		private function drawGraphics():void
		{
			var errorGraphics:Array = [];
			var messagge:String;
			if (map)
			{				
				var clipRect:Rectangle2D = map.viewBounds;
				var clippedGraphics:Array = [];
				for each (var g:Graphic in _graphics)
				{
					if (g.geometry is GeoPoint)
					{
						var point:GeoPoint = g.geometry as GeoPoint;
						if (clipRect.contains(point.x, point.y))
						{
							clippedGraphics.push(g);
						}
					}
					else if (g.geometry is GeoRegion)
					{
						var region:GeoRegion = g.geometry as GeoRegion;
						if (clipRect.intersects(region.bounds))
						{
							clippedGraphics.push(g);
						}
					}
					else if (g.geometry is GeoLine)
					{
						var line:GeoLine = g.geometry as GeoLine;
						if (clipRect.intersects(line.bounds))
						{
							clippedGraphics.push(g);
						}
					}
				}
				_preLayer.graphics.clear();
				for each (var graphic1:Graphic in clippedGraphics)
				{
					try
					{
						graphic1.style.draw(_preLayer, graphic1.geometry, null, map);
					}
					catch (e:Error)
					{
						errorGraphics.push(graphic1);
						messagge = e.message;
					}
				}
				_preLayer.cacheAsBitmap = true;
				
				if (_needPick)
				{				
					_behindLayer.graphics.clear();
					for each (var graphic:Graphic in clippedGraphics)
					{
						if (graphic.geometry is GeoRegion)
						{
							try
							{
								var graphicStyle:GraphicFillStyle = (graphic.style as GraphicFillStyle);
								graphicStyle._pickColor = graphic.pickColor;
								graphicStyle.draw(_behindLayer, graphic.geometry, null, map);
								graphicStyle._pickColor = -1;
							}
							catch (e:Error)
							{
							}
						}
						if (graphic.geometry is GeoLine)
						{
							try
							{
								var style:GraphicLineStyle = (graphic.style as GraphicLineStyle);
								style._pickColor = graphic.pickColor;
								style.draw(_behindLayer, graphic.geometry, null, map);
								style._pickColor = -1;
							}
							catch (e:Error)
							{
							}
						}
						if (graphic.geometry is GeoPoint)
						{
							try
							{
								var markerStyle:GraphicMarkerStyle = (graphic.style as GraphicMarkerStyle);
								markerStyle.pickColor = graphic.pickColor;
								markerStyle.draw(_behindLayer, graphic.geometry, null, map);
								markerStyle.pickColor = -1;
							}
							catch (e:Error)
							{
							}
						}
					}
					_behindLayer.cacheAsBitmap = true;
				}
				
				if (!_gfAddedDispatched && this.hasEventListener(GraphicsLayerEvent.GRAPHICS_ADD))
				{
					this.dispatchEvent(new GraphicsLayerEvent(GraphicsLayerEvent.GRAPHICS_ADD, errorGraphics, messagge));
					_gfAddedDispatched = true;
				}
				this._bmdChanged = true;
			}
		}
		
		/**
		 * @private
		 * 
		 */	
		override protected function createChildren():void
		{
			super.createChildren();
			this.addChild(_behindPanLayer);
			_behindPanLayer.addChild(_behindLayer);
			this.addChild(_preLayer);
		}
		
		/**
		 * ${mapping_GraphicsLayer_method_add_D} 
		 * @param value ${mapping_GraphicsLayer_method_add_value}
		 * @see com.supermap.web.core.Graphic
		 * 
		 */		
		public function add(value:Array):void
		{
			if (value && value.length > 0)
			{
				for each (var g:Graphic in value)
				{
					_graphics.push(g);
					g.pickColor = _index;
					_fDictionary[_index] = g;
					_index++;
				}
				_gfAddedDispatched = false;
			}
			this.refresh();
		}
		
		/**
		 * ${mapping_GraphicsLayer_method_remove_D} 
		 * @param value ${mapping_GraphicsLayer_method_remove_value}
		 * @see com.supermap.web.core.Graphic
		 * 
		 */		
		public function remove(value:Array):void
		{
			var indexes:int = -1;
			if (value && value.length > 0)
			{
				var message:String;
				try
				{
					for each (var g:Graphic in value)
					{
						delete this._fDictionary[g.pickColor];
						indexes = _graphics.indexOf(g);
						if (indexes != -1)
						{
							_graphics.splice(indexes, 1);
						}
						
					}
				}
				catch (e:Error)
				{
					message = e.message;
				}
				if (this.hasEventListener(GraphicsLayerEvent.GRAPHICS_REMOVE))
				{
					this.dispatchEvent(new GraphicsLayerEvent(GraphicsLayerEvent.GRAPHICS_REMOVE, null, message));
				}
			}
			this.refresh();
		}
		
		/**
		 * ${mapping_GraphicsLayer_method_removeAll_D} 
		 * 
		 */		
		public function removeAll():void
		{
			var message:String;
			try
			{
				for each (var g:Graphic in _graphics)
				{
					delete this._fDictionary[g.pickColor];
				}
				_graphics.splice(0, _graphics.length);
			}
			catch (e:Error)
			{
				message = e.message;
			}
			if (this.hasEventListener(GraphicsLayerEvent.GRAPHICS_REMOVE_ALL))
			{
				this.dispatchEvent(new GraphicsLayerEvent(GraphicsLayerEvent.GRAPHICS_REMOVE_ALL, null, message));
			}
			this.refresh();
		}
		
		/**
		 * ${mapping_GraphicsLayer_method_getGraphicByPoint_D} 
		 * @param point ${mapping_GraphicsLayer_method_getGraphicByPoint_point}
		 * @see com.supermap.web.core.Graphic
		 * 
		 */
		public function getGraphicByPoint(point:Point):Graphic
		{
			var parentContainer:LayerContainer = LayerContainer(this.parent);
			
			if(this._bmdChanged)
			{				
				_bmd = new BitmapData(parentContainer.width, parentContainer.height);
				_behindPanLayer.x = parentContainer.scrollRect.x;
				_behindPanLayer.y = parentContainer.scrollRect.y;
				_behindLayer.width = parentContainer.width;
				_behindLayer.height = parentContainer.height;
				_behindLayer.x = -parentContainer.scrollRect.x;
				_behindLayer.y = -parentContainer.scrollRect.y;
				_behindPanLayer.cacheAsBitmap = true;
				_bmd.draw(_behindPanLayer);
				
				this._bmdChanged = false;
			}
			
			//获取鼠标点对应的颜色值
			var color1:uint = this._bmd.getPixel32(point.x, point.y);
			var alphat:uint = (color1 >> 24) & 0xFF;
			if(alphat != 255)
				return null;
			
			var color:uint = this._bmd.getPixel(point.x, point.y);
			var chex:String = color.toString(16);
			var nc:int = parseInt(chex, 16);
			var currentF1:Graphic = _fDictionary[nc] as Graphic;
				
			if(currentF1)
			{
				var containedPoint:Point2D = this.map.screenToMap(point);
				var containRect:Rectangle2D;
				if(currentF1.geometry is GeoPoint)
				{
					var style:GraphicMarkerStyle = currentF1.style as GraphicMarkerStyle;
					var geoPoint:GeoPoint = currentF1.geometry as GeoPoint;
					if(style.symbol == "icon")
					{
						var geo:GeoRegion = this.getIconBounds(geoPoint.tempIconRec);
						//							this.add([new Graphic(geo)]);
						if(!geo.contains(new GeoPoint(containedPoint.x,containedPoint.y)))
						{
							return null;
						}
					}
					else
					{
						//容器内的像素坐标
						//var screenPoint:Point = new Point(this.map.mapToContainerX(point.x),this.map.mapToContainerY(point.y));
						var screenPoint:Point = this.map.mapToScreen(new Point2D(geoPoint.x,geoPoint.y));
						containRect = this.getPointBounds(screenPoint, style.xOffset, style.yOffset, style.size/2);
					}
				}
				else
					containRect = currentF1.geometry.bounds;
				
				if(containRect && (!containRect.containsPoint(containedPoint)))
				{
					return null;
				}
			}
			
			return currentF1
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */
		override protected function zoomStartHandler(event:ZoomEvent):void
		{
			super.zoomStartHandler(event);
			_preLayer.visible = false;
			_behindLayer.visible = false;
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */
		override protected function zoomEndHandler(event:ZoomEvent):void
		{
			super.zoomEndHandler(event);
			_preLayer.visible = true;
			_behindLayer.visible = true;
			this.graphics.clear();
		}
	}
}
