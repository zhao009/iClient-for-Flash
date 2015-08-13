package com.supermap.web.core.styles.graphicStyles
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.styles.PredefinedLineStyle;
	import com.supermap.web.core.styles.PredefinedMarkerStyle;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.StyleUtil;
	
	import flash.display.Bitmap;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	import mx.graphics.SolidColorStroke;

	use namespace sm_internal;

	/**
	 * ${core_styles_GraphicMarkerStyle_Title}.
	 * <p>${core_styles_GraphicMarkerStyle_Description}</p> 
	 */	
	public class GraphicMarkerStyle extends PredefinedMarkerStyle
	{
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
		
		public static const ICON:String = "icon";
		
		private var _preLayer:Sprite;
		sm_internal var pickColor:int = -1;
		private var _icon:Object;

		/**
		 * ${core_styles_GraphicMarkerStyle_constructor_D} 
		 * @param symbol ${core_styles_GraphicMarkerStyle_constructor_param_symbol}
		 * @param size ${core_styles_GraphicMarkerStyle_constructor_param_size}
		 * @param color ${core_styles_GraphicMarkerStyle_constructor_param_color}
		 * @param alpha ${core_styles_GraphicMarkerStyle_constructor_param_alpha}
		 * @param xOffset ${core_styles_GraphicMarkerStyle_constructor_param_xOffset}
		 * @param yOffset ${core_styles_GraphicMarkerStyle_constructor_param_yOffset}
		 * @param angle ${core_styles_GraphicMarkerStyle_constructor_param_angle}
		 * @param border ${core_styles_GraphicMarkerStyle_constructor_param_border}
		 * @param icon ${core_styles_GraphicMarkerStyle_constructor_param_icon}
		 * 
		 */		
		public function GraphicMarkerStyle(symbol:String = SYMBOL_CIRCLE, size:Number = 12, color:Number = 0x4272d7, alpha:Number = 1, xOffset:Number = 0, yOffset:Number = 0, angle:Number = 0, border:GraphicLineStyle = null, icon:Object = null)
		{
			super(symbol, size, color, alpha, xOffset, yOffset, angle, border);
			_icon = icon;
		}

		/**
		 * ${core_styles_GraphicMarkerStyle_attribute_icon_D} 
		 * @see PredefinedMarkerStyle#symbol
		 * @return 
		 * 
		 */		
		public function get icon():Object
		{
			return _icon;
		}

		public function set icon(value:Object):void
		{
			_icon = value;
		}

		/**
		 * @inheritDoc 
		 * 
		 */		
		public override function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			_preLayer = sprite;
			if (!geometry)
			{
				return;
			}
			if (geometry is GeoPoint)
			{
				drawPoint(sprite, this.size, this.size / 2, geometry as GeoPoint, map);
			}
		}

		private function drawPoint(sprite:Sprite, size:Number, half:Number, point:GeoPoint, map:Map, centerX:Number = 0, centerY:Number = 0):void
		{
			//所有样式暂不支持角度旋转
			switch (this.symbol)
			{
				case SYMBOL_CIRCLE:
				{
					this.drawPointCircle(sprite, size, half, point, map);
					break;
				}
				case SYMBOL_STAR:
				{
					drawPointStar(sprite, size, half, point, map);
					break;
				}
				case SYMBOL_SQUARE:
				{
					drawPointSquare(sprite, size, half, point, map);
					break;
				}
				case SYMBOL_TRIANGLE:
				{
					drawPointTriangle(sprite, size, half, point, map);
					break;
				}
				case SYMBOL_SECTOR:
				{
					drawPointSector(map, sprite, size, half, point);
					break;
				}
				case SYMBOL_X:
				{
					drawPointX(sprite, size, half, point, map);
					break;
				}
				case SYMBOL_DIAMOND:
				{
					drawPointDiamond(sprite, size, half, point, map);
					break;
				}
				case ICON:
				{
					drawPointIcon(sprite, size, half, point, map);
					break;
				}
				default:
				{
					this.drawPointCircle(sprite, size, half, point, map);
					break;
				}
			}
		}

		private function drawPointIcon(sprite:Sprite, size:Number, half:Number, point:GeoPoint, map:Map):void
		{
			if(_icon)
			{
				var iconBitmap:Bitmap;
				if(_icon is Class)
				{
					iconBitmap = new _icon as Bitmap;
				}else if(_icon is Bitmap)
				{
					iconBitmap = _icon as Bitmap;
				}else
				{
					return;
				}
				var pixelX:Number = this.toScreenX(map, point.x) + xOffset;
				var pixelY:Number = this.toScreenY(map, point.y) + yOffset;
	
				var offsetX:Number = pixelX - iconBitmap.width * 0.5;
				var offsetY:Number = pixelY - iconBitmap.height * 0.5;
				var iconW:Number =  iconBitmap.width;
				var iconH:Number =  iconBitmap.height;
				var drawColor:int;
				sprite.graphics.lineStyle();
				var tempAngle:Number = angle*Math.PI/180;
				if (pickColor != -1)
				{
					drawColor = pickColor;
					sprite.graphics.beginFill(drawColor);
				}
				else
				{
					var matrix:Matrix = new Matrix();
					if(this.angle != 0)                                                                                                                                                                                                                                                                            
					{
						matrix.translate(-iconW/2, -iconH/2);
						matrix.rotate(tempAngle);
						matrix.translate(pixelX, pixelY);
						sprite.graphics.beginBitmapFill(iconBitmap.bitmapData, matrix, false, true);
					}else
					{
						matrix.translate(offsetX, offsetY);
						sprite.graphics.beginBitmapFill(iconBitmap.bitmapData, matrix);
					}
				}
				 
				if(this.angle != 0)
				{
					point.tempIconRec = new Array;
					
					var preA:Point = new Point(offsetX,offsetY);
					var preB:Point = new Point(offsetX+iconW, offsetY);
					var preC:Point = new Point(offsetX+iconW, offsetY+iconH);
					var preD:Point = new Point(offsetX, offsetY+iconH);
					var centerPoint:Point = new Point(pixelX,pixelY)
					
					var A:Point = rotationByCenter(preA,centerPoint,tempAngle);
					var B:Point = rotationByCenter(preB,centerPoint,tempAngle);
					var C:Point = rotationByCenter(preC,centerPoint,tempAngle);
					var D:Point = rotationByCenter(preD,centerPoint,tempAngle);
					
					sprite.graphics.moveTo(A.x,A.y);
					sprite.graphics.lineTo(B.x,B.y);
					sprite.graphics.lineTo(C.x,C.y);
					sprite.graphics.lineTo(D.x,D.y);
					sprite.graphics.lineTo(A.x,A.y);
					sprite.graphics.endFill();
					point.tempIconRec.push(A,B,C,D);
				}
				else{
					point.tempIconRec = new Array;
					sprite.graphics.lineStyle();
					sprite.graphics.drawRect(offsetX, offsetY, iconBitmap.width, iconBitmap.height);
					point.tempIconRec.push(new Point(offsetX,offsetY),new Point(offsetX+iconBitmap.width,offsetY),new Point(offsetX+iconBitmap.width,offsetY+iconBitmap.height),new Point(offsetX,offsetY+iconBitmap.height));
				}
				
				sprite.graphics.endFill();
			}
		}
		
		private function rotationByCenter(point:Point, centerPoint:Point, centerAngle:Number):Point
		{
			var dx:Number = point.x-centerPoint.x;
			var dy:Number = point.y-centerPoint.y;
			var resultPoint:Point = new Point;
			resultPoint.x = Math.cos(centerAngle)*dx - Math.sin(centerAngle)*dy + centerPoint.x;
			resultPoint.y = Math.cos(centerAngle)*dy + Math.sin(centerAngle)*dx + centerPoint.y;
			return resultPoint;
		}

		//画菱形
		private function drawPointDiamond(sprite:Sprite, size:Number, half:Number, point:GeoPoint, map:Map):void
		{
			var drawColor:int;
			if (pickColor != -1)
			{
				drawColor = pickColor;
				sprite.graphics.beginFill(drawColor);
			}
			else
			{
				drawColor = this.color;
				sprite.graphics.beginFill(drawColor, this.alpha);
			}
			var pixelX:Number = this.toScreenX(map, point.x) + xOffset;
			var pixelY:Number = this.toScreenY(map, point.y) + yOffset;
			var ptsDiamond:Array = null;

			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.weight = this.border.weight;
				this.stroke.alpha = this.border.alpha;
				if (this.border.symbol == GraphicLineStyle.SYMBOL_SOLID)
				{
//					if (this.angle)
//					{
//						this.traceRotationDiamond(sprite, size, half, null, false, this.stroke, point);
//					}
//					else
//					{
					this.stroke.apply(sprite.graphics, null,null);
					this.traceDiamond(sprite.graphics, pixelX, pixelY, half);
//					}
				}
				else if (this.border.symbol == GraphicLineStyle.SYMBOL_NULL)
				{
//					if (this.angle)
//					{
//						this.traceRotationDiamond(sprite, size, half, null, false, null, point);
//					}
//					else
//					{
					this.traceDiamond(sprite.graphics, pixelX, pixelY, half);
//					}
				}
				else
				{
					ptsDiamond = [];
//					if (this.angle)
//					{
//						this.traceRotationDiamond(sprite, size, half, ptsDiamond, true, this.stroke, point);
//					}
//					else
//					{
					var AToR:Number = Math.PI / 180;
					var shortWidth:Number = half * Math.tan(30 * AToR);
					ptsDiamond.push(pixelX + shortWidth, pixelY, pixelX, pixelY - half, pixelX - shortWidth, pixelY, pixelX, pixelY + half, pixelX + shortWidth, pixelY);
					this.traceDiamond(sprite.graphics, pixelX, pixelY, half);
					sprite.graphics.endFill();
					StyleUtil.drawStyledGeoLine(sprite, ptsDiamond, this.stroke, this.pattern);
//					}
				}
			}
			else
			{
				sprite.graphics.lineStyle();
//				if (this.angle)
//				{
//					this.traceRotationDiamond(sprite, size, half, null, false, null, point);
//				}
//				else
//				{
				this.traceDiamond(sprite.graphics, pixelX, pixelY, half);
//				}
			}
			sprite.graphics.endFill();
		}

		private function traceDiamond(graphics:Graphics, sx:Number, sy:Number, half:Number):void
		{
			var AToR:Number = Math.PI / 180;
			var shortWidth:Number = half * Math.tan(30 * AToR);
			graphics.moveTo(sx + shortWidth, sy);
			graphics.lineTo(sx, sy - half);
			graphics.lineTo(sx - shortWidth, sy);
			graphics.lineTo(sx, sy + half);
		}

		//绘制“X”
		private function drawPointX(sprite:Sprite, size:Number, half:Number, point:GeoPoint, map:Map):void
		{
			var drawColor:int;
			if (pickColor != -1)
			{
				drawColor = pickColor;
				sprite.graphics.beginFill(drawColor);
			}
			else
			{
				drawColor = this.color;
				sprite.graphics.beginFill(drawColor, this.alpha);
			}
			var pixelX:Number = this.toScreenX(map, point.x) + xOffset;
			var pixelY:Number = this.toScreenY(map, point.y) + yOffset;
			var ptsX:Array = null;
			var pts:Array = null;

			this.stroke.color = this.color;
			this.stroke.alpha = this.alpha;
			if (this.border)
			{
				this.stroke.weight = this.border.weight;
				if (this.border.symbol == GraphicLineStyle.SYMBOL_SOLID)
				{
//					if (this.angle)
//					{
//						this.traceRotationX(sprite, size, half, null, false, this.stroke, point);
//					}
//					else
//					{
					this.stroke.apply(sprite.graphics, null, null);
					this.traceX(sprite.graphics, pixelX, pixelY, half);
//					}
				}
				else if (this.border.symbol == GraphicLineStyle.SYMBOL_NULL)
				{
					this.stroke.weight = 1;
//					if (this.angle)
//					{
//						this.traceRotationX(sprite, size, half, null, false, this.stroke, point);
//					}
//					else
//					{
					this.stroke.apply(sprite.graphics, null, null);
					this.traceX(sprite.graphics, pixelX, pixelY, half);
//					}
				}
				else
				{
					ptsX = [];
//					if (this.angle)
//					{
//						this.traceRotationX(sprite, size, half, ptsX, true, this.stroke, point);
//					}
//					else
//					{
					ptsX.push([pixelX - half, pixelY + half, pixelX + half, pixelY - half], [pixelX + half, pixelY + half, pixelX - half, pixelY - half]);
					this.traceX(sprite.graphics, pixelX, pixelY, half);
					sprite.graphics.endFill();
					for each (pts in ptsX)
					{
						StyleUtil.drawStyledGeoLine(sprite, pts, this.stroke, this.pattern);
					}
//					}
				}
			}
			else
			{
//				this.stroke.weight = 1;			
//				if (angle && this.angle)
//				{
//					this.traceRotationX(sprite, size, half, null, false, this.stroke, point);
//				}
//				else
//				{
				this.stroke.apply(sprite.graphics, null, null);
				this.traceX(sprite.graphics, pixelX, pixelY, half);
//				}
			}
			sprite.graphics.endFill();
		}

		private function traceX(graphics:Graphics, sx:Number, sy:Number, half:Number):void
		{
			graphics.moveTo(sx - half, sy + half);
			graphics.lineTo(sx + half, sy - half);
			graphics.moveTo(sx + half, sy + half);
			graphics.lineTo(sx - half, sy - half);
		}

		//画扇形
		private function drawPointSector(map:Map, sprite:Sprite, size:Number, half:Number, point:GeoPoint):void
		{
			var drawColor:int;
			if (pickColor != -1)
			{
				drawColor = pickColor;
				sprite.graphics.beginFill(drawColor);
			}
			else
			{
				drawColor = this.color;
				sprite.graphics.beginFill(drawColor, this.alpha);
			}
			var pixelX:Number = this.toScreenX(map, point.x) + xOffset;
			var pixelY:Number = this.toScreenY(map, point.y) + yOffset;

			var ptsSector:Array = [];
			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.alpha = this.border.alpha;
				this.stroke.weight = this.border.weight;
				if (this.border.symbol == GraphicLineStyle.SYMBOL_SOLID)
				{
//					if(this.angle)
//					{
//						this.traceRotationSector(sprite, size, half, ptsSector, false, this.stroke, point);
//					}
//					else
//					{
					this.stroke.apply(sprite.graphics, null, null);
					this.traceSector(sprite, pixelX, pixelY, half, null);
//					}
				}
				else if (this.border.symbol == GraphicLineStyle.SYMBOL_NULL)
				{
//					if(this.angle)
//					{
//						this.traceRotationSector(sprite, size, half, ptsSector, false, null, point);
//					}
//					else
//					{
					this.traceSector(sprite, pixelX, pixelY, half, null);
//					}
				}
				else
				{
//					if(this.angle)
//					{
//						this.traceRotationSector(sprite, size, half, ptsSector, true, this.stroke, point);
//					}
//					else
//					{
					sprite.graphics.beginFill(this.color, this.alpha);
					this.traceSector(sprite, pixelX, pixelY, half, ptsSector);
					sprite.graphics.endFill();
					StyleUtil.drawStyledGeoLine(sprite, ptsSector, this.stroke, this.pattern);
//					}

				}
			}
			else
			{
				sprite.graphics.lineStyle();
//				if(this.angle)
//				{
//					this.traceRotationSector(sprite, size, half, ptsSector, false, null, point);
//				}
//				else
//				{
				this.traceSector(sprite, pixelX, pixelY, half, null);
//				}
			}
		}

		private function traceSector(sprite:Sprite, sx:Number, sy:Number, radius:Number, sectorPoints:Array):void
		{
			if (!sectorPoints)
			{
				sectorPoints = [];
			}
			var AToR:Number = Math.PI / 180;
			var startAngle:Number = 45 * AToR;
			var endAngle:Number = -45 * AToR;
			var startArcPoint:Point = new Point(sx + radius * Math.cos(startAngle), sy - radius * Math.sin(startAngle));
			sprite.graphics.moveTo(startArcPoint.x, startArcPoint.y);
			sectorPoints.push(startArcPoint.x, startArcPoint.y);
			for (var i:int = 1; i <= 90; i++)
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

		//三角形
		private function drawPointTriangle(sprite:Sprite, size:Number, half:Number, point:GeoPoint, map:Map):void
		{
			var drawColor:int;
			if (pickColor != -1)
			{
				drawColor = pickColor;
				sprite.graphics.beginFill(drawColor);
			}
			else
			{
				drawColor = this.color;
				sprite.graphics.beginFill(drawColor, this.alpha);
			}
			var ptsTriangle:Array = null;
			var pixelX:Number = this.toScreenX(map, point.x) + xOffset;
			var pixelY:Number = this.toScreenY(map, point.y) + yOffset;

			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.weight = this.border.weight;
				this.stroke.alpha = this.border.alpha;
				if (this.border.symbol == GraphicLineStyle.SYMBOL_SOLID)
				{
//					if (this.angle)
//					{
//						this.traceRotationTriangle(sprite, size, half, null, false, this.stroke, point);
//					}
//					else
//					{
					this.stroke.apply(sprite.graphics, null, null);
					this.traceTriangle(sprite.graphics, pixelX, pixelY, half);
//					}
				}
				else if (this.border.symbol == GraphicLineStyle.SYMBOL_NULL)
				{
//					if (this.angle)
//					{
//						this.traceRotationTriangle(sprite, size, half, null, false, null, point);
//					}
//					else
//					{
					this.traceTriangle(sprite.graphics, pixelX, pixelY, half);
//					}
				}
				else
				{
					ptsTriangle = [];
//					if (this.angle)
//					{						
//						this.traceRotationTriangle(sprite, size, half, ptsTriangle, true, this.stroke, point);
//					}
//					else
//					{						
					this.traceTriangle(sprite.graphics, pixelX, pixelY, half);
					sprite.graphics.endFill();

					var pt01x:Number = 0;
					var pt01y:Number = half * 1.5;
					var pt02x:Number = half;
					var pt02y:Number = 0;
					var pt03x:Number = Math.sqrt(half * half - half / 2 * half / 2);
					var pt03y:Number = pt01y;
					ptsTriangle.push(pixelX - pt03x, pixelY + half / 2, pixelX, pixelY - half, pixelX + pt03x, pixelY + half / 2, pixelX - pt03x, pixelY + half / 2);
					StyleUtil.drawStyledGeoLine(sprite, ptsTriangle, this.stroke, this.pattern);

//					}
				}
			}
			else
			{
				sprite.graphics.lineStyle();
//				if (this.angle)
//				{
//					this.traceRotationTriangle(sprite, size, half, null, false, null, point);
//				}
//				else
//				{
				this.traceTriangle(sprite.graphics, pixelX, pixelY, half);
//				}
			}
			sprite.graphics.endFill();
		}

		private function traceTriangle(graphics:Graphics, sx:Number, sy:Number, half:Number):void
		{
			var halfhalf:Number = half * 0.5;
			var height:Number = Math.sqrt(half * half - halfhalf * halfhalf);
			graphics.moveTo(sx - height, sy + halfhalf);
			graphics.lineTo(sx, sy - half);
			graphics.lineTo(sx + height, sy + halfhalf);
		}

		//正方形 
		private function drawPointSquare(sprite:Sprite, size:Number, half:Number, point:GeoPoint, map:Map):void
		{
			var drawColor:int;
			if (pickColor != -1)
			{
				drawColor = pickColor;
				sprite.graphics.beginFill(drawColor);
			}
			else
			{
				drawColor = this.color;
				sprite.graphics.beginFill(drawColor, this.alpha);
			}
			var ptsSquare:Array = null;
			var pixelX:Number = this.toScreenX(map, point.x) + xOffset;
			var pixelY:Number = this.toScreenY(map, point.y) + yOffset;

			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.weight = this.border.weight;
				this.stroke.alpha = this.border.alpha;
				if (this.border.symbol == GraphicLineStyle.SYMBOL_SOLID)
				{
//					if (this.angle)
//					{
//						this.traceRotationSquare(sprite, size, half, null, false, this.stroke, point);
//					}
//					else
//					{
					this.stroke.apply(sprite.graphics, null, null);
					sprite.graphics.drawRect(pixelX - size / 2, pixelY - size / 2, size, size);
//					}
				}
				else if (this.border.symbol == GraphicLineStyle.SYMBOL_NULL)
				{
//					if (this.angle)
//					{
//						this.traceRotationSquare(sprite, size, half, null, false, null, point);
//					}
//					else
//					{
					sprite.graphics.drawRect(pixelX - size / 2, pixelY - size / 2, size, size);
//					}
				}
				else
				{
					ptsSquare = [];
//					if (this.angle)
//					{
//						this.traceRotationSquare(sprite, size, half, ptsSquare, true, this.stroke, point);
//					}
//					else
//					{						
					ptsSquare.push(pixelX - size / 2, pixelY - size / 2, pixelX + size / 2, pixelY - size / 2, pixelX + size / 2, pixelY + size / 2, pixelX - size / 2, pixelY + size / 2, pixelX - size / 2, pixelY - size / 2);
					sprite.graphics.drawRect(pixelX - size / 2, pixelY - size / 2, size, size);
					sprite.graphics.endFill();
					StyleUtil.drawStyledGeoLine(sprite, ptsSquare, this.stroke, this.pattern);
//					}
				}
			}
			else
			{
				sprite.graphics.lineStyle();
//				if (this.angle)
//				{
//					this.traceRotationSquare(sprite, size, half, null, false, null, point);
//				}
//				else
//				{
				sprite.graphics.drawRect(pixelX - size / 2, pixelY - size / 2, size, size);
//				}
			}
			sprite.graphics.endFill();
		}

		//画五角星
		private function drawPointStar(sprite:Sprite, size:Number, half:Number, point:GeoPoint, map:Map):void
		{
			var drawColor:int;
			if (pickColor != -1)
			{
				drawColor = pickColor;
				sprite.graphics.beginFill(drawColor);
			}
			else
			{
				drawColor = this.color;
				sprite.graphics.beginFill(drawColor, this.alpha);
			}
			var ptsStar:Array = [];
			var pixelX:Number = this.toScreenX(map, point.x) + xOffset;
			var pixelY:Number = this.toScreenY(map, point.y) + yOffset;

			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.weight = this.border.weight;
				this.stroke.alpha = this.border.alpha;

				if (this.border.symbol == GraphicLineStyle.SYMBOL_SOLID)
				{
//					if (this.angle)
//					{
//						this.traceRotationStar(sprite, this.size,half, null, false, this.stroke, point);
//					}
//					else
//					{
					this.stroke.apply(sprite.graphics, null, null);
					this.traceStar(sprite, size / 2, ptsStar, pixelX, pixelY);
//					}
				}
				else if (this.border.symbol == GraphicLineStyle.SYMBOL_NULL)
				{
//					if (this.angle)
//					{
//						this.traceRotationStar(sprite, this._size,this._half, null, false, null, point);
//					}
//					else
//					{						
					this.traceStar(sprite, size / 2, ptsStar, pixelX, pixelY);
//					}
				}
				else
				{
//					if(this.angle)
//					{
//						this.traceRotationStar(sprite, this._size, this._half, ptsStar, true, this.stroke, point);
//					}
//					else
//					{					
					this.traceStar(sprite, size / 2, ptsStar, pixelX, pixelY);
					sprite.graphics.endFill();
					StyleUtil.drawStyledGeoLine(sprite, ptsStar, this.stroke, this.pattern);

//					}
				}
			}
			else
			{
				sprite.graphics.lineStyle();

//				if(this.angle)
//				{
//					this.traceRotationStar(sprite, this._size, this._half, ptsStar, false, this.stroke, point);
//				}
//				else
//				{
				this.traceStar(sprite, size / 2, ptsStar, pixelX, pixelY);

//				}
			}
			sprite.graphics.endFill();
		}

		private function traceStar(sprite:Sprite, size:Number, ptsStar:Array, x:Number, y:Number):void
		{
			//此算法中心点在原点	
			var AToR:Number = Math.PI / 180;
			var sin18:Number = Math.sin(18 * AToR);
			var sin36:Number = Math.sin(36 * AToR);
			var sin54:Number = Math.sin(54 * AToR);
			var sin72:Number = Math.sin(72 * AToR);
			var tan36:Number = Math.tan(36 * AToR);

			var ax:Number = -size * sin72;
			var ay:Number = -size * sin18;

			var bx:Number = -size * sin18 * tan36;
			var by:Number = -size * sin18;

			var cx:Number = 0;
			var cy:Number = -size;

			var dx:Number = size * sin18 * tan36;
			var dy:Number = -size * sin18;

			var ex:Number = size * sin72;
			var ey:Number = -size * sin18;

			var fx:Number = size * sin18 * tan36 * (1 + 2 * sin18);
			var fy:Number = size * sin18 * (2 * sin72 * tan36 - 1);

			var gx:Number = size * sin36;
			var gy:Number = size * sin54;

			var hx:Number = 0;
			var hy:Number = size * sin18 * (1 / sin54);

			var ix:Number = -size * sin36;
			var iy:Number = size * sin54;

			var jx:Number = -size * sin18 * tan36 * (1 + 2 * sin18);
			var jy:Number = size * sin18 * (2 * sin72 * tan36 - 1);

			ax += x;
			bx += x;
			cx += x;
			dx += x;
			ex += x;
			fx += x;
			gx += x;
			hx += x;
			ix += x;
			jx += x;

			ay += y;
			by += y;
			cy += y;
			dy += y;
			ey += y;
			fy += y;
			gy += y;
			hy += y;
			iy += y;
			jy += y;

			//sprite.graphics.beginFill(0,0.6);
			sprite.graphics.moveTo(ax, ay);
			sprite.graphics.lineTo(bx, by);
			sprite.graphics.lineTo(cx, cy);
			sprite.graphics.lineTo(dx, dy);
			sprite.graphics.lineTo(ex, ey);
			sprite.graphics.lineTo(fx, fy);
			sprite.graphics.lineTo(gx, gy);
			sprite.graphics.lineTo(hx, hy);
			sprite.graphics.lineTo(ix, iy);
			sprite.graphics.lineTo(jx, jy);

			ptsStar.push(ax, ay, bx, by, cx, cy, dx, dy, ex, ey, fx, fy, gx, gy, hx, hy, ix, iy, jx, jy, ax, ay);
		}

		private function drawPointCircle(sprite:Sprite, size:Number, half:Number, point:GeoPoint, map:Map):void
		{
			var drawColor:int;
			if (pickColor != -1)
			{
				drawColor = pickColor;
				sprite.graphics.beginFill(drawColor);
			}
			else
			{
				drawColor = this.color;
				sprite.graphics.beginFill(drawColor, this.alpha);
			}

			var pixelX:Number = this.toScreenX(map, point.x) + xOffset;
			var pixelY:Number = this.toScreenY(map, point.y) + yOffset;
			if (this.border)
			{
				this.stroke.color = this.border.color;
				this.stroke.alpha = this.border.alpha;
				this.stroke.weight = this.border.weight;
				if (this.border.symbol == GraphicLineStyle.SYMBOL_SOLID)
				{
					this.stroke.apply(sprite.graphics, null, null);
					sprite.graphics.drawCircle(pixelX, pixelY, size / 2);
				}
				else if (this.border.symbol == GraphicLineStyle.SYMBOL_NULL)
				{
					sprite.graphics.drawCircle(pixelX, pixelY, size / 2);
				}
				else
				{
					var ary:Array = [];
					sprite.graphics.drawCircle(pixelX, pixelY, size / 2);
					sprite.graphics.endFill();
					this.traceStyledCircle(sprite.graphics, pixelX, pixelY, size / 2, ary);
					this.stroke.apply(sprite.graphics, null, null);
					StyleUtil.drawStyledGeoLine(sprite, ary, this.stroke, this.pattern);
				}
			}
			else
			{
				sprite.graphics.lineStyle();
				sprite.graphics.drawCircle(pixelX, pixelY, size / 2);
			}
			sprite.graphics.endFill();
		}

		private function traceStyledCircle(graphics:Graphics, sx:Number, sy:Number, radius:Number, aryCirclePoints:Array):void
		{
			var pointX:Number = NaN;
			var pointY:Number = NaN;
			var preRadian:Number = Math.PI / 180; //弧度
			var i:int = 0;

			while (i <= 360)
			{
				pointX = sx + radius * Math.sin(i * preRadian);
				pointY = sy + radius * Math.cos(i * preRadian);
				aryCirclePoints.push(pointX, pointY);
				i++;
			}
		}

	}
}
