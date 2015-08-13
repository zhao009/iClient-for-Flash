package com.supermap.web.events
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	
	use namespace sm_internal;
	
	/**
	 * ${events_MapMouseEvent_Title} 
	 * @see com.supermap.web.mapping.Map
	 * 
	 * 
	 */	
	public class MapMouseEvent extends MouseEvent
	{
		private var _originalMouseEvent:MouseEvent;
		private var _map:Map;
		private var _mapPoint:Point2D;
		/**
		 * ${events_MapMouseEvent_MAP_CLICK_D} 
		 */		
		public static const MAP_CLICK:String = "mapClick";
		
		/**
		 * ${events_MapMouseEvent_constructor_D} 
		 * @param type ${events_MapMouseEvent_constructor_param_type}
		 * @param map ${events_MapMouseEvent_constructor_param_map}
		 * @param mapPoint ${events_MapMouseEvent_constructor_param_mapPoint}
		 * 
		 */		
		public function MapMouseEvent(type:String, map:Map, mapPoint:Point2D)
		{
			super(type, true, true);
			this._map = map;
			this._mapPoint = mapPoint;
			
		}
		
		/**
		 * ${events_MapMouseEvent_attribute_mapPoint_D} 
		 * 
		 */		
		public function get mapPoint():Point2D
		{
			return _mapPoint;
		}

		/**
		 * ${events_MapMouseEvent_attribute_map_D} 
		 * @return 
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
		override public function get stageX() : Number
		{
			return this._originalMouseEvent.stageX;
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function get stageY() : Number
		{
			return this._originalMouseEvent.stageY;
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			var new_mapMouseEvent:* = new MapMouseEvent(type, this.map, this.mapPoint);
			new_mapMouseEvent.setMouseEventProperties(this._originalMouseEvent);
			return new_mapMouseEvent;
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */	
		override public function toString() : String
		{
			return formatToString("MapMouseEvent", "type", "map", "mapPoint", "localX", "localY", "stageX", "stageY", "relatedObject", "ctrlKey", "altKey", "shiftKey", "delta");
		}
		
		sm_internal function setMouseEventProperties(event:MouseEvent) : void
		{
			localX = event.localX;
			localY = event.localY;
			relatedObject = event.relatedObject;
			ctrlKey = event.ctrlKey;
			altKey = event.altKey;
			shiftKey = event.shiftKey;
			buttonDown = event.buttonDown;
			delta = event.delta;
			this._originalMouseEvent = event;
		}
	}
}