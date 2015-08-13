package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.dataServices.FieldStatisticResult;
	
	/**
	 * ${iServerJava6R_serviceEvents_FieldStatisticEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_FieldStatisticEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.dataServices.FieldStatisticService
	 * @see com.supermap.web.iServerJava6R.dataServices.FieldStatisticResult
	 */	
	public class FieldStatisticEvent extends ServiceEvent
	{
		private var _result:FieldStatisticResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_FieldStatisticEvent_evnet_PROCESS_COMPLETE_D} 
		 */	
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_FieldStatisticEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_FieldStatisticEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_FieldStatisticEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_FieldStatisticEvent_constructor_param_originResult}
		 * 
		 */		
		public function FieldStatisticEvent(type:String, result:FieldStatisticResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_FieldStatisticEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():FieldStatisticResult
		{
			return _result;
		}
	}
}