package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.networkAnalystServices.FindTSPPathsResult;
	/**
	 * ${iServerJava6R_serviceEvents_FindTSPPathsEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_FindTSPPathsEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindTSPPathsService
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindTSPPathsResult
	 * 
	 */	
	public class FindTSPPathsEvent extends ServiceEvent
	{  
		private var _result:FindTSPPathsResult;
		/**
		 * ${iServerJava6R_serviceEvents_FindTSPPathsEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_FindTSPPathsEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_FindTSPPathsEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_FindTSPPathsEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_FindTSPPathsEvent_constructor_param_originResult}
		 * 
		 */		
		public function FindTSPPathsEvent(type:String, result:FindTSPPathsResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_FindTSPPathsEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():FindTSPPathsResult
		{
			return _result;
		}

	}
}