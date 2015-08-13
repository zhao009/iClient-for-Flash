package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.RouteCalculateMeasureResult;
	/**
	 * ${iServerJava6R_serviceEvents_RouteCalculateMeasureEvent_Title}.
	 * <p>${iServerJava6R_serviceEvents_RouteCalculateMeasureEvent_Description}</p>
	 * 
	 */	
	public class RouteCalculateMeasureEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_RouteCalculateMeasureEvent_evnet_PROCESS_COMPLETE_D} 
		 */	
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:RouteCalculateMeasureResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_RouteCalculateMeasureEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_RouteCalculateMeasureEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_RouteCalculateMeasureEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_GRouteCalculateMeasureEvent_constructor_param_originResult}
		 * 
		 */	
		public function RouteCalculateMeasureEvent(type:String,result:RouteCalculateMeasureResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		/**
		 * ${iServerJava6R_serviceEvents_RouteCalculateMeasureEvent_attribute_result_D} 
		 * @return 
		 * 
		 */	
		public function get result():RouteCalculateMeasureResult
		{
			return _result;
		}
		
	}
}