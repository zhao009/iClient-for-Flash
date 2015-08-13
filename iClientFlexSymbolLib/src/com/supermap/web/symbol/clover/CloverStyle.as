package com.supermap.web.symbol.clover
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.core.styles.MarkerStyle;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.events.GraphicsLayerEvent;
	import com.supermap.web.mapping.*;
	import com.supermap.web.mapping.supportClasses.LayerContainer;
	import com.supermap.web.sm_internal;
	import com.supermap.web.symbol.event.CloverEvent;
	import com.supermap.web.utils.GeoUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import mx.core.UIComponent;
	import mx.events.PropertyChangeEvent;
	import mx.graphics.SolidColorStroke;
	
	use namespace sm_internal;	
	
	/**
	 * ${symbol_CloverStyle_Title}.
	 * <p>${symbol_CloverStyle_Description}</p> 
	 * 
	 */	
	public class CloverStyle extends MarkerStyle
	{		
		private var _size:Number = 30;
		private var _half:Number = 15;					
		private var _sectorItems:Array = [];
		private var sectorItemsChanged:Boolean = false;
		
		private var tar:GraphicsLayer;
		private var _map:Map;		
		
		private static var dict:Dictionary;		
		private static var layer:GraphicsLayer;
		private static var DefaultCloverStyle:Style;
		
		private var centerX:Number;
		private var centerY:Number;
		
		sm_internal var _stroke:SolidColorStroke;
		
		//构造函数   	
		/**
		 * ${symbol_CloverStyle_constructor_D} 
		 * @param sectorItems ${symbol_CloverStyle_constructor_param_sectorItems}
		 * @param xOffset ${symbol_CloverStyle_constructor_param_xOffset}
		 * @param yOffset ${symbol_CloverStyle_constructor_param_yOffset}
		 * 
		 */		 		
		public function CloverStyle(sectorItems:Array = null, xOffset:Number = 0, yOffset:Number = 0)
		{			
			this._stroke = new SolidColorStroke();							
			this.xOffset = xOffset;
			this.yOffset = yOffset;
			
			if(!sectorItems)
			{
				this.sectorItems.push(new SectorItem(60),new SectorItem(180),new SectorItem(300));//默认的三个扇叶
			}
			else
			{
				this.sectorItems = sectorItems;
			}
			
			if(!CloverStyle.dict)
				dict = new Dictionary();
		}
		
		sm_internal function get stroke():SolidColorStroke
		{
			return _stroke;
		}
		
		sm_internal function set stroke(value:SolidColorStroke):void
		{
			var oldValue:SolidColorStroke = this._stroke;
			if(value != this.stroke)
			{
				this._stroke = value;				
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stroke", oldValue, value));
				}
			}
		}
		
		/**
		 * ${symbol_CloverStyle_attribute_sectorItems_D} 
		 * @see com.supermap.web.symbol.clover.SectorItem
		 * @return 
		 * 
		 */		
		public function get sectorItems():Array
		{
			return _sectorItems;
		}
		
		public function set sectorItems(value:Array):void
		{			
			var oldValue:Array = this._sectorItems;
			if(value != this.sectorItems)
			{
				this._sectorItems = value;
				sectorItemsChanged = true;
				dispatchEventChange();
				
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sectorItems", oldValue, value));
				}
			}
		}
		
		/**
		 * ${symbol_CloverStyle_attribute_size_D} 
		 * @return 
		 * 
		 */		
		public function get size():Number
		{
			if(sectorItemsChanged)//默认返回最大的值
			{
				var values:Array = [];
				for(var i:int = 0; i < this.sectorItems.length; i++)
				{
					values.push((sectorItems[i] as SectorItem).sectorRadius);
				}
				values.sort();
				return values[values.length - 1];
			}
			else
			{
				return this._size;//默认显示为30
			}
			return _size;
		}
		
		/**
		 * ${symbol_CloverStyle_attribute_numSector_D} 
		 * @return 
		 * 
		 */	
		public function get numSector():int
		{
			return this.sectorItems.length;
		}	
		
		/**
		 * ${symbol_CloverStyle_method_clone_D} 
		 * @return 
		 * 
		 */		
		public override function clone() : Style
		{
			var cloverStyle:CloverStyle;
			if(this._sectorItems && this._sectorItems.length > 0)
			{
				var sectorItemClone:Array = [];
				var len:int = this._sectorItems.length;
				for(var i:int = 0; i < len; i++)
				{
					if(this._sectorItems[i] is SectorItem)
					{
						sectorItemClone.push(SectorItem.formSectorItem(this._sectorItems[i]));
					}
				}
				cloverStyle = new CloverStyle(sectorItemClone, this.xOffset, this.yOffset);
			}
			else
			{
				cloverStyle = new CloverStyle(this._sectorItems, this.xOffset, this.yOffset);
			}
			
			return cloverStyle;
			
		}
		
		/**
		 * ${symbol_CloverStyle_attribute_defaultStyle_D} 
		 * @return 
		 * 
		 */		
		public static function get defaultStyle():Style
		{
			if(DefaultCloverStyle == null)
			{
				DefaultCloverStyle = new CloverStyle();
			}
			return DefaultCloverStyle;
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
		}		
		
		/**
		 * @inheritDoc 
		 * @param sprite
		 * 
		 */		
		//		override public  function clear(sprite:Sprite):void
		//		{
		//			sprite.graphics.clear();
		//		}		
		
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
		
		private function borderChangeHandler(event:Event) : void
		{
			dispatchEventChange();			
		}
		
		private function drawPoint(sprite:Sprite, size:Number, half:Number, point:GeoPoint, map:Map, centerX:Number = 0, centerY:Number = 0):void
		{	
			if(sprite is Feature)
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
			}
			drawPointSector(map,sprite, size, half, point);
		}			
		
		private function drawPointSector(map:Map,sprite:Sprite, size:Number, half:Number, point:GeoPoint) : void
		{		
			_map = map;
			var forLength:int;
			if(sprite is Feature)
			{
				removeSpts(sprite);			
				addSpts(sprite);		
				forLength = sprite.numChildren;
			}
			else
				forLength = sectorItems.length;
			
			addSectorItem(map, sprite, size, half, this._stroke, point);	
		}
		
		/**
		 * 移除sprite里的所有child
		 */
		private function removeSpts(sprite:Sprite):void
		{
			if(this.sectorItems && this.sectorItems.length & sprite.numChildren)
			{
				do
				{
					sprite.removeChildAt(0);
				}
				while(sprite.numChildren)
			}			
		}
		
		/**
		 * 添加预定个数的child到sprite里
		 */
		private function addSpts(sprite:Sprite):void
		{
			if(this.sectorItems && this.sectorItems.length)
			{
				for(var i:int = 0; i < this.sectorItems.length; i++)
				{
					sprite.addChild(new SectorSprite() as DisplayObject);
				}
			}			
		}			
		
		
		private static var layers:Array = [];
		private function addSectorItem(map:Map, sprite:Sprite, size:Number, half:Number, stroke:SolidColorStroke, point:GeoPoint):void
		{
			var forLength:int;
			var ptsSector:Array = [];
			if(sprite is Feature)
			{
				forLength = sprite.numChildren;
				for(var i:int = 0; i <  forLength; i++)
				{
					var currentSectorSpt:SectorSprite = sprite.getChildAt(i) as SectorSprite;
					currentSectorSpt.x = half;
					currentSectorSpt.y = half;	
					
					var sectorItem:SectorItem = this.sectorItems[i];
					var sectorColor:uint = sectorItem.sectorColor;
					var sectorAlpha:Number = sectorItem.sectotAlpha;
					if(sectorItem.attributes)
						currentSectorSpt.attributes = sectorItem.attributes;
					currentSectorSpt.sectorItem = sectorItem;
					if(sectorItem.isBorder)
					{
						var sectorItemBorderColor:uint = sectorItem.borderColor;
						var sectorItemBorderAlpha:Number = sectorItem.borderAlpha;
						var sectorItemBorderWeight:Number = sectorItem.borderWeight;
						
						this._stroke.color = sectorItemBorderColor;				
						this._stroke.alpha = sectorItemBorderAlpha;
						this._stroke.weight = sectorItemBorderWeight;
					}
					//起始边的角度
					var sectorStartLineAngle:Number = sectorItem.sectorCenterLineAngle - (sectorItem.sectorInnerAngle / 2);
					currentSectorSpt.graphics.beginFill(sectorColor, sectorAlpha);
					
					if (sectorItem && sectorItem.isBorder)
					{
						this._stroke.apply(currentSectorSpt.graphics, null, null);					
					}			
					this.traceSector(currentSectorSpt, 0, 0, sectorItem.sectorRadius, sectorStartLineAngle, sectorItem.sectorInnerAngle, ptsSector);	
					currentSectorSpt.graphics.endFill();		
				}
			}
			else
			{
				if(layers.indexOf(sprite.parent) == -1)
				{
					layers.push(sprite.parent);
					GraphicsLayer(sprite.parent).addEventListener(MouseEvent.CLICK, sectorItemClickHandler);
					GraphicsLayer(sprite.parent).addEventListener(GraphicsLayerEvent.GRAPHICS_REMOVE_ALL, graphicsRemoveAllHandler);
				}
				
				var tempx:Number = this.toScreenX(map,point.x);
				var tempy:Number = this.toScreenY(map,point.y);
				centerX = point.x;
				centerY = point.y;
				forLength = sectorItems.length;
				for(var j:int = 0; j <  forLength; j++)
				{
					var ptsSectorG:Array = [];
					var sectorItemG:SectorItem = this.sectorItems[j];
					var sectorColorG:uint = sectorItemG.sectorColor;
					var sectorAlphaG:Number = sectorItemG.sectotAlpha;
					if(sectorItemG.isBorder)
					{
						var sectorItemBorderColorG:uint = sectorItemG.borderColor;
						var sectorItemBorderAlphaG:Number = sectorItemG.borderAlpha;
						var sectorItemBorderWeightG:Number = sectorItemG.borderWeight;
						
						this._stroke.color = sectorItemBorderColorG;				
						this._stroke.alpha = sectorItemBorderAlphaG;
						this._stroke.weight = sectorItemBorderWeightG;
					}
					//起始边的角度
					var sectorStartLineAngleG:Number = sectorItemG.sectorCenterLineAngle - (sectorItemG.sectorInnerAngle / 2);
					sprite.graphics.beginFill(sectorColorG, sectorAlphaG);
					if (sectorItemG && sectorItemG.isBorder)
					{
						this._stroke.apply(sprite.graphics, null, null);					
					}
					else
						sprite.graphics.lineStyle();
					this.traceSector(sprite, tempx, tempy, sectorItemG.sectorRadius, sectorStartLineAngleG, sectorItemG.sectorInnerAngle, ptsSectorG);
					sprite.graphics.endFill();	
					
					sectorItemG.centerX = centerX;
					sectorItemG.centerY = centerY;
					
					//优化？
					dict[sectorItemG] = {"ptsSectorG" : ptsSectorG, "layer" : sprite.parent};
				}
			}
		}	
		
		//todo:算法的改进 不要用Array......
		private function traceSector(sprite:Sprite, sx:Number, sy:Number, radius:Number, sectorStartLineAngle:Number, sectorInnerAngle:Number, sectorPoints:Array):void
		{
			if(!sectorPoints)
				sectorPoints = [];
			
			var AToR:Number = Math.PI / 180;
			//起始点
			var startArcPoint:Point = new Point();
			startArcPoint.x = sx + radius * Math.cos(sectorStartLineAngle * AToR);
			startArcPoint.y = sy + radius * Math.sin(sectorStartLineAngle * AToR);
			sprite.graphics.moveTo(startArcPoint.x, startArcPoint.y);
			sectorPoints.push(new Point2D(startArcPoint.x, startArcPoint.y));
			for (var i:int = 1; i <= sectorInnerAngle; i++)
			{
				if(i * 0.25 is int)
				{
					var centerLineAngle:Number = (sectorStartLineAngle + i) * AToR;
					var centerLineAngleX:Number = sx + radius * Math.cos(centerLineAngle);
					var centerLineAngleY:Number = sy + radius * Math.sin(centerLineAngle);
					sprite.graphics.lineTo(centerLineAngleX, centerLineAngleY);
					sectorPoints.push(new Point2D(centerLineAngleX, centerLineAngleY));
				}
			}
			sprite.graphics.lineTo(sx, sy);	
			sectorPoints.push(new Point2D(sx, sy));
		}
		
		private function screenToMap(sprite:Sprite, screenX:Number, screenY:Number):Point2D
		{
			var containedPoint:Point2D;
			if(!tar)
				tar = UIComponent(sprite).owner as GraphicsLayer;
			
			var parentContainer:LayerContainer = LayerContainer(tar.parent);
			//屏幕上的像素坐标
			var mousePoint:Point = new Point(screenX - parentContainer.scrollRect.x, screenY - parentContainer.scrollRect.y);
			containedPoint = tar.map.screenToMap(new Point(mousePoint.x, mousePoint.y));
			return containedPoint;
		}
		
		private function sectorItemClickHandler(event:MouseEvent):void
		{
			if(_map.isPanning)
			{
				return;
			}
			var tar:GraphicsLayer = event.currentTarget as GraphicsLayer;
			var isDispatch:Boolean = false;
			
			for(var SItem:Object in dict)
			{
				if(dict[SItem].layer.map == _map ){
					if(!isDispatch && GeoUtil.contains(dict[SItem].ptsSectorG, event.localX, event.localY) && _map.viewBounds.contains(SItem.centerX, SItem.centerY))
					{
//						if(tar.hasEventListener(CloverEvent.GRAPHIC_CLICK))
//						{
//							trace("tar.hasEventListener");
//						}
						tar.dispatchEvent(new CloverEvent(CloverEvent.GRAPHIC_CLICK, SectorItem(SItem), {"mouseX":event.stageX, "mouseY":event.stageY, "centerX":SItem.centerX, "centerY":SItem.centerY}));
						isDispatch = true;
					}
				}
			}
		}
		
		/**
		 *  当移除layer的操作时候 也对字典进行更新操作
		 */
		private function graphicsRemoveAllHandler(event:GraphicsLayerEvent):void
		{
			if(event.target is GraphicsLayer)
			{
				for(var SItem:Object in dict)
				{
					if(dict[SItem].layer == event.target)
					{
						delete dict[SItem];
					}
				}
			}
		}
	}
}