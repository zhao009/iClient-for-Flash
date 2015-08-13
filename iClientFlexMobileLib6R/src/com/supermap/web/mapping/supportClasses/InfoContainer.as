package com.supermap.web.mapping.supportClasses
{
	import com.supermap.web.events.InfoPlacementEvent;
	import com.supermap.web.mapping.InfoPlacement;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	
	import mx.containers.*;
	import mx.containers.utilityClasses.*;
	import mx.core.*;
	import mx.events.*;
	
	import spark.components.BorderContainer;
	import spark.components.Group;
	import spark.components.SkinnableContainer;
	import spark.components.supportClasses.SkinnableComponent;
	
	use namespace sm_internal;
	
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	public class InfoContainer extends SkinnableContainer
	{
//		private var _layout:BoxLayout;
		protected var _map:Map;
		private var _infoAnchorX:Number;
		private var _infoAnchorY:Number;
		private var _data:Object;
		
		internal static const BORDER_PLACEMENT:String = "borderPlacement";
		internal static const BORDER_THICKNESS:String = "borderThickness";
		internal static const BORDER_COLOR:String = "borderColor";
		internal static const BORDER_ALPHA:String = "borderAlpha";
		internal static const INFO_PLACEMENT_MODE:String = "infoPlacementMode";
		internal static const INFO_PLACEMENT:String = "infoPlacement";
		internal static const INFO_OFFSET_X:String = "infoOffsetX";
		internal static const INFO_OFFSET_Y:String = "infoOffsetY";
		internal static const INFO_OFFSET_W:String = "infoOffsetW";
		internal static const UPPER_LEFT_RADIUS:String = "upperLeftRadius";
		internal static const LOWER_LEFT_RADIUS:String = "lowerLeftRadius";
		internal static const UPPER_RIGHT_RADIUS:String = "upperRightRadius";
		internal static const LOWER_RIGHT_RADIUS:String = "lowerRightRadius";
		
		public function InfoContainer(map:Map)
		{
//			this._layout = new BoxLayout();
			this._map = map;
//			this._layout.target = this;
//			this._layout.direction = BoxDirection.VERTICAL;
			
			addEventListener(KeyboardEvent.KEY_DOWN, this.stopEventHandler);
			addEventListener(KeyboardEvent.KEY_UP, this.stopEventHandler);
			addEventListener(MouseEvent.CLICK, this.stopEventHandler);
			addEventListener(MouseEvent.DOUBLE_CLICK, this.stopEventHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, this.stopEventHandler);
			addEventListener(MouseEvent.MOUSE_WHEEL, this.stopEventHandler);
			addEventListener(ChildExistenceChangedEvent.CHILD_ADD, this.childAddHandler);
			addEventListener(InfoPlacementEvent.INFO_PLACEMENT, this.infoPlacementHandler);
			
			this.setStyle("skinClass", com.supermap.web.mapping.supportClasses.InfoBorder);
		}
		
		public function get data():Object
		{
			return _data;
		}

		private function infoPlacementHandler(event:InfoPlacementEvent):void
		{
			setStyle(INFO_PLACEMENT, event.infoPlacement);
		}
		
		public function get map():Map
		{
			return this._map;
		}
		
		private function stopEventHandler(event:Event):void
		{
			event.stopPropagation();
		}
		
		private function childAddHandler(event:ChildExistenceChangedEvent):void
		{			
			if (this._data && event.relatedObject is IDataRenderer)
			{
				IDataRenderer(event.relatedObject).data = this._data;
			}			
		}
		
		public function get anchorX():Number
		{
			return this._infoAnchorX;
		}
		
		private function set infowindowAnchorX(value:Number):void
		{
			this._infoAnchorX = value;
			invalidateSize();
			invalidateDisplayList();
		}
		
		public function get anchorY():Number
		{
			return this._infoAnchorY;
		}
		
		private function set infowindowAnchorY(value:Number):void
		{
			this._infoAnchorY = value;
			invalidateSize();
			invalidateDisplayList();
		}
		
		public function set data(value:Object):void
		{
			var renderer:IDataRenderer = null;
//			super.data = value;
			var index:int = 0;
			while (index < numChildren)
			{
				
				renderer = getChildAt(index) as IDataRenderer;
				if (renderer)
				{
					renderer.data = value;
					this._data = value;
				}
				index = index + 1;
			}
		}
		
		override public function styleChanged(styleProp:String):void
		{
			super.styleChanged(styleProp);
			
			switch(styleProp)
			{
				case INFO_OFFSET_X:
				case INFO_OFFSET_Y:
				case INFO_OFFSET_W:
				{
					invalidateSize();
				}
				case INFO_PLACEMENT:					
				case INFO_PLACEMENT_MODE:
				case UPPER_LEFT_RADIUS:
				case UPPER_RIGHT_RADIUS:
				case LOWER_LEFT_RADIUS:
				case LOWER_RIGHT_RADIUS:
				case BORDER_THICKNESS:
				case BORDER_COLOR:
				case BORDER_ALPHA:
				{
					invalidateDisplayList();
				}
				default:
				{
					break;
				}
			}
		}
		
		override protected function measure():void
		{
			super.measure();
			measuredMinWidth = 16;
			minWidth = 16;
			measuredMinHeight = 16;
			minHeight = 16;
//			this._layout.measure();
			
			setActualSize(measuredWidth < 16 ? (16) : (measuredWidth), measuredHeight < 16 ? (16) : (measuredHeight));
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if (unscaledWidth > 0 && unscaledHeight > 0)
			{
//				this._layout.updateDisplayList(unscaledWidth, unscaledHeight);
				this.updateXY(unscaledWidth, unscaledHeight, getStyle(INFO_PLACEMENT));
			}
		}
		
		protected function updateXY(unscaledWidth:Number, unscaledHeight:Number, infoPlacement:String):void
		{
			switch(infoPlacement)
			{
				case InfoPlacement.LOWERRIGHT:
				{
					this.doLowerRight(unscaledWidth, unscaledHeight);
					break;
				}
				case InfoPlacement.UPPERLEFT:
				{
					this.doUpperLeft(unscaledWidth, unscaledHeight);
					break;
				}
				case InfoPlacement.LOWERLEFT:
				{
					this.doLowerLeft(unscaledWidth, unscaledHeight);
					break;
				}
				case InfoPlacement.RIGHT:
				{
					this.doRight(unscaledWidth, unscaledHeight);
					break;
				}
				case InfoPlacement.LEFT:
				{
					this.doLeft(unscaledWidth, unscaledHeight);
					break;
				}
				case InfoPlacement.TOP:
				{
					this.doTop(unscaledWidth, unscaledHeight);
					break;
				}
				case InfoPlacement.BOTTOM:
				{
					this.doBottom(unscaledWidth, unscaledHeight);
					break;
				}
				case InfoPlacement.CENTER:
				{
					this.doCenter(unscaledWidth, unscaledHeight);
					break;
				}
				default:
				{
					this.doUpperRight(unscaledWidth, unscaledHeight);
					infoPlacement = InfoPlacement.UPPERRIGHT;
					break;
				}
			}
			setStyle(BORDER_PLACEMENT, infoPlacement);
		}
		
		private function doTop(unscaledWidth:Number, unscaledHeight:Number):void
		{
			x = this.anchorX - unscaledWidth / 2;
			y = this.anchorY - unscaledHeight - getStyle(INFO_OFFSET_Y);
		}
		
		private function doBottom(unscaledWidth:Number, unscaledHeight:Number):void
		{
			x = this.anchorX - unscaledWidth / 2;
			y = this.anchorY + getStyle(INFO_OFFSET_Y);
		}
		
		private function doLeft(unscaledWidth:Number, unscaledHeight:Number):void
		{
			x = this.anchorX - unscaledWidth - getStyle(INFO_OFFSET_X);
			y = this.anchorY - unscaledHeight / 2;
		}
		
		private function doRight(unscaledWidth:Number, unscaledHeight:Number):void
		{
			x = this.anchorX + getStyle(INFO_OFFSET_X);
			y = this.anchorY - unscaledHeight / 2;
		}
		
		private function doLowerLeft(unscaledWidth:Number, unscaledHeight:Number):void
		{
			x = this.anchorX - unscaledWidth - getStyle(INFO_OFFSET_X);
			y = this.anchorY + getStyle(INFO_OFFSET_Y);
		}
		
		private function doUpperLeft(unscaledWidth:Number, unscaledHeight:Number):void
		{
			x = this.anchorX - unscaledWidth - getStyle(INFO_OFFSET_X);
			y = this.anchorY - unscaledHeight - getStyle(INFO_OFFSET_Y);
		}
		
		private function doLowerRight(unscaledWidth:Number, unscaledHeight:Number) : void
		{
			x = this.anchorX + getStyle(INFO_OFFSET_X);
			y = this.anchorY + getStyle(INFO_OFFSET_Y);
		}
		
		private function doUpperRight(unscaledWidth:Number, unscaledHeight:Number) : void
		{
			x = this.anchorX + getStyle(INFO_OFFSET_X);
			y = this.anchorY - unscaledHeight - getStyle(INFO_OFFSET_Y);
		}
		
		private function doCenter(unscaledWidth:Number, unscaledHeight:Number) : void
		{
			x = this.anchorX - unscaledWidth / 2;
			y = this.anchorY - unscaledHeight / 2;
		}
		
		protected function adjustPlacement(screenX:Number, screenY:Number, unscaledWidth:Number, unscaledHeight:Number, map:Map) : void
		{
			if (getStyle(INFO_PLACEMENT_MODE) === "none")
			{
				return;
			}
			var newScreenX:Number = screenX + unscaledWidth;
			var newScreenY:Number = screenY + unscaledHeight;
			
			//地图范围完成包含infowindow时，不做调整
			if (screenX >= 0 && newScreenX <= map.width && screenY >= 0 && newScreenY <= map.height)
			{
				return;
			}
			
			var placementMode:String = getStyle(InfoContainer.INFO_PLACEMENT);
			if (placementMode == InfoPlacement.UPPERLEFT)
			{
				if (screenX < 0 && screenY < 0)
				{
					this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERRIGHT);
				}
				else
				{
					if (screenX < 0)
					{
//						if (this.anchorY < map.height)
//						{
							this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERRIGHT);
//						}
					}
					else if (screenY < 0)
					{
						this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERLEFT);
					}
				}
			}
			else
			{
				if (placementMode == InfoPlacement.LOWERRIGHT)
				{
					if (newScreenX > map.width && newScreenY > map.height)
					{
						this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERLEFT);
					}
					else
					{
						if (newScreenX > map.width)
						{
							if (this.anchorY < map.height)
							{
								this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERLEFT);
							}
						}
						else if (newScreenY > map.height)
						{
							this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERRIGHT);
						}
					}
				}
				else
				{
					if (placementMode == InfoPlacement.LOWERLEFT)
					{
						if (screenX < 0 && newScreenY > map.height)
						{
							this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERRIGHT);
						}
						else
						{
							if (screenX < 0)
							{
								if (newScreenY < map.height)
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERRIGHT);
								}
							}
							else if (newScreenY > map.height)
							{
								this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERLEFT);
							}
						}
					}
					else
					{
						if (placementMode == InfoPlacement.UPPERRIGHT)
						{
							if (newScreenX > map.width && screenY < 0)
							{
								this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERLEFT);
							}
							else
							{
								if (newScreenX > map.width)
								{
//									if (this.anchorY < map.height)
//									{
										this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERLEFT);
//									}
								}
								else if (screenY < 0)
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERRIGHT);
								}
							}
						}
						else if (placementMode === InfoPlacement.RIGHT)
						{
							if (newScreenX > map.width)
							{
								if (screenY < 0)
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERLEFT);
								}
								else if (newScreenY > map.height)
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERLEFT);
								}
								else
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LEFT);
								}
							}
							else
							{
								if (newScreenX <= map.width)
								{
									if (screenY < 0)
									{
										this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERRIGHT);
									}
									else if (newScreenY > map.height)
									{
										this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERRIGHT);
									}
								}
							}
						}
						else if (placementMode === InfoPlacement.LEFT)
						{
							if (screenX < 0)
							{
								if (screenY < 0)
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERRIGHT);
								}
								else if (newScreenY > map.height)
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERRIGHT);
								}
								else
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.RIGHT);
								}
							}
							else
							{
								if (newScreenX <= map.width && screenX >= 0)
								{
									if (screenY < 0)
									{
										this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERLEFT);
									}
									else if (newScreenY > map.height)
									{
										this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERLEFT);
									}
								}
							}
						}
						else if (placementMode === InfoPlacement.BOTTOM)
						{
							if (newScreenY > map.height)
							{
								if (screenX < 0)
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERRIGHT);
								}
								else if (newScreenX > map.width)
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERLEFT);
								}
								else
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.TOP);
								}
							}
							else
							{
								if (newScreenY < map.height)
								{
									if (screenX < 0)
									{
										this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERRIGHT);
									}
									else if (newScreenX > map.width)
									{
										this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERLEFT);
									}
								}
							}
						}
						else if (placementMode === InfoPlacement.TOP)
						{
							if (screenY < 0)
							{
								if (screenX < 0)
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERRIGHT);
								}
								else if (newScreenX > map.width)
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.LOWERLEFT);
								}
								else
								{
									this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.BOTTOM);
								}
							}
							else
							{
//								if (newScreenY < map.height && screenY >= 0)
//								{
									if (screenX < 0)
									{
										this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERRIGHT);
									}
									else if (newScreenX> map.width)
									{
										this.updateXY(unscaledWidth, unscaledHeight, InfoPlacement.UPPERLEFT);
									}
//								}
							}
						}
					}
				}
			}
		}
		
		public function set anchorY(value:Number):void
		{
			var oy:Number = this.anchorY;
			if(oy !== value)
			{
				this.infowindowAnchorY = value;
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "anchorY", oy, value));
				}
			}
		}
		
		public function set anchorX(value:Number):void
		{
			var ox:Number = this.anchorX;
			if(ox !== value)
			{
				this.infowindowAnchorX = value;
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "anchorX", ox, value));
				}
			}
		}
		
	}
}
