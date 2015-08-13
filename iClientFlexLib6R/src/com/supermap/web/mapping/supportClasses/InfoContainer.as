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
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;
	
	use namespace sm_internal;
	
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	public class InfoContainer extends Container
	{
		private var _layout:BoxLayout;
		protected var _map:Map;
		private var _infoAnchorX:Number;
		private var _infoAnchorY:Number;
		
		internal static const BORDER_PLACEMENT:String = "borderPlacement";
		internal static const BORDER_THICKNESS:String = "borderThickness";
		internal static const BORDER_COLOR:String = "borderColor";
		internal static const BORDER_ALPHA:String = "borderAlpha";
		internal static const BACKGROUND_ALPHA:String = "backgroundAlpha";
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
			this._layout = new BoxLayout();
			this._map = map;
			this._layout.target = this;
			this._layout.direction = BoxDirection.VERTICAL;
			
			addEventListener(KeyboardEvent.KEY_DOWN, this.stopEventHandler);
			addEventListener(KeyboardEvent.KEY_UP, this.stopEventHandler);
			addEventListener(MouseEvent.CLICK, this.stopEventHandler);
			addEventListener(MouseEvent.DOUBLE_CLICK, this.stopEventHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, this.stopEventHandler);
			addEventListener(MouseEvent.MOUSE_WHEEL, this.stopEventHandler);
			addEventListener(ChildExistenceChangedEvent.CHILD_ADD, this.childAddHandler);
			addEventListener(InfoPlacementEvent.INFO_PLACEMENT, this.infoPlacementHandler);
			addEventListener(FlexEvent.PREINITIALIZE, initStyle);

//			initStyle();
		}
		
		private function initStyle(event:FlexEvent):void
		{
			if(this.styleName)
			{
				return;
			}
			
			var styleManager:IStyleManager2 = FlexGlobals.topLevelApplication.styleManager;	
			var cssDeclaration:CSSStyleDeclaration = styleManager.getStyleDeclaration("com.supermap.web.mapping.InfoWindow");

			if(cssDeclaration)
			{
				var vertocalGap:Number = cssDeclaration.getStyle("vertocalGap");
				var paddingLeft:Number = cssDeclaration.getStyle("paddingLeft");
				var paddingRight:Number = cssDeclaration.getStyle("paddingRight");
				var paddingTop:Number = cssDeclaration.getStyle("paddingTop");
				var paddingBottom:Number = cssDeclaration.getStyle("paddingBottom");
				var backgroundColor:uint = cssDeclaration.getStyle("backgroundColor");
				var backgroundAlpha:Number = cssDeclaration.getStyle("backgroundAlpha");
				var borderColor:uint = cssDeclaration.getStyle("borderColor");
				var borderAlpha:Number = cssDeclaration.getStyle("borderAlpha");
				var upperLeftRadius:Number = cssDeclaration.getStyle("upperLeftRadius");
				var lowerLeftRadius:Number = cssDeclaration.getStyle("lowerLeftRadius");
				var lowerRightRadius:Number = cssDeclaration.getStyle("lowerRightRadius");
				var infoPlacementMode:String = cssDeclaration.getStyle("infoPlacementMode");
				var infoPlacement:String = cssDeclaration.getStyle("infoPlacement");
				var infoOffsetX:Number = cssDeclaration.getStyle("infoOffsetX");
				var infoOffsetY:Number = cssDeclaration.getStyle("infoOffsetY");
				var infoOffsetW:Number = cssDeclaration.getStyle("infoOffsetW");
				var shadowAlpha:Number = cssDeclaration.getStyle("shadowAlpha");
				var shadowAngle:Number = cssDeclaration.getStyle("shadowAngle");
				var shadowColor:uint = cssDeclaration.getStyle("shadowColor");
				cssDeclaration.setStyle("borderSkin", com.supermap.web.mapping.supportClasses.InfoBorder);
				cssDeclaration.setStyle("verticalGap", vertocalGap ? vertocalGap : 0);
				cssDeclaration.setStyle("paddingLeft", paddingLeft ? paddingLeft : 3);
				cssDeclaration.setStyle("paddingRight", paddingRight ? paddingRight : 3);			
				cssDeclaration.setStyle("paddingTop", paddingTop ? paddingTop : 3);			
				cssDeclaration.setStyle("paddingBottom", paddingBottom ? paddingBottom : 3);			
				cssDeclaration.setStyle("backgroundColor", backgroundColor ? backgroundColor : 0x999999);			
				cssDeclaration.setStyle("backgroundAlpha", backgroundAlpha ? backgroundAlpha : 1.0);			
				cssDeclaration.setStyle("borderColor", borderColor ? borderColor : 0x000000);			
				cssDeclaration.setStyle("borderAlpha", borderAlpha ? borderAlpha : 1);			
				cssDeclaration.setStyle("upperLeftRadius", upperLeftRadius ? upperLeftRadius : 5);			
				cssDeclaration.setStyle("lowerRightRadius", lowerRightRadius ? lowerRightRadius : 5);			
				cssDeclaration.setStyle("lowerLeftRadius", lowerLeftRadius ? lowerLeftRadius : 5);
				cssDeclaration.setStyle("infoPlacementMode", infoPlacementMode ? infoPlacementMode : "auto");			
				cssDeclaration.setStyle("infoPlacement", infoPlacement ? infoPlacement : InfoPlacement.UPPERRIGHT);			
				cssDeclaration.setStyle("infoOffsetX", infoOffsetX ? infoOffsetX : 12);			
				cssDeclaration.setStyle("infoOffsetY", infoOffsetY ? infoOffsetY : 12);			
				cssDeclaration.setStyle("infoOffsetW", infoOffsetW ? infoOffsetW : 10);	
				cssDeclaration.setStyle("shadowAlpha", shadowAlpha ? shadowAlpha : 1.0);
				cssDeclaration.setStyle("shadowAngle", shadowAngle ? shadowAngle : 45);
				cssDeclaration.setStyle("shadowColor", shadowColor ? shadowColor : 0x000000);
				cssDeclaration.setStyle("upperLeftRadius", 5);			
				cssDeclaration.setStyle("lowerRightRadius", 5);			
				cssDeclaration.setStyle("lowerLeftRadius", 5);
				cssDeclaration.setStyle("upperRightRadius", 5);			
				cssDeclaration.setStyle("infoPlacementMode", "none");			
				cssDeclaration.setStyle("infoOffsetX", 12);			
				cssDeclaration.setStyle("infoOffsetY", 12);			
				cssDeclaration.setStyle("infoOffsetW", 10);
				
			}
			else
			{
				setStyle("borderSkin", com.supermap.web.mapping.supportClasses.InfoBorder);
				setStyle("verticalGap", 0);
				setStyle("paddingLeft", 3);
				setStyle("paddingRight", 3);			
				setStyle("paddingTop", 3);			
				setStyle("paddingBottom", 3);			
				setStyle("backgroundColor", 0x999999);			
				setStyle("backgroundAlpha", 1.0);			
				setStyle("borderColor", 0x000000);			
				setStyle("borderAlpha", 1);			
				setStyle("upperLeftRadius", 5);			
				setStyle("upperRightRadius", 5);			
				setStyle("lowerLeftRadius", 5);
				setStyle("lowerRightRadius", 5);			
				setStyle("infoPlacementMode", "auto");			
				setStyle("infoPlacement", InfoPlacement.UPPERRIGHT);			
				setStyle("infoOffsetX", 12);			
				setStyle("infoOffsetY", 12);			
				setStyle("infoOffsetW", 10);	
				setStyle("shadowAlpha", 1.0);
				setStyle("shadowAngle", 45);
				setStyle("shadowColor", 0x000000);
			}
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
			if (data)
			{
				if (event.relatedObject is IDataRenderer)
				{
					IDataRenderer(event.relatedObject).data = data;
				}
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
		
		override public function set data(value:Object):void
		{
			var renderer:IDataRenderer = null;
			super.data = value;
			var index:int = 0;
			while (index < numChildren)
			{
				
				renderer = getChildAt(index) as IDataRenderer;
				if (renderer)
				{
					renderer.data = value;
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
				{
				  if(this._map.infoWindow.showShadow)
				  {setStyle("infoOffsetX", 12);	}  
				}	
				case INFO_OFFSET_Y:
				{
					if(this._map.infoWindow.showShadow)
					{setStyle("infoOffsetY", 12);	}  
				}	
				case INFO_OFFSET_W:
					
				{   
					if(this._map.infoWindow.showShadow)
					{
						setStyle("infoOffsetW", 10);	}  
					invalidateSize();
				}
				case INFO_PLACEMENT:
				{
					if(this._map.infoWindow.showShadow)
					{setStyle("infoPlacement", InfoPlacement.UPPERRIGHT);	}  
				}	
				case INFO_PLACEMENT_MODE:
				{
					if(this._map.infoWindow.showShadow)
					{setStyle("infoPlacementMode", "none");	}  
				}	
				case UPPER_LEFT_RADIUS:
				{
					if(this._map.infoWindow.showShadow)
					{setStyle("upperLeftRadius", 5);	}  
				}	
				case UPPER_RIGHT_RADIUS:
				{
					if(this._map.infoWindow.showShadow)
					{setStyle("upperRightRadius", 5);	}  
				}	
				case LOWER_LEFT_RADIUS:
				{
					if(this._map.infoWindow.showShadow)
					{setStyle("lowerLeftRadius", 5);	}  
				}	
				case LOWER_RIGHT_RADIUS:
				{
					if(this._map.infoWindow.showShadow)
					{setStyle("lowerRightRadius", 5);	}  
				}	
				case BACKGROUND_ALPHA:
				{
					if(this._map.infoWindow.showShadow)
					{setStyle("backgroundAlpha", 1);	}  
				}
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
			this._layout.measure();
			
			setActualSize(measuredWidth < 16 ? (16) : (measuredWidth), measuredHeight < 16 ? (16) : (measuredHeight));
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if (unscaledWidth > 0 && unscaledHeight > 0)
			{
				this._layout.updateDisplayList(unscaledWidth, unscaledHeight);
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
