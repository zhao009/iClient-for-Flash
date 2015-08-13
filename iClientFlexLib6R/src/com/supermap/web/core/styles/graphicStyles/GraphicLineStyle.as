package com.supermap.web.core.styles.graphicStyles
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.GeoUtil;
	import com.supermap.web.utils.StyleUtil;

	import flash.display.Sprite;

	import mx.core.UIComponent;
	import mx.graphics.SolidColorStroke;
	import com.supermap.web.core.styles.PredefinedLineStyle;

	use namespace sm_internal;

	/**
	 * ${core_styles_GraphicLineStyle_Title}.
	 * <p>${core_styles_GraphicLineStyle_Description}</p> 
	 * 
	 */	
	public class GraphicLineStyle extends PredefinedLineStyle
	{
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_NULL_D} 
		 */		
		public static const SYMBOL_NULL:String= "null";	
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_SOLID_D} 
		 */		
		public static const SYMBOL_SOLID:String= "solid";	
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_DASH_D}.
		 */		
		public static const SYMBOL_DASH:String= "dash";		
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_DOT_D}.
		 */		
		public static const SYMBOL_DOT:String = "dot";	 
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_DASHDOT_D}.
		 */		
		public static const SYMBOL_DASHDOT:String= "dashdot";
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_DASHDOTDOT_D}.
		 */		
		public static const SYMBOL_DASHDOTDOT:String = "dashdotdot";				
		/**
		 * ${core_styles_PredefinedLineStyle_const_STYLE_COUSTOM_D} 
		 */	
		public static const SYMBOL_COUSTOM:String = "coustom";
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_CAP_NONE_D}.
		 * <p>${core_styles_GraphicLineStyle_const_CAP_CAP_NONE_remarks}</p> 
		 */		
		public static const CAP_NONE:String = "null";
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_ROUND_D}.
		 * <p>${core_styles_GraphicLineStyle_const_CAP_ROUND_remarks}</p> 
		 */		
		public static const CAP_ROUND:String = "round";
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_SQUARE_D}.
		 * <p>${core_styles_GraphicLineStyle_const_CAP_SQUARE_remarks}</p> 
		 */		
		public static const CAP_SQUARE:String = "square";
		
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_JOIN_MITER_D}.
		 * <p>${core_styles_GraphicLineStyle_const_CAP_JOIN_MITER_remarks}</p> 
		 */	
		public static const JOIN_MITER:String = "miter";
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_JOIN_ROUND_D}.
		 * <p>${core_styles_GraphicLineStyle_const_CAP_JOIN_ROUND_remarks}</p> 
		 */		
		public static const JOIN_ROUND:String = "round";
		/**
		 * ${core_styles_PredefinedLineStyle_const_CAP_JOIN_BEVEL_D}.
		 * <p>${core_styles_GraphicLineStyle_const_CAP_JOIN_BEVEL_remarks}</p> 
		 */		
		public static const JOIN_BEVEL:String = "bevel";
		
		private var map:Map;
		private var _sprite:Sprite;
		sm_internal var _pickColor:int = -1;
		private var _stroke:SolidColorStroke;

		/**
		 * ${core_styles_GraphicLineStyle_constructor_D} 
		 * @param symbol ${core_styles_GraphicLineStyle_constructor_param_symbol}
		 * @param color ${core_styles_GraphicLineStyle_constructor_param_color}
		 * @param alpha ${core_styles_GraphicLineStyle_constructor_param_alpha}
		 * @param weight ${core_styles_GraphicLineStyle_constructor_param_weight}
		 * @param cap ${core_styles_GraphicLineStyle_constructor_param_cap}
		 * @param join ${core_styles_GraphicLineStyle_constructor_param_join}
		 * @param miterLimit ${core_styles_GraphicLineStyle_constructor_param_miterLimit}
		 * 
		 */		
		public function GraphicLineStyle(symbol:String = SYMBOL_SOLID, color:Number = 0x5082e5, alpha:Number = 1, weight:Number = 2, cap:String = null, join:String = null, miterLimit:Number = 3)
		{
			super(symbol, color, alpha, weight, cap, join, miterLimit);
			_stroke = new SolidColorStroke();
		}

		/**
		 * @inheritDoc 
		 * 
		 */		
		public override function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			this.map = map;
			this._sprite = sprite;
			if (_pickColor != -1)
			{
				/// alpha!!
				_sprite.graphics.lineStyle(weight, _pickColor, 1.0, false, "normal", this.cap, this.join, this.miterLimit);
			}
			else
			{
				this.setLineStyle(sprite.graphics);
			}
			this.drawLine(geometry);
		}

		private function drawLine(geometry:Geometry):void
		{
			if (!geometry)
			{
				return;
			}

			var clipRect:Rectangle2D = map.viewBounds.expand(3);
			var geoBounds:Rectangle2D = geometry.bounds;

			if (geometry is GeoLine)
			{
				var geoLine:GeoLine = geometry as GeoLine;
				switch (this.symbol)
				{
					case SYMBOL_SOLID:
					{
						drawSolidGeoLine(clipRect, geoLine);
						break;
					}
					case SYMBOL_NULL:
					{
						drawNullGeoLine(clipRect, geoLine);
						break;
					}
					default:
					{
						this.drawStyledGeoLine(clipRect, geoLine);
						break;
					}
				}
			}
		}

		private function drawStyledGeoLine(rect:Rectangle2D, line:GeoLine):void
		{
			var ptStart:Point2D = null;
			var ptEnd:Point2D = null;
			//其它样式的线需要选取操作
			if(_pickColor != -1)
			{
				this._stroke.color = this._pickColor;
				this._stroke.alpha = 1.0;//选取不能透明
			}else
			{
				this._stroke.color = this.color;
			}
			this._stroke.weight = this.weight;

			var ptCount:int = line.partCount;
			for (var i:int = 0; i < ptCount; i++)
			{
				var part:Array = line.getPart(i);
				if (part.length > 1)
				{
					ptStart = part[0];
					var j:int = 1;
					while (j < part.length)
					{
						ptEnd = part[j];
						if (!ptEnd.equals(ptStart))
						{
							this.drawSegmentStyledGeoline(rect, ptStart, ptEnd, this._stroke);
						}
						ptStart = ptEnd;
						j++;

					}
				}
			}
		}

		private function drawSegmentStyledGeoline(rect:Rectangle2D, ptStart:Point2D, ptEnd:Point2D, stroke:SolidColorStroke):void
		{
			var ptStartX:Number = this.toScreenX(map, ptStart.x);
			var ptStartY:Number = this.toScreenY(map, ptStart.y);
			var ptEndX:Number = this.toScreenX(map, ptEnd.x);
			var ptEndY:Number = this.toScreenY(map, ptEnd.y);
			var offsetX:Number = ptEndX - ptStartX;
			var offsetY:Number = ptEndY - ptStartY;
			var ptsLength:Number = Math.sqrt(offsetX * offsetX + offsetY * offsetY);
			var ptAry:Array = [];
			if (ptsLength >= 32000)
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
							ptAry.push(ptStartX);
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
				StyleUtil.drawStyledGeoLine(this._sprite, ptAry, stroke, this.pattern);
			}
		}

		private function drawNullGeoLine(rect:Rectangle2D, line:GeoLine):void
		{
			return;
		}

		private function drawSolidGeoLine(rect:Rectangle2D, line:GeoLine):void
		{
			var ptStart:Point2D = null;
			var ptEnd:Point2D = null;
			var k:int = 0;
			var ptCount:int = line.partCount;
			for (var i:int = 0; i < ptCount; i++)
			{
				var part:Array = line.getPart(i);
				if (part.length > 1)
				{
					ptStart = part[0];
					k = 1;
					//线段的第二个点
					_sprite.graphics.moveTo(this.toScreenX(map, ptStart.x), this.toScreenY(map, ptStart.y));
					while (k < part.length)
					{
						ptEnd = part[k];
						if (!ptEnd.equals(ptStart))
						{
							this.drawSegmentGeoline(rect, ptStart, ptEnd);
						}
						ptStart = ptEnd;
						k++;
					}
				}
			}
		}

		private function drawSegmentGeoline(rect:Rectangle2D, ptStart:Point2D, ptEnd:Point2D):void
		{
			var ptStartX:Number = this.toScreenX(map, ptStart.x);
			var ptStartY:Number = this.toScreenY(map, ptStart.y);
			var ptEndX:Number = this.toScreenX(map, ptEnd.x);
			var ptEndY:Number = this.toScreenY(map, ptEnd.y);

			var ptMoveTo:Point2D = null;
			var ptLineTO:Point2D = null;
			var offsetX:Number = ptEndX - ptStartX;
			var offsetY:Number = ptEndY - ptStartY;
			var ptsLength:Number = Math.sqrt(offsetX * offsetX + offsetY * offsetY);
			if (ptsLength >= 32000)
			{
				var ary:Array = [];
				if (rect.contains(ptStart.x, ptStart.y) && rect.contains(ptEnd.x, ptEnd.y))
				{
					//					_preLayer.graphics.lineTo(ptEndX - sprite.x, ptEndY - sprite.y);
					_sprite.graphics.lineTo(ptEndX, ptEndY);
				}
				else
				{
					ary = GeoUtil.clipLineRect(ptStart, ptEnd, rect);
					if (ary.length == 0)
					{
						return;
					}
					else if (ary.length == 1)
					{
						var ptNew:Point2D = ary[0];
						if (!rect.contains(ptStart.x, ptStart.y) && rect.contains(ptEnd.x, ptEnd.y))
						{
							//							_preLayer.graphics.moveTo(this.toScreenX(map, ptNew.x) - sprite.x, this.toScreenY(map, ptNew.y) - sprite.y);
							_sprite.graphics.moveTo(this.toScreenX(map, ptNew.x), this.toScreenY(map, ptNew.y));
							_sprite.graphics.lineTo(ptEndX, ptEndY);
						}
						else
						{
							//							sprite.graphics.lineTo(this.toScreenX(map, ptNew.x) - sprite.x, this.toScreenY(map,ptNew.y) - sprite.y);
							_sprite.graphics.lineTo(this.toScreenX(map, ptNew.x), this.toScreenY(map, ptNew.y));
						}
					}
					else
					{
						ptMoveTo = ary[0];
						ptLineTO = ary[1];
						_sprite.graphics.moveTo(this.toScreenX(map, ptMoveTo.x), this.toScreenY(map, ptMoveTo.y));
						_sprite.graphics.lineTo(this.toScreenX(map, ptLineTO.x), this.toScreenY(map, ptLineTO.y));
					}

				}
			}
			else
			{
				_sprite.graphics.lineTo(ptEndX, ptEndY);
			}
		}
	}
}
