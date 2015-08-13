package com.supermap.web.events
{
	import flash.events.Event;
	
	/**
	 * ${events_CloudLayerEvent_Title}
	 * @see com.supermap.web.mapping.CloudLayer 
	 * 
	 */	
	public class CloudLayerEvent extends Event
	{
		/**
		 * ${events_CloudLayerEvent_field_KEY_ERROR_D} 
		 */		
		public static const KEY_ERROR:String = "keyError";
		/**
		 * ${events_CloudLayerEvent_field_KEY_SUCCESS_D} 
		 */
		public static const KEY_SUCCESS:String = "keySuccess";
		private var _message:String;
		
		/**
		 * ${events_CloudLayerEvent_constructor_D} 
		 * @param type ${events_CloudLayerEvent_constructor_param_type}
		 * @param message ${events_CloudLayerEvent_constructor_param_message}
		 * 
		 */		
		public function CloudLayerEvent(type:String, message:String)
		{
			super(type);
			this._message = message;
		}
		
		/**
		 * ${events_CloudLayerEvent_attribute_message_D} 
		 * @return 
		 * 
		 */		
		public function get message():String
		{
			return _message;
		}

	}
}