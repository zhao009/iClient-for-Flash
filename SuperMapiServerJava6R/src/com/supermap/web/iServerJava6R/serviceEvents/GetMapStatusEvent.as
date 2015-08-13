package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.mapServices.GetMapStatusResult;

	/**
	 * ${iServerJava6R_serviceEvents_GetMapStatusEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_GetMapStatusEvent_Description}</p> 
	 * 
	 */	
	public class GetMapStatusEvent extends ServiceEvent
	{ 
		private var _result:GetMapStatusResult;
		/**
		 * ${iServerJava6R_serviceEvents_GetMapStatusEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_GetMapStatusEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_GetMapStatusEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_GetMapStatusEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_GetMapStatusEvent_constructor_param_originResult}
		 * 
		 */		
		public function GetMapStatusEvent(type:String, result:GetMapStatusResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_GetMapStatusEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():GetMapStatusResult
		{
			return _result;
		}
		
	}
}