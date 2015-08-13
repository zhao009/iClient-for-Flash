package com.supermap.web.components
{     
	import com.supermap.web.actions.MapAction;
	import com.supermap.web.components.skins.MagnifierSkin;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.events.MapEvent;
	import com.supermap.web.events.ViewBoundsEvent;
	import com.supermap.web.mapping.Layer;
	import com.supermap.web.mapping.Map;
	
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	import spark.components.SkinnableContainer;
	import spark.components.supportClasses.SkinnableComponent;
	
	[IconFile("/designIcon/Magnifier.png")]
	/**
	 * ${controls_Magnifier_Title}.
	 * <p>${controls_Magnifier_Description}</p> 
	 * 
	 */	
	public class Magnifier extends SkinnableContainer
	{   
		private var _littleMap:Map;//放大镜里面的图
		private var _map:Map;//放大镜外面的大图
		private var _mapLayer:Layer;  
		private var _border:SkinnableContainer = new SkinnableContainer();      
		private var _zoomFactor:int = 1;  
		private var _cursorID:int = -1;  
		private var _disableMouseWheel:Boolean = false;//默认滚轮是不关闭的 
		private var _skinElement:SkinnableComponent = new SkinnableComponent();//由于一直都存在，所以不用lazyDog方法
		private var _myMask:UIComponent;
		private var _mapEnabled:Boolean = true;//默认放大镜启用，响应出图
		
		[Embed(source="/../assets/images/action/scope_press.png")]//定义鼠标图标
		private var _cursorIcon:Class; 
		/**
		 * ${controls_Magnifier_constructor_None_D} 
		 * 
		 */		
		public function Magnifier()          
		{                
			super(); 
			this.percentHeight = 100;
			this.percentWidth = 100; 
			this.skinElement.setStyle("skinClass", MagnifierSkin);
			this.skinElement.x = this.skinElement.y = 0;
			this.skinElement.width = this.skinElement.height = 200;
			this._border.invalidateDisplayList(); 
		}  
	 
		private function get skinElement():SkinnableComponent
		{
			return _skinElement;
		}

		private function set skinElement(value:SkinnableComponent):void
		{
			_skinElement = value;
		}
 
		/**
		 * ${controls_Magnifier_attribute_radius_D}.
		 * <p>${controls_Magnifier_attribute_radius_remarks}</p> 
		 * 
		 */		
		public function set radius(value:Number):void
		{
			this.skinElement.width = this.skinElement.height = 2 * value;  
		}
		
		/**
		 * ${controls_Magnifier_attribute_stageX_D} 
		 * @param value
		 * 
		 */		
		public function set stageX(value:Number):void
		{
			this._border.x = value;
		}
		
		/**
		 * ${controls_Magnifier_attribute_stageY_D} 
		 * @param value
		 * 
		 */		
		public function set stageY(value:Number):void
		{
			this._border.y = value;
		}
		  
		/**
		 * ${controls_Magnifier_attribute_width_D} 
		 * @param value
		 * 
		 */		
		override public function set width(value:Number):void
		{
			this.skinElement.width = value;
		}
	 
		/**
		 * ${controls_Magnifier_attribute_height_D} 
		 * @param value
		 * 
		 */		
		override public function set height(value:Number):void
		{
			this.skinElement.height = value;
		}
		
		/**
		 * ${controls_Magnifier_attribute_skinClass_D} 
		 * @param value
		 * 
		 */		
		public function set skinClass(value:Class):void
		{
			this.skinElement.setStyle("skinClass", value); 
			this._border.invalidateDisplayList();
		}
	 
		[Inspectable(category = "iClient",  enumeration = "true,false")]
		/**
		 * ${controls_Magnifier_attribute_disableMouseWheel_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get disableMouseWheel():Boolean
		{
			return _disableMouseWheel;
		}
		
		public function set disableMouseWheel(value:Boolean):void
		{
			_disableMouseWheel = value;
		}
	  
		[Inspectable(category = "iClient",  enumeration = "true,false")]
		/**
		 * @default true 
		 * @return 
		 * 
		 */		
		public function get mapEnabled():Boolean
		{
			return _mapEnabled;
		}
		
		public function set mapEnabled(value:Boolean):void
		{
			this.enabled = this._mapEnabled = value;
			//为true刷新当前显示
			if(value)
			{
				scaleMap();
			}
		}
	
		override public function set visible(value:Boolean):void
		{
			super.visible = value;
			mapEnabled = value;
		}
		
		[Inspectable(category = "iClient")]
		/**
		 * ${controls_Magnifier_attribute_zoomFactor_D} 
		 * @default 1
		 * @return 
		 * 
		 */		
		public function get zoomFactor():int
		{
			return _zoomFactor; 
		}
		
		public function set zoomFactor(value:int):void
		{
			_zoomFactor = value;   
		}
		
		[Inspectable(category = "iClient")]
		/**
		 * ${controls_Magnifier_attribute_map_D} 
		 * @return 
		 * 
		 */		
		public function get map():Map
		{
			return _map;
		}
		
		public function set map(value:Map):void
		{
			if(this._map)
			{
				this._map.removeEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.map_viewBoundsChangeHandler);
			} 
			_map = value;
			if(this._map)
			{
				this._map.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.map_viewBoundsChangeHandler, false, 0, true);
			} 
		}
		
		[Inspectable(category = "iClient")]
		/**
		 * ${controls_Magnifier_attribute_layer_D} 
		 * @return 
		 * 
		 */		
		public function get layer():Layer
		{
			return _mapLayer;
		}
		
		public function set layer(value:Layer):void
		{  
			if (this._littleMap)
			{
				this._littleMap.removeEventListener(MapEvent.LOAD, this.map_loadHandler);  
			}
			this._littleMap = new Map(); 
			
			this.addElement(this._littleMap); 
			this._littleMap.panDuration = 0; 
			this._littleMap.zoomDuration = 0; 
			this._littleMap.addEventListener(MapEvent.LOAD, this.map_loadHandler, false, 0, true);  
	
			_mapLayer = value;
			_mapLayer.addEventListener(LayerEvent.UPDATE_END, this.layer_loadEndHandler, false, 0, true);
			_littleMap.addElement(layer);
		}
	 
		/**
		 * @inheritDoc 
		 * @param unscaledWidth
		 * @param unscaledHeight
		 * 
		 */		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{ 
			super.updateDisplayList(unscaledWidth, unscaledHeight); 
			this.updateCircleBorder();
		}
		 
		private function initMask(rect:Rectangle):void
		{
			this._myMask = new UIComponent(); 
			_littleMap.mask = _myMask;
			
			var g:Graphics = _myMask.graphics; 
			g.clear();
			g.beginFill(0x0000ff, 0); //透明度在这里基本不起作用 
			g.drawEllipse(this.skinElement.x, this.skinElement.y, this.skinElement.width, this.skinElement.height); 
			g.endFill();  
			this._border.addElement(_myMask);
			this._border.addElement(this.skinElement);
		}
		
		private function initCircleBorder():void
		{   
			var rect:Rectangle = new Rectangle(this.skinElement.x, this.skinElement.y, this.skinElement.width,  this.skinElement.height);  
		 	this.addElement(this._border); 
			//添加事件侦听
			this._border.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			this._border.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler, false, 0, true);
			this._border.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true); 
			this.initMask(rect);
		}
	    
		private function updateCircleBorder():void
		{   
			//var rect:Rectangle = new Rectangle(this.skinElement.x, this.skinElement.y, this.skinElement.width,  this.skinElement.height);  
		 	this.initMask(null);    
		}
		   
		private function map_loadHandler(event:MapEvent):void//当地图加载完成时调用
		{  
			this._littleMap.action = new MapAction(this._littleMap);  
			this.normalMap();
			this.initCircleBorder();
		}
		
		private function layer_loadEndHandler(event:LayerEvent):void
		{ 
			if (this._littleMap)
			{  
				this.scaleMap();//移动地图，对放大区域进行匹配
			} 
		}
		
		private function map_viewBoundsChangeHandler(event:ViewBoundsEvent) : void
		{
			if (this._littleMap)
			{  
				this.scaleMap();//移动地图，对放大区域进行匹配
			} 
		}
		  
		private function mouseOverHandler(event:MouseEvent):void
		{
			event.stopPropagation();    
			this.scaleMap();//将地图放大 
			this._border.removeEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);  
			if(!this.disableMouseWheel)//当鼠标监听失效时，不监听
			{
				this._border.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler, false, 0, true);
			}
		}
		
		private function mouseLeaveHandler(event:MouseEvent):void
		{
			this.stopDragging();
			this._border.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheelHandler);
		}
		
		private function mouseMoveHandler(event:MouseEvent):void
		{      
			this.scaleMap()  
		}
		
		private function mouseUpHandler(event:MouseEvent):void
		{        
			this.scaleMap();//替换上面的函数，将地图放大
			
			this.stopDragging();   
			this._border.stopDrag(); 
			this.removeCursor();
		} 
		
		private function mouseDownHandler(event:MouseEvent):void
		{
			event.stopPropagation();  //确保不对地图进行任何处理 
			
			this.scaleMap();//将地图放大 
			this.startDragging();  
			this._border.startDrag(); 
			 
			this.addCursor();   
		}
		 
		private function mouseWheelHandler(event:MouseEvent):void
		{ 
			event.stopPropagation();
			
			if(event.delta > 0)
			{
				this.zoomFactor++; 
			}
			else
			{ 
				if(this.zoomFactor <= 2)
				{
					this.zoomFactor = 1;//用于控制缩小时的极值
				}
				else
				{
					this.zoomFactor--;
				} 
			} 
			this.scaleMap();//执行缩放 
		}
	 
		private function getPositionParam(point:Point):Array
		{
			var xLength:Number = this.x + this.width;
			var yLength:Number = this.y + this.height;
			if(xLength != 0)
			{
				var leftParam:Number = point.x / xLength;
				var rightParam:Number = 1 - leftParam;
			}
			if(yLength != 0)
			{
				var topParam:Number = point.y / yLength;
				var bottomParam:Number = 1 - topParam;
			} 
			
			var array:Array = [leftParam, rightParam, topParam, bottomParam];
			return array;
		}
		
		private function zoomToResolution( resolution:Number, point:Point2D = null, params:Array = null) : void
		{ 
			
			var leftParam:Number = 0.5;
			var rightParam:Number = 0.5;
			var bottomParam:Number = 0.5;
			var topParam:Number = 0.5;
			
			if(params)
			{
				leftParam = params[0];
				rightParam =  params[1]; 
				topParam =  params[2];
				bottomParam =  params[3];
			}
			
			if(this._littleMap.viewBounds != null && point != null && !isNaN(resolution) && resolution > 0)
			{
				var left:Number = point.x - (resolution * this.width) * leftParam;
				var right:Number = point.x + (resolution * this.width) * rightParam;
				var bottom:Number = point.y - (resolution * this.height) * bottomParam;
				var top:Number = point.y + (resolution * this.height) * topParam;
				try
				{
					this._littleMap.viewBounds = new Rectangle2D(left, bottom, right, top);
				}
				catch(error:ArgumentError)
				{
					return;
				} 
			}		
		} 
		
		private function scaleMap():void
		{ 
			if(!this._mapEnabled)
			{
				return;
			}
			if(this._littleMap && this.map && this.map.viewBounds && this._border)
			{  
				this._littleMap.zoomToResolution(this.map.resolution, this.map.viewBounds.center);//地图先还原 
				
				var centerX:int = this._border.x + this._border.width/2;//放大准备 
				var centerY:int = this._border.y + this._border.height/2;
				var point:Point = new Point(centerX, centerY); 
				var local:Point2D = this._littleMap.screenToMap(point);//获取map上被点中点的2D点  
				var scaleValue:int = this.zoomFactor >= 1? this.zoomFactor : 1;//按silverLigth的公式计算
				this.zoomToResolution(this._littleMap.resolution / scaleValue, local, this.getPositionParam(point)); 
			}
		}
		
		private function normalMap():void
		{ 
			if(this._littleMap && this.map && this.map.viewBounds)
			{ 
				this._littleMap.zoomToResolution(this.map.resolution, this.map.viewBounds.center);
			}
		}
		
		private function startDragging():void
		{
			this.parent.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler, false, 0, true); 
			systemManager.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
		} 
		
		private function stopDragging():void
		{
			this.parent.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler); 
			systemManager.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		} 
	  
		private function removeCursor():void
		{
			this.cursorManager.removeCursor(this._cursorID);
		}
		
		private function addCursor():void
		{ 
			this.cursorManager.removeCursor(this._cursorID);
			this._cursorID = this.cursorManager.setCursor(this._cursorIcon);
		}
	}
}