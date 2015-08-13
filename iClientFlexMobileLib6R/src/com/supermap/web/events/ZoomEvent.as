package com.supermap.web.events
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.sm_internal;
	
	import flash.events.Event;
	
	use namespace sm_internal;
	
	/**
	 * ${events_ZoomEvent_Title}.
	 * ${events_ZoomEvent_Description} 
	 * 
	 * 
	 */	
	public class ZoomEvent extends Event
	{
		private var _viewBounds:Rectangle2D;
		private var _zoomFactor:Number;
		private var _level:Number;
		
		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		
		/**
		 * ${events_ZoomEvent_ZOOM_START_D} 
		 */		
		public static const ZOOM_START:String = "zoomStart";
		/**
		 * ${events_ZoomEvent_ZOOM_UPDATE_D} 
		 */		
		public static const ZOOM_UPDATE:String = "zoomUpdate";
		/**
		 * ${events_ZoomEvent_ZOOM_END_D} 
		 */		
		public static const ZOOM_END:String = "zoomEnd";
		
		/**
		 * ${events_ZoomEvent_constructor_D} 
		 * @param type ${events_ZoomEvent_constructor_param_type}
		 * @param viewBounds ${events_ZoomEvent_constructor_param_viewBounds}
		 * @param zoomFactor ${events_ZoomEvent_constructor_param_zoomFactor}
		 * @param level ${events_ZoomEvent_constructor_param_level}
		 * 
		 */		
		public function ZoomEvent(type:String, viewBounds:Rectangle2D = null, zoomFactor:Number = 1, level:Number = -1)
		{
			super(type);
			this._viewBounds = viewBounds;
			this._zoomFactor = zoomFactor;
			this._level = level;
		}
		
		sm_internal function get height():Number
		{
			return _height;
		}

		sm_internal function set height(value:Number):void
		{
			_height = value;
		}

		sm_internal function get width():Number
		{
			return _width;
		}

		sm_internal function set width(value:Number):void
		{
			_width = value;
		}

		sm_internal function get y():Number
		{
			return _y;
		}

		sm_internal function set y(value:Number):void
		{
			_y = value;
		}

		sm_internal function get x():Number
		{
			return _x;
		}

		sm_internal function set x(value:Number):void
		{
			_x = value;
		}

		/**
		 * ${events_ZoomEvent_attribute_level_D} 
		 * 
		 */		
		public function get level():Number
		{
			return _level;
		}

		public function set level(value:Number):void
		{
			_level = value;
		}

		/**
		 * ${events_ZoomEvent_attribute_zoomFactor_D} 
		 * @return 
		 * 
		 */		
		public function get zoomFactor():Number
		{
			return _zoomFactor;
		}

		public function set zoomFactor(value:Number):void
		{
			_zoomFactor = value;
		}

		/**
		 * ${events_ZoomEvent_attribute_viewBounds_D} 
		 * 
		 */		
		public function get viewBounds():Rectangle2D
		{
			return _viewBounds;
		}
		
		public function set viewBounds(value:Rectangle2D):void
		{
			_viewBounds = value;
		}

		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			var new_zoomEvent:ZoomEvent = new ZoomEvent(type, this.viewBounds.clone(), this.zoomFactor, this.level);
			return new_zoomEvent;
		}
		/**
		 * @private 
		 * @return 
		 * 
		 */	
		override public function toString() : String
		{
			return formatToString("ZoomEvent", "type", "viewBounds", "zoomFactor", "level");
		}
	}
}