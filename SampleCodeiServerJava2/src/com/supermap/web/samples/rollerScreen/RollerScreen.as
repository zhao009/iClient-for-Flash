package com.supermap.web.samples.rollerScreen
{    
	import com.supermap.web.actions.MapAction;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.events.MapEvent;
	import com.supermap.web.events.PanEvent;
	import com.supermap.web.events.ViewBoundsEvent;
	import com.supermap.web.events.ZoomEvent;
	import com.supermap.web.mapping.Layer;
	import com.supermap.web.mapping.Map;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Image;
	import mx.core.UIComponent;
	import mx.effects.Move;
	import mx.effects.effectClasses.BlurInstance;
	import mx.events.FlexEvent;
	import mx.managers.CursorManager;
	import mx.managers.CursorManagerPriority;
	
	import spark.components.SkinnableContainer; 
	
	public class RollerScreen extends SkinnableContainer
	{   
		private var _littleMap:Map = new Map();//里面的图
		private var _backMap:Map;//外面的大图
		private var _layer:Layer;
		
		private var _rectMask:UIComponent = new UIComponent();  
		private var _border:RectangleBox;  
		
		//外观样式
		public var fillColor:uint = 0;
		public var fillAlpha:Number = 0;
            
		private var clickArea:int;
		
		public static const LEFT:int = 1000;
		public static const RIGHT:int = 1001;
		public static const TOP:int = 1002;
		public static const BOTTOM:int = 1003;
		
		public static const LEFT_TOP:int = 1004;
		public static const RIGHT_TOP:int = 1005;
		public static const LEFT_BOTTOM:int = 1006;
		public static const RIGHT_BOTTOM:int = 1007;
		 
		public function RollerScreen()          
		{                
			super();   
			this.addElement(this._littleMap);
			this.addEventListener(FlexEvent.PREINITIALIZE, this.preInitializeHandler); 
			this.addEventListener(FlexEvent.UPDATE_COMPLETE, this.update_complete);
 			//将宽度和高度设置为自适应
			this.percentHeight = 100;
			this.percentWidth = 100;
		}  
		
		//--------------------------------------------------------------------------
		//
		//  Get and set
		//
		//--------------------------------------------------------------------------
		
		public function get map():Map
		{
			return _backMap;
		}

		public function set map(value:Map):void
		{
			_backMap = value;   
			if(this._backMap)
			{
				this._backMap.addEventListener(MapEvent.LOAD, this.backMapLoadHandler);	
			}
		}

		public function get layer():Layer
		{
			return _layer;
		}
		
		public function set layer(value:Layer):void
		{
			if(this._layer)
			{
				this._littleMap.removeEventListener(MapEvent.LOAD, this.littlemap_loadHandler); 
				this._littleMap.removeEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, viewBoundsChangeHandler);
				this._littleMap.removeEventListener(ZoomEvent.ZOOM_END, zoomEndHandler);
			} 
			_layer = value; 
			if (this._layer)
			{
				this._littleMap.addElement(layer);  
				this._littleMap.addEventListener(MapEvent.LOAD, this.littlemap_loadHandler); 
				this._littleMap.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, viewBoundsChangeHandler); 
				this._littleMap.addEventListener(ZoomEvent.ZOOM_END, zoomEndHandler);
			}  
		}
		
		public function littlemap_loadHandler(event:MapEvent):void
		{    
			this._littleMap.action = null;//给这个家伙上条铁链，不让它平移 
			//先初始化Border然后再初始化Mask
			this.initBorder();
		  	this.initMask(); 
		}
		
		private function initBorder():void
		{    
			var rect:Rectangle = new Rectangle(_littleMap.x, _littleMap.y, _littleMap.width, _littleMap.height); 
			this._border = RectangleBox.createIndexBox(rect.left, rect.top, rect.right, rect.bottom, this.fillColor, this.fillAlpha);  
			this.addElement(this._border); 
			this._border.visible = false;
		} 
		 
		private function initMask():void
		{ 
			_rectMask.name = "myMask"; 
			this._rectMask.x = 0;
			this._rectMask.y = 0;  
			this._rectMask.graphics.clear();
			this._rectMask.width = _littleMap.width;
			this._rectMask.height = _littleMap.height;
		
			this._border.addChild(this._rectMask);//将mask作为子控件添加到border里面
			_littleMap.mask = _rectMask; 
			var g:Graphics = _rectMask.graphics;  
			g.beginFill(0x0000ff, 0); //透明度在这里基本不起作用
			g.drawRect(this._littleMap.x, this._littleMap.y, this._littleMap.width, this._littleMap.height); 
			g.endFill(); 
		} 
		
		//--------------------------------------------------------------------------
		//
		//  Event handler
		//
		//--------------------------------------------------------------------------
		
		private function mouseDownHandler(event:MouseEvent):void
		{   
			event.stopPropagation(); 
			var pt:Point = new Point(event.stageX, event.stageY);
			pt = globalToLocal(pt); 
			startDragging();  
			this.setMaskMode(pt);    
		} 
		
		private function mouseMoveHandler(event:MouseEvent):void
		{   
			var pt:Point = new Point(event.stageX, event.stageY);
			pt = globalToLocal(pt);  
			this.setMaskMove(pt); 
			this._backMap.zoomToLevel(this._littleMap.level, this._littleMap.viewBounds.center);//这句代码可能会带来尾图缺陷 
		}
		
		private function mouseUpHandler(event:MouseEvent):void
		{    
			stopDragging(); 
	
			this.initMask();//恢复到正常状态
		} 
		
		private function mouseLeaveHandler(event:MouseEvent):void
		{ 
			stopDragging(); 
		}
		
		private function viewBoundsChangeHandler(event:ViewBoundsEvent):void
		{   
			this._backMap.viewBounds = this._littleMap.viewBounds;
		}
		
		private function zoomEndHandler(event:ZoomEvent):void
		{
			this._backMap.viewBounds = this._littleMap.viewBounds;
		}
  
		//--------------------------------------------------------------------------
		//
		//  Action function
		//
		//--------------------------------------------------------------------------
		
		private function preInitializeHandler(event:FlexEvent):void
		{   
			this._littleMap.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler); 
			this._littleMap.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler); 
			
		}
		
		private function update_complete(event:FlexEvent):void
		{ 
			this.percentHeight = 100;
			this.percentWidth = 100;
			this._littleMap.percentHeight = 100;
			this._littleMap.percentWidth = 100; 
			
			this.initBorder();
			this.initMask();  
		}
		
		private function backMapLoadHandler(event:MapEvent):void
		{
			this._backMap.action = null;
		}
	
		private function startDragging():void
		{  
			this._border.visible = true;
			this.parent.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler); 
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}  
		
		private function stopDragging():void
		{   
			this._border.visible = false; 
			this.parent.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler); 
			this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
		}
		
		
		private function drawTriangle(point1:Point, point2:Point, point3:Point):void
		{
			this._rectMask.graphics.clear();
			this._rectMask.graphics.beginFill(0x0000ff, 0);
			this._rectMask.graphics.moveTo(point1.x, point1.y);
			this._rectMask.graphics.lineTo(point2.x, point2.y);
			this._rectMask.graphics.lineTo(point3.x, point3.y);
			this._rectMask.graphics.lineTo(point1.x, point1.y);
			this._rectMask.graphics.endFill();
		}
		 
		private function drawTriangleByArea(area:int):void//通过区域属性来画三角形
		{
			var x:int = this._littleMap.x;
			var y:int = this._littleMap.y;
			var w:int = this._littleMap.width;
			var h:int = this._littleMap.height;
			if(area == RollerScreen.LEFT_TOP)//左上角
			{ 
				this.drawTriangle(new Point(x + w, y + h), new Point(x - w, y + h), new Point(x + w, y - h))
			}
			else if(area == RollerScreen.LEFT_BOTTOM)
			{
				this.drawTriangle(new Point(x - w, y), new Point(x + w, y), new Point(x + w, y + 2 * h));
			}
			else if(area == RollerScreen.RIGHT_TOP)
			{
				this.drawTriangle(new Point(0, -h), new Point(2 * w, h), new Point(0, h));
			}
			else if(area == RollerScreen.RIGHT_BOTTOM)
			{
				this.drawTriangle(new Point(0, 0), new Point(2 * w, 0), new Point(0, 2 * h));
			}
		}
		
		
		private function setTriangelMask(pt:Point):void
		{ 
			this._rectMask.visible = false;
			var w:int = this._littleMap.width;
			var h:int = this._littleMap.height;
			//开始做其他四个区
			if(
				(pt.x >= this._littleMap.x)&& 
				(pt.x <= this._littleMap.width / 3 + this._littleMap.x) && 
				(pt.y >= this._littleMap.y) && 
				(pt.y <= this._littleMap.height / 3  + this._littleMap.y)
			) 
			{
				//左上区  
				this.clickArea = RollerScreen.LEFT_TOP;   
				this._rectMask.x = pt.x;
				this._rectMask.y = pt.y;
	 
				this.drawTriangleByArea(this.clickArea);
			}
			else if(
				(pt.x >= this._littleMap.x) && 
				(pt.x <= this._littleMap.width / 3 + this._littleMap.x) && 
				(pt.y >= this._littleMap.height / 3 * 2 + this._littleMap.y) && 
				(pt.y <= this._littleMap.height + this._littleMap.y)
			) 	
			{
				//左下区  
				this.clickArea = RollerScreen.LEFT_BOTTOM;  
				this._rectMask.x = pt.x;
				this._rectMask.y = pt.y - this._littleMap.height;
				
			 	this.drawTriangleByArea(this.clickArea);
			} 
				
			else if(
				(pt.x >= this._littleMap.width / 3 * 2 + this._littleMap.x) && 
				(pt.x <= this._littleMap.width + this._littleMap.x) && 
				(pt.y >= this._littleMap.y) && 
				(pt.y <= this._littleMap.height / 3  + this._littleMap.y)
			) 	
			{
				//右上区  
				this.clickArea = RollerScreen.RIGHT_TOP;  
				this._rectMask.x = pt.x - this._littleMap.width;
				this._rectMask.y = pt.y;
				
				this.drawTriangleByArea(this.clickArea);
			} 
				
			else if(
				(pt.x >= this._littleMap.width / 3 * 2 + this._littleMap.x) && 
				(pt.x <= this._littleMap.width + this._littleMap.x)&& 
				(pt.y >= this._littleMap.height/ 3 * 2 + this._littleMap.y) && 
				(pt.y <= this._littleMap.height + this._littleMap.y)
			) 	
			{
				//右下区  
				this.clickArea = RollerScreen.RIGHT_BOTTOM;   
				this._rectMask.x = pt.x - this._littleMap.width;
				this._rectMask.y = pt.y - this._littleMap.height;
				
				this.drawTriangleByArea(this.clickArea);
			}   
		}
	 
		private function setMaskMode(pt:Point):void//鼠标单击时的处理方法
		{    
			if(
				(pt.x >= this._littleMap.x) && 
				(pt.x <= this._littleMap.width / 2 + this._littleMap.x) && 
				(pt.y >= this._littleMap.height / 3 + this._littleMap.y) && 
				(pt.y <= this._littleMap.height / 3 * 2 + this._littleMap.y)
			)//鼠标点中了左侧
			{
				//左区  
				this.clickArea = RollerScreen.LEFT;
				this._rectMask.x = pt.x;
			}
			else if(
				(pt.x >= this._littleMap.width / 2 + this._littleMap.x) && 
				(pt.x <= this._littleMap.width + this._littleMap.x) && 
				(pt.y >= this._littleMap.height / 3 + this._littleMap.y) && 
				(pt.y <= this._littleMap.height / 3 * 2 + this._littleMap.y)
			)//鼠标点中了左侧 	
			{
				//右区 
				this.clickArea = RollerScreen.RIGHT; 
				this._rectMask.x = pt.x - this._littleMap.width;
			} 
				
			else if(
				(pt.x >= this._littleMap.width / 3 + this._littleMap.x) &&
				(pt.x <= this._littleMap.width  / 3 * 2 + this._littleMap.x) && 
				(pt.y >= this._littleMap.y ) && 
				(pt.y <= this._littleMap.height / 3 + this._littleMap.y)
			)//鼠标点中了左侧 	
			{
				//上区 
				this.clickArea = RollerScreen.TOP; 
				this._rectMask.y = pt.y;
			} 
				
			else if(
				(pt.x >= this._littleMap.width / 3 + this._littleMap.x) &&
				(pt.x <= this._littleMap.width  / 3 * 2 + this._littleMap.x) && 
				(pt.y >= this._littleMap.height / 3 * 2 + this._littleMap.y) && 
				(pt.y <= this._littleMap.height + this._littleMap.y)
			)//鼠标点中了左侧 	
			{
				//下区 
				this.clickArea = RollerScreen.BOTTOM; 
				this._rectMask.y = pt.y - this._littleMap.height;
			}  
			else
			{
				this.setTriangelMask(pt);//当鼠标点中斜角时，调用另一个函数 
		
		 
			}
		} 
		 
		private function setMaskMove(pt:Point):void
		{
			if(this.clickArea == RollerScreen.LEFT)
			{
				this._rectMask.x = pt.x; 
			}
			else if(this.clickArea == RollerScreen.RIGHT)
			{
				this._rectMask.x = pt.x - this._littleMap.width;
			}
			else if(this.clickArea == RollerScreen.TOP)
			{
				this._rectMask.y = pt.y;
			}
			else if(this.clickArea == RollerScreen.BOTTOM)
			{
				this._rectMask.y = pt.y - this._littleMap.height;
			} 
			//下面是四个角上的效果
			else if(this.clickArea == RollerScreen.LEFT_TOP)
			{
				this._rectMask.x = pt.x;
				this._rectMask.y = pt.y;
			}
			else if(this.clickArea == RollerScreen.LEFT_BOTTOM)
			{
				this._rectMask.x = pt.x;
				this._rectMask.y = pt.y - this._littleMap.height;
			}
			else if(this.clickArea == RollerScreen.RIGHT_TOP)
			{
				this._rectMask.x = pt.x - this._littleMap.width;
				this._rectMask.y = pt.y;
			}
			else if(this.clickArea == RollerScreen.RIGHT_BOTTOM)
			{
				this._rectMask.x = pt.x - this._littleMap.width;
				this._rectMask.y = pt.y - this._littleMap.height;
			}
		} 
	}
}