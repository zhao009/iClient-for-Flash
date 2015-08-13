package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.layerServices.GetLayersInfoResult;

	/**
	 * ${iServerJava6R_serviceEvents_GetLayersInfoEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_GetLayersInfoEvent_Description}</p> 
	 * 
	 */	
	public class GetLayersInfoEvent extends ServiceEvent
	{ 
		private var _result:GetLayersInfoResult;
		/**
		 * ${iServerJava6R_serviceEvents_GetLayersInfoEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_GetLayersInfoEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_GetLayersInfoEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_GetLayersInfoEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_GetLayersInfoEvent_constructor_param_originResult}
		 * 
		 */		
		public function GetLayersInfoEvent(type:String, result:GetLayersInfoResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_GetLayersInfoEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():GetLayersInfoResult
		{
			return _result;
		}
	}
}