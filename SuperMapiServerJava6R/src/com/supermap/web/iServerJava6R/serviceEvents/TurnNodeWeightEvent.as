package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.networkAnalystServices.TurnNodeWeightResult;
	/**
	 * ${iServerJava6R_serviceEvents_TurnNodeWeightEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_TurnNodeWeightEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.GetTurnNodeWeightService
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.TurnNodeWeightResult
	 * 
	 */	
	public class TurnNodeWeightEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_TurnNodeWeightEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:TurnNodeWeightResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_TurnNodeWeightEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_TurnNodeWeightEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_TurnNodeWeightEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_TurnNodeWeightEvent_constructor_param_originResult}
		 * 
		 */		
		public function TurnNodeWeightEvent(type:String, result:TurnNodeWeightResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_TurnNodeWeightEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():TurnNodeWeightResult
		{
			return _result;
		}
	}
}