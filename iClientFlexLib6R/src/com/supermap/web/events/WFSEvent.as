package com.supermap.web.events
{
	import flash.events.Event;
	
	/**
	 * ${events_WFSEvent_Title} 
	 * 
	 */	
	public class WFSEvent extends Event
	{
		private var _originResult:Object;
		
		/**
		 * ${events_WFSEvent_constructor_D} 
		 * @param type ${events_WFSEvent_constructor_param_type}
		 * @param originResult ${events_WFSEvent_constructor_param_originResult}
		 * 
		 */		
		public function WFSEvent(type:String, originResult:Object)
		{
			super(type);
			this._originResult = originResult;
		}

		/**
		 * ${events_WFSEvent_attribute_originResult_D} 
		 * @return 
		 * 
		 */		
		public function get originResult():Object
		{
			return _originResult;
		}

	}
}