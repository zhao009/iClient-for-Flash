package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.layerServices.ChartFeatureInfoSpecsResult;

	/**
	 * ${iServerJava6R_serviceEvents_ChartFeatureInfoSpecsEvent_Tile}.
	 * <p>${iServerJava6R_serviceEvents_ChartFeatureInfoSpecsEvent_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.layerServices.ChartAttributeSpec
	 * @see com.supermap.web.iServerJava6R.layerServices.ChartFeatureInfoSpec
	 * @see com.supermap.web.iServerJava6R.layerServices.ChartFeatureInfoSpecsResult
	 * @see com.supermap.web.iServerJava6R.layerServices.ChartFeatureInfoSpecsService
	 * 
	 */	
	public class ChartFeatureInfoSpecsEvent extends ServiceEvent
	{
		
		private var _result:ChartFeatureInfoSpecsResult;		
		/**
		 * ${iServerJava6R_serviceEvents_ChartFeatureInfoSpecsEvent_evnet_PROCESS_COMPLETE_D} 
		 */	
		public static const PROCESS_COMPLETE:String = "processComplete";

		/**
		 * ${iServerJava6R_serviceEvents_ChartFeatureInfoSpecsEvent_constructor_D} 
		 * @param type ${iServerJava6R_serviceEvents_ChartFeatureInfoSpecsEvent_constructor_param_type}
		 * @param result ${iServerJava6R_serviceEvents_ChartFeatureInfoSpecsEvent_constructor_param_result}
		 * @param originResult ${iServerJava6R_serviceEvents_ChartFeatureInfoSpecsEvent_constructor_param_originResult}
		 * 
		 */	
		public function ChartFeatureInfoSpecsEvent(type:String,result:ChartFeatureInfoSpecsResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		/**
		 * ${iServerJava6R_serviceEvents_ChartFeatureInfoSpecsEvent_attribute_result_D} 
		 * @return 
		 * 
		 */	
		public function get result():ChartFeatureInfoSpecsResult
		{
			return _result;
		}

	}
}