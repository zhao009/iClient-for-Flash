package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.trafficTransferAnalystServices.TransferSolutionResult;

	/**
	 * ${iServerJava6R_serviceEvents_TransferSolutionEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_TransferSolutionEvent_Description}</p>
	 * @see com.supermap.web.iServerJava6R.trafficTransferAnalystServices.TransferSolutionService
	 * @see com.supermap.web.iServerJava6R.trafficTransferAnalystServices.TransferSolutionResult 
	 */		
	public class TransferSolutionEvent extends ServiceEvent
	{
		private var _result:TransferSolutionResult;

		/**
		 * ${iServerJava6R_serviceEvents_TransferSolutionEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";

		/**
		 * ${iServerJava6R_serviceEvents_TransferSolutionEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_TransferSolutionEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_TransferSolutionEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_TransferSolutionEvent_constructor_param_originResult}
		 * 
		 */			
		public function TransferSolutionEvent(type:String, result:TransferSolutionResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_TransferSolutionEvent_attribute_result_D} 
		 * @return 
		 * 
		 */			
		public function get result():TransferSolutionResult
		{
			return _result;
		}
	}
}