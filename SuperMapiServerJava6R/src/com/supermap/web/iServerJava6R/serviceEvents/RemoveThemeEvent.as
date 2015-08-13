package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.themeServices.RemoveThemeResult;

	/**
	 * ${iServerJava6R_serviceEvents_RemoveThemeEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_RemoveThemeEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.themeServices.RemoveThemeService
	 * @see com.supermap.web.iServerJava6R.themeServices.RemoveThemeResult
	 * 
	 */	
	public class RemoveThemeEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_RemoveThemeEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:RemoveThemeResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_RemoveThemeEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_RemoveThemeEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_RemoveThemeEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_RemoveThemeEvent_constructor_param_originResult}
		 * 
		 */		
		public function RemoveThemeEvent(type:String, result:RemoveThemeResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_RemoveThemeEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():RemoveThemeResult
		{
			return _result;
		}
	}
}