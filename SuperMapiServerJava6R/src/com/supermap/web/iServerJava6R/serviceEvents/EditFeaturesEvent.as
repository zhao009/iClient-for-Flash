package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.dataServices.EditFeaturesResult;

	/**
	 * ${iServerJava6R_serviceEvents_EditFeaturesEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_EditFeaturesEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.dataServices.EditFeaturesService
	 * @see com.supermap.web.iServerJava6R.dataServices.EditFeaturesResult
	 */	
	public class EditFeaturesEvent extends ServiceEvent
	{
		private var _result:EditFeaturesResult;
		
		/**
		 * ${iServerJava6R_serviceEvents_EditFeaturesEvent_evnet_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${iServerJava6R_serviceEvents_EditFeaturesEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_EditFeaturesEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_EditFeaturesEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_EditFeaturesEvent_constructor_param_originResult}
		 * 
		 */		
		public function EditFeaturesEvent(type:String, result:EditFeaturesResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_EditFeaturesEvent_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():EditFeaturesResult
		{
			return _result;
		}

	}
}