package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.DatasetBufferAnalystResult;

	/**
	 * ${iServerJava6R_serviceEvents_DatasetBufferAnalystEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_DatasetBufferAnalystEvent_Description}</p>
	 * @see com.supermap.web.iServerJava6R.spatialAnalystServices.DatasetBufferAnalystResult
	 * 
	 */	
	public class DatasetBufferAnalystEvent extends ServiceEvent
	{
		private var _result:DatasetBufferAnalystResult;
		/**
		 * ${iServerJava6R_serviceEvents_DatasetBufferAnalystEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_DatasetBufferAnalystEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_DatasetBufferAnalystEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_DatasetBufferAnalystEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_DatasetBufferAnalystEvent_constructor_param_originResult}
		 * 
		 */		
		public function DatasetBufferAnalystEvent(type:String, result:DatasetBufferAnalystResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_DatasetBufferAnalystEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():DatasetBufferAnalystResult
		{
			return _result;
		}

	}
}