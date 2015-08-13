package com.supermap.web.iServerJava6R.serviceEvents
{
	import flash.events.Event;
	
	/**
	 * ${iServerJava6R_serviceEvents_ServiceEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_ServiceEvent_Description}</p> 
	 * 
	 */	
	
	
	public class ServiceEvent extends Event
	{
		private var _originResult:Object;
		
		/**
		 * ${iServerJava6R_serviceEvents_ServiceEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_ServiceEvent_constructor_param_type}
		 * @param originResult ${iServerJava6R_serviceEvents_ServiceEvent_constructor_param_originResult}
		 * 
		 */		
		public function ServiceEvent(type:String, originResult:Object)
		{
			super(type);
			this._originResult = originResult;
		}

		/**
		 * ${iServerJava6R_serviceEvents_ServiceEvent_attribute_originResult_D} 
		 * @return 
		 * 
		 */		
		public function get originResult():Object
		{
			return _originResult;
		}
	}
}