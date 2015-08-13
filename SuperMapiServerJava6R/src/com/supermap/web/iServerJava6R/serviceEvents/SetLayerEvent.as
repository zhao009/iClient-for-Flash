package com.supermap.web.iServerJava6R.serviceEvents
{
	
	import flash.events.Event;
	import com.supermap.web.iServerJava6R.layerServices.SetLayerResult;

	/**
	 * ${iServerJava6R_serviceEvents_SetLayerEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_SetLayerEvent_Description}</p> 
	 * 
	 */	
	public class SetLayerEvent extends ServiceEvent
	{
		private var _result:SetLayerResult;
		/**
		 * ${iServerJava6R_serviceEvents_SetLayerEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_SetLayerEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_SetLayerEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_SetLayerEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_SetLayerEvent_constructor_param_originResult}
		 * 
		 */		
		public function SetLayerEvent(type:String, result:SetLayerResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		/**
		 * ${iServerJava6R_serviceEvents_SetLayerEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():SetLayerResult
		{
			return _result;
		}
 
	}
}