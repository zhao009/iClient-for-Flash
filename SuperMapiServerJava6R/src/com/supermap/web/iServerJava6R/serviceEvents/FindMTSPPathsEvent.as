package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.networkAnalystServices.FindMTSPPathsResult;
	
	/**
	 * ${iServerJava6R_serviceEvents_FindMTSPPathsEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_FindMTSPPathsEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindMTSPPathsService
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindMTSPPathsResult
	 */	
	public class FindMTSPPathsEvent extends ServiceEvent
	{  
		//--------------------------------------------------------------------------
		//
		//  服务参数类
		//
		//--------------------------------------------------------------------------
		
		private var _result:FindMTSPPathsResult;
		/**
		 * ${iServerJava6R_serviceEvents_FindMTSPPathsEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_FindMTSPPathsEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_FindMTSPPathsEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_FindMTSPPathsEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_FindMTSPPathsEvent_constructor_param_originResult}
		 * 
		 */		
		public function FindMTSPPathsEvent(type:String, result:FindMTSPPathsResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_FindMTSPPathsEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():FindMTSPPathsResult
		{
			return _result;
		}

		

	}
}