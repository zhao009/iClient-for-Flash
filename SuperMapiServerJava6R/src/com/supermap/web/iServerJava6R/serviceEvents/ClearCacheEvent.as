package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.mapServices.ClearCacheResult;
	
	/**
	 * 
	 * ${iServerJava6R_ClearCacheEvent_Title}.
	 * 
	 */		
	public class ClearCacheEvent extends ServiceEvent
	{
		private var _result:ClearCacheResult;
		/**
		 * ${iServerJava6R_serviceEvents_ClearCacheEvent_event_PROCESS_COMPLETE_D} 
		 */	
		public static const PROCESS_COMPLETE:String = "processComplete";
		/**
		 * ${iServerJava6R_ClearCacheEvent_constructor_D} 
		 * @param type ${iServerJava6R_ClearCacheEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_ClearCacheEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_ClearCacheEvent_constructor_param_originResult}
		 * 
		 */		
		public function ClearCacheEvent(type:String, result:ClearCacheResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		/**
		 * ${iServerJava6R_serviceEvents_FieldStatisticEvent_attribute_result_D} 
		 * @return 
		 * 
		 */	
		public function get result():ClearCacheResult
		{
			return _result;
		}

	}
}
