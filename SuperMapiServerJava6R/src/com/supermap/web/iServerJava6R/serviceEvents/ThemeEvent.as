package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.themeServices.ThemeResult;

	/**
	 * ${iServerJava6R_serviceEvents_ThemeEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_ThemeEvent_Description}</p>
	 * @see com.supermap.web.iServerJava6R.themeServices.ThemeService
	 * @see com.supermap.web.iServerJava6R.themeServices.ThemeResult
	 * 
	 */	
	public class ThemeEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_ThemeEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:ThemeResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_ThemeEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_ThemeEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_ThemeEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_ThemeEvent_constructor_param_originResult}
		 * 
		 */		
		public function ThemeEvent(type:String, result:ThemeResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_ThemeEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():ThemeResult
		{
			return _result;
		}
	}
}