package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.ThiessenAnalystResult;
	
	/**
	 * ${iServerJava6R_serviceEvents_ThiessenAnalystEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_ThiessenAnalystEvent_Description}</p>
	 * @see com.supermap.web.iServerJava6R.spatialAnalystServices.DatasetThiessenAnalystService
	 * @see com.supermap.web.iServerJava6R.spatialAnalystServices.GeometryThiessenAnalystService
	 * @see com.supermap.web.iServerJava6R.spatialAnalystServices.ThiessenAnalystResult
	 */	
	public class ThiessenAnalystEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_ThiessenAnalystEvent_evnet_PROCESS_COMPLETE_D} 
		 */
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:ThiessenAnalystResult;
		/**
		 * ${iServerJava6R_serviceEvents_ThiessenAnalystEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_ThiessenAnalystEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_ThiessenAnalystEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_ThiessenAnalystEvent_constructor_param_originResult}
		 * 
		 */	
		public function ThiessenAnalystEvent(type:String, result:ThiessenAnalystResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		/**
		 * ${iServerJava6R_serviceEvents_ThiessenAnalystEvent_attribute_result_D} 
		 * @return 
		 * 
		 */	
		public function get result():ThiessenAnalystResult
		{
			return _result;
		}

	}
}