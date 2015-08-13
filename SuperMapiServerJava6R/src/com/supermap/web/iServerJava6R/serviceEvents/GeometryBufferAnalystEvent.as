package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.GeometryBufferAnalystResult;

	/**
	 * ${iServerJava6R_serviceEvents_GeometryBufferAnalystEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_GeometryBufferAnalystEvent_Description}</p>
	 * 
	 */	
	public class GeometryBufferAnalystEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_GeometryBufferAnalystEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:GeometryBufferAnalystResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_GeometryBufferAnalystEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_GeometryBufferAnalystEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_GeometryBufferAnalystEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_GeometryBufferAnalystEvent_constructor_param_originResult}
		 * 
		 */		
		public function GeometryBufferAnalystEvent(type:String, result:GeometryBufferAnalystResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_GeometryBufferAnalystEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():GeometryBufferAnalystResult
		{
			return _result;
		}

	}
}