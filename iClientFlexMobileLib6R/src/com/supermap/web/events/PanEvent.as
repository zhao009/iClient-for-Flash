package com.supermap.web.events
{
	import com.supermap.web.core.Rectangle2D;
	
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * ${events_PanEvent_Title}.
	 * ${events_PanEvent_Description} 
	 * 
	 * 
	 */	
	public class PanEvent extends Event
	{
		private var _viewBounds:Rectangle2D;
		private var _point:Point;
		/**
		 * ${events_PanEvent_PAN_START_D} 
		 */		
		public static const PAN_START:String = "panStart";
		/**
		 * ${events_PanEvent_PAN_UPDATE_D} 
		 */		
		public static const PAN_UPDATE:String = "panUpdate";
		/**
		 * ${events_PanEvent_PAN_END_D} 
		 */		
		public static const PAN_END:String = "panEnd";
		
		/**
		 * ${events_PanEvent_constructor_D} 
		 * @param type ${events_PanEvent_constructor_param_type}
		 * @param viewBounds ${events_PanEvent_constructor_param_viewBounds}
		 * @param point ${events_PanEvent_constructor_param_point}
		 * 
		 */		
		public function PanEvent(type:String, viewBounds:Rectangle2D = null, point:Point = null)
		{
			super(type);
			this._viewBounds = viewBounds;
			this._point = point;
		}
		
		/**
		 * ${events_PanEvent_attribute_point_D}
		 * 
		 */		
		public function get point():Point
		{
			return _point;
		}

		/**
		 * ${events_PanEvent_constructor_param_point} 
		 * 
		 */		
		public function get viewBounds():Rectangle2D
		{
			return _viewBounds;
		}

		/**
		 * @private 
		 * @return 
		 * 
		 */
		override public function clone() : Event
		{
			return new PanEvent(type, this.viewBounds, this.point);
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */
		override public function toString() : String
		{
			return formatToString("PanEvent", "type", "viewBounds", "point");
		}
	}
}