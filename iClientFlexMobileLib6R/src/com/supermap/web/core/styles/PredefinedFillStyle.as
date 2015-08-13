package com.supermap.web.core.styles
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	import com.supermap.web.themes.RawTheme;
	import com.supermap.web.utils.GeoUtil;
	import com.supermap.web.utils.StyleUtil;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	
	import mx.events.PropertyChangeEvent;
	import mx.graphics.SolidColorStroke;
	
	use namespace sm_internal;

	/**
	 * ${core_styles_PredefineFillStyle_Title}.
	 * <p>${core_styles_PredefineFillStyle_Description}</p> 
	 * 
	 */	
	public class PredefinedFillStyle extends FillStyle
	{
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_NULL_D} 
		 */		
		public static const SYMBOL_NULL:String 		= "null";	

		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_SOLID_D} 
		 */		
		public static const SYMBOL_SOLID:String 		= "solid";		
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_HORIZONTAL_D}.
		 * <p>${core_styles_PredefinedFillStyle_const_STYLE_HORIZONTAL_remarks}</p> 
		 */		
		public static const SYMBOL_HORIZONTAL:String = "horizontal";
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_VERTICAL_D}.
		 * <p>${core_styles_PredefinedFillStyle_const_STYLE_VERTICAL_remarks}</p> 
		 */		
		public static const SYMBOL_VERTICAL:String 	= "vertical";	
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_CROSS_D}.
		 * <p>${core_styles_PredefinedFillStyle_const_STYLE_CROSS_remarks}</p> 
		 */		
		public static const SYMBOL_CROSS:String 		= "cross";	
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_SLASH_D}.
		 * <p>${core_styles_PredefinedFillStyle_const_STYLE_SLASH_remarks}</p> 
		 */		
		public static const SYMBOL_SLASH:String 		= "slash";	
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_BACKSLASH_D}.
		 * <p>${core_styles_PredefinedFillStyle_const_STYLE_BACKSLASH_remarks}</p> 
		 */		
		public static const SYMBOL_BACKSLASH:String 	= "backslash";
		
		[Embed(source="/../assets/images/style/horizontal.png")]
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_Horizontal_D} 
		 */		
		public static var Horizontal:Class;
		[Embed(source="/../assets/images/style/vertical.png")]  	
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_Vertical_D} 
		 */		
		public static var  Vertical:Class;
		[Embed(source="/../assets/images/style/cross.png")] 
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_Cross_D} 
		 */		
		public static var  Cross:Class;
		[Embed(source="/../assets/images/style/slash.png")]	
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_Slash_D} 
		 */		
		public static var Slash:Class;
		[Embed(source="/../assets/images/style/backslash.png")] 
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_Backslash_D} 
		 */		
		public static var  Backslash:Class;
		
		private var _symbol:String;
		private var _stroke:SolidColorStroke;
		private var _color:uint;
		private var _alpha:Number;
		private var _pattern:Array;
		private static var _defaultStyle:PredefinedFillStyle;
		
		/**
		 * ${core_styles_PredefinedFillStyle_constructor_D} 
		 * @param symbol ${core_styles_PredefinedFillStyle_constructor_param_style_D}
		 * @param color ${core_styles_PredefinedFillStyle_constructor_param_color_D}
		 * @param alpha ${core_styles_PredefinedFillStyle_constructor_param_alpha_D}
		 * @param border ${core_styles_PredefinedFillStyle_constructor_param_border_D}
		 * 
		 */		
		public function PredefinedFillStyle(symbol:String = SYMBOL_SOLID, color:Number = 0x4272d7, alpha:Number = 0.4, border:PredefinedLineStyle = null)
		{	  
			_stroke=new SolidColorStroke();
			this._symbol = symbol;
			if(!border)
				border = new PredefinedLineStyle();
			this.border = border;	
			
			if(!Map.theme)
			{
				this._alpha = alpha;
				this._color = color;
				
			}
			else
			{
				this._color = (color == 0x4272d7) ? Map.theme.fillColor : color;
				this._alpha = (alpha == 0.4) ? Map.theme.fillAlpha : alpha;
			}
		}
			
		
		/**
		 * ${core_styles_PredefinedFillStyle_attribute_alpha_D}
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
			if (oldValue !== value)
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
		 * ${core_styles_PredefinedFillStyle_attribute_color_D} 
		 * @default color
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
			if (oldValue !== value)
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
		 * ${core_styles_PredefinedFillStyle_method_pattern_D} 
		 * @return 
		 * 
		 */		
		public function get pattern():Array
		{
			if(this.border)
			{
				switch(this.border.symbol)
				{
					case PredefinedLineStyle.SYMBOL_SOLID:
					{				
						this._pattern = [1, 0];
						break;
					}
					case PredefinedLineStyle.SYMBOL_DASH:
					{					
						this._pattern = [6, 6];
						break;
					}
					case PredefinedLineStyle.SYMBOL_DOT:
					{					
						this._pattern = [1, 6];					
						break;
					}
					case PredefinedLineStyle.SYMBOL_DASHDOT:
					{					
						this._pattern = [6, 4, 1];
						break;
					}
					case PredefinedLineStyle.SYMBOL_DASHDOTDOT:
					{					
						this._pattern = [6, 4, 1, 4, 1];
						break;
					}
					default:
					{
						if(!this._pattern)
						{
							this._pattern = [1, 0];
						}
						break;
					}
				}
			}
			return this._pattern;
		}	
		public function set pattern(pattern:Array) : void
		{		
			if(pattern && pattern.length > 0)
			{
				this._pattern = pattern;
				dispatchEventChange();				
			}	
		}	

		[Inspectable(category = "iClient", enumeration = "SYMBOL_NULL,SYMBOL_SOLID,SYMBOL_HORIZONTAL,SYMBOL_VERTICAL,SYMBOL_CROSS,SYMBOL_SLASH,SYMBOL_BACKSLASH", defaultValue = "SYMBOL_SOLID")] 
		/**
		 * ${core_styles_PredefinedFillStyle_attribute_symbol_D}
		 * @default PredefinedFillStyle.SYMBOL_SOLID 
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
			if (oldValue !== value)
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
		 * @inheritDoc 
		 * 
		 */		
		override public function draw(sprite:Sprite,geometry:Geometry, attributes:Object, map:Map) : void
		{					
			var clipRect:Rectangle2D = map.viewBounds.expand(3);						
			if (geometry is GeoRegion)
			{
				this.drawFillSymbol(map,sprite, geometry, clipRect);
			}
			
		}
		
		/**
		 * ${core_styles_PredefinedFillStyle_method_drawFillSymbol_D} 
		 * @param map ${core_styles_PredefinedFillStyle_method_drawFillSymbol_param_map}
		 * @param sprite ${core_styles_PredefinedFillStyle_method_drawFillSymbol_param_sprite}
		 * @param geometry ${core_styles_PredefinedFillStyle_method_drawFillSymbol_param_geometry}
		 * @param clipRect ${core_styles_PredefinedFillStyle_method_drawFillSymbol_param_clipRect}
		 * 
		 */		
		private  function drawFillSymbol(map:Map,sprite:Sprite,geometry:Geometry,clipRect:Rectangle2D):void
		{
			if (geometry is GeoRegion)
			{				
				switch(this.symbol)
				{
					case SYMBOL_SOLID:
					{	
						this.drawSolidFillRegion(sprite, geometry, map, clipRect);						
						break;
					}
					case SYMBOL_NULL:
					{
						this.drawNullFillRegion(map, sprite, geometry as GeoRegion, clipRect);						
						break;
					}
					case SYMBOL_HORIZONTAL:
					{	
						this.drawOtherFill(map, new Horizontal as Bitmap, sprite, geometry as GeoRegion, clipRect);						
						break;
					}
					case SYMBOL_VERTICAL:
					{
						this.drawOtherFill(map, new Vertical as Bitmap, sprite, geometry as GeoRegion, clipRect);
						break;
					}
					case SYMBOL_CROSS:
					{
						this.drawOtherFill(map, new Cross as Bitmap, sprite, geometry as GeoRegion, clipRect);
						break;
					}
					case SYMBOL_SLASH:
					{
						this.drawOtherFill(map, new Slash as Bitmap, sprite, geometry as GeoRegion, clipRect);
						break;
					}
					case SYMBOL_BACKSLASH:
					{
						this.drawOtherFill(map,new Backslash as Bitmap,sprite, geometry as GeoRegion,clipRect);
						break;
					}
					default:
					{
						this.drawSolidFillRegion(sprite, geometry, map, clipRect);
						break;
					}
				}
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override public  function clear(sprite:Sprite) : void
		{
			sprite.graphics.clear();	
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override public  function destroy(sprite:Sprite) : void
		{
			sprite.graphics.clear();
			sprite.x = 0;
			sprite.y = 0;			
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override public function clone() : Style
		{
			var fillStyle:PredefinedFillStyle = new PredefinedFillStyle(this._symbol, this.color, this.alpha, this.border);
			return fillStyle;
			
		}
		
		private function drawNullFillRegion(map:Map,sprite:Sprite, region:GeoRegion,clipRect:Rectangle2D):void
		{
			sprite.graphics.beginFill(16777215, 0);//16777215为无色或者白色
			if (map && region && region is GeoRegion && clipRect)
			{
				this.drawRegion(map, sprite, region as GeoRegion, clipRect);
			}			
		}
		
		private function drawSolidFillRegion(sprite:Sprite, region:Geometry, map:Map, clipRect:Rectangle2D):void
		{			
			sprite.graphics.beginFill(this._color, this._alpha);			
			if (map && region && region is GeoRegion && clipRect)
			{
				this.drawRegion(map, sprite, region as GeoRegion, clipRect);	
			}
		}
		
		private function drawOtherFill(map:Map, bitmap:Bitmap, sprite:Sprite, region:GeoRegion,clipRect:Rectangle2D):void
		{
			this.setStyle(bitmap);				
			sprite.graphics.beginBitmapFill(bitmap.bitmapData);	
			if (map && region && region is GeoRegion && clipRect)
			{
				drawRegion(map, sprite, region as GeoRegion, clipRect);
			}	
			
		}

		private function drawRegion(map:Map,sprite:Sprite, region:GeoRegion,clipRect:Rectangle2D):void
		{			
			var hasOutline:Boolean = false;
			var regPart:Array = null;
			var aryPt:Array = null;
			var regPt:Point2D = null;
			
			var onePartRegion:GeoRegion = new GeoRegion();
			var partBounds:Rectangle2D = null;
			var regionBounds:Rectangle2D = region.bounds;
			var rectL:Number = this.toScreenX(map, regionBounds.left);
			var rectR:Number = this.toScreenX(map, regionBounds.right);
			var rectMin:Number = this.toScreenY(map, regionBounds.top);
			var rectMax:Number = this.toScreenY(map, regionBounds.bottom);			
			sprite.x = rectL;
			sprite.y = rectMin;
			sprite.width = rectR - rectL;
			sprite.height = rectMax - rectMin;	
			
			if (this.border)
			{
				hasOutline = true;
				this._stroke.color = this.border.color;
				this._stroke.weight = this.border.weight;
				this._stroke.alpha = this.border.alpha;
			}
			
			for(var i:int=0; i < region.partCount; i++)
			{
				regPart = region.getPart(i);
				if (region.partCount == 1)
				{
					partBounds = regionBounds;
				}
				else
				{
					if(onePartRegion.partCount)
						onePartRegion.setPart(0, regPart);
					else
						onePartRegion.addPart(regPart);
					
					partBounds = onePartRegion.bounds;
				}
				if (regPart.length >= 2)
				{
					aryPt = [];
					for each (regPt in regPart)
					{	
						aryPt.push(this.toScreenX(map, regPt.x) - sprite.x);
						aryPt.push(this.toScreenY(map, regPt.y) - sprite.y);						
					}
					if (clipRect.containsRect(partBounds))
					{
						this.tracePolygon(map, clipRect, sprite, aryPt, regPart, this._stroke, hasOutline, false);
						continue;
					}
					
					this.tracePolygon(map, clipRect, sprite, aryPt, regPart, this._stroke, hasOutline, true);
				}
			}
			sprite.graphics.endFill();
			
			if(this.border && this.border.symbol != PredefinedLineStyle.SYMBOL_NULL && this.border.symbol != PredefinedLineStyle.SYMBOL_SOLID)
			{
				for  (var j:int=0; j<region.partCount; j++)
				{				
					regPart = region.getPart(j);
					this.traceSegmentStyledLine(map, clipRect, sprite, this._stroke, regPart);
					continue;
				}				
			}
		}
		private function traceSegmentStyledLine(map:Map, rect:Rectangle2D, sprite:Sprite, stroke:SolidColorStroke, arrOfStyledPoints:Array) : void
		{
			var pt:Point2D = null;			
			this.closeRegion(arrOfStyledPoints);
			var aryPt:Point2D = arrOfStyledPoints[0];			
			var i:int = 1;
			while (i < arrOfStyledPoints.length)
			{				
				pt = arrOfStyledPoints[i];			
				if (aryPt.x != pt.x || aryPt.y != pt.y)
				{					
					this.drawSegmentStyledPolygon(map, rect, sprite, stroke, aryPt, pt);
				}
				aryPt = pt;
				i++;
			}
			
		}	
		
		private function closeRegion(arrPoints:Array):void
		{
			if (arrPoints[(arrPoints.length - 1)].x != arrPoints[0].x || arrPoints[(arrPoints.length - 1)].y != arrPoints[0].y)
			{
				arrPoints.push(arrPoints[0]);
			}
		}
		
		private function drawSegmentStyledPolygon(map:Map, rect:Rectangle2D, sprite:Sprite, stroke:SolidColorStroke, ptStart:Point2D, ptEnd:Point2D) : void
		{
			var ptStartX:Number = this.toScreenX(map, ptStart.x);
			var ptStartY:Number = this.toScreenY(map, ptStart.y);
			var ptEndX:Number =  this.toScreenX(map, ptEnd.x);
			var ptEndY:Number =  this.toScreenY(map, ptEnd.y);
			var numLen:Number = Math.sqrt(Math.pow(ptEndX - ptStartX, 2) + Math.pow(ptEndY - ptStartY, 2));
			var ptAry:Array = [];	
			if (numLen >= 32000)
			{				
				if(rect.contains(ptStart.x, ptStart.y) && rect.contains(ptEnd.x, ptEnd.y))
				{
					ptAry.push(ptStartX - sprite.x);
					ptAry.push(ptStartY - sprite.y);				
					ptAry.push(ptEndX - sprite.x);
					ptAry.push(ptEndY - sprite.y);
				}
				else
				{
					var ary:Array = GeoUtil.clipLineRect(ptStart, ptEnd, rect);	
					if(ary.length == 0)
					{
						return;
					}
					else if(ary.length == 1)
					{
						var ptNew:Point2D = ary[0];						
						if (!rect.contains(ptStart.x, ptStart.y) && rect.contains(ptEnd.x, ptEnd.y))
						{
							ptAry.push(this.toScreenX(map, ptNew.x) - sprite.x);
							ptAry.push(this.toScreenY(map, ptNew.y) - sprite.y);
							ptAry.push(ptEndX - sprite.x);
							ptAry.push(ptEndY - sprite.y);
						}
						else
						{
							ptAry.push(ptStartX - sprite.x);
							ptAry.push(ptStartY - sprite.y);
							ptAry.push(toScreenX(map, ptNew.x) - sprite.x);
							ptAry.push(toScreenY(map, ptNew.y) - sprite.y);
						}
					}
					else
					{
						var ptMoveTo:Point2D = ary[0];
						var ptLineTo:Point2D = ary[1];
						ptAry.push(toScreenX(map, ptMoveTo.x) - sprite.x);
						ptAry.push(toScreenY(map, ptMoveTo.y) - sprite.y);
						ptAry.push(toScreenX(map, ptLineTo.x) - sprite.x);
						ptAry.push(toScreenY(map, ptLineTo.y) - sprite.y);
					}
					
				}
			}
			else
			{
				ptAry.push(ptStartX - sprite.x);
				ptAry.push(ptStartY - sprite.y);				
				ptAry.push(ptEndX - sprite.x);
				ptAry.push(ptEndY - sprite.y);
			}
			
			
			if (ptAry != null)
			{							
				StyleUtil.drawStyledGeoLine(sprite, ptAry, stroke, this.pattern);		
			}
			
		}
		private function tracePolygon(map:Map, rect:Rectangle2D, sprite:Sprite, arrOfScreenPoints:Array, arrOfMapPoints:Array, stroke:SolidColorStroke, hasOutline:Boolean, drawSegment:Boolean) : void
		{
			
			if (hasOutline)
			{
				if (this.border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					if (drawSegment)
					{
						this.traceSegmentLine(map, rect, sprite, stroke, arrOfMapPoints.slice());
					}
					else
					{	
						stroke.apply(sprite.graphics, null, null);
						this.graphicsFilling(map, sprite, arrOfScreenPoints);											
					}
				}
				else
				{
					this.graphicsFilling(map, sprite, arrOfScreenPoints);
				}
			}
			else
			{
				this.graphicsFilling(map, sprite, arrOfScreenPoints);
			}
			
		}
		
		private function traceSegmentLine(map:Map, rect:Rectangle2D, sprite:Sprite, stroke:SolidColorStroke, arrPoints:Array) : void
		{
			var ptZero:Point2D = null;			
			var aryPtZero:Point2D = arrPoints[0];
			sprite.graphics.moveTo(toScreenX(map, aryPtZero.x) - sprite.x, toScreenY(map, aryPtZero.y) - sprite.y);
			var i:int = 1;
			while (i < arrPoints.length)
			{				
				ptZero = arrPoints[i];
				
				if (!ptZero.equals(aryPtZero))
				{
					this.drawSegmentPolygon(map, rect, sprite, stroke, aryPtZero, ptZero);
				}
				aryPtZero = ptZero;
				i++;
			}
			
		}
		
		private function graphicsFilling(map:Map, sprite:Sprite, arrOfPoints:Array) : void
		{
			sprite.graphics.moveTo(arrOfPoints[0], arrOfPoints[1]);
			var i:int = 2;			
			if(arrOfPoints.length == 4)
			{
				sprite.graphics.endFill();
				if(this.border)
					sprite.graphics.lineStyle(this.border.weight, this.border.color, this.border.alpha);
				else
					sprite.graphics.lineStyle(1, this._color);
				sprite.graphics.moveTo(arrOfPoints[0], arrOfPoints[1]);
				sprite.graphics.lineTo(arrOfPoints[2], arrOfPoints[3]);
				return;
			}
			while (i < arrOfPoints.length)
			{				
				sprite.graphics.lineTo(arrOfPoints[i], arrOfPoints[(i + 1)]);				
				i += 2;
			}
			
		}
		
		private function drawSegmentPolygon(map:Map, rect:Rectangle2D, sprite:Sprite, stroke:SolidColorStroke, startPt:Point2D, endPt:Point2D) : void
		{
			var aryPts:Array = null;
			var ptZero:Point2D = null;
			var aryPtZero:Point2D = null;
			var aryPtOne:Point2D = null;
			var startPtx:Number = map.mapToContainerX(startPt.x);
			var startPty:Number = map.mapToContainerY(startPt.y);
			var endPtx:Number = map.mapToContainerX(endPt.x);
			var endPty:Number = map.mapToContainerY(endPt.y);
			var numLen:Number = Math.sqrt(Math.pow(endPtx - startPtx, 2) + Math.pow(endPty - startPty, 2));
			if (numLen >= 32000)
			{
				aryPts = [];
				
				if (rect.contains(startPt.x, startPt.y) && rect.contains(endPt.x, endPt.y))
				{
					stroke.apply(sprite.graphics, null, null);
					sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
				}
				else
				{
					aryPts = GeoUtil.clipLineRect(startPt, endPt, rect);
					if (aryPts.length == 0)
					{
						sprite.graphics.lineStyle();
						sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
					}
					else if (aryPts.length == 1)
					{
						ptZero = aryPts[0];
						
						if (!rect.contains(startPt.x, startPt.y) && rect.contains(endPt.x, endPt.y))
						{
							sprite.graphics.lineTo(toScreenX(map, ptZero.x) - sprite.x, toScreenY(map, ptZero.y) - sprite.y);
							stroke.apply(sprite.graphics, null, null);
							sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
						}
						else
						{
							stroke.apply(sprite.graphics, null, null);
							sprite.graphics.lineTo(toScreenX(map, ptZero.x) - sprite.x, toScreenY(map, ptZero.y) - sprite.y);
							sprite.graphics.lineStyle();
							sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
						}
					}
					else
					{
						aryPtZero = aryPts[0];
						aryPtOne = aryPts[1];
						sprite.graphics.lineStyle();
						sprite.graphics.lineTo(toScreenX(map, aryPtZero.x) - sprite.x, toScreenY(map, aryPtZero.y) - sprite.y);
						stroke.apply(sprite.graphics, null, null);
						sprite.graphics.lineTo(toScreenX(map, aryPtOne.x) - sprite.x, toScreenY(map, aryPtOne.y) - sprite.y);
						sprite.graphics.lineStyle();
						sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
					}
				}
			}
			else
			{
				stroke.apply(sprite.graphics, null, null);
				sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
			}
			
		}
		
		/**
		 * ${core_styles_PredefinedFillStyle_method_setStyle_D} 
		 * @param bitmap ${core_styles_PredefinedFillStyle_method_setStyle_param_bitmap}
		 * @see flash.display.Bitmap.BitData.colorTransform
		 * 
		 */		
		sm_internal function setStyle(bitmap:Bitmap):void
		{
			var rect:Rectangle = new Rectangle(0, 0, bitmap.width, bitmap.height);
			var ct:ColorTransform = new ColorTransform();
			ct.alphaMultiplier = this._alpha;
			ct.color = this._color;
			bitmap.bitmapData.colorTransform(rect, ct);
		}
		
		/**
		 * ${core_styles_PredefinedFillStyle_attribute_defaultStyle_D} 
		 * @return 
		 * 
		 */		
		public static function get defaultStyle():PredefinedFillStyle
		{
			if(_defaultStyle == null)
			{
				_defaultStyle = new PredefinedFillStyle();
	 		}
			return _defaultStyle;
		}
		
	
	}
}