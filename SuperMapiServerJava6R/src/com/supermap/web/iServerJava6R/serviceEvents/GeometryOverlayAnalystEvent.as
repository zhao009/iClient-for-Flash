package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.GeometryOverlayAnalystResult;

	/**
	 * ${iServerJava6R_serviceEvents_GeometryOverlayAnalystEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_GeometryOverlayAnalystEvent_Description}</p>
	 * 
	 */	
	public class GeometryOverlayAnalystEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_GeometryOverlayAnalystEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:GeometryOverlayAnalystResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_GeometryOverlayAnalystEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_GeometryOverlayAnalystEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_GeometryOverlayAnalystEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_GeometryOverlayAnalystEvent_constructor_param_originResult}
		 * 
		 */		
		public function GeometryOverlayAnalystEvent(type:String, result:GeometryOverlayAnalystResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_GeometryOverlayAnalystEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():GeometryOverlayAnalystResult
		{
			return _result;
		}

	}
}