package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.networkAnalystServices.FindPathResult;
	
	/**
	 * ${iServerJava6R_serviceEvents_FindPathEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_FindPathEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindPathService
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindPathResult
	 */	
	public class FindPathEvent extends ServiceEvent
	{ 
		private var _result:FindPathResult;
		/**
		 * ${iServerJava6R_serviceEvents_FindPathEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		/**
		 * ${iServerJava6R_serviceEvents_FindPathEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_FindPathEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_FindPathEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_FindPathEvent_constructor_param_originResult}
		 * 
		 */		
		public function FindPathEvent(type:String, result:FindPathResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_FindPathEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():FindPathResult
		{
			return _result;
		}

	}
}