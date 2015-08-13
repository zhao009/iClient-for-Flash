package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.DatasetOverlayAnalystResult;

	/**
	 * ${iServerJava6R_serviceEvents_DatasetOverlayAnalystEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_DatasetOverlayAnalystEvent_Description}</p>
	 */	
	public class DatasetOverlayAnalystEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_DatasetOverlayAnalystEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:DatasetOverlayAnalystResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_DatasetOverlayAnalystEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_DatasetOverlayAnalystEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_DatasetOverlayAnalystEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_DatasetOverlayAnalystEvent_constructor_param_originResult}
		 * 
		 */		
		public function DatasetOverlayAnalystEvent(type:String, result:DatasetOverlayAnalystResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_DatasetOverlayAnalystEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():DatasetOverlayAnalystResult
		{
			return _result;
		}

	}
}