package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.networkAnalystServices.ComputeWeightMatrixResult;

	/**
	 * ${iServerJava6R_serviceEvents_ComputeWeightMatrixEvent_Title}.
	 * <p>${iServerJava6R_serviceEvents_ComputeWeightMatrixEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.ComputeWeightMatrixService
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.ComputeWeightMatrixResult
	 * 
	 */	
	public class ComputeWeightMatrixEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_ComputeWeightMatrixEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:ComputeWeightMatrixResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_ComputeWeightMatrixEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_ComputeWeightMatrixEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_ComputeWeightMatrixEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_ComputeWeightMatrixEvent_constructor_param_originResult}
		 * 
		 */		
		public function ComputeWeightMatrixEvent(type:String, result:ComputeWeightMatrixResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_ComputeWeightMatrixEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():ComputeWeightMatrixResult
		{
			return _result;
		}

	}
}