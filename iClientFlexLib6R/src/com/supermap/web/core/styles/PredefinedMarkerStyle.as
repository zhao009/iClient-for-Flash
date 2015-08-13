package com.supermap.web.core.styles
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.mapping.*;
	import com.supermap.web.sm_internal;
	import com.supermap.web.themes.RawTheme;
	import com.supermap.web.utils.StyleUtil;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.events.PropertyChangeEvent;
	import mx.graphics.SolidColorStroke;

	use namespace sm_internal;
	
	/**
	 * ${core_styles_PredefinedMarkerStyle_Title}.
	 * <p>${core_styles_PredefinedMarkerStyle_Description}</p> 
	 * 
	 */	
	public class PredefinedMarkerStyle extends MarkerStyle
	{
		private var _symbol:String;
		private var _size:Number = 0;		
		private var _color:uint;
		private var _alpha:Number;		
		private var _half:Number = 0;
		private var customSprite:CustomSprite;
		private var _border:PredefinedLineStyle;
		sm_internal var stroke:SolidColorStroke;
		private var _pattern:Array;
		private static var markerDefaultStyle:Style;	
		
		/**
		 * ${core_styles_PredefinedMarkerStyle_const_STYLE_CIRCLE_D} 
		 */		
		public static const SYMBOL_CIRCLE:String = "circle";	
		/**
		 * ${core_styles_PredefinedMarkerStyle_const_STYLE_PENTACLE_D} 
		 */		
		public static const SYMBOL_STAR:String = "star";	
		/**
		 * ${core_styles_PredefinedMarkerStyle_const_STYLE_SQUARE_D} 
		 */		
		public static const SYMBOL_SQUARE:String = "square";
		/**
		 * ${core_styles_PredefinedMarkerStyle_const_STYLE_SYMBOL_DIAMOND_D} 
		 */		
		public static const SYMBOL_DIAMOND:String = "diamond"; 
		/**
		 * ${core_styles_PredefinedMarkerStyle_const_STYLE_TRIANGLE_D} 
		 */		
		public static const SYMBOL_TRIANGLE:String = "triangle";	
		/**
		 * ${core_styles_PredefinedMarkerStyle_const_STYLE_SYMBOL_SECTOR_D} 
		 */		
		public static const SYMBOL_SECTOR:String = "sector";
		/**
		 * ${core_styles_PredefinedMarkerStyle_const_STYLE_X_D} 
		 */		
		public static const SYMBOL_X:String = "x";

		
		//构造函数   
		/**
		 * ${core_styles_PredefinedMarkerStyle_constructor_D} 
		 * @param symbol ${core_styles_PredefinedMarkerStyle_constructor_param_symbol_D}
		 * @param size ${core_styles_PredefinedMarkerStyle_constructor_param_size_D}
		 * @param color ${core_styles_PredefinedMarkerStyle_constructor_param_color_D}
		 * @param alpha ${core_styles_PredefinedMarkerStyle_constructor_param_alpha_D}
		 * @param xOffset ${core_styles_PredefinedMarkerStyle_constructor_param_offsetx_D}
		 * @param yOffset ${core_styles_PredefinedMarkerStyle_constructor_param_offsety_D}
		 * @param angle ${core_styles_PredefinedMarkerStyle_constructor_param_angle_D}
		 * @param border ${core_styles_PredefinedMarkerStyle_constructor_param_border_D}
		 * 
		 */		
		public function PredefinedMarkerStyle(symbol:String = SYMBOL_CIRCLE, size:Number = 12, color:Number = 0x4272d7, alpha:Number = 1,
											  xOffset:Number = 0, yOffset:Number = 0, angle:Number = 0, border:PredefinedLineStyle = null)
		{	 
			this.stroke = new SolidColorStroke();
			this._symbol = symbol;
			this.xOffset = xOffset;
			this.yOffset = yOffset;
			this.angle = angle;	
			this._border = border;
			
			if(!Map.theme)
			{
				this.size = size;	
				this._color = color;
				this._alpha = alpha;
			}
			else
			{
				this._color = (color == 0x4272d7) ? Map.theme.pointColor : color;
				this._alpha = (alpha == 1) ? Map.theme.alpha : alpha;
				this.size = (size == 12) ? Map.theme.size : size;
			}
		}
			
		/**
		 * ${core_styles_PredefinedMarkerStyle_attribute_alpha_D}
		 * @default 1 
		 * @return 
		 * 
		 */		
		public function get alpha():Number
		{
			return _alpha;
		}
		
		public function set alpha(value:Number):void
		{
			var oldValue:Number = this._alpha;
			if(value != this._alpha)
			{
				this._alpha = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alpha", oldValue, value));
				}
			}
		}
		
		/**
		 * ${core_styles_PredefinedMarkerStyle_attribute_border_D} 
		 * @default null
		 * @return 
		 * 
		 */		
		public function get border():PredefinedLineStyle
		{
			return _border;
		}
		
		public function set border(value:PredefinedLineStyle) : void
		{
			var oldValue:PredefinedLineStyle = this._border;
			if(value != this._border)	
			{
				if (this._border)
				{
					this._border.removeEventListener(Event.CHANGE, this.borderChangeHandler);
				}
				this._border = value;
				if (this._border)
				{
					this._border.addEventListener(Event.CHANGE, this.borderChangeHandler);
				}
				
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "border", oldValue, value));
				}
			}
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		public override function clone() : Style
		{
			var markerStyle:PredefinedMarkerStyle = new PredefinedMarkerStyle(this._symbol, this._size, this._color, this._alpha, this.xOffset, this.yOffset, this.angle, this._border);
			
			return markerStyle;
			
		}
		
		/**
		 * ${core_styles_PredefinedMarkerStyle_attribute_color_D} 
		 * @default 0xFF0000
		 * @return 
		 * 
		 */		
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			var oldValue:uint = this._color;
			if(value != this._color)
			{				
				this._color = value;
				dispatchEventChange();						
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "color", oldValue, value));
				}
			}
		}
		
		/**
		 * ${core_styles_PredefinedMarkerStyle_attribute_size_D}
		 * @default 10 
		 * @return 
		 * 
		 */		
		public function get size():Number
		{
			return _size;
		}
		
		public function set size(value:Number):void
		{
			var oldValue:Number = this._size;
			
			if(value != this._size)
			{
				this._size = value <= 0 ? 0 : value;	
				this._half = this._size / 2;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "size", oldValue, value));
				}
			}
		}
		
		[Inspectable(category = "iClient", enumeration = "SYMBOL_CIRCLE,SYMBOL_STAR,SYMBOL_SQUARE,SYMBOL_DIAMOND,SYMBOL_TRIANGLE,SYMBOL_SECTOR,SYMBOL_X", defaultValue = "SYMBOL_CIRCLE")] 
		/**
		 * ${core_styles_PredefinedMarkerStyle_attribute_symbol_D} 
		 * @return 
		 * 
		 */		
		public function get symbol():String
		{
			return _symbol;
		}
		
		public function set symbol(value:String):void
		{
			var oldValue:String = this._symbol;
			if(value != this._symbol)
			{
				this._symbol = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "symbol", oldValue, value));
				}
			}
		}
		
		/**
		 * ${core_styles_PredefinedLineStyle_attribute_pattern_D}.
		 * <p>${core_styles_PredefinedLineStyle_attribute_pattern_remarks}</p>
		 * @return 
		 * 
		 */		
		public  function get pattern():Array
		{
			if(this.border)
			{
				switch(this._border.symbol)
				{
					case PredefinedLineStyle.SYMBOL_DASH:
					{
						this._pattern = [9, 9];
						break;
					}
					case PredefinedLineStyle.SYMBOL_DOT:
					{
						this._pattern = [1, 6];
						break;
					}
					case PredefinedLineStyle.SYMBOL_DASHDOT:
					{
						this._pattern = [6, 4, 1, 4];
						break;
					}
					case PredefinedLineStyle.SYMBOL_DASHDOTDOT:
					{
						this._pattern = [6, 4, 1, 4, 1, 4];
						break;
					}					
					default:
					{
						this._pattern = [1, 0];
						break;
					}
				}
			}
			return this._pattern;
		}
		
		/**
		 * ${core_styles_PredefinedMarkerStyle_attribute_defaultStyle_D} 
		 * @return 
		 * 
		 */		
		public static function get defaultStyle():Style
		{
			if(markerDefaultStyle == null)
			{
				markerDefaultStyle = new PredefinedMarkerStyle();
 			}
			return markerDefaultStyle;
		}
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * @param geometry
		 * @param attributes
		 * @param map
		 * 
		 */		
		override public  function draw(sprite:Sprite,geometry:Geometry,attributes:Object,map:Map):void
		{
			if (!geometry)
			{
				return;
			}		
			if(geometry is GeoPoint)
			{				
				drawPoint(sprite, this._size, this._half, geometry as GeoPoint, map);
			}
			else
			{
				drawOther(sprite, geometry, map);
			}
		}
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * 
		 */		
		override public  function clear(sprite:Sprite):void
		{
			sprite.graphics.clear();
			if(this.angle)
				removeAllChildren(sprite);
		}
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * 
		 */		
		override public function destroy(sprite:Sprite) : void
		{
			removeAllChildren(sprite);
			sprite.graphics.clear();
			sprite.x = 0;
			sprite.y = 0;			
		}
		
		/**
		 * @inheritDoc 
		 * @param width
		 * @param height
		 * @return 
		 * 
		 */		
		override sm_internal function createSwatch(width:Number = 50, height:Number = 50) : UIComponent
		{
			var com:UIComponent = new UIComponent();
			com.width = width;
			com.height = height;
			var child:UIComponent = new UIComponent();
			com.addChild(child);
			var halfW:Number = width * 0.5;
			var halfH:Number = height * 0.5;
			var size:Number = Math.min(this._size, width, height);
			this.drawPoint(child, size, size * 0.5, null, null, halfW, halfH);
			return com;
		}
		
		private function borderChangeHandler(event:Event) : void
		{
			dispatchEventChange();
			
		}
		
		private function drawPoint(sprite:Sprite, size:Number, half:Number, point:GeoPoint, map:Map, centerX:Number = 0, centerY:Number = 0):void
		{			
			if(map && point)
			{
				sprite.x = this.toScreenX(map, point.x) - half;				
				sprite.y = this.toScreenY(map, point.y) - half;	
				sprite.width = size;
				sprite.height = size;    
				if(xOffset)
				{
					sprite.x += xOffset;
				}
				if(yOffset)
				{
					sprite.y -= yOffset;
				}
			}
			else
			{

				sprite.x = centerX - half;
				sprite.y = centerY - half;
				sprite.width = size;
				sprite.height = size;

			}
			switch(this._symbol)
			{	
				case SYMBOL_CIRCLE:
				{
					//此方法已完成
					this.drawPointCircle(sprite, size, half, point);
					break;
				}
				case SYMBOL_STAR:
				{
					//旋转暂时没做
					drawPointStar(sprite, size, half, point);
					break;
				}
				case SYMBOL_SQUARE:
				{
					//此方法已完成
					drawPointSquare(sprite, size, half, point);
					break;
				}
				case SYMBOL_TRIANGLE:
				{
					//此方法已完成
					drawPointTriangle(sprite, size, half, point);
					break;
				}
				case SYMBOL_SECTOR:
				{
					drawPointSector(map,sprite, size, half, point);
					break;
				}
				case SYMBOL_X:
				{					
					//此方法已完成	`
					drawPointX(sprite, size, half, point);
					break;
				}
				case SYMBOL_DIAMOND:
				{
					//此方法已完成
					drawPointDiamond(sprite, size, half, point);
					break;
				}
				default:
				{
					this.drawPointCircle(sprite, size, half, point);
					break;
				}
			}
			
		}
		
		private function drawPointCircle(sprite:Sprite, size:Number, half:Number, point:GeoPoint) : void
		{
			sprite.graphics.beginFill(this._color, this._alpha);			
			if(this._border)
			{
				this.stroke.color = this._border.color;				
				this.stroke.alpha = this._border.alpha;
				this.stroke.weight = this._border.weight;
				if(this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{				
//					if(this._angle)
//					{
//						this.traceRotationCircle(sprite, half, null, false, this.stroke, point);
//					}
//					else
//					{
						this.stroke.apply(sprite.graphics, null, null);
						sprite.graphics.drawCircle(half, half, half);
//					}
				}
				else if(this._border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{				
//					if (this._angle)
//					{
//						this.traceRotationCircle(sprite, half, null, false, null, point);
//					}
//					else
//					{
						sprite.graphics.drawCircle(half, half, half);
//					}
				}
				else
				{
					var ary:Array=[];				
//					if(this._angle)
//					{
//						this.traceRotationCircle(sprite, half, ary, true, null, point);
//					}
//					else
//					{
						sprite.graphics.drawCircle(half, half, half);
						sprite.graphics.endFill();
						this.traceStyledCircle(sprite.graphics, half, half, half, ary);						
						StyleUtil.drawStyledGeoLine(sprite, ary, this.stroke, this.pattern);				
//					}
				}
			}			
			else
			{
//				if(angle)
//				{
//					this.traceRotationCircle(sprite, half, null, false, null, point);
//				}
//				else
//				{					
					sprite.graphics.drawCircle(half, half, half);
//				}
			}			
			sprite.graphics.endFill();
		}
		
//		private function traceRotationCircle(sprite:Sprite, half:Number, arrCirclePoints:Array, isStyled:Boolean, stroke:SolidColorStroke, point:GeoPoint):void
//		{
//			removeAllChildren(sprite);
//			var customSpt:CustomSprite = new CustomSprite();
//			customSpt.point = point;
//			customSpt.x = half; 
//			customSpt.y = half;
//			customSpt.rotation = this._angle;
//			customSpt.graphics.beginFill(this._color, this._alpha);
//			if (this._border && this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
//			{
//				stroke.apply(customSpt.graphics, null, null);
//
//			}	
//			customSpt.graphics.drawCircle(0, 0, half);
//			customSpt.graphics.endFill();
//			if (isStyled)
//			{
//				this.traceStyledCircle(customSpt.graphics, half, half, half, arrCirclePoints);
//				StyleUtil.drawStyledGeoLine(sprite, arrCirclePoints, this.stroke, this.pattern);
//			}
//			sprite.addChild(customSpt);
//		}
		
		private function traceStyledCircle(graphics:Graphics,sx:Number,sy:Number,radius:Number,aryCirclePoints:Array) : void
		{
			var pointX:Number = NaN;
			var pointY:Number = NaN;
			var preRadian:Number = Math.PI / 180;//弧度
			var i:int = 0;
			
			while(i <= 360)
			{
				pointX = sx + radius * Math.sin(i * preRadian);
				pointY = sy + radius * Math.cos(i * preRadian);				
				aryCirclePoints.push(pointX, pointY);				
				i++;
			}			
		}
		
		//画五角星
		private function drawPointStar(sprite:Sprite, size:Number, half:Number, point:GeoPoint) : void
		{ 			
			var ptsStar:Array=[];
			sprite.graphics.beginFill(this._color, this._alpha);
			if(this._border)
			{
				this.stroke.color=this._border.color;
				this.stroke.weight=this._border.weight;
				this.stroke.alpha=this._border.alpha;
				
				if(this._border.symbol==PredefinedLineStyle.SYMBOL_SOLID)
				{
					if (this.angle)
					{
						this.traceRotationStar(sprite, this._size,this._half, null, false, this.stroke, point);
					}
					else
					{
						this.stroke.apply(sprite.graphics, null, null);
						this.traceStar(sprite, half, ptsStar, half, half);											
					}
				}
				else if(this._border.symbol==PredefinedLineStyle.SYMBOL_NULL)
				{
					if (this.angle)
					{
						this.traceRotationStar(sprite, this._size,this._half, null, false, null, point);
					}
					else
					{						
						this.traceStar(sprite, half, ptsStar, half, half);						
					}
				}
				else
				{	
					if(this.angle)
					{
						this.traceRotationStar(sprite, this._size, this._half, ptsStar, true, this.stroke, point);
					}
					else
					{					
						this.traceStar(sprite, half, ptsStar, half, half);	
						sprite.graphics.endFill();
						StyleUtil.drawStyledGeoLine(sprite, ptsStar, this.stroke, this.pattern);
						
					}
				}
			}
			else
			{
				
				if(this.angle)
				{
					this.traceRotationStar(sprite, this._size, this._half, ptsStar, false, this.stroke, point);
				}
				else
				{
					this.traceStar(sprite, half, ptsStar, half, half);						
					
				}
			}
			sprite.graphics.endFill();	
			
		}
		
		private function traceStar(sprite:Sprite, size:Number, ptsStar:Array, x:Number, y:Number) : void
		{			
			//此算法中心点在原点	
			var AToR:Number = Math.PI / 180;
			var sin18:Number = Math.sin(18 * AToR);
			var sin36:Number = Math.sin(36 * AToR);
			var sin54:Number = Math.sin(54 * AToR);
			var sin72:Number = Math.sin(72 * AToR);
			var tan36:Number = Math.tan(36 * AToR);
			
			var ax:Number = -size * sin72;
			var ay:Number=-size*sin18;
			
			var bx:Number=-size*sin18*tan36;
			var by:Number=-size*sin18;
			
			var cx:Number=0;
			var cy:Number=-size;
			
			var dx:Number=size*sin18*tan36;
			var dy:Number=-size*sin18;
			
			var ex:Number=size*sin72;
			var ey:Number=-size*sin18;
			
			var fx:Number=size*sin18*tan36*(1+2*sin18);
			var fy:Number=size*sin18*(2*sin72*tan36-1);
			
			var gx:Number=size*sin36;
			var gy:Number=size*sin54;
			
			var hx:Number=0;
			var hy:Number=size*sin18*(1/sin54);
			
			var ix:Number=-size*sin36;
			var iy:Number=size*sin54;
			
			var jx:Number=-size*sin18*tan36*(1+2*sin18);
			var jy:Number=size*sin18*(2*sin72*tan36-1);
			
			ax+=x;
			bx+=x;
			cx+=x;
			dx+=x;			
			ex+=x;
			fx+=x;
			gx+=x;
			hx+=x;			
			ix+=x;
			jx+=x;
			
			ay+=y;
			by+=y;
			cy+=y;
			dy+=y;			
			ey+=y;
			fy+=y;
			gy+=y;
			hy+=y;			
			iy+=y;
			jy+=y;			
			
			//sprite.graphics.beginFill(0,0.6);
			sprite.graphics.moveTo(ax,ay);			
			sprite.graphics.lineTo(bx,by);		
			sprite.graphics.lineTo(cx,cy);
			sprite.graphics.lineTo(dx,dy);
			sprite.graphics.lineTo(ex,ey);	
			sprite.graphics.lineTo(fx,fy);				
			sprite.graphics.lineTo(gx,gy);
			sprite.graphics.lineTo(hx,hy);
			sprite.graphics.lineTo(ix,iy);
			sprite.graphics.lineTo(jx,jy);
			
			ptsStar.push(ax,ay,bx,by,cx,cy,dx,dy,ex,ey,fx,fy,gx,gy,hx,hy,ix,iy,jx,jy,ax,ay);
		}
		
		private function traceRotationStar(sprite:Sprite, size:Number, half:Number, arrStarPoints:Array, isStyled:Boolean, stroke:SolidColorStroke, point:GeoPoint):void
		{
			removeAllChildren(sprite);
			var customSprite:CustomSprite = new CustomSprite();
			customSprite.point = point;
			customSprite.x = half;//this.size/2
			customSprite.y = half;
			customSprite.rotation = this.angle;
			customSprite.graphics.beginFill(this._color, this._alpha);		
			arrStarPoints = [];
			if (this._border && this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
			{
				stroke.apply(customSprite.graphics, null, null);
			}			
			this.traceStar(customSprite, half, arrStarPoints, 0, 0);
			customSprite.graphics.endFill();
			if (isStyled)
			{						
				StyleUtil.drawStyledGeoLine(customSprite, arrStarPoints, stroke, this.pattern);
			}
			sprite.addChild(customSprite);
		}
		
		//正方形 
		private function drawPointSquare(sprite:Sprite, size:Number, half:Number, point:GeoPoint) : void
		{
			var ptsSquare:Array = null;
			sprite.graphics.beginFill(this._color, this._alpha);
			if (this._border)
			{
				this.stroke.color = this._border.color;
				this.stroke.weight = this._border.weight;
				this.stroke.alpha = this._border.alpha;
				if (this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{					
					if (this.angle)
					{
						this.traceRotationSquare(sprite, size, half, null, false, this.stroke, point);
					}
					else
					{
						this.stroke.apply(sprite.graphics, null, null);
						sprite.graphics.drawRect(0, 0, size, size);
					}
				}
				else if (this._border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{					
					if (this.angle)
					{
						this.traceRotationSquare(sprite, size, half, null, false, null, point);
					}
					else
					{
						sprite.graphics.drawRect(0, 0, size, size);
					}
				}
				else
				{
					ptsSquare = [];					
					if (this.angle)
					{
						this.traceRotationSquare(sprite, size, half, ptsSquare, true, this.stroke, point);
					}
					else
					{						
						ptsSquare.push(0, 0, size, 0, size, size, 0, size, 0, 0);
						sprite.graphics.drawRect(0, 0, size, size);
						sprite.graphics.endFill();
						StyleUtil.drawStyledGeoLine(sprite, ptsSquare, this.stroke, this.pattern);
					}
				}
			}
			else
			{				
				if (this.angle)
				{
					this.traceRotationSquare(sprite, size, half, null, false, null, point);
				}
				else
				{
					sprite.graphics.drawRect(0, 0, size, size);
				}
			}
			sprite.graphics.endFill();
		}
		
		//旋转矩形
		private function traceRotationSquare(sprite:Sprite, size:Number, half:Number, arrSquarePoints:Array, isStyled:Boolean, stroke:SolidColorStroke, point:GeoPoint) : void
		{
			removeAllChildren(sprite);
			var customSprite:CustomSprite = new CustomSprite();
			customSprite.point = point;
			customSprite.x = half;
			customSprite.y = half;
			customSprite.rotation = angle;
			customSprite.graphics.beginFill(this._color, this._alpha);
			
			if (this._border && this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
			{
				stroke.apply(customSprite.graphics, null, null);
			}
			customSprite.graphics.drawRect(-half, -half, size, size);
			customSprite.graphics.endFill();
			if (isStyled)
			{
				arrSquarePoints.push(-half, half, -half, -half, half, -half, half, half, -half, half);
				StyleUtil.drawStyledGeoLine(customSprite, arrSquarePoints, stroke, this.pattern);
			}
			sprite.addChild(customSprite);
		}
		
		//三角形
		private function drawPointTriangle(sprite:Sprite, size:Number, half:Number, point:GeoPoint) : void
		{
			var ptsTriangle:Array = null;
			sprite.graphics.beginFill(this._color, this._alpha);
			if (this._border)
			{
				this.stroke.color = this._border.color;
				this.stroke.weight = this._border.weight;
				this.stroke.alpha = this._border.alpha;
				if (this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{				
					if (this.angle)
					{
						this.traceRotationTriangle(sprite, size, half, null, false, this.stroke, point);
					}
					else
					{
						this.stroke.apply(sprite.graphics, null, null);
						this.traceTriangle(sprite.graphics, half, half, half);
					}
				}
				else if (this._border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{				
					if (this.angle)
					{
						this.traceRotationTriangle(sprite, size, half, null, false, null, point);
					}
					else
					{
						this.traceTriangle(sprite.graphics, half, half, half);
					}
				}
				else
				{
					ptsTriangle = [];					
					if (this.angle)
					{						
						this.traceRotationTriangle(sprite, size, half, ptsTriangle, true, this.stroke, point);
					}
					else
					{						
						this.traceTriangle(sprite.graphics, half, half, half);
						sprite.graphics.endFill();
						
						var pt01x:Number = 0;
						var pt01y:Number = half * 1.5;
						var pt02x:Number = half;
						var pt02y:Number = 0;
						var pt03x:Number = Math.sqrt(size * size - half / 2 * half / 2);
						var pt03y:Number = pt01y;	
						ptsTriangle.push(pt01x, pt01y, pt02x, pt02y, pt03x, pt03y, pt01x, pt01y);						
						StyleUtil.drawStyledGeoLine(sprite, ptsTriangle, this.stroke, this.pattern);
						
					}
				}
			}
			else
			{			
				if (this.angle)
				{
					this.traceRotationTriangle(sprite, size, half, null, false, null, point);
				}
				else
				{
					this.traceTriangle(sprite.graphics, half, half, half);
				}
			}
			sprite.graphics.endFill();
		}
		
		//以等边三角形的中心进行平面内旋转一定的角度
		private function traceRotationTriangle(sprite:Sprite, size:Number, half:Number, arrTrianglePoints:Array, isStyled:Boolean, stroke:SolidColorStroke, point:GeoPoint):void
		{
			removeAllChildren(sprite);
			var custromSprite:CustomSprite = new CustomSprite();
			custromSprite.point = point;
			sprite.addChild(custromSprite);
			custromSprite.x = half;//this.size/2
			custromSprite.y = half;
			custromSprite.rotation = this.angle;
			custromSprite.graphics.beginFill(this._color, this._alpha);
			
			if (this._border && this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
			{
				stroke.apply(custromSprite.graphics, null, null);
			}			
			this.traceTriangle(custromSprite.graphics, 0, 0, half);
			custromSprite.graphics.endFill();
			if (isStyled)
			{
				var halfhalf:Number = 0.5 * half;
				var height:Number = Math.sqrt(half * half - halfhalf * halfhalf);
				arrTrianglePoints.push(-height, halfhalf, 0, -half, height, halfhalf, -height, halfhalf);
				StyleUtil.drawStyledGeoLine(custromSprite, arrTrianglePoints, stroke, this.pattern);
			}
		}
		
		private function traceTriangle(graphics:Graphics, sx:Number, sy:Number, half:Number) : void
		{			
			var halfhalf:Number = half * 0.5;
			var height:Number = Math.sqrt(half * half - halfhalf * halfhalf);
			graphics.moveTo(sx - height ,sy + halfhalf);
			graphics.lineTo(sx, sy - half);			
			graphics.lineTo(sx + height, sy + halfhalf);	
		}
		
		//画扇形
		private function drawPointSector(map:Map,sprite:Sprite, size:Number, half:Number, point:GeoPoint) : void
		{			
//			sprite.x = this.toScreenX(map, point.x) - this.size;
//			sprite.y = this.toScreenY(map, point.y) - this.size;
//			sprite.width = this.size * 2;
//			sprite.height = this.size * 2;			
			sprite.graphics.beginFill(this.color, this.alpha);			
			var ptsSector:Array = [];
			if (this._border)
			{
				this.stroke.color = this._border.color;				
				this.stroke.alpha = this._border.alpha;
				this.stroke.weight = this._border.weight;
				if (this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					if(this.angle)
					{
						this.traceRotationSector(sprite, size, half, ptsSector, false, this.stroke, point);
					}
					else
					{
						this.stroke.apply(sprite.graphics, null, null);
						this.traceSector(sprite, half, half, half, null);
					}
				}
				else if (this._border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{				
					if(this.angle)
					{
						this.traceRotationSector(sprite, size, half, ptsSector, false, null, point);
					}
					else
					{
						this.traceSector(sprite, half, half, half, null);
					}
				}
				else
				{
					if(this.angle)
					{
						this.traceRotationSector(sprite, size, half, ptsSector, true, this.stroke, point);
					}
					else
					{
						sprite.graphics.beginFill(this.color, this.alpha);
						this.traceSector(sprite, half, half, half, ptsSector);
						sprite.graphics.endFill();					
						StyleUtil.drawStyledGeoLine(sprite, ptsSector, this.stroke, this.pattern);
					}
					
				}
			}
			else
			{
				if(this.angle)
				{
					this.traceRotationSector(sprite, size, half, ptsSector, false, null, point);
				}
				else
				{
					this.traceSector(sprite, half, half, half, null);
				}
			}
		}
		
		private function traceRotationSector(sprite:Sprite, size:Number, half:Number, sectorPoints:Array, isStyled:Boolean, stroke:SolidColorStroke, point:GeoPoint):void
		{
			removeAllChildren(sprite);
			var custromSprite:CustomSprite = new CustomSprite();
			custromSprite.point = point;
			sprite.addChild(custromSprite);
			custromSprite.x = half;
			custromSprite.y = half;
			custromSprite.rotation = this.angle;
			custromSprite.graphics.beginFill(this._color, this._alpha);
			
			if (this._border && this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
			{
				stroke.apply(custromSprite.graphics, null, null);
			}			
			this.traceSector(custromSprite, 0, 0, half, sectorPoints);
			custromSprite.graphics.endFill();
			if (isStyled)
			{
				StyleUtil.drawStyledGeoLine(custromSprite, sectorPoints, stroke, this.pattern);
			}
		}
		
		private function traceSector(sprite:Sprite, sx:Number, sy:Number, radius:Number, sectorPoints:Array):void
		{
			if(!sectorPoints)
			{
				sectorPoints = [];
			}
			var AToR:Number = Math.PI / 180;
			var startAngle:Number = 45 * AToR;
			var endAngle:Number = -45 * AToR;			
			var startArcPoint:Point = new Point(sx + radius * Math.cos(startAngle), sy - radius * Math.sin(startAngle));
			sprite.graphics.moveTo(startArcPoint.x, startArcPoint.y);
			sectorPoints.push(startArcPoint.x, startArcPoint.y);
			for(var i:int = 1;i <= 90; i++)
			{
				var centerLineAngle:Number = (45 - i) * AToR;
				var centerLineAngleX:Number = sx + radius * Math.cos(centerLineAngle);
				var centerLineAngleY:Number = sy - radius * Math.sin(centerLineAngle);				
				sprite.graphics.lineTo(centerLineAngleX, centerLineAngleY);				
				sectorPoints.push(centerLineAngleX, centerLineAngleY);								
			}
			
			var size:Number = radius * 0.5; 
			sprite.graphics.lineTo(sx, sy);
			sectorPoints.push(sx, sy);			
			sectorPoints.push(startArcPoint.x, startArcPoint.y);		
		}
		
		
		//绘制“X”
		private function drawPointX(sprite:Sprite,size:Number,half:Number,point:GeoPoint) : void
		{			
			var ptsX:Array = null;
			var pts:Array = null;
			sprite.graphics.beginFill(this._color, this._alpha);
			this.stroke.color = this._color;
			this.stroke.alpha = this._alpha;
			if (this._border)
			{
				this.stroke.weight = this._border.weight;
				if (this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{					
					if (this.angle)
					{
						this.traceRotationX(sprite, size, half, null, false, this.stroke, point);
					}
					else
						
					{
						this.stroke.apply(sprite.graphics, null, null);
						this.traceX(sprite.graphics, half, half, half);
					}
				}
				else if (this._border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{
					this.stroke.weight = 1;					
					if (this.angle)
					{
						this.traceRotationX(sprite, size, half, null, false, this.stroke, point);
					}
					else
					{
						this.stroke.apply(sprite.graphics, null, null);
						this.traceX(sprite.graphics, half, half, half);
					}
				}
				else
				{
					ptsX = [];					
					if (this.angle)
					{
						this.traceRotationX(sprite, size, half, ptsX, true, this.stroke, point);
					}
					else
					{
						ptsX.push([0, size, size, 0], [size, size, 0, 0]);
						this.traceX(sprite.graphics, half, half, half);
						sprite.graphics.endFill();
						for each (pts in ptsX)
						{	
							StyleUtil.drawStyledGeoLine(sprite,pts,this.stroke, this.pattern);
						}
					}
				}
			}
			else
			{
				this.stroke.weight = 1;			
				if (angle && this.angle)
				{
					this.traceRotationX(sprite, size, half, null, false, this.stroke, point);
				}
				else
				{
					this.stroke.apply(sprite.graphics, null, null);
					this.traceX(sprite.graphics, half, half, half);
				}
			}
			sprite.graphics.endFill();
		}
		
		private function traceX(graphics:Graphics, sx:Number, sy:Number, half:Number) : void
		{
			graphics.moveTo(sx - half, sy + half);
			graphics.lineTo(sx + half, sy - half);
			graphics.moveTo(sx + half, sy + half);
			graphics.lineTo(sx - half, sy - half);
			
		}
		
		private function traceRotationX(sprite:Sprite, size:Number, half:Number, arrXPoints:Array, isStyled:Boolean, stroke:SolidColorStroke, point:GeoPoint) : void
		{
			var ptsX:Array = null;
			removeAllChildren(sprite);
			var customSprite:CustomSprite = new CustomSprite();
			customSprite.point = point;
			customSprite.x = half;
			customSprite.y = half;
			customSprite.rotation = angle;
			customSprite.graphics.beginFill(this._color, this._alpha);
			if (this._border)
			{
				if (this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					stroke.apply(customSprite.graphics, null, null);
				}
			}
			else
			{
				stroke.apply(customSprite.graphics, null, null);
			}
			this.traceX(customSprite.graphics, 0, 0, half);
			customSprite.graphics.endFill();
			if (isStyled)
			{
				arrXPoints.push([-half, half, half, -half], [half, half, -half, -half]);
				for each (ptsX in arrXPoints)
				{
					StyleUtil.drawStyledGeoLine(customSprite, ptsX, stroke, this.pattern);
				}
			}
			sprite.addChild(customSprite);
		}
		
		//画菱形
		private function drawPointDiamond(sprite:Sprite,size:Number,half:Number,point:GeoPoint) : void
		{
			var ptsDiamond:Array = null;
			sprite.graphics.beginFill(this._color, this._alpha);
			if (this._border)
			{
				this.stroke.color = this._border.color;
				this.stroke.weight = this._border.weight;
				this.stroke.alpha = this._border.alpha;
				if (this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{					
					if (this.angle)
					{
						this.traceRotationDiamond(sprite, size, half, null, false, this.stroke, point);
					}
					else
					{
						this.stroke.apply(sprite.graphics, null, null);
						this.traceDiamond(sprite.graphics, half, half, half);
					}
				}
				else if (this._border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{					
					if (this.angle)
					{
						this.traceRotationDiamond(sprite, size, half, null, false, null, point);
					}
					else
					{
						this.traceDiamond(sprite.graphics, half, half, half);
					}
				}
				else
				{
					ptsDiamond = [];					
					if (this.angle)
					{
						this.traceRotationDiamond(sprite, size, half, ptsDiamond, true, this.stroke, point);
					}
					else
					{
						var AToR:Number = Math.PI / 180;
						var shortWidth:Number = half * Math.tan(30 * AToR);
						ptsDiamond.push(half - shortWidth, half, half, 0, half + shortWidth, half, half, size, half - shortWidth, half);
						this.traceDiamond(sprite.graphics, half, half, half);
						sprite.graphics.endFill();
						StyleUtil.drawStyledGeoLine(sprite, ptsDiamond, this.stroke, this.pattern);
					}
				}
			}
			else
			{				
				if (this.angle)
				{
					this.traceRotationDiamond(sprite, size, half, null, false, null, point);
				}
				else
				{
					this.traceDiamond(sprite.graphics, half, half, half);
				}
			}
			sprite.graphics.endFill();
		}
		
		private function traceDiamond(graphics:Graphics, sx:Number, sy:Number, half:Number) : void
		{
			var AToR:Number = Math.PI / 180;
			var shortWidth:Number = half * Math.tan(30 * AToR);
			graphics.moveTo(sx + shortWidth, sy);
			graphics.lineTo(sx, sy - half);
			graphics.lineTo(sx - shortWidth, sy);
			graphics.lineTo(sx, sy + half);			
		}
		
		private function traceRotationDiamond(sprite:Sprite, size:Number, half:Number, arrDiamondPoints:Array, isStyled:Boolean, stroke:SolidColorStroke, point:GeoPoint) : void
		{
			removeAllChildren(sprite);
			var customSprite:CustomSprite = new CustomSprite();
			customSprite.point = point;
			customSprite.x = half;
			customSprite.y = half;
			customSprite.rotation = angle;
			customSprite.graphics.beginFill(this._color, this._alpha);
			if (this._border)
			{
				if (this._border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					stroke.apply(customSprite.graphics, null, null);
				}
			}
			
			this.traceDiamond(customSprite.graphics, 0, 0, half);
			customSprite.graphics.endFill();
			if (isStyled)
			{
				var AToR:Number = Math.PI / 180;
				var shortWidth:Number = half * Math.tan(30 * AToR);
				arrDiamondPoints.push(-shortWidth, 0, 0, -half, shortWidth, 0, 0, half, -shortWidth, 0);
				StyleUtil.drawStyledGeoLine(customSprite, arrDiamondPoints, stroke, this.pattern);
			}
			sprite.addChild(customSprite);
			
		}
		
		private function drawOther(sprite:Sprite, geometry:Geometry, map:Map) : void
		{
			var geoline:GeoLine;
			var geoLineRect:Rectangle2D;
			var arrOfPolylinePoints:Array;
			var dPath:Array;
			var path:Array;
			
			var geoRegion:GeoRegion;
			var geoRegionRect:Rectangle2D;
			var arrOfgeoRegionPoints:Array;
			var geoRegionPath:Array;
			
			removeAllChildren(sprite);
			//处理线
			if(geometry is GeoLine)
			{
				geoline = GeoLine(geometry) as GeoLine;
				geoLineRect = geoline.bounds;
				arrOfPolylinePoints = [];
				var i:int = 0;
				var linePartNum:Number = geoline.partCount;
				for(i; i < linePartNum; i++)
				{					
					path = geoline.getPart(i);
					var pntCount:int = path.length;
					if (pntCount > 1)
					{
						for(var j:int = 0; j < pntCount; j++)
						{
							arrOfPolylinePoints.push(new Point2D(path[j].x, path[j].y));
						}
					}	
				}				
				this.traceMultipointGeometry(sprite, map, arrOfPolylinePoints, geoLineRect);
			}
			
			//处理面
			if(geometry is GeoRegion)
			{
				geoRegion = GeoRegion(geometry) as GeoRegion;
				geoRegionRect = geoRegion.bounds;
				arrOfgeoRegionPoints = [];
				var k:int = 0;
				var regionPartNum:Number = geoRegion.partCount;
				for(k; k < regionPartNum; k++)
				{		
					geoRegionPath = geoRegion.getPart(k);
					var regionPntCount:int = geoRegionPath.length;
					if (regionPntCount > 1)
					{
						//考虑面是个闭合环路，最后一个点必然和起始点重合，素以不做二次绘制
						for(var p:int = 0;p < regionPntCount - 1; p++)
						{
							arrOfgeoRegionPoints.push(new Point2D(geoRegionPath[p].x, geoRegionPath[p].y));
						}
					}	
				}
				this.traceMultipointGeometry(sprite, map, arrOfgeoRegionPoints, geoRegionRect);
			}
		}
		
		private function traceMultipointGeometry(sprite:Sprite, map:Map, arrOfPoints:Array, multipointBounds:Rectangle2D) : void
		{
			var rectL:Number = NaN;
			var rectT:Number = NaN;
			var rectR:Number = NaN;
			var rectB:Number = NaN;
			if (multipointBounds != null)
			{
				rectL = this.toScreenX(map, multipointBounds.left);
				rectT = this.toScreenY(map, multipointBounds.top);
				rectR = this.toScreenX(map, multipointBounds.right);
				rectB = this.toScreenY(map, multipointBounds.bottom);
				sprite.x = rectL - this._half;
				sprite.y = rectB - this._half;
				sprite.width = rectR + this._size - rectL;
				sprite.height = rectT + this._size - rectB;
			}
			switch(_symbol)
			{
				case SYMBOL_CIRCLE:
				{
					drawMultipointCircle(map, sprite, arrOfPoints);
					break;
				}
				case SYMBOL_SQUARE:
				{
					drawMultipointSquare(map, sprite, arrOfPoints);
					break;
				}
				case SYMBOL_DIAMOND:
				{
					drawMultipointDiamond(map, sprite, arrOfPoints);
					break;
				}
				case SYMBOL_STAR:
				{
					drawMultipointStar(map, sprite, arrOfPoints);
					break;
				}
				case SYMBOL_X:
				{
					drawMultipointX(map, sprite, arrOfPoints);
					break;
				}
				case SYMBOL_TRIANGLE:
				{
					drawMultipointTriangle(map, sprite, arrOfPoints);
					break;
				}
				case SYMBOL_SECTOR:
				{
					drawMultPointSector(map, sprite, arrOfPoints);
					break;
				}
					
				default:
				{
					break;
				}
			}
			
		}
		
		private function drawMultipointCircle(map:Map, sprite:Sprite, arrOfPoints:Array, multipointExtent:Rectangle2D = null) : void
		{
			var pt:Point2D = null;
			var ptX:Number = NaN;
			var ptY:Number = NaN;
			for each (pt in arrOfPoints)
			{
				
				ptX = this.toScreenX(map, pt.x) - sprite.x + xOffset;
				ptY = this.toScreenY(map, pt.y) - sprite.y - yOffset;
				
//				if (this.angle)
//				{
					this.customSprite = new CustomSprite();
					sprite.addChild(this.customSprite);
					this.customSprite.point = new GeoPoint(pt.x, pt.y);
					this.customSprite.x = ptX;
					this.customSprite.y = ptY;
					this.customSprite.rotation = this.angle;
					this.traceMulipointCircle(map, this.customSprite, pt, 0, 0, true);
//					continue;
//				}
//				this.traceMulipointCircle(map, sprite, pt, ptX, ptY, false);
			}
		}
		
		private function traceMulipointCircle(map:Map, sprite:Sprite, point:Point2D, sx:Number, sy:Number, isRotated:Boolean) : void
		{			
			var pts:Array = null;
			var customSprite:CustomSprite = null;
			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.weight = this.border.weight;
				this.stroke.alpha = this.border.alpha;
				if (this.border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					this.stroke.apply(sprite.graphics, null, null);
					sprite.graphics.drawCircle(sx, sy, this._half);
					sprite.graphics.endFill();
				}
				else if (this.border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					sprite.graphics.drawCircle(sx, sy, this._half);
					sprite.graphics.endFill();
				}
				else
				{
					pts = [];
//					if (isRotated)
//					{
						sprite.graphics.beginFill(this._color, this._alpha);
						this.traceStyledCircle(sprite.graphics, sx, sy, this._half, pts);
						StyleUtil.drawStyledGeoLine(sprite, pts, this.stroke, this.pattern);
						sprite.graphics.endFill();
//					}
//					else
//					{
//						customSprite = new CustomSprite();
//						sprite.addChild(customSprite);
//						customSprite.point = new GeoPoint(point.x,point.y);
//						customSprite.x = sx;
//						customSprite.y = sy;
//						customSprite.graphics.beginFill(this._color, this._alpha);
//						this.traceStyledCircle(customSprite.graphics, 0, 0, this._half, pts);
//						StyleUtil.drawStyledGeoLine(customSprite, pts, this.stroke, this.pattern);
//						customSprite.graphics.endFill();
//					}
				}
			}
			else
			{
				sprite.graphics.beginFill(this._color, this._alpha);
				sprite.graphics.drawCircle(sx, sy, this._half);
				sprite.graphics.endFill();
			}
			
		}
		
		private function drawMultipointSquare(map:Map, sprite:Sprite, arrOfPoints:Array, multipointExtent:Rectangle2D = null) : void
		{
			var pt:Point2D = null;
			var ptX:Number = NaN;
			var ptY:Number = NaN;
			var customSprite:CustomSprite = null;
			for each (pt in arrOfPoints)
			{		
				ptX = toScreenX(map, pt.x) - sprite.x + xOffset;
				ptY = toScreenY(map, pt.y) - sprite.y - yOffset;
				
//				if (this.angle)
//				{
					customSprite = new CustomSprite();
					customSprite.point = new GeoPoint(pt.x, pt.y);;
					sprite.addChild(customSprite);
					customSprite.x = ptX;
					customSprite.y = ptY;
					customSprite.rotation = this.angle;
					this.traceMultipointSquare(map, customSprite, pt, 0, 0, true);
//					continue;
//				}
//				this.traceMultipointSquare(map, sprite, pt, ptX, ptY, false);
			}			
		}
		
		private function traceMultipointSquare(map:Map, sprite:Sprite, point:Point2D, sx:Number, sy:Number, isRotated:Boolean) : void
		{			
			var pts:Array = null;
			var customSprite:CustomSprite = null;
			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.weight = this.border.weight;
				this.stroke.alpha = this.border.alpha;
				if (this.border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					this.stroke.apply(sprite.graphics, null, null);
					sprite.graphics.drawRect(sx - this._half, sy - this._half, this._size, this._size);
					sprite.graphics.endFill();
				}
				else if (this.border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					sprite.graphics.drawRect(sx - this._half, sy - this._half, this._size, this._size);
					sprite.graphics.endFill();
				}
				else
				{
					pts = [];
//					if (isRotated)
//					{
						pts.push(sx - this._half, sy - this._half, sx + this._half, sy - this._half, sx + this._half, sy + this._half, sx - this._half, sy + this._half, sx - this._half, sy - this._half);
						sprite.graphics.beginFill(this._color, this._alpha);
						sprite.graphics.drawRect(sx - this._half, sy - this._half, this._size, this._size);
						sprite.graphics.endFill();
						StyleUtil.drawStyledGeoLine(sprite, pts, this.stroke, this.pattern);
//					}
//					else
//					{						
//						pts.push(-this._half, -this._half, this._half, -this._half, this._half, this._half, -this._half, this._half, -this._half, -this._half);
//						customSprite = new CustomSprite();
//						sprite.addChild(customSprite);
//						customSprite.point = new GeoPoint(point.x,point.y);
//						customSprite.x = sx;
//						customSprite.y = sy;
//						customSprite.graphics.beginFill(this._color, this._alpha);
//						customSprite.graphics.drawRect(-this._half, -this._half, this._size, this._size);
//						customSprite.graphics.endFill();
//						StyleUtil.drawStyledGeoLine(customSprite, pts, this.stroke, this.pattern);					
//					}
				}
			}
			else
			{
				sprite.graphics.beginFill(this._color, this._alpha);
				sprite.graphics.drawRect(sx - this._half, sy - this._half, this._size, this._size);
				sprite.graphics.endFill();
			}
			
		}
		
		private function drawMultipointDiamond(map:Map, sprite:Sprite, arrOfPoints:Array, multipointExtent:Rectangle2D = null) : void
		{
			var pt:Point2D = null;
			var ptX:Number = NaN;
			var ptY:Number = NaN;
			var customSprite:CustomSprite = null;
			for each (pt in arrOfPoints)
			{
				
				ptX = this.toScreenX(map, pt.x) - sprite.x + xOffset;
				ptY = this.toScreenY(map, pt.y) - sprite.y - yOffset;
//				if (this.angle)
//				{
					customSprite = new CustomSprite();
					customSprite.point = new GeoPoint(pt.x,pt.y);
					sprite.addChild(customSprite);
					customSprite.x = ptX;
					customSprite.y = ptY;
					customSprite.rotation = angle;
					this.traceMultipointDiamond(map, customSprite, pt, 0, 0, true);
//					continue;
//				}
//				this.traceMultipointDiamond(map, sprite, pt, ptX, ptY, false);
			}
			
		}
		
		private function traceMultipointDiamond(map:Map, sprite:Sprite, point:Point2D, sx:Number, sy:Number, isRotated:Boolean) : void
		{			
			var pts:Array = null;
			var customSprite:CustomSprite = null;
			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.weight = this.border.weight;
				this.stroke.alpha = this.border.alpha;
				if (this.border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					this.stroke.apply(sprite.graphics, null, null);
					this.traceDiamond(sprite.graphics, sx, sy, this._half);
					sprite.graphics.endFill();
				}
				else if (this.border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					this.traceDiamond(sprite.graphics, sx, sy, this._half);
				}
				else
				{
					pts = [];
					var AToR:Number = Math.PI / 180;
					var shortWidth:Number = this._half * Math.tan(30 * AToR);
//					if (isRotated)
//					{
						pts.push(sx - shortWidth, sy, sx, sy - this._half, sx + shortWidth, sy, sx, sy + this._half, sx - shortWidth, sy);
						sprite.graphics.beginFill(this._color, this._alpha);
						this.traceDiamond(sprite.graphics, sx, sy, this._half);
						sprite.graphics.endFill();
						StyleUtil.drawStyledGeoLine(sprite, pts, this.stroke, this.pattern);
//					}
//					else
//					{
//						pts.push(-shortWidth, 0, 0, -this._half, shortWidth, 0, 0, this._half, -shortWidth, 0);
//						customSprite = new CustomSprite();
//						sprite.addChild(customSprite);
//						customSprite.point = new GeoPoint(point.x,point.y);
//						customSprite.x = sx;
//						customSprite.y = sy;
//						customSprite.graphics.beginFill(this._color, this._alpha);
//						this.traceDiamond(customSprite.graphics, 0, 0, this._half);
//						customSprite.graphics.endFill();
//						StyleUtil.drawStyledGeoLine(customSprite, pts, this.stroke, this.pattern);
//					}
				}
			}
			else
			{
				sprite.graphics.beginFill(this._color, this._alpha);
				this.traceDiamond(sprite.graphics, sx, sy, this._half);
				sprite.graphics.endFill();
			}
			
		}
		
		private function drawMultipointStar(map:Map, sprite:Sprite, arrOfPoints:Array, multipointExtent:Rectangle2D = null) : void
		{		
			var pt:Point2D = null;
			var ptX:Number = NaN;
			var ptY:Number = NaN;
			var customSprite:CustomSprite = null;
			for each (pt in arrOfPoints)
			{			
				ptX = this.toScreenX(map, pt.x) - sprite.x + xOffset;
				ptY = this.toScreenY(map, pt.y) - sprite.y - yOffset;

				customSprite = new CustomSprite();
				customSprite.point = new GeoPoint(pt.x, pt.y);
				sprite.addChild(customSprite);
				customSprite.x = ptX;
				customSprite.y = ptY;
				customSprite.rotation = angle;
				this.traceMultipointStar(map, customSprite, pt, 0, 0, true);
			}
		}
		
		//五角星
		private function traceMultipointStar(map:Map, sprite:Sprite, point:Point2D, sx:Number, sy:Number, isRotated:Boolean) : void
		{
			var pts:Array = null;
			var customSprite:CustomSprite = null;
			var ptsBorder:Array = [];
			
			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.weight = this.border.weight;
				this.stroke.alpha = this.border.alpha;
				if (this.border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					this.stroke.apply(sprite.graphics, null, null);
					this.traceStar(sprite, this._half, ptsBorder, sx, sy);
					sprite.graphics.endFill();
				}
				else if (this.border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					this.traceStar(sprite, this._half, ptsBorder, sx, sy);
				}
				else
				{
					pts = [];
//					if (isRotated)
//					{						
						sprite.graphics.beginFill(this._color, this._alpha);
						this.traceStar(sprite, this._half, ptsBorder, sx, sy);
						sprite.graphics.endFill();
//					}
//					else
//					{						
//						customSprite = new CustomSprite();
//						sprite.addChild(customSprite);
//						customSprite.point = new GeoPoint(point.x,point.y);						
//						customSprite.graphics.beginFill(this._color, this._alpha);
//						trace("001pts",pts);
//						sprite.graphics.beginFill(this._color, this._alpha);
//						this.traceStar(sprite,this._half,pts,sx,sy);
//						
//						sprite.graphics.endFill();
//						StyleUtil.drawStyledGeoLine(sprite, pts, this.stroke, this.pattern);
//						trace("002pts",pts);
//						
//						//customSprite.graphics.endFill();
//					}
				}
			}
			else
			{				
				sprite.graphics.beginFill(this._color, this._alpha);
				this.traceStar(sprite,this._half, ptsBorder, sx, sy);
				sprite.graphics.endFill();
			}
		}
		
		private function drawMultipointX(map:Map, sprite:Sprite, arrOfPoints:Array, multipointExtent:Rectangle2D = null) : void
		{
			var pt:Point2D = null;
			var ptX:Number = NaN;
			var ptY:Number = NaN;
			var customSprite:CustomSprite = null;
			this.stroke.color = this._color;
			this.stroke.alpha = this._alpha;
			for each (pt in arrOfPoints)
			{			
				ptX = toScreenX(map, pt.x) - sprite.x + xOffset;
				ptY = toScreenY(map, pt.y) - sprite.y - yOffset;
				
//				if (this.angle)
//				{
					customSprite = new CustomSprite();
					sprite.addChild(customSprite);
					customSprite.point = new GeoPoint(pt.x,pt.y);
					customSprite.x = ptX;
					customSprite.y = ptY;
					customSprite.rotation = angle;
					this.traceMultipointX(map, customSprite, pt, this.stroke, 0, 0, true);
//					continue;
//				}
//				this.traceMultipointX(map, sprite, pt, this.stroke, ptX, ptY, false);
			}
			
		}
		
		private function traceMultipointX(map:Map, sprite:Sprite, point:Point2D, stroke:SolidColorStroke, sx:Number, sy:Number, isRotated:Boolean) : void
		{
			var pts:Array = null;
			var ptsItem:Array = null;
			var customSprite:CustomSprite = null;
			var ptsItemNoAngle:Array = null;
			if (this.border)
			{
				stroke.weight = this.border.weight;
				if (this.border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					stroke.apply(sprite.graphics, null, null);
					sprite.graphics.beginFill(this._color, this._alpha);
					this.traceX(sprite.graphics, sx, sy, this._half);
					sprite.graphics.endFill();
				}
				else if (this.border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{
					stroke.weight = 1;
					stroke.apply(sprite.graphics, null, null);
					this.traceX(sprite.graphics, sx, sy, this._half);
					sprite.graphics.endFill();
				}
				else
				{
					pts = [];
//					if (isRotated)
//					{
						pts.push([sx - this._half, sy + this._half, sx + this._half, sy - this._half], [sx + this._half, sy + this._half, sx - this._half, sy - this._half]);
						this.traceX(sprite.graphics, sx, sy, this._half);
						sprite.graphics.endFill();
						for each (ptsItem in pts)
						{
							
							StyleUtil.drawStyledGeoLine(sprite, ptsItem, stroke, this.pattern);
						}
//					}
//					else
//					{
//						pts.push([-this._half, this._half, this._half, -this._half], [this._half, this._half, -this._half, -this._half]);
//						customSprite = new CustomSprite();
//						sprite.addChild(customSprite);
//						customSprite.point = new GeoPoint(point.x,point.y);
//						customSprite.x = sx;
//						customSprite.y = sy;
//						this.traceX(customSprite.graphics, sx, sy, this._half);
//						customSprite.graphics.endFill();
//						for each (ptsItemNoAngle in pts)
//						{
//							
//							StyleUtil.drawStyledGeoLine(customSprite, ptsItemNoAngle, stroke, this.pattern);
//						}
//					}
				}
			}
			else
			{
				stroke.weight = 1;
				stroke.apply(sprite.graphics, null, null);
				this.traceX(sprite.graphics, sx, sy, this._half);
				sprite.graphics.endFill();
			}
			
		}
		
		private function drawMultipointTriangle(map:Map, sprite:Sprite, arrOfPoints:Array, multipointExtent:Rectangle2D = null) : void
		{
			var pt:Point2D= null;
			var ptX:Number = NaN;
			var ptY:Number = NaN;
			var customSprite:CustomSprite = null;
			for each (pt in arrOfPoints)
			{
				
				ptX = toScreenX(map, pt.x) - sprite.x + xOffset;
				ptY = toScreenY(map, pt.y) - sprite.y - yOffset;
				
//				if (this.angle)
//				{
					customSprite = new CustomSprite();
					sprite.addChild(customSprite);
					customSprite.point = new GeoPoint(pt.x,pt.y);
					customSprite.x = ptX;
					customSprite.y = ptY;
					customSprite.rotation = angle;
					this.traceMultipointTriangle(map, customSprite, pt, 0, 0, true);
					continue;
//				}
//				this.traceMultipointTriangle(map, sprite, pt, ptX, ptY, false);
			}
			
		}
		
		private function traceMultipointTriangle(map:Map, sprite:Sprite, point:Point2D, sx:Number, sy:Number, isRotated:Boolean) : void
		{			
			var pts:Array = null;
			var customSprite:CustomSprite = null;
			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.weight = this.border.weight;
				this.stroke.alpha = this.border.alpha;
				if (this.border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					this.stroke.apply(sprite.graphics, null, null);
					this.traceTriangle(sprite.graphics, sx, sy, this._half);
					sprite.graphics.endFill();
				}
				else if (this.border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					this.traceTriangle(sprite.graphics, sx, sy, this._half);
					sprite.graphics.endFill();
				}
				else
				{
					pts = [];
//					if (isRotated)
//					{
				        var height:Number = Math.sqrt(this._half * this._half - this._half / 2 * this._half / 2);
						pts.push(sx - height, sy + this._half / 2, sx, sy - this._half, sx + height, sy + this._half / 2, sx - height, sy + this._half / 2);
						sprite.graphics.beginFill(this._color, this._alpha);
						this.traceTriangle(sprite.graphics, sx, sy, this._half);
						sprite.graphics.endFill();
						StyleUtil.drawStyledGeoLine(sprite, pts, this.stroke, this.pattern);
//					}
//					else
//					{						
//						pts.push(-Math.sqrt(this._half * this._half - this._half / 2 * this._half / 2), this._half / 2, 0, -this._half, Math.sqrt(this._half * this._half - this._half / 2 * this._half / 2), this._half / 2, -Math.sqrt(this._half * this._half - this._half / 2 * this._half / 2), this._half / 2-0.01);
//						customSprite = new CustomSprite();
//						sprite.addChild(customSprite);
//						customSprite.point = new GeoPoint(point.x,point.y);
//						customSprite.x = sx;
//						customSprite.y = sy;
//						customSprite.graphics.beginFill(this._color, this._alpha);
//						this.traceTriangle(customSprite.graphics, 0, 0, this._half);
//						customSprite.graphics.endFill();
//						StyleUtil.drawStyledGeoLine(customSprite, pts, this.stroke, this.pattern);
//					}
				}
			}
			else
			{
				sprite.graphics.beginFill(this._color, this._alpha);
				this.traceTriangle(sprite.graphics, sx, sy, this._half);
				sprite.graphics.endFill();
			}			
		}
		
		private function drawMultPointSector(map:Map, sprite:Sprite, arrOfPoints:Array, multipointExtent:Rectangle2D = null) : void
		{
			var pt:Point2D= null;
			var ptX:Number = NaN;
			var ptY:Number = NaN;
			var customSprite:CustomSprite = null;
			for each (pt in arrOfPoints)
			{				
				ptX = toScreenX(map, pt.x) - sprite.x + xOffset;
				ptY = toScreenY(map, pt.y) - sprite.y - yOffset;
				
				customSprite = new CustomSprite();
				sprite.addChild(customSprite);
				customSprite.point = new GeoPoint(pt.x,pt.y);
				customSprite.x = ptX;
				customSprite.y = ptY;

				customSprite.rotation = angle;
				this.traceMultipointSector(map, customSprite, pt, 0, 0, true);
					
			}
		}
		
		private function traceMultipointSector(map:Map, sprite:Sprite, point:Point2D, sx:Number, sy:Number, isRotated:Boolean) : void
		{			
			var pts:Array = [];
			var customSprite:CustomSprite = null;
			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.weight = this.border.weight;
				this.stroke.alpha = this.border.alpha;
				if (this.border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					this.stroke.apply(sprite.graphics, null, null);
					traceSector(sprite, sx, sy, this._half, pts);
					sprite.graphics.endFill();
				}
				else if (this.border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{
					sprite.graphics.beginFill(this._color, this._alpha);
					traceSector(sprite, sx, sy, this._half, pts);
					sprite.graphics.endFill();
				}
				else
				{				
					sprite.graphics.beginFill(this.color, this.alpha);
					traceSector(sprite, sx, sy, this._half, pts);
					sprite.graphics.endFill();					
					StyleUtil.drawStyledGeoLine(sprite, pts, this.stroke, this.pattern);
				}
			}
			else
			{
				sprite.graphics.beginFill(this._color, this._alpha);
				traceSector(sprite, sx, sy, this._half, pts);
				sprite.graphics.endFill();
			}			
		}
		
		
	}
}