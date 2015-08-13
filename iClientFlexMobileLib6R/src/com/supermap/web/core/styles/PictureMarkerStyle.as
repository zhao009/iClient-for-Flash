package com.supermap.web.core.styles
{	
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.core.BitmapAsset;
	import mx.core.UIComponent;
	import mx.events.PropertyChangeEvent;
	import mx.states.AddChild;
	
	import spark.primitives.Graphic;
	
	use namespace sm_internal;
	
	/**
	 * ${core_styles_PictureMarkerStyle_Title}.
	 * <p>${core_styles_PictureMarkerStyle_Description}</p>
	 * @example ${core_styles_PictureMarkerStyle_Example} 
	 * <listing>
	 *	var geoPoint:GeoPoint = new GeoPoint(0,30);
	 *	var pictureMarkerStyle:PictureMarkerStyle = new PictureMarkerStyle("../assets/sunny.png");
	 *	var feature:Feature = new Feature(geoPoint,pictureMarkerStyle);
	 *	featureLayer.addFeature(feature);
	 * </listing> 
	 * 
	 */	
	public class PictureMarkerStyle extends MarkerStyle
	{
		private static var _defaultStyle:PictureMarkerStyle;
		
		private var _embed:Class;
		private var _source:Object;		
		private var _width:Number;
		private var _height:Number;
		private var _alpha:Number;
		private var _dispObj:DisplayObject;		
		private var _loaderContext:LoaderContext;
		private var _hasChildren:Boolean;
		private var _rotationSprite:Sprite;
		private var _editModeOn:Boolean;
		private var _myWidth:Number;
		private var _myHeight:Number;
		private var _spriteToPoint:Dictionary;
		private var _spriteToPointsArray:Dictionary;	
		private var map:Map;
		private var spt:Sprite;
		private var _sourceChange:Boolean;
		
		/**
		 * ${core_styles_PictureMarkerStyle_constructor_D} 
		 * @param source ${core_styles_PictureMarkerStyle_constructor_param_source}
		 * @param width ${core_styles_PictureMarkerStyle_constructor_param_width}
		 * @param height ${core_styles_PictureMarkerStyle_constructor_param_height}
		 * @param xOffset ${core_styles_PictureMarkerStyle_constructor_param_xoffset}
		 * @param yOffset ${core_styles_PictureMarkerStyle_constructor_param_yoffset}
		 * @param alpha ${core_styles_PictureMarkerStyle_constructor_param_alpha}
		 * @param angle ${core_styles_PictureMarkerStyle_constructor_param_angle}
		 * 
		 */		
		public function PictureMarkerStyle(source:Object = null , width:Number = 0, height:Number = 0, xOffset:Number = 0, yOffset:Number = 0, alpha:Number = 1, angle:Number = 0)
		{			
			this._loaderContext = new LoaderContext(true);	
			this._spriteToPoint = new Dictionary();
			this._spriteToPointsArray = new Dictionary();		
			this._embed = BitmapAsset;
			this._source = _embed;
			this.source = source;
			this.width = width;
			this.height = height;
			this.xOffset = xOffset;
			this.yOffset = yOffset;
			this.alpha = alpha;
			this.angle = angle;			
		}

		/**
		 * ${core_styles_PictureMarkerStyle_attribute_alpha_D} 
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
		 * ${core_styles_PictureMarkerStyle_attribute_height_D}.
		 * <p>${core_styles_PictureMarkerStyle_attribute_height_remarks}</p> 
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
			var oldValue:Number = this.height;
			if(oldValue != value)
			{
				this._height = value;
				this._myHeight = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"height",oldValue,value));
				}
				
			}
		}

		/**
		 * ${core_styles_PictureMarkerStyle_attribute_width_D}.
		 * <p>${core_styles_PictureMarkerStyle_attribute_width_remarks}</p>
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
			var oldValue:Number = this.width;
			if(oldValue != value)
			{
				this._width = value;
				this._myWidth = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"width",oldValue,value));
				}
				
			}
		}
	
		/**
		 * ${core_styles_PictureMarkerStyle_attribute_source_D} 
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
				this._dispObj = null;
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
		 * 
		 */		
		override public function clear(sprite:Sprite) : void
		{
			sprite.graphics.clear();
/*			if(sprite.numChildren)
			{
				for(var i:int = 0; i < sprite.numChildren; i++)
				{
					sprite.removeChildAt(0);
					delete this._spriteToPoint[sprite];
					delete this._spriteToPointsArray[sprite];
				}
			}*/
			
//			for(var key:Sprite in this._spriteToPoint)
//			{
//				this._spriteToPoint[key] = null;
//			}
//			for(var key:Sprite in this._spriteToPointsArray)
//			{
//				this._spriteToPointsArray[key] = null;
//			}	
//			this._spriteToPoint[sprite] = null;
			

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
			var swatchSprite:Sprite;
			var centerX:Number;
			var centerY:Number;
			var imageWidth:Number;
			var imageHeight:Number;
			var swatchPlacement:Function = function () : void
			{
				this._dispObj.width = imageWidth;
				this._dispObj.height = imageHeight;
				swatchSprite.width = imageWidth;
				swatchSprite.height = imageHeight;
				swatchSprite.x = centerX - imageWidth / 2;
				swatchSprite.y = centerY - imageHeight / 2;
				if (!angle)
				{
					swatchSprite.addChild(this._dispObj);
					this._dispObj.x = 0;
					this._dispObj.y = 0;
				}
				else
				{
					_rotationSprite = new UIComponent();
					_rotationSprite.x = imageWidth / 2;
					_rotationSprite.y = imageHeight / 2;
					this._dispObj.x = (-imageWidth) / 2;
					this._dispObj.y = (-imageHeight) / 2;
					_rotationSprite.addChild(this._dispObj);
					_rotationSprite.rotation = angle;
					swatchSprite.addChild(_rotationSprite);
				}
			}
			
			var swatch:UIComponent = new UIComponent();
			swatch.width = width;
			swatch.height = height;
			swatchSprite = new UIComponent();
			swatch.addChild(swatchSprite);
			centerX = width * 0.5;
			centerY = height * 0.5;
			removeAllChildren(swatchSprite);
			if (!(this._source is Class) && this._source is Bitmap)
			{
				this._dispObj = this._source is Bitmap ? (this._source as Bitmap) : (new this._source() as DisplayObject);
				if (this._width)
				{
					imageWidth = Math.min(this._width, width);
				}
				else
				{
					imageWidth = Math.min(this._dispObj.width, width);
				}
				if (this._height)
				{
					imageHeight = Math.min(this._height, height);
				}
				else
				{
					imageHeight = Math.min(this._dispObj.height, height);
				}
				swatchPlacement();
			}
			else
			{
				var handleCacheResult:Function = function (resultSprite:CustomSprite) : void
				{
					this._dispObj = resultSprite as DisplayObject;
					if (_myWidth && _myHeight)
					{
						imageWidth = Math.min(_myWidth, width);
						imageHeight = Math.min(_myHeight, height);
						swatchPlacement();
					}
					else
					{
						imageWidth = Math.min(this._dispObj.width, width);
						imageHeight = Math.min(this._dispObj.width, height);
					}
					swatchPlacement();
				}
				PictureMarkerStyleCache.instance.getDisplayObject(this._source, null, handleCacheResult);
			}
			return swatch;
		}
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * 
		 */		
		public override function destroy(sprite:Sprite) : void
		{
			removeAllChildren(sprite);
			sprite.graphics.clear();
			sprite.mouseChildren = true;
			sprite.rotation = 0;
			sprite.x = 0;
			sprite.y = 0;	
			delete this._spriteToPoint[sprite];
			delete this._spriteToPointsArray[sprite];
		}
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * @param geometry
		 * @param attributes
		 * @param map
		 * 
		 */		
		public override  function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{			
			var sourcePoint:GeoPoint = null;	
			this.map=map;
			this.spt=sprite;
			sprite.alpha = this.alpha;
			if (!geometry)
			{
				return;
			}
			if (this._source is Class || this._source is Bitmap)
			{
				removeAllChildren(sprite);	
				if (geometry is GeoPoint)
				{
					sourcePoint = geometry as GeoPoint;
					if (sprite.numChildren > 0)
					{
						this.getChildFromSprite(sprite);
					}
					if (sprite.numChildren == 0)
					{
						this._hasChildren = false;	
						if (sprite is CompositeStyleComponent)
						{
							CompositeStyleComponent(sprite).source = this._source;
						}
						else
						{
							Feature(sprite).source = this._source;
						}
						this._dispObj = new CustomSprite();
						this._dispObj.name = "displayObject";
						if (this._source is Class)
						{
							CustomSprite(this._dispObj).addChild(new this._source());
						}
						else
						{
							CustomSprite(this._dispObj).addChild(this._source as Bitmap);
						}
						CustomSprite(this._dispObj).point = sourcePoint;
						if (this._editModeOn)
						{
							CustomSprite(this._dispObj).mouseChildren = false;
						}
					}
					this.drawSourcePoint(map, sprite, sourcePoint);
					
				}
				else
				{
					drawOtherSourcePoint(map, sprite, geometry);
				}					
				
			}
			else if (this._source is String || this._source is ByteArray)
			{		
				if (geometry is GeoPoint)
				{
					sourcePoint = geometry as GeoPoint;
					this.drawLoadedPoint(map, sprite, sourcePoint);
				}
				else
				{
					this.drawOtherLoadedPoint(map, sprite, geometry);
				}							
			}
		}		
			
		private function drawSourcePoint(map:Map,sprite:Sprite, point:GeoPoint) : void
		{
			sprite.x = toScreenX(map, point.x);
			sprite.y = toScreenY(map, point.y);
			if (this._myWidth)
			{
				this._dispObj.width = this._myWidth;
				sprite.x = sprite.x - this._myWidth / 2;
				this._dispObj.x = 0;
				sprite.width = this._myWidth;
			}
			else
			{
				sprite.x = sprite.x - this._dispObj.width / 2;
				this._dispObj.x = 0;
				sprite.width = this._dispObj.width;
			}
			if (this._myHeight)
			{
				this._dispObj.height = this._myHeight;
				sprite.y = sprite.y - this._myHeight / 2;
				this._dispObj.y = 0;
				sprite.height = this._myHeight;
			}
			else
			{
				sprite.y = sprite.y - this._dispObj.height / 2;
				this._dispObj.y = 0;
				sprite.height = this._dispObj.height;
			}
			if (xOffset)
			{
				sprite.x = sprite.x + xOffset;
			}
			if (yOffset)
			{
				sprite.y = sprite.y - yOffset;
			}
			if (!angle)
			{
				if (!this._hasChildren)
				{
					sprite.addChild(this._dispObj);
				}
				else if (DisplayObject(sprite.getChildAt(0)).name != "displayObject")
				{
					sprite.removeChildAt(0);
					sprite.addChild(this._dispObj);
				}
			}
			else
			{
				if (!this._hasChildren)
				{
					this._rotationSprite = new UIComponent();
					this._rotationSprite.name = "rotationSprite";
					this._rotationSprite.addChild(this._dispObj);
					sprite.addChild(this._rotationSprite);
				}
				if (this._myWidth)
				{
					this._rotationSprite.x = this._myWidth / 2;
					this._dispObj.x = (-this._myWidth) / 2;
				}
				else
				{
					this._rotationSprite.x = this._dispObj.width / 2;
					this._dispObj.x = (-this._dispObj.width) / 2;
				}
				if (this._myHeight)
				{
					this._rotationSprite.y = this._myHeight / 2;
					this._dispObj.y = (-this._myHeight) / 2;
				}
				else
				{
					this._rotationSprite.y = this._dispObj.height / 2;
					this._dispObj.y = (-this._dispObj.height) / 2;
				}
				this._rotationSprite.rotation = angle;
			}
			
		}
		
		private var picWidth:Number;
		private var picHeight:Number;
		
		private function drawLoadedPoint(map:Map,sprite:Sprite,point:GeoPoint) : void
		{
			var geoPoint:GeoPoint;
			var dObject:DisplayObject;
			sprite.x = toScreenX(map, point.x);
			sprite.y = toScreenY(map, point.y);
			if (sprite.numChildren == 0)
			{
				var handleCacheResult:Function = function (resultSprite:CustomSprite) : void
				{
					picWidth = resultSprite.width;
					picHeight = resultSprite.height;
					
					delete _spriteToPoint[sprite];
					if (_editModeOn)
					{
						resultSprite.mouseChildren = false;
					}
					_dispObj = resultSprite as DisplayObject;
					if (!angle)
					{
						sprite.addChild(_dispObj);
						stylePlacement(map, _dispObj, 0, 0, sprite, null);
					}
					else
					{
						_rotationSprite = new UIComponent();
						_rotationSprite.name = "rotationSprite";
						stylePlacement(map, _dispObj, 0, 0, sprite, _rotationSprite, null);
						_rotationSprite.addChild(_dispObj);
						_rotationSprite.rotation = angle;
						sprite.addChild(_rotationSprite);
					}
					sprite.dispatchEvent(new PictureMarkerStyleEvent(PictureMarkerStyleEvent.COMPLETE));
				}
				if (sprite is CompositeStyleComponent)
				{
					CompositeStyleComponent(sprite).source = this._source;
				}
				else
				{
					Feature(sprite).source = this._source;
				}
				geoPoint = this._spriteToPoint[sprite];
				if (geoPoint == null)
				{
					PictureMarkerStyleCache.instance.getDisplayObject(this._source, point, handleCacheResult);
					this._spriteToPoint[sprite] = point;
				}
			}
			else
			{
				if ((sprite is CompositeStyleComponent && CompositeStyleComponent(sprite).source === this._source) || (sprite is Feature))
				{
					if (sprite is Feature && Feature(sprite).source !== this._source)
					{
						removeAllChildren(sprite);
						this.drawLoadedPoint(map, sprite, point);
					}
					else
					{
						dObject = sprite.getChildAt(0);
						if (dObject is DisplayObjectContainer)
						{
							if (dObject.name == "rotationSprite")
							{
								this._rotationSprite = dObject as UIComponent;
								this._dispObj = DisplayObjectContainer(dObject).getChildAt(0);
								this.stylePlacement(map, this._dispObj, 0, 0, sprite, this._rotationSprite, null);
								this._rotationSprite.rotation = angle;
							}
							else if (angle)
							{
								this._dispObj = sprite.removeChildAt(0);
								this._rotationSprite = new UIComponent();
								this._rotationSprite.name = "rotationSprite";
								this._rotationSprite.addChild(this._dispObj);
								sprite.addChild(this._rotationSprite);
								this.stylePlacement(map, this._dispObj, 0, 0, sprite, this._rotationSprite, null);
								this._rotationSprite.rotation = angle;
							}
							else
							{
								this._dispObj = dObject;
								this.stylePlacement(map, this._dispObj, 0, 0, sprite, null, null);
							}
						}
						
					}

				}
			}
				
		}
		
		
		
		private function drawOtherSourcePoint(map:Map, sprite:Sprite, geometry:Geometry) : void
		{
			var sourcePointsBounds:Rectangle2D;
			var arrOfSourcePoints:Array = [];					
			var traceMultipointGeometry:Function = function () : void
			{
				if (sprite.numChildren == 0)
				{
					sourceMultipoint(map, sprite, arrOfSourcePoints, sourcePointsBounds);
				}
				else
				{
					getChildrenFromSprite(map, sprite, arrOfSourcePoints, sourcePointsBounds, true);
				}
				
			}
			sprite.x = 0;
			sprite.y = 0;
			if(sprite is CompositeStyleComponent)
			{
				if (geometry is GeoLine)
				{
					var geoline:GeoLine = GeoLine(geometry) as GeoLine;
					sourcePointsBounds = geoline.bounds;									
					var linePartCount:int = geoline.partCount;
					for (var i:int = 0; i < linePartCount; i++)
					{						
						var linepath:Array = geoline.getPart(i);
						var linepathlength:int = linepath.length;
						for(var j:int = 0; j < linepathlength; j++)
						{							
							arrOfSourcePoints.push(linepath[j] as Point2D);							
						}
					}					
					traceMultipointGeometry();
				}
				else if (geometry is GeoRegion)
				{
					var geoRegion:GeoRegion = GeoRegion(geometry) as GeoRegion;
					sourcePointsBounds = geoRegion.bounds;				
					var regionPartCount:int = geoRegion.partCount;
					
					for (var k:int = 0; k < regionPartCount; k++)
					{	
						var regionpath:Array = geoRegion.getPart(i);
						var regionpathlength:int = regionpath.length;
						//todo？针对首尾点相同的情况，避免重复绘制，影响透明度下的显示
						for(j = 0; j < regionpathlength - 1; j++)
						{							
							arrOfSourcePoints.push(regionpath[j] as Point2D);							
						}
					}
					traceMultipointGeometry();				
				}
			}
			
		}
		
		private function drawOtherLoadedPoint(map:Map, sprite:Sprite, geometry:Geometry) : void
		{
			var loadedPointsBounds:Rectangle2D;
			var arrOfPoints:Array = [];
			var traceLoadedMultipoint:Function = function () : void
			{
				if (sprite.numChildren == 0)
				{
					loadedMultipoint(map, sprite, arrOfPoints, loadedPointsBounds);
				}
				else
				{
					getChildrenFromSprite(map, sprite, arrOfPoints, loadedPointsBounds, false);
				}
			}
			sprite.x = 0;
			sprite.y = 0;
			if (sprite is CompositeStyleComponent)
			{

				if (geometry is GeoLine)
				{
					var geoline:GeoLine = GeoLine(geometry) as GeoLine;
					loadedPointsBounds = geoline.bounds;						
					var linePartCount:int = geoline.partCount;
					for (var i:int = 0; i < linePartCount; i++)
					{						
						var linepath:Array = geoline.getPart(i);
						var linepathlength:int = linepath.length;
						for(var j:int = 0; j < linepathlength; j++)
						{							
							arrOfPoints.push(linepath[j]);							
						}
					}					
					traceLoadedMultipoint();
				}
				else if (geometry is GeoRegion)
				{
					var geoRegion:GeoRegion = GeoRegion(geometry) as GeoRegion;
					loadedPointsBounds = geoRegion.bounds;				
					var regionPartCount:int = geoRegion.partCount;
					
					for (var k:int = 0; k < regionPartCount; k++)
					{	
						var regionpath:Array = geoRegion.getPart(i);
						var regionpathlength:int = regionpath.length;
						//todo？针对首尾点相同的情况，避免重复绘制，影响透明度下的显示
						for(j = 0; j < regionpathlength - 1; j++)
						{							
							arrOfPoints.push(regionpath[j]);							
						}
					}
					traceLoadedMultipoint();
				}

			}
		}
		
		private function getChildFromSprite(sprite:Sprite) : void
		{
			var dispObj:DisplayObject = null;
			this._hasChildren = true;
			if (sprite is CompositeStyleComponent && CompositeStyleComponent(sprite).source === this._source)
			{
				if (sprite is Feature && Feature(sprite).source !== this._source)
				{
					removeAllChildren(sprite);
				}
				else
				{
					dispObj = sprite.getChildAt(0);
					if (dispObj is DisplayObjectContainer && dispObj.name == "rotationSprite")
					{
						this._rotationSprite = dispObj as UIComponent;
						this._dispObj = DisplayObjectContainer(dispObj).getChildAt(0);
					}
					else if (angle)
					{
						this._dispObj = sprite.removeChildAt(0);
						this._rotationSprite = new UIComponent();
						this._rotationSprite.name = "rotationSprite";
						this._rotationSprite.addChild(this._dispObj);
						sprite.addChild(this._rotationSprite);
					}
					else
					{
						this._dispObj = dispObj;
					}
				}
			}
		}
		
		private function getChildrenFromSprite(map:Map, sprite:Sprite, arrOfPoints:Array, pointsBounds:Rectangle2D,  isSource:Boolean) : void
		{
			var displayObject:DisplayObject = null;
			var displayObjectChild:DisplayObject = null;
			var displayObjectLen:Number = NaN;
			var pts:Array = null;
			var i:Number = NaN;
			var k:Number = NaN;
			var aryPts:Array = null;
			var j:Number = NaN;
			var aryDisplayObject:Array = [];
			var ary:Array = [];
			while (sprite.numChildren > 0)
			{				
				displayObject = sprite.removeChildAt(0);
				if (displayObject is DisplayObjectContainer && displayObject.name == "rotationSprite")
				{
					displayObjectChild = DisplayObjectContainer(displayObject).getChildAt(0);
					aryDisplayObject.push(displayObjectChild);
					ary.push(displayObject);
					continue;
				}
				if (angle)
				{
					aryDisplayObject.push(displayObject);
					this._rotationSprite = new UIComponent();
					this._rotationSprite.name = "rotationSprite";
					this._rotationSprite.addChild(displayObject);
					ary.push(this._rotationSprite);
					continue;
				}
				aryDisplayObject.push(displayObject);
			}
			if (aryDisplayObject.length != arrOfPoints.length || ary.length != 0)
			{

				if (ary.length == arrOfPoints.length)
				{
					this.storedMultipoint(map, sprite, arrOfPoints, aryDisplayObject, ary, pointsBounds, isSource);
				}
				else if (aryDisplayObject.length > arrOfPoints.length)
				{
					while (aryDisplayObject.length == arrOfPoints.length)
					{					
						aryDisplayObject.pop();
					}
					if (ary.length != 0)
					{
						while (ary.length == arrOfPoints.length)
						{						
							ary.pop();
						}
					}
					this.storedMultipoint(map, sprite, arrOfPoints, aryDisplayObject, ary, pointsBounds, isSource);
				}
			}
			else
			{
				if (aryDisplayObject.length >= arrOfPoints.length || ary.length != 0) 
				{
					if(ary.length < arrOfPoints.length)
					{
						if (isSource)
						{
							this.sourceMultipoint(map, sprite, arrOfPoints, pointsBounds);
						}
						else
						{
							displayObjectLen = aryDisplayObject.length;
							pts = [];
							i = 0;
							while (i < displayObjectLen)
							{						
								pts.push(arrOfPoints[i]);
								i++;
							}
							this.storedMultipoint(map, sprite, pts, aryDisplayObject, ary, pointsBounds, isSource);
							k = arrOfPoints.length - aryDisplayObject.length;
							aryPts = [];
							if (k == 1)
							{
								aryPts.push(arrOfPoints[(arrOfPoints.length - 1)]);
							}
							else
							{
								j = displayObjectLen;
								while (j < arrOfPoints.length)
								{							
									aryPts.push(arrOfPoints[j]);
									j++;
								}
							}
							this.loadedMultipoint(map, sprite, aryPts, pointsBounds);
						}
					}
				}
			}
			
		}
		
		private function sourceMultipoint(map:Map, sprite:Sprite, arr:Array, sourcePointsBounds:Rectangle2D) : void
		{			
			var pt:Point2D = null;
			var ptX:Number = NaN;
			var ptY:Number = NaN;
			if (sprite is CompositeStyleComponent)
			{
				CompositeStyleComponent(sprite).source = this._source;
			}
			else
			{
				Feature(sprite).source = this._source;
			}
			for each (pt in arr)
			{				
				this._dispObj = new CustomSprite();
				this._dispObj.name = "displayObject";
				CustomSprite(this._dispObj).point =new GeoPoint( pt.x,pt.y);
				if (this._source is Bitmap)
				{
					CustomSprite(this._dispObj).addChild(new Bitmap(Bitmap(this._source).bitmapData));
				}
				else
				{					
					CustomSprite(this._dispObj).addChild(new this._source());
				}
				if (this._editModeOn)
				{
					CustomSprite(this._dispObj).mouseChildren = false;
				}
				ptX = this.toScreenX(map, pt.x);
				ptY = this.toScreenY(map, pt.y);				
				
				if (!angle)
				{
					sprite.addChild(this._dispObj);	
					this.stylePlacement(map, this._dispObj, ptX, ptY, sprite, null, sourcePointsBounds);					
				}
				else
				{
					this._rotationSprite = new UIComponent();
					this._rotationSprite.addChild(this._dispObj);
					this._rotationSprite.name = "rotationSprite";
					this._rotationSprite.rotation = angle;
					sprite.addChild(this._rotationSprite);
					this.stylePlacement(map, this._dispObj, ptX, ptY, sprite, this._rotationSprite, sourcePointsBounds);
				}
			}			
		}
	
		
		private function storedMultipoint(map:Map, sprite:Sprite, arr:Array, arrDisplayObject:Array, arrRotationSprite:Array, pointsBounds:Rectangle2D, isSource:Boolean) : void
		{
			var i:Number = NaN;
			var pt:Point2D = null;
			var ptX:Number = NaN;
			var ptY:Number = NaN;
			if (sprite is CompositeStyleComponent && CompositeStyleComponent(sprite).source === this.source)
			{
				if (sprite is Feature && Feature(sprite).source !== this.source)
				{
					removeAllChildren(sprite);
					if (isSource)
					{
						this.sourceMultipoint(map, sprite, arr, pointsBounds);
					}
					else
					{
						this.loadedMultipoint(map, sprite, arr, pointsBounds);
					}
				}
				else
				{
					i = 0;
					for each (pt in arr)
					{
						
						ptX = toScreenX(map, pt.x);
						ptY = toScreenY(map, pt.y);
						arrDisplayObject[i].point = new GeoPoint(pt.x, pt.y);
						if (arrRotationSprite.length == 0)
						{
							sprite.addChild(arrDisplayObject[i]);
							this.stylePlacement(map, arrDisplayObject[i], ptX, ptY, sprite, null, pointsBounds);
						}
						else
						{
							sprite.addChild(arrRotationSprite[i]);
							this.stylePlacement(map, arrDisplayObject[i], ptX, ptY, sprite, arrRotationSprite[i] as Sprite, pointsBounds);
							Sprite(arrRotationSprite[i]).rotation = angle;
						}
						i++;
					}
				}
			}
			
			
		}
		
		private function loadedMultipoint(map:Map, sprite:Sprite, arr:Array, loadedPointsBounds:Rectangle2D) : void
		{
			var count:Number;
			var handleCacheResult:Function = function (resultSprite:CustomSprite) : void
			{
				count--;
				this._dispObj = resultSprite as DisplayObject;
				var x:Number = toScreenX(map, resultSprite.x);
				var y:Number = toScreenY(map, resultSprite.y);
				if (!angle)
				{
					sprite.addChild(this._dispObj);
					stylePlacement(map, this._dispObj, x, y, sprite, null, loadedPointsBounds);
				}
				else
				{
					_rotationSprite = new UIComponent();
					_rotationSprite.addChild(this._dispObj);
					_rotationSprite.name = "rotationSprite";
					_rotationSprite.rotation = angle;
					sprite.addChild(_rotationSprite);
					stylePlacement(map, this._dispObj, x, y, sprite, _rotationSprite, loadedPointsBounds);
				}
				if (count == 0)
				{					
					sprite.dispatchEvent(new PictureMarkerStyleEvent(PictureMarkerStyleEvent.COMPLETE));
				}
				
			}
				
			if (sprite is CompositeStyleComponent)
			{
				CompositeStyleComponent(sprite).source = this.source;
			}
			else
			{
				Feature(sprite).source = this.source;
			}
			count = arr.length;
			var array:Array = this._spriteToPointsArray[sprite];
			if (array == null)			
			{
				this._spriteToPointsArray[sprite] = arr;
				var i:int = 0;
				while (i < arr.length)
				{					
					PictureMarkerStyleCache.instance.getDisplayObject(this._source, new GeoPoint(arr[i].x, arr[i].y), handleCacheResult);
					i++;
				}
			}
//			else if(this._sourceChange)
//			{
//				i = 0;
//				while (i < array.length)
//				{					
//					PictureMarkerStyleCache.instance.getDisplayObject(this._source, new GeoPoint(array[i].x, array[i].y), handleCacheResult);
//					i++;
//				}
//
//			}
		}
		
		sm_internal function doNotLoad(sprite:Sprite, geometry:Geometry) : Boolean
		{
			var bol:Boolean = false;
			var pts:Array = null;
			var numGeoLine:Number = NaN;
			var numGeoRegion:Number = NaN;
			if (this._source is Class)
			{
				bol = false;
			}
 			else if (PictureMarkerStyleCache.instance.isComplete(String(this._source)))
			{
				bol = false;
			}
			else
			{
				pts = [];
				switch(geometry.type)
				{
					case "SmGeoPoint":
					{						
						if (sprite.numChildren == pts.length)
						{
							bol = false;
						}
						else
						{
							bol = true;
						}
						break;
					}
					case "SmGeoLine":
					{
						var geoLine:GeoLine = geometry as GeoLine;
						var ptsGeoLine:Array = [];
						var lineLen:int = geoLine.partCount;
						for (var i:int = 0; i < lineLen; i++)
						{
							var linePart:Array = geoLine.getPart(i);
							if (linePart.length >= 2)
							{
								if (linePart[(linePart.length - 1)].x == linePart[0].x)
								{
									ptsGeoLine = linePart[(linePart.length - 1)].y == linePart[0].y ? (linePart.slice(1, linePart.length)) : (linePart);
								}
								else
								{
									ptsGeoLine = linePart;
								}
							}
							numGeoLine = 0;
							while (numGeoLine < ptsGeoLine.length)
							{					
								pts.push(ptsGeoLine[numGeoLine] as GeoPoint);
								numGeoLine++;
							}
						}
						if (sprite.numChildren == pts.length)
						{
							bol = false;
						}
						else
						{
							bol = true;
						}
						break;
					}
					case "SmGeoRegion":
					{
						var geoRegion:GeoRegion = geometry as GeoRegion;
						var ptsGeoRegion:Array = [];
						var regionLen:int = geoRegion.partCount;
						for (var j:int = 0; j < regionLen; j++)
						{
							var regionPart:Array = geoRegion.getPart(j);
							if (regionPart.length > 2)
							{
								if (regionPart[(regionPart.length - 1)].x == regionPart[0].x)
								{
									ptsGeoRegion = regionPart[(regionPart.length - 1)].y == regionPart[0].y ? (regionPart.slice(1, regionPart.length)) : (regionPart);
								}
								else
								{
									ptsGeoRegion = regionPart;
								}
							}
							numGeoRegion = 0;
							while (numGeoRegion < ptsGeoRegion.length)
							{			
								pts.push(ptsGeoRegion[numGeoRegion] as GeoPoint);
								numGeoRegion++;
							}
						}
						if (sprite.numChildren == pts.length)
						{
							bol = false;
						}
						else
						{
							bol = true;
						}
						break;
					}
					
					default:
					{
						break;
					}
				}
			}
			return bol;
		}
			
		private function stylePlacement(map:Map, dispObj:DisplayObject, sx:Number, sy:Number, sprite:Sprite, rotationSprite:Sprite=null, rect:Rectangle2D=null):void
		{
			var rectL:Number = NaN;
			var rectT:Number = NaN;
			var rectR:Number = NaN;
			var rectB:Number = NaN;
			
			if (rect)
			{
				rectL = toScreenX(map, rect.left);
				rectT = toScreenY(map, rect.bottom);
				rectR = toScreenX(map, rect.right);
				rectB = toScreenY(map, rect.top);
				if (this._myWidth)
				{
					dispObj.width = this._myWidth;
					sprite.x = rectL - this._myWidth / 2;
					sprite.width = rectR + this._myWidth - rectL;
					if (!rotationSprite)
					{
						dispObj.x = sx - (this._myWidth / 2 + sprite.x);
					}
					else
					{
						rotationSprite.x = sx - sprite.x;
						dispObj.x = (-this._myWidth) / 2;
					}
				}
				else
				{
					sprite.x = rectL - dispObj.width / 2;
//					sprite.width = rectR + dispObj.width - rectL;
					dispObj.width = picWidth;
					sprite.width = picWidth;
					if (!rotationSprite)
					{
						dispObj.x = sx - (dispObj.width / 2 + sprite.x);
					}
					else
					{
						rotationSprite.x = sx - sprite.x;
						dispObj.x = (-dispObj.width) / 2;
					}
				}
				if (this._myHeight)
				{
					dispObj.height = this._myHeight;
					sprite.y = rectB - this._myHeight / 2;
					sprite.height = rectT + this._myHeight - rectB;
					if (!rotationSprite)
					{
						dispObj.y = sy - (this._myHeight / 2 + sprite.y);
					}
					else
					{
						rotationSprite.y = sy - sprite.y;
						dispObj.y = (-this._myHeight) / 2;
					}
				}
				else
				{
					sprite.y = rectB - dispObj.height / 2;
//					sprite.height = rectT + dispObj.height - rectB;
					dispObj.height = picHeight;
					sprite.height = picHeight;
					if (!rotationSprite)
					{
						dispObj.y = sy - (dispObj.height / 2 + sprite.y);
					}
					else
					{
						rotationSprite.y = sy - sprite.y;
						dispObj.y = (-dispObj.height) / 2;
					}
				}
				if (xOffset)
				{
					sprite.x = sprite.x + xOffset;
					if (!rotationSprite)
					{
						dispObj.x = dispObj.x + xOffset;
					}
					else
					{
						rotationSprite.x = rotationSprite.x + xOffset;
					}
				}
				if (yOffset)
				{
					sprite.y = sprite.y - yOffset;
					if (!rotationSprite)
					{
						dispObj.y = dispObj.y - yOffset;
					}
					else
					{
						rotationSprite.y = rotationSprite.y - yOffset;
					}
				}
			}
			else
			{
				if (this._myWidth)
				{
					dispObj.width = this._myWidth;
					sprite.x = sprite.x - this._myWidth / 2;
					dispObj.x = 0;
					sprite.width = this._myWidth;
					if (rotationSprite)
					{
						rotationSprite.x = this._myWidth / 2;
						dispObj.x = (-this._myWidth) / 2;
					}
				}
				else
				{
					sprite.x = sprite.x - picWidth / 2;
					dispObj.x = 0;
//					sprite.width = dispObj.width;
					dispObj.width = picWidth;
					sprite.width = picWidth;
					if (rotationSprite)
					{
						rotationSprite.x = dispObj.width / 2;
						dispObj.x = (-dispObj.width) / 2;
					}
				}
				if (this._myHeight)
				{
					dispObj.height = this._myHeight;
					sprite.y = sprite.y - this._myHeight / 2;
					dispObj.y = 0;
					sprite.height = this._myHeight;
					if (rotationSprite)
					{
						rotationSprite.y = this._myHeight / 2;
						dispObj.y = (-this._myHeight) / 2;
					}
				}
				else
				{
					sprite.y = sprite.y - picHeight / 2;//这一句还有问题
					dispObj.y = 0;
//					sprite.height = dispObj.height;
					dispObj.height = picHeight;
					sprite.height = picHeight;
					if (rotationSprite)
					{
						rotationSprite.y = dispObj.height / 2;
						dispObj.y = (-dispObj.height) / 2;
					}
				}
				if (xOffset)
				{
					sprite.x = sprite.x + xOffset;
					if (rotationSprite)
					{
						rotationSprite.x = rotationSprite.x + xOffset;
					}
				}
				if (yOffset)
				{
					sprite.y = sprite.y - yOffset;
					if (rotationSprite)
					{
						rotationSprite.y = rotationSprite.y - yOffset;
					}
				}
			}
		}
		
		public static function get defaultStyle() : Style
		{
			if (_defaultStyle == null)
			{
				_defaultStyle = new PictureMarkerStyle();
			}
			return _defaultStyle;
		}
	}
}
