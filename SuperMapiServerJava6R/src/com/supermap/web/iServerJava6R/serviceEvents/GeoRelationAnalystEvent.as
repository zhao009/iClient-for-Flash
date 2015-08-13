package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.GeoRelationAnalystResult;

	/**
	 * ${iServerJava6R_serviceEvents_DatasetGeoReAnalystEvt_Title}.
	 * <p>${iServerJava6R_serviceEvents_DatasetGeoReAnalystEvt_Description}</p>
	 * @see com.supermap.web.iServerJava6R.spatialAnalystServices.GeoRelationAnalystResult
	 * 
	 */	
	public class GeoRelationAnalystEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_DatasetGeoReAnalystEvt_evnet_PROCESS_COMPLETE_D} 
		 */	
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:GeoRelationAnalystResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_DatasetGeoReAnalystEvt_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_DatasetGeoReAnalystEvt_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_DatasetGeoReAnalystEvt_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_DatasetGeoReAnalystEvt_constructor_param_originResult}
		 * 
		 */	
		public function GeoRelationAnalystEvent(type:String, result:GeoRelationAnalystResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		/**
		 * ${iServerJava6R_serviceEvents_DatasetGeoReAnalystEvt_attribute_result_D} 
		 * @return 
		 * 
		 */	
		public function get result():GeoRelationAnalystResult
		{
			return _result;
		}

	}
}