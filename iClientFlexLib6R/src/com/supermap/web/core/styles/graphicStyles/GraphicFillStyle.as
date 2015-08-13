package com.supermap.web.core.styles.graphicStyles
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.styles.PredefinedFillStyle;
	import com.supermap.web.core.styles.PredefinedLineStyle;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.GeoUtil;
	import com.supermap.web.utils.StyleUtil;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import mx.graphics.SolidColorStroke;

	use namespace sm_internal;

	/**
	 * ${core_styles_GraphicFillStyle_Title}.
	 * <p>${core_styles_GraphicFillStyle_Description}</p> 
	 * 
	 */	
	public class GraphicFillStyle extends PredefinedFillStyle
	{
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_NULL_D}
		 */
		public static const SYMBOL_NULL:String = "null";

		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_SOLID_D}
		 */
		public static const SYMBOL_SOLID:String = "solid";
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_HORIZONTAL_D}.
		 */
		public static const SYMBOL_HORIZONTAL:String = "horizontal";
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_VERTICAL_D}.
		 */
		public static const SYMBOL_VERTICAL:String = "vertical";
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_CROSS_D}.
		 */
		public static const SYMBOL_CROSS:String = "cross";
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_SLASH_D}.
		 */
		public static const SYMBOL_SLASH:String = "slash";
		/**
		 * ${core_styles_PredefinedFillStyle_const_STYLE_BACKSLASH_D}.
		 */
		public static const SYMBOL_BACKSLASH:String = "backslash";

		private var _stroke:SolidColorStroke;
		sm_internal var _pickColor:int = -1;

		/**
		 * ${core_styles_GraphicFillStyle_constructor_D} 
		 * @param symbol ${core_styles_GraphicFillStyle_constructor_param_symbol}
		 * @param color ${core_styles_GraphicFillStyle_constructor_param_color}
		 * @param alpha ${core_styles_GraphicFillStyle_constructor_param_alpha}
		 * @param border ${core_styles_GraphicFillStyle_constructor_param_border}
		 * 
		 */		
		public function GraphicFillStyle(symbol:String = SYMBOL_SOLID, color:Number = 0x4272d7, alpha:Number = 0.4, border:GraphicLineStyle = null)
		{
			super(symbol, color, alpha, border);
			_stroke = new SolidColorStroke();
		}

		/**
		 * @inheritDoc 
		 * 
		 */		
		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if (geometry is GeoRegion)
			{
				this.drawFillSymbol(map, sprite, geometry);
			}

		}

		private function drawFillSymbol(map:Map, sprite:Sprite, geometry:Geometry):void
		{
			if (geometry is GeoRegion)
			{
				switch (this.symbol)
				{
					case SYMBOL_SOLID:
					{
						this.drawSolidFillRegion(sprite, geometry, map);
						break;
					}
					case SYMBOL_NULL:
					{
						this.drawNullFillRegion(map, sprite, geometry as GeoRegion);
						break;
					}
					case SYMBOL_HORIZONTAL:
					{
						this.drawOtherFill(map, new Horizontal as Bitmap, sprite, geometry as GeoRegion);
						break;
					}
					case SYMBOL_VERTICAL:
					{
						this.drawOtherFill(map, new Vertical as Bitmap, sprite, geometry as GeoRegion);
						break;
					}
					case SYMBOL_CROSS:
					{
						this.drawOtherFill(map, new Cross as Bitmap, sprite, geometry as GeoRegion);
						break;
					}
					case SYMBOL_SLASH:
					{
						this.drawOtherFill(map, new Slash as Bitmap, sprite, geometry as GeoRegion);
						break;
					}
					case SYMBOL_BACKSLASH:
					{
						this.drawOtherFill(map, new Backslash as Bitmap, sprite, geometry as GeoRegion);
						break;
					}
					default:
					{
						this.drawSolidFillRegion(sprite, geometry, map);
						break;
					}
				}
			}
		}

		private function drawNullFillRegion(map:Map, sprite:Sprite, region:GeoRegion):void
		{
			if (_pickColor != -1)
			{
				sprite.graphics.beginFill(this._pickColor);
			}
			else
			{
				sprite.graphics.beginFill(16777215, 0); //16777215为无色或者白色
			}
			if (map && region && region is GeoRegion)
			{
				this.drawRegion(map, sprite, region as GeoRegion);
			}
		}

		private function drawSolidFillRegion(sprite:Sprite, region:Geometry, map:Map):void
		{
			if (_pickColor != -1)
			{
				sprite.graphics.beginFill(this._pickColor);
			}
			else
			{
				sprite.graphics.beginFill(this.color, this.alpha);
			}
			if (map && region && region is GeoRegion)
			{
				this.drawRegion(map, sprite, region as GeoRegion);
			}
		}

		private function drawOtherFill(map:Map, bitmap:Bitmap, sprite:Sprite, region:GeoRegion):void
		{

			if (_pickColor != -1)
			{
				sprite.graphics.beginFill(this._pickColor);
			}
			else
			{
				this.setStyle(bitmap);
				sprite.graphics.beginBitmapFill(bitmap.bitmapData);
			}
			if (map && region && region is GeoRegion)
			{
				drawRegion(map, sprite, region as GeoRegion);
			}

		}

		private function drawRegion(map:Map, sprite:Sprite, region:GeoRegion):void
		{
			var clipRect:Rectangle2D = map.viewBounds.expand(3);
			var hasOutline:Boolean = false;
			var regPart:Array = null;
			var aryPt:Array = null;
			var regPt:Point2D = null;

			var onePartRegion:GeoRegion = new GeoRegion();
			var partBounds:Rectangle2D = null;
			var regionBounds:Rectangle2D = region.bounds;

			if (this.border)
			{
				hasOutline = true;
				this._stroke.color = this.border.color;
				this._stroke.weight = this.border.weight;
				this._stroke.alpha = this.border.alpha;
			}

			for (var i:int = 0; i < region.partCount; i++)
			{
				regPart = region.getPart(i);
				if (region.partCount == 1)
				{
					partBounds = regionBounds;
				}
				else
				{
					if (onePartRegion.partCount)
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
						aryPt.push(this.toScreenX(map, regPt.x));
						aryPt.push(this.toScreenY(map, regPt.y));
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

			if (this.border && this.border.symbol != GraphicLineStyle.SYMBOL_NULL && this.border.symbol != GraphicLineStyle.SYMBOL_SOLID)
			{
				for (var j:int = 0; j < region.partCount; j++)
				{
					regPart = region.getPart(j);
					this.traceSegmentStyledLine(map, sprite, this._stroke, regPart);
					continue;
				}
			}
		}

		private function traceSegmentStyledLine(map:Map, sprite:Sprite, stroke:SolidColorStroke, arrOfStyledPoints:Array):void
		{
			var rect:Rectangle2D = map.viewBounds.expand(3);
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

		private function drawSegmentStyledPolygon(map:Map, rect:Rectangle2D, sprite:Sprite, stroke:SolidColorStroke, ptStart:Point2D, ptEnd:Point2D):void
		{
			var ptStartX:Number = this.toScreenX(map, ptStart.x);
			var ptStartY:Number = this.toScreenY(map, ptStart.y);
			var ptEndX:Number = this.toScreenX(map, ptEnd.x);
			var ptEndY:Number = this.toScreenY(map, ptEnd.y);
			var numLen:Number = Math.sqrt(Math.pow(ptEndX - ptStartX, 2) + Math.pow(ptEndY - ptStartY, 2));
			var ptAry:Array = [];
			if (numLen >= 32000)
			{
				if (rect.contains(ptStart.x, ptStart.y) && rect.contains(ptEnd.x, ptEnd.y))
				{
					ptAry.push(ptStartX);
					ptAry.push(ptStartY);
					ptAry.push(ptEndX);
					ptAry.push(ptEndY);
				}
				else
				{
					var ary:Array = GeoUtil.clipLineRect(ptStart, ptEnd, rect);
					if (ary.length == 0)
					{
						return;
					}
					else if (ary.length == 1)
					{
						var ptNew:Point2D = ary[0];
						if (!rect.contains(ptStart.x, ptStart.y) && rect.contains(ptEnd.x, ptEnd.y))
						{
							ptAry.push(this.toScreenX(map, ptNew.x));
							ptAry.push(this.toScreenY(map, ptNew.y));
							ptAry.push(ptEndX);
							ptAry.push(ptEndY);
						}
						else
						{
							ptAry.push(ptStartX);
							ptAry.push(ptStartY);
							ptAry.push(toScreenX(map, ptNew.x));
							ptAry.push(toScreenY(map, ptNew.y));
						}
					}
					else
					{
						var ptMoveTo:Point2D = ary[0];
						var ptLineTo:Point2D = ary[1];
						ptAry.push(toScreenX(map, ptMoveTo.x));
						ptAry.push(toScreenY(map, ptMoveTo.y));
						ptAry.push(toScreenX(map, ptLineTo.x));
						ptAry.push(toScreenY(map, ptLineTo.y));
					}

				}
			}
			else
			{
				ptAry.push(ptStartX);
				ptAry.push(ptStartY);
				ptAry.push(ptEndX);
				ptAry.push(ptEndY);
			}


			if (ptAry != null)
			{
				StyleUtil.drawStyledGeoLine(sprite, ptAry, stroke, this.pattern);
			}

		}

		private function tracePolygon(map:Map, rect:Rectangle2D, sprite:Sprite, arrOfScreenPoints:Array, arrOfMapPoints:Array, stroke:SolidColorStroke, hasOutline:Boolean, drawSegment:Boolean):void
		{

			//hasOutLine用于判断当前面是否包含边界
			if (hasOutline)
			{
				if (this.border.symbol == GraphicLineStyle.SYMBOL_SOLID)
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
				sprite.graphics.lineStyle();
				this.graphicsFilling(map, sprite, arrOfScreenPoints);
			}

		}

		private function traceSegmentLine(map:Map, rect:Rectangle2D, sprite:Sprite, stroke:SolidColorStroke, arrPoints:Array):void
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

		private function graphicsFilling(map:Map, sprite:Sprite, arrOfPoints:Array):void
		{
			sprite.graphics.moveTo(arrOfPoints[0], arrOfPoints[1]);
			var i:int = 2;
			if (arrOfPoints.length == 4)
			{
				sprite.graphics.endFill();
				if (this.border)
					sprite.graphics.lineStyle(this.border.weight, this.border.color, this.border.alpha);
				else
					sprite.graphics.lineStyle(1, this.color);
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

		private function drawSegmentPolygon(map:Map, rect:Rectangle2D, sprite:Sprite, stroke:SolidColorStroke, startPt:Point2D, endPt:Point2D):void
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
					sprite.graphics.lineTo(endPtx, endPty);
				}
				else
				{
					aryPts = GeoUtil.clipLineRect(startPt, endPt, rect);
					if (aryPts.length == 0)
					{
						sprite.graphics.lineStyle();
						sprite.graphics.lineTo(endPtx, endPty);
					}
					else if (aryPts.length == 1)
					{
						ptZero = aryPts[0];

						if (!rect.contains(startPt.x, startPt.y) && rect.contains(endPt.x, endPt.y))
						{
							sprite.graphics.lineTo(toScreenX(map, ptZero.x), toScreenY(map, ptZero.y));
							stroke.apply(sprite.graphics, null, null);
							sprite.graphics.lineTo(endPtx, endPty);
						}
						else
						{
							stroke.apply(sprite.graphics, null, null);
							sprite.graphics.lineTo(toScreenX(map, ptZero.x), toScreenY(map, ptZero.y));
							sprite.graphics.lineStyle();
							sprite.graphics.lineTo(endPtx, endPty);
						}
					}
					else
					{
						aryPtZero = aryPts[0];
						aryPtOne = aryPts[1];
						sprite.graphics.lineStyle();
						sprite.graphics.lineTo(toScreenX(map, aryPtZero.x), toScreenY(map, aryPtZero.y));
						stroke.apply(sprite.graphics, null, null);
						sprite.graphics.lineTo(toScreenX(map, aryPtOne.x), toScreenY(map, aryPtOne.y));
						sprite.graphics.lineStyle();
						sprite.graphics.lineTo(endPtx, endPty);
					}
				}
			}
			else
			{
				stroke.apply(sprite.graphics, null, null);
				sprite.graphics.lineTo(endPtx, endPty);
			}
		}
	}
}
