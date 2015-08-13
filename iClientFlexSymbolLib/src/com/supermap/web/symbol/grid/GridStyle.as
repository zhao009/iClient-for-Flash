package com.supermap.web.symbol.grid
{
	import com.supermap.web.actions.Pan;
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.styles.MarkerStyle;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.events.GraphicsLayerEvent;
	import com.supermap.web.mapping.GraphicsLayer;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	import com.supermap.web.symbol.event.GridEvent;
	import com.supermap.web.utils.GeoUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import mx.core.UIComponent;
	import mx.events.PropertyChangeEvent;
	import mx.graphics.SolidColorStroke;
	
	use namespace sm_internal;
	
	public class GridStyle extends MarkerStyle
	{
		private var _itemSize:Number = 10;
		private var _gridItems:Array;
		private var _isHorPriority:Boolean = true;
		private var _map:Map;
		
		private static var dict:Dictionary;		
		private static var DefaultGridStyle:Style;
		private static var layer:GraphicsLayer;
		
		private var centerX:Number;
		private var centerY:Number;
		
		//sm_internal var _gap:Number = 0;//预留接口 		
		sm_internal var _stroke:SolidColorStroke;	
		
		/**
		 *  构造函数
		 *  @param gridItems 方格项数组 默认为三项
		 *  @param xOffset 水平偏移量(仅仅针对Feature有效)
		 *  @param yOffset 垂直偏移量(仅仅针对Feature有效)
		 */
		public function GridStyle(gridItems:Array = null, xOffset:Number = 0, yOffset:Number = 0)
		{
			this._stroke = new SolidColorStroke();	
			this.xOffset = xOffset;
			this.yOffset = yOffset;
			if(!gridItems)
			{
				this.gridItems = [];
				//可以把默认值开出来 用户可设置 保证默认样式也可以统一修改
				this.gridItems.push(new GridItem(10, 0xf06522),new GridItem(10, 0x8dc73f),new GridItem(10, 0x00adef));
			}
			else
			{
				this.gridItems = gridItems;
			}
			if(!dict)
				dict = new Dictionary();
		}
		
		/**
		 *  获取方格默认设置大小 
		 *  @return Number
		 */
		public function get itemSize():Number
		{
			return this._itemSize;
		}
		
		public function set itemSize(value:Number):void
		{
			var oldValue:Number = this._itemSize;
			if(this._itemSize !== value)
			{
				_itemSize = value;
				dispatchEventChange();//这里并不支持重绘 ...
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "itemSize", oldValue, value));
				}
			}
		}

//		sm_internal function get gap():Number
//		{
//			return _gap;
//		}
//
//		sm_internal function set gap(value:Number):void
//		{
//			var oldValue:Number = this._gap;
//			if(this._gap !== value)
//			{
//				_gap = value;
//				dispatchEventChange();//这里并不支持重绘 ...
//				if(this.hasEventListener("propertyChange"))
//				{
//					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"gap",oldValue, value));
//				}
//			}
//		}

		/**
		 *  设置方格是否水平优先排列显示,默认为True
		 *  @return Boolean
		 */
		public function get isHorPriority():Boolean
		{
			return _isHorPriority;
		}

		public function set isHorPriority(value:Boolean):void
		{
			var oldValue:Boolean = this._isHorPriority;
			if(this._isHorPriority !== value)
			{
				_isHorPriority = value;
				dispatchEventChange();//这里并不支持重绘 ...
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isHorPriority",oldValue, value));
				}
			}
		}

		/**
		 *  返回当前方格总数
		 *  @return int
		 */
		public function get numGridItems():int
		{
			return this._gridItems.length;
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
				dispatchEventChange();//这里并不支持重绘 ...
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "stroke", oldValue, value));
				}
			}
		}

		/**
		 *  返回当前方格项所在的数组对象
		 *  @return Array
		 */
		public function get gridItems():Array
		{
			return _gridItems;
		}

		public function set gridItems(value:Array):void
		{
			var oldValue:Array = this._gridItems;
			if(this._gridItems !== value)
			{
				this._gridItems = value;
				dispatchEventChange();//这里并不支持重绘 ...
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "gridItems", oldValue, value));
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
		override public  function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
			if (!geometry)
			{
				return;
			}		
			if(geometry is GeoPoint)
			{				
				var half:Number = this._itemSize * 0.5;
				drawPoint(sprite, this._itemSize, half, geometry as GeoPoint, map);
			}			
		}	
		
		private function drawPoint(sprite:Sprite, size:Number, half:Number, point:GeoPoint, map:Map, centerX:Number = 0, centerY:Number = 0):void
		{	
			if(sprite is Feature)
			{
				if(map && point)
				{
					sprite.x = this.toScreenX(map, point.x);				
					sprite.y = this.toScreenY(map, point.y);	
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
			drawPointSector(map, sprite, size, half, point);
		}			
		
		private function drawPointSector(map:Map, sprite:Sprite, size:Number, half:Number, point:GeoPoint) : void
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
				forLength = gridItems.length;
			
			addSectorItem(map, sprite, size, half, this._stroke, point);	
		}
		
		/**
		 * 移除sprite里的所有child
		 */
		private function removeSpts(sprite:Sprite):void
		{
			if(this.gridItems && this.gridItems.length & sprite.numChildren)
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
			if(this.gridItems && this.gridItems.length)
			{
				for(var i:int = 0; i < this.gridItems.length; i++)
				{
					sprite.addChild(new GridSprite() as DisplayObject);
				}
			}			
		}
		
		/**
		 *  复制该对象，返回一个新的GridStyle实例
		 *  @see com.supermap.web.core.styles.Style
		 *  @return Style
		 *  
		 */
		public override function clone() : Style
		{
			var gridStyle:GridStyle;
			if(this._gridItems && this._gridItems.length > 0)
			{
				var gridItemClone:Array = [];
				var len:int = this._gridItems.length;
				for(var i:int = 0; i < len; i++)
				{
					if(this._gridItems[i] is GridItem)
					{
						gridItemClone.push(GridItem.formGridItem(this._gridItems[i]));
					}
				}
				gridStyle = new GridStyle(gridItemClone, this.xOffset, this.yOffset);
			}
			else
			{
				gridStyle = new GridStyle(this._gridItems, this.xOffset, this.yOffset);
			}
			return gridStyle;
		}
		
		/**
		 *  返回一个默认样式
		 *  @see com.supermap.web.core.styles.Style
		 *  @return Style
		 */
		public static function get defaultStyle():Style
		{
			if(DefaultGridStyle == null)
			{
				DefaultGridStyle = new GridStyle();
			}
			return DefaultGridStyle;
		}
		
		/**
		 *  清理样式
		 */
		override public function destroy(sprite:Sprite) : void
		{
			removeAllChildren(sprite);
			sprite.graphics.clear();
			sprite.x = 0;
			sprite.y = 0;			
		}
		
		private static var layers:Array = [];
		private function addSectorItem(map:Map, sprite:Sprite, size:Number, half:Number, stroke:SolidColorStroke, point:GeoPoint):void
		{
			var forLength:int;
			var ptsSector:Array = [];
			
			var row:int;
			var rateRow:Number;
			var newRow:int;
			
			if(sprite is Feature)
			{
				centerX = point.x;
				centerY = point.y;
				
				forLength = sprite.numChildren;
				row = Math.ceil(Math.sqrt(forLength));
				rateRow = forLength / row;
				newRow = (rateRow is int) ? rateRow : Math.ceil(rateRow);
				for(var k:int = 0; k < newRow; k++)
				{
					for(var p:int = 0; p < row; p++)
					{
						if(numSquare == forLength) 
							return;
						
						var currentGridSpt:GridSprite = sprite.getChildAt(numSquare) as GridSprite;
						var gridItem:GridItem = this.gridItems[numSquare];
						gridItem.centerX = centerX;
						gridItem.centerY = centerY;
						var gridColor:uint = gridItem.color;
						var gridAlpha:Number = gridItem.alpha;
						if(gridItem.attributes)
							currentGridSpt.attributes = gridItem.attributes;
						currentGridSpt.gridItem = gridItem;
						if(gridItem.isBorder)
						{
							var gridItemBorderColor:uint = gridItem.borderColor;
							var gridItemBorderAlpha:Number = gridItem.borderAlpha;
							var gridItemBorderWeight:Number = gridItem.borderWeight;
							
							this._stroke.color = gridItemBorderColor;				
							this._stroke.alpha = gridItemBorderAlpha;
							this._stroke.weight = gridItemBorderWeight;
						}
						var centSptX:Number;
						var centSptY:Number;
						if(this._isHorPriority)//行优先计算
						{
							centSptX = - row * 0.5 * itemSize + 0.5 * itemSize * (2*p + 1);
							centSptY = - row * 0.5 * itemSize + 0.5 * itemSize * (2*k + 1);
						}
						else
						{
							centSptX = - row * 0.5 * itemSize + 0.5 * itemSize * (2*k + 1);
							centSptY = - row * 0.5 * itemSize + 0.5 * itemSize * (2*p + 1);
						}	
						currentGridSpt.graphics.beginFill(gridColor, gridAlpha);					
						if (gridItem && gridItem.isBorder)
						{
							this._stroke.apply(currentGridSpt.graphics, null, null);					
						}			
						traceSector(currentGridSpt, centSptX, centSptY, itemSize, null, null);
						currentGridSpt.graphics.endFill();		
						numSquare++;
					}
				}
			}
			else
			{
//				if(sprite.parent != layer)
//				{
//					if(dict)
//					{
//						for(var sItem:* in dict)
//						{
//							delete dict[sItem];
//						}
//					}
//					layer = UIComponent(sprite).parent as GraphicsLayer;
//					layer.addEventListener(MouseEvent.CLICK, sectorItemClickHandler);
//				}
				
				if(layers.indexOf(sprite.parent) == -1)
				{
					layers.push(sprite.parent);
					GraphicsLayer(sprite.parent).addEventListener(MouseEvent.CLICK, sectorItemClickHandler);
					GraphicsLayer(sprite.parent).addEventListener(GraphicsLayerEvent.GRAPHICS_REMOVE_ALL, graphicsRemoveAllHandler);
				}
				
				centerX = point.x;
				centerY = point.y;
				forLength = gridItems.length;
				//计算方形的行列 
				row = Math.ceil(Math.sqrt(forLength));
				rateRow = forLength / row;
				newRow = (rateRow is int) ? rateRow : Math.ceil(rateRow);
				var numSquare:int = 0;
				//按照方形的中心显示
				var tempx:Number = this.toScreenX(map,point.x);
				var tempy:Number = this.toScreenY(map,point.y);
				
				for(var i:int = 0; i < newRow; i++)
				{
					for(var j:int = 0; j < row; j++)
					{
						if(numSquare == forLength) 
							return;
						//存放每一个item的点集合
						var ptsSectorG:Array = [];
						//每一个小方格单元
						var gridItemG:GridItem = this.gridItems[numSquare];	
						//给每一个方块设置中心点属性
						gridItemG.centerX = centerX;
						gridItemG.centerY = centerY;					
						
						if(gridItemG.isBorder)
						{
							var sectorItemBorderColorG:uint = gridItemG.borderColor;
							var sectorItemBorderAlphaG:Number = gridItemG.borderAlpha;
							var sectorItemBorderWeightG:Number = gridItemG.borderWeight;
							
							this._stroke.color = sectorItemBorderColorG;				
							this._stroke.alpha = sectorItemBorderAlphaG;
							this._stroke.weight = sectorItemBorderWeightG;
						}					
						//这里要计算出来每一个方块的中心位置以及大小
						var sectorColorG:uint = gridItemG.color;
						var sectorAlphaG:Number = gridItemG.alpha;
						sprite.graphics.beginFill(sectorColorG, sectorAlphaG);
						if (gridItemG && gridItemG.isBorder)
						{
							this._stroke.apply(sprite.graphics, null, null);					
						}
						else
							sprite.graphics.lineStyle();
						
						var centX:Number;
						var centY:Number;
						if(this._isHorPriority)//行优先计算
						{
							centX = tempx - row * 0.5 * itemSize + 0.5 * itemSize * (2*j + 1);
							centY = tempy - row * 0.5 * itemSize + 0.5 * itemSize * (2*i + 1);
						}
						else
						{
							centX = tempx - row * 0.5 * itemSize + 0.5 * itemSize * (2*i + 1);
							centY = tempy - row * 0.5 * itemSize + 0.5 * itemSize * (2*j + 1);
						}	
						var bounds:Rectangle = new Rectangle();
						traceSector(sprite, centX, centY, itemSize, bounds, ptsSectorG);
//						gridItemG.itemCenterX =  
//						gridItemG.itemCenterY = 	
//						dict[gridItemG] = bounds;
						numSquare++;
						
						sprite.graphics.endFill();
						
						//优化？
						dict[gridItemG] = {"ptsSectorG" : ptsSectorG, "layer" : sprite.parent};
					}
				}				
			}
		}
		
		/**
		 * 在屏幕上绘制每一个方块 
		 */
		private function traceSector(sprite:Sprite, gx:Number, gy:Number, size:Number, bounds:Rectangle, sectorPoints:Array):void
		{
			if(sectorPoints == null)
				sectorPoints = [];
				
			if(!bounds)
				bounds = new Rectangle(gx - size * 0.5, gy - size * 0.5, size, size);	
			else
			{
				bounds.x = gx - size * 0.5;
				bounds.y = gy - size * 0.5;
				bounds.width = size;
				bounds.height = size;
			}
			sectorPoints.push(new Point2D(bounds.x, bounds.y), 
				new Point2D(bounds.x + bounds.width, bounds.y),
				new Point2D(bounds.x + bounds.width, bounds.y + bounds.height),
				new Point2D(bounds.x, bounds.y + bounds.height));
			
			sprite.graphics.drawRect(bounds.x, bounds.y, size, size);			
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
		
		private function sectorItemClickHandler(event:MouseEvent):void
		{
			if(_map.isPanning)
			{
				return;
			}
//			var tar:GraphicsLayer = event.currentTarget as GraphicsLayer;
//			var isDispatch:Boolean = false;
//			//这里可以根据当前范围进行dict的数据更新 应该会有所提升 估计提升不大 字典键值对的存取与字典长度影响不大 
//			for(var SItem:Object in dict)
//			{
//				if(!isDispatch && Rectangle(dict[SItem]).contains(event.localX, event.localY) && _map.viewBounds.contains(SItem.centerX, SItem.centerY))
//				{
//					tar.dispatchEvent(new GridEvent(GridEvent.GRAPHIC_CLICK, GridItem(SItem), {"mouseX":event.stageX, "mouseY":event.stageY, "centerX":SItem.centerX, "centerY":SItem.centerY}));
//					isDispatch = true;
//				}				
//			}
			
			var tar:GraphicsLayer = event.currentTarget as GraphicsLayer;
			var isDispatch:Boolean = false;
			
			for(var SItem:Object in dict)
			{
				if(dict[SItem].layer.map == _map ){
					if(!isDispatch && GeoUtil.contains(dict[SItem].ptsSectorG, event.localX, event.localY) && _map.viewBounds.contains(SItem.centerX, SItem.centerY))
					{
						tar.dispatchEvent(new GridEvent(GridEvent.GRAPHIC_CLICK, GridItem(SItem), {"mouseX":event.stageX, "mouseY":event.stageY, "centerX":SItem.centerX, "centerY":SItem.centerY}));
						isDispatch = true;
					}
				}
			}
		}
	}
}