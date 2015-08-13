package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.dataServices.GetFieldsResult;
	
	/**
	 * ${iServerJava6R_serviceEvents_GetFieldsEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_GetFieldsEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.dataServices.GetFieldsService
	 * @see com.supermap.web.iServerJava6R.dataServices.GetFieldsResult
	 */	
	public class GetFieldsEvent extends ServiceEvent
	{
		private var _result:GetFieldsResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_GetFieldsEvent_evnet_PROCESS_COMPLETE_D} 
		 */	
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_GetFieldsEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_GetFieldsEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_GetFieldsEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_GetFieldsEvent_constructor_param_originResult}
		 * 
		 */	
		public function GetFieldsEvent(type:String, result:GetFieldsResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_GetFieldsEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():GetFieldsResult
		{
			return _result;
		}
	}
}