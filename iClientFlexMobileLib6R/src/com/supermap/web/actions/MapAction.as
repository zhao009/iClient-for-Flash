package com.supermap.web.actions
{ 
	import com.supermap.web.core.Feature;
	import com.supermap.web.mapping.*;
	import com.supermap.web.mapping.supportClasses.*;
	import com.supermap.web.sm_internal;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	import mx.managers.*;
	
	use namespace sm_internal;
	
	/**
	 * ${actions_MapAction_Title}.
	 * <p>${actions_MapAction_Description}</p>
	 * 
	 * 
	 */	
	public class MapAction extends EventDispatcher
	{
		private var _map:Map;
		private var _cursorClass:Class;
		private var _cursorID:int;
		private var _isMouseOut:Boolean;
		private var _cursorXOffset:Number = 0;
		private var _cursorYOffset:Number = 0;
		/**
		 * ${actions_MapAction_constructor_D} 
		 * @param map ${actions_MapAction_constructor_param_map}
		 * 
		 */		
		public function MapAction(map:Map)
		{
			this._map = map;
		}
		
		//属性

		/**
		 * ${actions_DrawAction_method_setCursor_param_value} 
		 * @param value ${actions_DrawAction_method_setCursor_param_value}
		 * @param xOffset ${actions_DrawAction_method_setCursor_param_xOffset}
		 * @param yOffset ${actions_DrawAction_method_setCursor_param_yOffset}
		 * 
		 */			
		public function setCursor(value:Class, xOffset:Number = 0, yOffset:Number = 0):void
		{	
			this._cursorXOffset = xOffset;
			this._cursorYOffset = yOffset;
			
			_cursorClass = value;	
			this._map.cursorManager.removeCursor(this._cursorID);
			if(value)
			{
				this._cursorID = this._map.cursorManager.setCursor(_cursorClass, CursorManagerPriority.LOW, xOffset, yOffset);  //先改为LOW吧，参考esri
			}
		}
		
		/**
		 * ${actions_MapAction_attribute_map_D} 
		 * @return 
		 * 
		 */		
		public function get map():Map
		{
			return this._map;
		}
		public function set map(map:Map):void
		{
			this._map = map;
		}
		
		//end 属性	
		
		sm_internal function addMapListeners():void
		{
			if(this.map)
			{
				map.layerHolder.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				map.layerHolder.addEventListener(MouseEvent.DOUBLE_CLICK, onMouseDoubleClick);
				map.layerHolder.addEventListener(MouseEvent.CLICK, onMouseClick);
				map.layerHolder.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				map.layerHolder.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				map.layerHolder.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				if(map.stage)
					map.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
					
			}
			
		}
		
		sm_internal function removeMapListeners():void
		{
			if(this._map)
			{
				this.setCursor(null);
				map.layerHolder.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				map.layerHolder.removeEventListener(MouseEvent.DOUBLE_CLICK, onMouseDoubleClick);
				map.layerHolder.removeEventListener(MouseEvent.CLICK, onMouseClick);
				map.layerHolder.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
				map.layerHolder.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				map.layerHolder.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				if(map.stage)
					map.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			}
		}
		/**
		 * ${actions_DrawAction_method_Protected_onMouseDown_D} 
		 * @param event
		 * 
		 */		
		protected function onMouseDown(event:MouseEvent):void
		{
			var listenerFlag:Boolean = map.stage.hasEventListener(MouseEvent.MOUSE_UP);
			if(!listenerFlag)
				map.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		/**
		 * ${actions_DrawAction_method_Protected_onMouseMove_D} 
		 * @param event
		 * 
		 */		
		protected function onMouseMove(event:MouseEvent):void
		{
		}
		
		/**
		 * ${actions_DrawAction_method_Protected_onMouseClick_D} 
		 * @param event
		 * 
		 */		
		protected function onMouseClick(event:MouseEvent):void
		{
		}
		
		/**
		 * ${actions_DrawAction_method_Protected_onMouseOut_D} 
		 * @param event
		 * 
		 */		
		protected function onMouseOut(event:MouseEvent):void
		{
			if(this._cursorID)
			{
				this._map.cursorManager.removeCursor(this._cursorID);
				this._isMouseOut = true;
			}
		}
		
		/**
		 * ${actions_DrawAction_method_Protected_onMouseOver_D} 
		 * @param event
		 * 
		 */		
		protected function onMouseOver(event:MouseEvent):void
		{
			if(this._cursorID && this._isMouseOut)
			{
				this._cursorID = this._map.cursorManager.setCursor(_cursorClass, CursorManagerPriority.LOW, this._cursorXOffset, this._cursorYOffset); 
				this._isMouseOut = false;
			}
		}
		
		/**
		 * ${actions_DrawAction_method_Protected_onMouseUp_D} 
		 * @param event
		 * 
		 */		
		protected function onMouseUp(event:MouseEvent):void
		{
		}
		
		/**
		 * ${actions_DrawAction_method_Protected_onMouseDoubleClick_D} 
		 * @param event
		 * 
		 */		
		protected function onMouseDoubleClick(event:MouseEvent):void
		{
		}
		
		sm_internal static function targetHasEventListener(event:MouseEvent) : Boolean
		{
			var eventDispatcher:IEventDispatcher = null;
			var displayObject:DisplayObject = event.target as DisplayObject;
			while (displayObject)
			{
				
				if (displayObject is Layer)
				{
					return false;
				}
				else if (displayObject is LayerContainer)
				{
					return false;
				}
				else if (displayObject is InfoContainer)
				{
					return true;
				}
				else if (displayObject is Feature)
				{
					var feature:Feature = Feature(displayObject);
					if (feature.checkForMouseListenersEnabled)
					{
						if (feature.parent)
						{
							var parent:FeaturesLayer = feature.parent as FeaturesLayer;
							if(!parent.isPanEnableOnFeature)
							{
								return true;
							}
						}
					}  
					return false;
				}  
				else if (displayObject.parent is ElementsLayer || displayObject.parent.parent is ElementsLayer)
				{   
					var eleParent:ElementsLayer;
					if(displayObject.parent is ElementsLayer)
						eleParent = displayObject.parent as ElementsLayer;
					else if(displayObject.parent.parent is ElementsLayer)
						eleParent = displayObject.parent.parent as ElementsLayer;
					if(!eleParent.isPanEnableOnElement)
					{
						return true;
					}
					return false;
				}
				else if(displayObject is Map || displayObject.parent is Map)
				{
					return false;
				}
				else if (displayObject is IEventDispatcher)
				{
					eventDispatcher = IEventDispatcher(displayObject);
					if (eventDispatcher.hasEventListener(MouseEvent.MOUSE_DOWN))
					{
						return true;
					}
					if (eventDispatcher.hasEventListener(MouseEvent.MOUSE_MOVE))
					{
						return true;
					}
					if (eventDispatcher.hasEventListener(MouseEvent.MOUSE_UP))
					{
						return true;
					}
					if (eventDispatcher.hasEventListener(MouseEvent.CLICK))
					{
						return true;
					}
					if (eventDispatcher.hasEventListener(MouseEvent.DOUBLE_CLICK))
					{
						return true;
					}
				}
				displayObject = displayObject.parent;
			}
			return false;
		}
	}
}