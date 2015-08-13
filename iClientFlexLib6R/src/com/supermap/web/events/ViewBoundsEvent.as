package com.supermap.web.events
{
	import com.supermap.web.core.Rectangle2D;
	
	import flash.events.Event;
	
	/**
	 * ${events_ViewBoundsEvent_Title}.
	 * ${events_ViewBoundsEvent_Description} 
	 * 
	 * 
	 */	
	public class ViewBoundsEvent extends Event
	{
		private var _viewBounds:Rectangle2D;
		private var _levelChange:Boolean;
		private var _resolution:Number;
		
		/**
		 * ${events_ViewBoundsEvent_VIEWBOUNDS_CHANGE_D} 
		 */		
		public static const VIEW_BOUNDS_CHANGE:String = "viewBoundsChange";
		/**
		 * ${events_ViewBoundsEvent_VIEWBOUNDS_UPDATE_D} 
		 */		
		public static const VIEW_BOUNDS_UPDATE:String = "viewBoundsUpdate";
		
		/**
		 * ${events_ViewBoundsEvent_constructor_D} 
		 * @param type ${events_ViewBoundsEvent_constructor_param_type}
		 * @param viewBounds ${events_ViewBoundsEvent_constructor_param_viewBounds}
		 * @param levelChange ${events_ViewBoundsEvent_constructor_param_levelChange}
		 * @param resolution ${events_ViewBoundsEvent_constructor_param_resolution}
		 * 
		 */		
		public function ViewBoundsEvent(type:String, viewBounds:Rectangle2D= null, levelChange:Boolean = false, resolution:Number = NaN)
		{
			super(type);
			this._viewBounds = viewBounds;
			this._levelChange = levelChange;
			this._resolution = resolution;
		}
		
		/**
		 * ${events_ViewBoundsEvent_attribute_resolution_D} 
		 * 
		 */		
		public function get resolution():Number
		{
			return _resolution;
		}

		/**
		 * ${events_ViewBoundsEvent_attribute_levelChange_D} 
		 * 
		 */		
		public function get levelChange():Boolean
		{
			return _levelChange;
		}

		/**
		 * ${events_ViewBoundsEvent_attribute_viewBounds_D} 
		 * @return 
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
			return new ViewBoundsEvent(type, this.viewBounds);
		}
		/**
		 * @private 
		 * @return 
		 * 
		 */	
		override public function toString() : String
		{
			return formatToString("ViewBoundsEvent", "type", "viewBounds", "levelChange", "resolution");
		}
	}
}