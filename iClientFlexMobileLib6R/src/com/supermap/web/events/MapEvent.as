package com.supermap.web.events
{
	import com.supermap.web.mapping.*;
	
	import flash.events.Event;
	
	/**
	 * ${events_MapEvent_Title} 
	 * @see com.supermap.web.mapping.Map
	 * 
	 * 
	 */	
	public class MapEvent extends Event
	{

		private var _map:Map;
		private var _layer:Layer;
		private var _index:int = -1;
		
		/**
		 * ${events_MapEvent_field_LOAD_D} 
		 */		
		public static const LOAD:String = "load";
		/**
		 * ${events_MapEvent_field_LAYER_ADD_D} 
		 */		
		public static const LAYER_ADD:String = "layerAdd";
		/**
		 * ${events_MapEvent_field_LAYER_REMOVE_D} 
		 */		
		public static const LAYER_REMOVE:String = "layerRemove";
		/**
		 * ${events_MapEvent_field_LAYER_REMOVE_ALL_D} 
		 */		
		public static const LAYER_REMOVE_ALL:String = "layerRemoveAll";
		/**
		 * ${events_MapEvent_field_LAYER_REORDER_D} 
		 */		
		public static const LAYER_MOVE:String = "layerMove";
		
		
		/**
		 * ${events_MapEvent_constructor_D} 
		 * @param type ${events_MapEvent_constructor_param_type}
		 * @param map ${events_MapEvent_constructor_param_map}
		 * @param layer ${events_MapEvent_constructor_param_layer}
		 * @param index ${events_MapEvent_constructor_param_index}
		 * 
		 */		
		public function MapEvent(type:String, map:Map = null, layer:Layer = null, index:int = -1)
		{
			super(type);
			this._map = map;
			this._layer = layer;
			this._index = index;
		}
		
		/**
		 * ${events_DrawEvent_attribute_index_D} 
		 * @return 
		 * 
		 */		
		public function get index():int
		{
			return _index;
		}

		/**
		 * ${events_DrawEvent_attribute_layer_D} 
		 * 
		 */		
		public function get layer():Layer
		{
			return _layer;
		}

		/**
		 * ${events_DrawEvent_attribute_map_D} 
		 * 
		 */		
		public function get map():Map
		{
			return _map;
		}

		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new MapEvent(type, this.map, this.layer, this.index);
		}
		/**
		 * @private 
		 * @return 
		 * 
		 */	
		override public function toString() : String
		{
			return formatToString("MapEvent", "type", "map", "layer", "index");
		}

	}
}