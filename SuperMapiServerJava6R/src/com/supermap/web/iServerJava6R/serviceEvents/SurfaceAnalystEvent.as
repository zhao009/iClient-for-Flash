package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.SurfaceAnalystResult;

	/**
	 * ${iServerJava6R_serviceEvents_SurfaceAnalystEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_SurfaceAnalystEvent_Description}</p>
	 * 
	 */	
	public class SurfaceAnalystEvent extends ServiceEvent
	{
		/**
		 * ${iServerJava6R_serviceEvents_SurfaceAnalystEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:SurfaceAnalystResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_SurfaceAnalystEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_SurfaceAnalystEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_SurfaceAnalystEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_SurfaceAnalystEvent_constructor_param_originResult}
		 * 
		 */		
		public function SurfaceAnalystEvent(type:String, result:SurfaceAnalystResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_SurfaceAnalystEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():SurfaceAnalystResult
		{
			return _result;
		}

	}
}