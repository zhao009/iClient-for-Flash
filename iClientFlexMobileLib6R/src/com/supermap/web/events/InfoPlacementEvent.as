package com.supermap.web.events
{
	import flash.events.Event;
	
	/**
	 * ${events_InfoPlacementEvent_Title} 
	 * @see com.supermap.web.mapping.InfoPlacement
	 * @private
	 * 
	 */	
	public class InfoPlacementEvent extends Event
	{
		private var _infoPlacement:String = "upper-right";
		/**
		 * ${events_InfoPlacementEvent_field_INFO_PLACEMENT_D} 
		 */		
		public static const INFO_PLACEMENT:String = "infoPlacement";
		
		/**
		 * ${events_InfoPlacementEvent_constructor_D} 
		 * @param infoPlacement ${events_InfoPlacementEvent_constructor_param_infoPlacement}
		 * 
		 */		
		public function InfoPlacementEvent(infoPlacement:String = "upper-right")
		{
			super(INFO_PLACEMENT, true);
			this._infoPlacement = infoPlacement;
		}
		
		/**
		 * ${events_InfoPlacementEvent_attribute_infoPlacement_D} 
		 * @return 
		 * 
		 */		
		public function get infoPlacement():String
		{
			return _infoPlacement;
		}

		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new InfoPlacementEvent(this.infoPlacement);
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */	
		override public function toString() : String
		{
			return formatToString("InfoPlacementEvent", "type", "infoPlacement");
		}
	}
}