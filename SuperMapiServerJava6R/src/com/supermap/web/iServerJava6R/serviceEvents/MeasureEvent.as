package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.measureServices.MeasureResult;

	/**
	 * ${iServerJava6R_serviceEvents_MeasureEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_MeasureEvent_Description}</p>
	 * @see com.supermap.web.iServerJava6R.measureServices.MeasureService
	 * @see com.supermap.web.iServerJava6R.measureServices.MeasureResult
	 * 
	 */	
	public class MeasureEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_MeasureEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:MeasureResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_MeasureEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_MeasureEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_MeasureEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_MeasureEvent_constructor_param_originResult}
		 * 
		 */		
		public function MeasureEvent(type:String, result:MeasureResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_MeasureEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():MeasureResult
		{
			return _result;
		}

	}
}