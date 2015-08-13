package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.networkAnalystServices.FindServiceAreasResult;

	/**
	 * ${iServerJava6R_serviceEvents_FindServiceAreasEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_FindServiceAreasEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindServiceAreasService
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindServiceAreasResult
	 */	
	public class FindServiceAreasEvent extends ServiceEvent
	{
		
		//--------------------------------------------------------------------------
		//
		// 分析结果
		//
		//--------------------------------------------------------------------------
		
		private var _result:FindServiceAreasResult;
		/**
		 * ${iServerJava6R_serviceEvents_FindServiceAreasEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		/**
		 * ${iServerJava6R_serviceEvents_FindServiceAreasEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_FindServiceAreasEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_FindServiceAreasEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_FindServiceAreasEvent_constructor_param_originResult}
		 * 
		 */		
		public function FindServiceAreasEvent(type:String, result:FindServiceAreasResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_FindServiceAreasEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():FindServiceAreasResult
		{
			return _result;
		}

	}
}