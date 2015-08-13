package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.trafficTransferAnalystServices.StopQueryResult;

	/**
	 * ${iServerJava6R_serviceEvents_StopQueryEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_StopQueryEvent_Description}</p>
	 * @see com.supermap.web.iServerJava6R.trafficTransferAnalystServices.StopQueryService
	 * @see com.supermap.web.iServerJava6R.trafficTransferAnalystServices.StopQueryResult 
	 */	
	public class StopQueryEvent extends ServiceEvent
	{
		private var _result:StopQueryResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_StopQueryEvent_evnet_PROCESS_COMPLETE_D} 
		 */
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_StopQueryEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_StopQueryEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_StopQueryEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_StopQueryEvent_constructor_param_originResult}
		 * 
		 */	
		public function StopQueryEvent(type:String, result:StopQueryResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_StopQueryEvent_attribute_result_D} 
		 * @return 
		 * 
		 */	
		public function get result():StopQueryResult
		{
			return _result;
		}
		
	}
}