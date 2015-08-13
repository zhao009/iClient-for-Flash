package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.GenerateSpatialDataResult;
	/**
	 * ${iServerJava6R_serviceEvents_GenerateSpatialDataEvent_Title}.
	 * <p>${iServerJava6R_serviceEvents_GenerateSpatialDataEvent_Description}</p>
	 * 
	 */	
	public class GenerateSpatialDataEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_GenerateSpatialDataEvent_evnet_PROCESS_COMPLETE_D} 
		 */	
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:GenerateSpatialDataResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_GenerateSpatialDataEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_GenerateSpatialDataEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_GenerateSpatialDataEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_GenerateSpatialDataEvent_constructor_param_originResult}
		 * 
		 */	
		public function GenerateSpatialDataEvent(type:String,result:GenerateSpatialDataResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		/**
		 * ${iServerJava6R_serviceEvents_GenerateSpatialDataEvent_attribute_result_D} 
		 * @return 
		 * 
		 */	
		public function get result():GenerateSpatialDataResult
		{
			return _result;
		}

	}
}