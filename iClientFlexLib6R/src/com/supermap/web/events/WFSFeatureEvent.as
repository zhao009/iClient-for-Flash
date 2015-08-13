package com.supermap.web.events
{
	import com.supermap.web.ogc.wfs.WFSFeatureResult;
	
	/**
	 * ${events_WFSFeatureEvent_Title}.
	 * <p>${events_WFSFeatureEvent_Description}</p> 
	 * 
	 */	
	public class WFSFeatureEvent extends WFSEvent
	{
		private var _wfsFeatureResult:WFSFeatureResult;
		
		/**
		 * ${events_WFSFeatureEvent_field_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${events_WFSFeatureEvent_constructor_D} 
		 * @param type ${events_WFSFeatureEvent_constructor_param_type}
		 * @param wfsFeatureResult ${events_WFSFeatureEvent_constructor_param_wfsFeatureResult}
		 * @param originResult ${events_WFSFeatureEvent_constructor_param_originResult}
		 * 
		 */		
		public function WFSFeatureEvent(type:String, wfsFeatureResult:WFSFeatureResult, originResult:Object)
		{
			super(type, originResult);
			this._wfsFeatureResult = wfsFeatureResult;
			
		}
			
		/**
		 * ${events_WFSFeatureEvent_attribute_wfsFeatureResult_D} 
		 * @return 
		 * 
		 */		
		public function get wfsFeatureResult():WFSFeatureResult
		{
			return _wfsFeatureResult;
		}

	}
}