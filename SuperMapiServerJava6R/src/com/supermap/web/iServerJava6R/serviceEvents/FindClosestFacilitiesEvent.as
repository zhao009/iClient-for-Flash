package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.networkAnalystServices.FindClosestFacilitiesResult;

	/**
	 * ${iServerJava6R_serviceEvents_FindClosestFacilitiesEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_FindClosestFacilitiesEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindClosestFacilitiesService
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.FindClosestFacilitiesResult
	 */	
	public class FindClosestFacilitiesEvent extends ServiceEvent
	{  
		//--------------------------------------------------------------------------
		//
		//  查找最近设施服务参数
		//
		//--------------------------------------------------------------------------
		
		private var _result:FindClosestFacilitiesResult;
		/**
		 * ${iServerJava6R_serviceEvents_FindClosestFacilitiesEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_FindClosestFacilitiesEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_FindClosestFacilitiesEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_FindClosestFacilitiesEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_FindClosestFacilitiesEvent_constructor_param_originResult}
		 * 
		 */		
		public function FindClosestFacilitiesEvent(type:String, result:FindClosestFacilitiesResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_FindClosestFacilitiesEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():FindClosestFacilitiesResult
		{
			return _result;
		}

	}
}