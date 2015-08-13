package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.networkAnalystServices.FindLocationResult;
	/**
	 * ${iServerJava6R_serviceEvents_FindLocationEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_FindLocationEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindLocationService
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindLocationResult
	 * 
	 */	 
	public class FindLocationEvent extends ServiceEvent
	{
		 
		private var _result:FindLocationResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_FindLocationEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_FindLocationEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_FindLocationEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_FindLocationEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_FindLocationEvent_constructor_param_originResult}
		 * 
		 */		
		public function FindLocationEvent(type:String, result:FindLocationResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_FindLocationEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():FindLocationResult
		{
			return _result;
		}

	}
}