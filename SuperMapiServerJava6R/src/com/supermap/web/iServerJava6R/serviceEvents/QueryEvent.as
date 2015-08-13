package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.queryServices.QueryResult;
	
	/**
	 * ${iServerJava6R_serviceEvents_QueryEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_QueryEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.queryServices.QueryService
	 * @see com.supermap.web.iServerJava6R.queryServices.QueryResult
	 * 
	 */	
	public class QueryEvent extends ServiceEvent
	{
		private var _result:QueryResult;
		/**
		 * ${iServerJava6R_serviceEvents_QueryEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_QueryEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_QueryEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_QueryEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_QueryEvent_constructor_param_originResult}
		 * 
		 */		
		public function QueryEvent(type:String, result:QueryResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}


		/**
		 * ${iServerJava6R_serviceEvents_QueryEvent_attribute_result_D} 
		 * @return 
		 * 
		 */			 	
		public function get result():QueryResult
		{
			return _result;
		}

	}
}