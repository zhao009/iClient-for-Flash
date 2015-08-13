package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.dataServices.GetFeaturesResult;
	
	/**
	 * ${iServerJava6R_serviceEvents_GetFeaturesEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_GetFeaturesEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.dataServices.GetFeaturesResult
	 * 
	 */	
	public class GetFeaturesEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_GetFeaturesEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:GetFeaturesResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_GetFeaturesEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_GetFeaturesEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_GetFeaturesEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_GetFeaturesEvent_constructor_param_originResult}
		 * 
		 */		
		public function GetFeaturesEvent(type:String, result:GetFeaturesResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_GetFeaturesEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():GetFeaturesResult
		{
			return _result;
		}
		
	}
}