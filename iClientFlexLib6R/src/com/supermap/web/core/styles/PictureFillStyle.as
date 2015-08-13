package com.supermap.web.core.styles
{	
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.utils.GeoUtil;
	import com.supermap.web.utils.StyleUtil;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import mx.core.BitmapAsset;
	import mx.events.PropertyChangeEvent;
	import mx.graphics.SolidColorStroke;
	
	/**
	 * ${core_styles_PictureFillStyle_Title}.
	 * <p>${core_styles_PictureFillStyle_Description}</p> 
	 * @example ${core_styles_PictureFillStyle_Example}
	 * <listing>
	 * var geoRegion:GeoRegion = new GeoRegion();
	 * geoRegion.addPart([new Point2D(-20,60),new Point2D(20,60),new Point2D(20,30),new Point2D(-20,30)]);
	 * var pictureFillStyle:PictureFillStyle = new PictureFillStyle("../assets/sunny.png");
	 * var feature:Feature = new Feature(geoRegion,pictureFillStyle);
	 * featureLayer.addFeature(feature);
	 * </listing> 
	 * 
	 */	
	public class PictureFillStyle extends FillStyle
	{
		private var _source:Object;	
		private var _embed:Class;
		private var _width:Number;
		private var _height:Number;
		private var _xScale:Number;
		private var _yScale:Number;
		private var _xOffset:Number;
		private var _yOffset:Number;
		private var _alpha:Number;
		private var _matrix:Matrix;
		private var _stroke:SolidColorStroke;
		private var _loaderContext:LoaderContext;
		private var _pattern:Array;
		private var _angle:Number;
		private var _bitmaps:Object;
		private var image:Bitmap
		private static var _defaultStyle:PictureFillStyle;	
		
		
		private var _sprite:Sprite;
		private var _geometry:Geometry;
		private var _attributes:Object;
		private var _map:Map;
		private var _isDrawWithoutIamge:Boolean;
		private var _sourceChange:Boolean;
		
		/**
		 * ${core_styles_PictureFillStyle_constructor_D} 
		 * @param source ${core_styles_PictureFillStyle_constructor_param_source}
		 * @param width ${core_styles_PictureFillStyle_constructor_param_width}
		 * @param height ${core_styles_PictureFillStyle_constructor_param_height}
		 * @param xScale ${core_styles_PictureFillStyle_constructor_param_xScale}
		 * @param yScale ${core_styles_PictureFillStyle_constructor_param_yScale}
		 * @param xOffset ${core_styles_PictureFillStyle_constructor_param_xOffset}
		 * @param yOffset ${core_styles_PictureFillStyle_constructor_param_yOffset}
		 * @param alpha ${core_styles_PictureFillStyle_constructor_param_alpha}
		 * @param angle ${core_styles_PictureFillStyle_constructor_param_angle}
		 * @param border ${core_styles_PictureFillStyle_constructor_param_border}
		 * 
		 */		
		public function PictureFillStyle(source:Object = null,width:Number=0, height:Number=0, xScale:Number = 1, yScale:Number = 1, xOffset:Number = 0, yOffset:Number = 0, alpha:Number = 1, angle:Number = 0, border:PredefinedLineStyle = null)
		{			
			this._matrix = new Matrix();
			this._stroke = new SolidColorStroke();
			this._loaderContext = new LoaderContext(true);
			this._bitmaps = {};	
			this._embed = BitmapAsset;
			this._source = _embed;
			this.source = source;
			this.width = width;
			this.height = height;
			this.xScale = xScale;
			this.yScale = yScale;
			this.xOffset = xOffset;
			this.yOffset = yOffset;
			this.alpha = alpha;
			this.angle = angle;
			this.border = border;	
		}
		
		/**
		 * ${core_styles_PictureFillStyle_attribute_alpha_D} 
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
		 * ${core_styles_PictureFillStyle_attribute_angle_D} 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get angle():Number
		{
			return _angle;
		}

		public function set angle(value:Number):void
		{
			var oldValue:Number = this._angle;
			if (oldValue !== value)
			{
				this._angle = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "angle", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_PictureFillStyle_attribute_yOffset_D} 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get yOffset():Number
		{
			return _yOffset;
		}

		public function set yOffset(value:Number):void
		{
			var oldValue:Number = this._yOffset;
			if (oldValue !== value)
			{
				this._yOffset = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "yoffset", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_PictureFillStyle_attribute_xOffset_D} 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get xOffset():Number
		{
			return _xOffset;
		}

		public function set xOffset(value:Number):void
		{
			var oldValue:Number = this._xOffset;
			if (oldValue !== value)
			{
				this._xOffset = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "xoffset", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_PictureFillStyle_attribute_yScale_D}
		 * @default 1 
		 * @return 
		 * 
		 */		
		public function get yScale():Number
		{
			return _yScale;
		}

		public function set yScale(value:Number):void
		{
			var oldValue:Number = this._yScale;
			if (yScale !== value)
			{
				this._yScale = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "yscale", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_PictureFillStyle_attribute_xScale_D} 
		 * @default 1
		 * @return 
		 * 
		 */		
		public function get xScale():Number
		{
			return _xScale;
		}

		public function set xScale(value:Number):void
		{
			var oldValue:Number = this._xScale;
			if (oldValue !== value)
			{
				this._xScale = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "angle", xScale, value));
				}
			}
		}

		/**
		 * ${core_styles_PictureFillStyle_attribute_height_D} 
		 * <p>${core_styles_PictureFillStyle_attribute_height_remarks}</p>
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			var oldValue:Number = this._height;
			if (oldValue !== value)
			{
				this._height = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "height", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_PictureFillStyle_attribute_width_D}.
		 * <p>${core_styles_PictureFillStyle_attribute_width_remarks}</p> 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			var oldValue:Number = this._width;
			if (oldValue !== value)
			{
				this._width = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "width", oldValue, value));
				}
			}
		}

		/**
		 * ${core_styles_PictureFillStyle_method_pattern_D}.
		 * <p>${core_styles_PictureFillStyle_method_pattern_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get pattern():Array
		{
			if(this.border && !this._pattern)
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
		/**
		 * ${core_styles_PictureFillStyle_attribute_source_D} 
		 * @return 
		 * 
		 */		
		public function get source():Object
		{
			return _source;
		}

		public function set source(value:Object):void
		{
			var oldValue:Object = this.source;
			if(oldValue != value)
			{
				if (value == null)
				{
					this._source = this._embed;
				}
				else
				{
					this._source = value;
				}
				this._sourceChange = true;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"source",oldValue,value));
				}
				
			}
		}


		/**
		 * @inheritDoc 
		 * @param sprite
		 * @param geometry
		 * @param attributes
		 * @param map
		 * 
		 */		
		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map) : void
		{		
			var rect:Rectangle2D = map.viewBounds.expand(3);			
			if (geometry is GeoRegion)
			{
				sprite.alpha = this.alpha;
				if (this._source is Class || this._source is Bitmap)
				{
					this.drawFillStyle(sprite, this._source, map, rect, geometry);
				}
				else if (this._source is String || this._source is ByteArray)
				{
					this.drawLoadedFillStyle(sprite, this._source, map, rect, geometry);
				}
			}
					
		}
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * 
		 */		
		override public function clear(sprite:Sprite) : void
		{
			sprite.graphics.clear();
//			if(this.angle)
//				removeAllChildren(sprite);
		}
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * 
		 */		
		override public function destroy(sprite:Sprite) : void
		{
			sprite.graphics.clear();
			sprite.x = 0;
			sprite.y = 0;
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override public function clone() : Style
		{
			var pictureFillStyle:PictureFillStyle = new PictureFillStyle(this._source, this._width, this._height, this._xScale, this._yScale, this._xOffset, this._yOffset,this._alpha, this._angle, this.border);
			return pictureFillStyle;
		}
		
		private function drawFillStyle(sprite:Sprite, source:Object, map:Map, bounds:Rectangle2D, geometry:Geometry, width:Number = 0, height:Number = 0) : void
		{
			var img:Bitmap = this._bitmaps[source] as Bitmap;
			if (img == null)
			{
				img = source is Bitmap ? (source as Bitmap) : (new source);
				this._bitmaps[source] = img;
			}
			if (map && bounds && geometry)
			{
				this.drawPolygon(map, bounds, sprite, geometry as GeoRegion, img);
			}
			else
			{
				this.drawSwatch(sprite, img, width, height);
			}
		}
		
		private function drawLoadedFillStyle(sprite:Sprite, source:Object, map:Map, bounds:Rectangle2D, geometry:Geometry, width:Number = 0, height:Number = 0) : void
		{
			var handleCacheResult:Function;
			handleCacheResult = function (resultSprite:CustomSprite) : void
			{
				var img:Bitmap = null;
				if (resultSprite.getChildAt(0) is Bitmap)
				{
					img = resultSprite.getChildAt(0) as Bitmap;					
					if (map && bounds && geometry)
					{
						drawPolygon(map, bounds, sprite, geometry as GeoRegion, img);
					}
					else
					{
						drawSwatch(sprite, img, width, height);
					}
				}
				
			}
			PictureMarkerStyleCache.instance.getDisplayObject(source, null, handleCacheResult);
		}
		
		private function drawPolygon(map:Map, rect:Rectangle2D, sprite:Sprite, geoRegion:GeoRegion, bmp:Bitmap) : void
		{
			var scaleX:Number = NaN;
			var scaleY:Number = NaN;
			var numAngle:Number = 0;
			var numxOffset:Number = NaN;
			var numyOffset:Number = NaN;
			var regionBounds:Rectangle2D = null;
			var hasOutline:Boolean = false;
			var aryRegion:Array = null;			
			var numWidth:Number = NaN;
			var numScale:Number = NaN;
			var numHeight:Number = NaN;
			var numyScale:Number = NaN;
			var pts:Array = null;
			var pt:Point2D = null;
			var bounds:Rectangle2D = geoRegion.bounds;
			var rectL:Number = this.toScreenX(map, bounds.left);
			var rectR:Number = this.toScreenX(map, bounds.right);
			var rectB:Number = this.toScreenY(map, bounds.bottom);
			var rectT:Number = this.toScreenY(map, bounds.top);
			sprite.x = rectL;
			sprite.y = rectT;
			sprite.width = rectR - rectR;
			sprite.height = rectB - rectT;
			if (this._width)
			{
				numWidth = this._width;
				if (this._xScale)
				{
					numWidth = numWidth * this._xScale;
				}
				bmp.width = numWidth;
				scaleX = numWidth / bmp.bitmapData.width;
				numxOffset = this._xOffset ? (this._xOffset - bmp.width / 2) : ((-bmp.width) / 2);
			}
			else
			{
				numScale = this._xScale ? (bmp.height * this._xScale) : (bmp.width);
				scaleX = numScale / bmp.bitmapData.width;
				numxOffset = this._xOffset ? (this._xOffset - numScale / 2) : ((-numScale) / 2);
			}
			if (this._height)
			{
				numHeight = this._height;
				if (this._yScale)
				{
					numHeight = numHeight * this._yScale;
				}
				bmp.height = numHeight;
				scaleY = numHeight / bmp.bitmapData.height;
				numyOffset = this._yOffset ? (-(this._yOffset + bmp.height / 2)) : ((-bmp.height) / 2);
			}
			else
			{
				numyScale = this._yScale ? (bmp.height * this._yScale) : (bmp.height);				
				scaleY = numyScale / bmp.bitmapData.height;				
				numyOffset = this._yOffset ? (-(this._yOffset + numyScale / 2)) : ((-numyScale) / 2);
			}
			if (this._angle)
			{
				numAngle = 2 * Math.PI * (this._angle / 360);
			}			
			//trace("bmp.bitmapData.width",bmp.bitmapData.width,"bmp.width",bmp.width,"bmp.bitmapData.height",bmp.bitmapData.height,"bmp.height",bmp.height);
			this._matrix.createBox(scaleX, scaleY, numAngle, numxOffset, numyOffset);			
			var max:Matrix=new Matrix();
			//bmp.alpha = 0.1;			
			sprite.graphics.beginBitmapFill(bmp.bitmapData, this._matrix, true, true);	
			
			if (this.border)
			{
				hasOutline = true;
				this._stroke.color = this.border.color;
				this._stroke.weight = this.border.weight;
				this._stroke.alpha = this.border.alpha;
			}
			for(var i:int=0;i<geoRegion.partCount;i++)
			{				
				aryRegion=geoRegion.getPart(i);
				regionBounds = geoRegion.bounds;
				
				if (aryRegion.length >= 2)
				{
					pts = [];
					for each (pt in aryRegion)
					{						
						pts.push(this.toScreenX(map, pt.x) - sprite.x);
						pts.push(this.toScreenY(map, pt.y) - sprite.y);						
					}
					this.tracePolygon(map, rect, sprite, pts, aryRegion, this._stroke, hasOutline, false);
					
				}
			}
			sprite.graphics.endFill();
			
			for(var j:int=0;j<geoRegion.partCount;j++)
			{				
				var aryBoarderPts:Array=geoRegion.getPart(j);
				if (this.border && this.border.symbol != PredefinedLineStyle.SYMBOL_NULL && this.border.symbol != PredefinedLineStyle.SYMBOL_SOLID)
				{
					this.traceSegmentStyledLine(map, rect, sprite, this._stroke, aryBoarderPts);
					continue;
				}	
			}
			
		}
		
		private function drawSwatch(sprite:Sprite, bmp:Bitmap, width:Number, height:Number) : void
		{
			var minWidth:Number = Math.min(width, bmp.width * this._xScale);
			var minHeight:Number = Math.min(height, bmp.height * this._yScale);
			bmp.width = minWidth;
			bmp.height = minHeight;
			if (this._width)
			{
				minWidth = Math.min( this._width * this._xScale, width);
				bmp.width = minWidth;
			}
			if (this._height)
			{
				minHeight = Math.min(height, this._height * this._yScale);
				bmp.height = minHeight;
			}
			var scaleX:Number = minWidth / bmp.bitmapData.width;
			var scaleY:Number = minHeight / bmp.bitmapData.height;
			
			var x:Number = NaN;
			var y:Number = NaN;
			if (this.xOffset)
			{
				x = this.xOffset - bmp.width / 2;
			}
			else
			{
				x = (-bmp.width) / 2;
			}
			if (this.yOffset)
			{
				y = -(this.yOffset + bmp.height / 2);
			}
			else
			{
				y = (-bmp.height) / 2;
			}
			
			var rotation:Number = 0;
			if (this.angle)
			{
				rotation = 2 * Math.PI * (this.angle / 360);
			}
			this._matrix.createBox(scaleX, scaleY, rotation, x, y);
			sprite.graphics.beginBitmapFill(bmp.bitmapData, this._matrix, true, true);
			if (border)
			{
				var minSize:Number = Math.min(border.weight, height);
				var halfMinSize:Number = minSize / 2;
				this._stroke.weight = minSize;
				this._stroke.color = border.color;
				this._stroke.alpha = border.alpha;
				if (border.symbol == PredefinedLineStyle.SYMBOL_SOLID)
				{
					this._stroke.apply(sprite.graphics, null, null);
					sprite.graphics.drawRoundRect(halfMinSize, halfMinSize, width - minSize, height - minSize, (width + height) / 8);
				}
				else if (border.symbol == PredefinedLineStyle.SYMBOL_NULL)
				{
					sprite.graphics.drawRoundRect(0, 0, width, height, (width + height) / 8);
				}
				else
				{
					var sizeArray:Array = [halfMinSize, halfMinSize, halfMinSize, height - halfMinSize, width - halfMinSize, height - halfMinSize, width - halfMinSize, halfMinSize, halfMinSize, halfMinSize];
					sprite.graphics.drawRect(halfMinSize, halfMinSize, width - minSize, height - minSize);
					sprite.graphics.endFill();
					StyleUtil.drawStyledGeoLine(sprite, sizeArray, this._stroke, this.pattern);
				}
			}
			else
			{
				sprite.graphics.drawRoundRect(0, 0, width, height, (width + height) / 8);
			}
			sprite.graphics.endFill();
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
		
		private function graphicsFilling(map:Map, sprite:Sprite, arrOfPoints:Array) : void
		{
			sprite.graphics.moveTo(arrOfPoints[0], arrOfPoints[1]);			
			var i:int = 2;
			while (i < arrOfPoints.length)
			{				
				sprite.graphics.lineTo(arrOfPoints[i], arrOfPoints[(i + 1)]);
				i = i + 2;
			}			
		}
		
		private function traceSegmentLine(map:Map, rect:Rectangle2D, sprite:Sprite, stroke:SolidColorStroke, arrPoints:Array) : void
		{
			var pt:Point2D = null;
			this.closePolygon(arrPoints);
			var ptZero:* = arrPoints[0];
			sprite.graphics.moveTo(toScreenX(map, ptZero.x) - sprite.x, toScreenY(map, ptZero.y) - sprite.y);
			var i:int = 1;
			while (i < arrPoints.length)
			{				
				pt = arrPoints[i];
				
				if (pt.x == ptZero.x && pt.y != ptZero.y)
				{
					this.drawSegmentPolygon(map, rect, sprite, stroke, ptZero, pt);
				}
				ptZero = pt;
				i++;
			}			
		}
		
		private function traceSegmentStyledLine(map:Map, rect:Rectangle2D, sprite:Sprite, stroke:SolidColorStroke, arrOfStyledPoints:Array) : void
		{
			var pt:Point2D = null;
			this.closePolygon(arrOfStyledPoints);
			var ptZero:* = arrOfStyledPoints[0];
			var i:int = 1;
			while (i < arrOfStyledPoints.length)
			{				
				pt = arrOfStyledPoints[i];				
				if (!pt.equals( ptZero))
				{
					this.drawSegmentStyledPolygon(map, rect, sprite, stroke, ptZero, pt);
				}
				ptZero = pt;
				i = i + 1;
			}
			
		}
		
		private function closePolygon(arrPoints:Array) : void
		{
			if (arrPoints[(arrPoints.length - 1)].x == arrPoints[0].x)
			{
			}
			if (arrPoints[(arrPoints.length - 1)].y != arrPoints[0].y)
			{
				arrPoints.push(arrPoints[0]);
			}
			
		}
		
		private function drawSegmentPolygon(map:Map, rect:Rectangle2D, sprite:Sprite, stroke:SolidColorStroke, startPt:Point2D, endPt:Point2D) : void
		{
			var clipPts:Array = null;
			var ptZero:GeoPoint = null;
			var ptf:GeoPoint = null;
			var ptc:GeoPoint = null;
			var startPtx:* = this.toScreenX(map, startPt.x);
			var startPty:* = this.toScreenY(map, startPt.y);
			var endPtx:* = this.toScreenX(map, endPt.x);
			var endPty:* = this.toScreenY(map, endPt.y);
			var disXY:* = Math.sqrt(Math.pow(endPtx - startPtx, 2) + Math.pow(endPty - startPty, 2));
			if (disXY >= 32000)
			{
				clipPts = [];
				if (rect.contains(startPt.x,startPt.y) && !rect.contains(endPt.x,endPt.y))
				{
					clipPts = GeoUtil.clipLineRect(startPt, endPt, rect);
					if (clipPts.length == 0)
					{
						sprite.graphics.lineStyle();
						sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
					}
					else if (clipPts.length == 1)
					{
						ptZero = clipPts[0];
						if (!rect.contains(startPt.x,startPt.y))
						{
						}
						if (rect.contains(endPt.x,endPt.y))
						{
							sprite.graphics.lineTo(toScreenX(map, ptZero.x) - sprite.x, toScreenY(map, ptZero.y) - sprite.y);
							stroke.apply(sprite.graphics, null, null);
							sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
						}
						else
						{
							if (rect.contains(startPt.x,startPt.y))
							{
								rect.contains(startPt.x,startPt.y);
							}
							if (!rect.contains(endPt.x,endPt.y))
							{
								stroke.apply(sprite.graphics, null, null);
								sprite.graphics.lineTo(toScreenX(map, ptZero.x) - sprite.x, toScreenY(map, ptZero.y) - sprite.y);
								sprite.graphics.lineStyle();
								sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
							}
						}
					}
					else
					{
						ptf = clipPts[0];
						ptc = clipPts[1];
						sprite.graphics.lineStyle();
						sprite.graphics.lineTo(toScreenX(map, ptf.x) - sprite.x, toScreenY(map, ptf.y) - sprite.y);
						stroke.apply(sprite.graphics, null, null);
						sprite.graphics.lineTo(toScreenX(map, ptc.x) - sprite.x, toScreenY(map, ptc.y) - sprite.y);
						sprite.graphics.lineStyle();
						sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
					}
				}
				else
				{
					stroke.apply(sprite.graphics, null, null);
					sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
				}
			}
			else
			{
				stroke.apply(sprite.graphics, null, null);
				sprite.graphics.lineTo(endPtx - sprite.x, endPty - sprite.y);
			}
			
		}
		
		private function drawSegmentStyledPolygon(map:Map, rect:Rectangle2D, sprite:Sprite, stroke:SolidColorStroke, startPt:Point2D, endPt:Point2D) : void
		{
			var ptZero:Point2D = null;
			var ptf:Point2D = null;
			var ptc:Point2D = null;
			var startPtx:* = this.toScreenX(map, startPt.x);
			var startPty:* = this.toScreenY(map, startPt.y);
			var endPtx:* = this.toScreenX(map, endPt.x);
			var endPty:* = this.toScreenY(map, endPt.y);
			var clipPts:Array = [];
			var pts:Array = [];
			if (rect.containsPoint(startPt))
			{
			}
			if (!rect.containsPoint(endPt))
			{
				clipPts = GeoUtil.clipLineRect(startPt, endPt, rect);
				if (clipPts.length == 0)
				{
				}
				else if (clipPts.length == 1)
				{
					ptZero = clipPts[0];
					if (!rect.containsPoint(startPt))
					{
					}
					if (rect.containsPoint(endPt))
					{
						pts.push(toScreenX(map, ptZero.x) - sprite.x);
						pts.push(toScreenY(map, ptZero.y) - sprite.y);
						pts.push(endPtx - sprite.x);
						pts.push(endPty - sprite.y);
					}
					else
					{
						if (rect.containsPoint(startPt))
						{
							rect.containsPoint(startPt);
						}
						if (!rect.containsPoint(endPt))
						{
							pts.push(startPtx - sprite.x);
							pts.push(startPty - sprite.y);
							pts.push(toScreenX(map, ptZero.x) - sprite.x);
							pts.push(toScreenY(map, ptZero.y) - sprite.y);
						}
					}
				}
				else
				{
					ptf = clipPts[0];
					ptc = clipPts[1];
					pts.push(toScreenX(map, ptf.x) - sprite.x);
					pts.push(toScreenY(map, ptf.y) - sprite.y);
					pts.push(toScreenX(map, ptc.x) - sprite.x);
					pts.push(toScreenY(map, ptc.y) - sprite.y);
				}
			}
			else
			{
				pts.push(startPtx - sprite.x);
				pts.push(startPty - sprite.y);
				pts.push(endPtx - sprite.x);
				pts.push(endPty - sprite.y);
			}
			if (pts != null)
			{
				StyleUtil.drawStyledGeoLine(sprite, pts, stroke, this.pattern);
			}

		}
		
		/**
		 * ${core_styles_PictureFillStyle_attribute_defaultStyle_D} 
		 * @return 
		 * 
		 */		
		public static function get defaultStyle() : Style
		{
			if (_defaultStyle == null)
			{
				_defaultStyle = new PictureFillStyle();
			}
			return _defaultStyle;
		}

	}
}