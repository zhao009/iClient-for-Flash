package com.supermap.web.core.styles
{
	
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.core.UIComponent;
	
	use namespace sm_internal;
	
	/**
	 * ${core_Style_Title}.
	 * <p>${core_Style_Description}</p> 
	 * 
	 */	
	public class Style extends EventDispatcher
	{
		/**
		 * ${core_Style_constructor_None_D} 
		 * 
		 */		
		public function Style()
		{
			super(null);			
			
		}
		
		/**
		 * ${core_Style_method_initialize_D} 
		 * @param sprite ${core_Style_method_initialize_param_sprite_D}
		 * @param geometry ${core_Style_method_initialize_param_geometry_D}
		 * @param attributes ${core_Style_method_initialize_param_attributes_D}
		 * @param map ${core_Style_method_initialize_param_map_D}
		 * 
		 */		
		public function initialize(sprite:Sprite,geometry:Geometry,attributes:Object, map:Map):void
		{
		}
		
		/**
		 * ${core_Style_method_draw_D} 
		 * @param sprite ${core_Style_method_draw_param_sprite_D}
		 * @param geometry ${core_Style_method_draw_param_geometry_D}
		 * @param attributes ${core_Style_method_draw_param_attributes_D}
		 * @param map ${core_Style_method_draw_param_map_D}
		 * 
		 */		
		public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map):void
		{
		}
		
		/**
		 * ${core_Style_method_clear_D} 
		 * @param sprite ${core_Style_method_clear_param_sprite_D}
		 * 
		 */		
		public function clear(sprite:Sprite):void
		{
			sprite.graphics.clear();
		}
		
		/**
		 * ${core_Style_method_destroy_D} 
		 * @param sprite ${core_Style_method_destroy_param_sprite_D}
		 *  
		 */		
		public function destroy(sprite:Sprite):void
		{
		}
		
		/**
		 * ${core_Style_method_createSwatch_D} 
		 * @param width ${core_Style_method_createSwatch_param_width}
		 * @param height ${core_Style_method_createSwatch_param_height}
		 * @return ${core_Style_method_createSwatch_return}
		 * 
		 */		
		sm_internal function createSwatch(width:Number = 50, height:Number = 50 ) : UIComponent
		{
			return null;
		}
		
		/**
		 * ${core_Style_method_toScreenX_D} 
		 * @param map ${core_Style_method_toScreenX_param_map}
		 * @param mapX ${core_Style_method_toScreenX_param_mapX}
		 * @return ${core_Style_method_toScreenX_return}
		 * 
		 */		
		protected function toScreenX(map:Map, mapX:Number) : Number
		{
			return map.mapToContainerX(mapX);
		}
		
		/**
		 * ${core_Style_method_toScreenY_D} 
		 * @param map ${core_Style_method_toScreenY_param_map}
		 * @param mapY ${core_Style_method_toScreenY_param_mapY}
		 * @return ${core_Style_method_toScreenY_return}
		 * 
		 */		
		protected function toScreenY(map:Map, mapY:Number) : Number
		{
			return map.mapToContainerY(mapY);
		}
		
		/**
		 * ${core_Style_method_removeAllChildren_D} 
		 * @param sprite ${core_Style_method_removeAllChildren_param_sprite_D}
		 * 
		 */		
		protected function removeAllChildren(sprite:Sprite):void
		{
			while (sprite.numChildren)
			{
				sprite.removeChildAt(0);
			}
		}
		
		/**
		 * ${core_Style_method_dispatchEventChange_D} 
		 * 
		 */		
		protected function dispatchEventChange():void
		{
			this.dispatchEvent(new Event(Event.CHANGE));
		}
		
		/**
		 * ${core_Style_method_clone_D} 
		 * @return 
		 * 
		 */		
		public function clone() : Style
		{
			return null;
		}


	}
}