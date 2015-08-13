package com.supermap.web.iServerJava6R.serviceEvents
{
	import flash.events.Event;
	import mx.rpc.events.FaultEvent;
	
	/**
	 * ${iServerJava6R_serviceEvents_GOIsEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_GOIsEvent_Description}</p> 
	 * 
	 */	
	public class GOIsEvent extends Event
	{
		/**
		 * ${iServerJava6R_serviceEvents_GOIsEvent_field_CLICK_D} 
		 */		
		public static const CLICK:String = "click";
		
		/**
		 * ${iServerJava6R_serviceEvents_GOIsEvent_field_MOUSEOVER_D} 
		 */		
		public static const MOUSEOVER:String = "mouseover";
		
		/**
		 * ${iServerJava6R_serviceEvents_GOIsEvent_field_INITIALIZED_D} 
		 */		
		public static const INITIALIZED:String = "initialized";
		
		/**
		 * ${iServerJava6R_serviceEvents_GOIsEvent_field_INITIALIZE_FAILED_D} 
		 */		
		public static const INITIALIZE_FAILED:String = "initializeFailed";
		
		private var _poiInfo:Object;
		private var _loc:Object;
		private var _error:FaultEvent;
	
		/**
		 * ${iServerJava6R_serviceEvents_GOIsEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_GOIsEvent_constructor_param_type}
		 * @param type ${iServerJava6R_serviceEvents_GOIsEvent_constructor_param_poiInfo}
		 * @param type ${iServerJava6R_serviceEvents_GOIsEvent_constructor_param_loc}
		 * @param type ${iServerJava6R_serviceEvents_GOIsEvent_constructor_param_error}
		 * 
		 */	
		public function GOIsEvent(type:String,poiInfo:Object = null,loc:Object = null,error:FaultEvent = null)
		{
			super(type);
			if(poiInfo) this._poiInfo = poiInfo;
			if(loc) this._loc = loc;
			if(error) this._error = error;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_GOIsEvent_attribute_poiInfo_D}.
		 * <p>${iServerJava6R_serviceEvents_GOIsEvent_attribute_poiInfo_remarks}</p>
		 * @return 
		 * 
		 */		
		public function get poiInfo():Object
		{
			return _poiInfo;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_GOIsEvent_attribute_loc_D}.
		 * <p>${iServerJava6R_serviceEvents_GOIsEvent_attribute_loc_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get loc():Object
		{
			return _loc;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_GOIsEvent_attribute_error_D} 
		 * @return 
		 * 
		 */		
		public function get error():FaultEvent
		{
			return _error;
		}
	}
}