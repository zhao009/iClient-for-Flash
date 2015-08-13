package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.networkAnalystServices.EdgeWeightResult;
	
	/**
	 * ${iServerJava6R_serviceEvents_EdgeWeightEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_EdgeWeightEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.GetEdgeWeightService
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.EdgeWeightResult
	 * 
	 */	
	public class EdgeWeightEvent extends ServiceEvent
	{ 
		private var _result:EdgeWeightResult;
		/**
		 * ${iServerJava6R_serviceEvents_EdgeWeightNamesEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_EdgeWeightEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_EdgeWeightEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_EdgeWeightEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_EdgeWeightEvent_constructor_param_originResult}
		 * 
		 */		
		public function EdgeWeightEvent(type:String, result:EdgeWeightResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_EdgeWeightEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():EdgeWeightResult
		{
			return _result;
		}


	}
}