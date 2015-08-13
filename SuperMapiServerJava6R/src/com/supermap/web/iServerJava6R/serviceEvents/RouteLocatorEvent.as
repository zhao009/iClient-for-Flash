package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.RouteLocatorResult;
	/**
	 * ${iServerJava6R_serviceEvents_RouteLocatorEvent_Title}.
	 * <p>${iServerJava6R_serviceEvents_RouteLocatorEvent_Description}</p>
	 * 
	 */	
	public class RouteLocatorEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_RouteLocatorEvent_evnet_PROCESS_COMPLETE_D} 
		 */	
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:RouteLocatorResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_RouteLocatorEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_RouteLocatorEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_RouteLocatorEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_RouteLocatorEvent_constructor_param_originResult}
		 * 
		 */	
		public function RouteLocatorEvent(type:String,result:RouteLocatorResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		/**
		 * ${iServerJava6R_serviceEvents_RouteLocatorEvent_attribute_result_D} 
		 * @return 
		 * 
		 */	
		public function get result():RouteLocatorResult
		{
			return _result;
		}
		
	}
}