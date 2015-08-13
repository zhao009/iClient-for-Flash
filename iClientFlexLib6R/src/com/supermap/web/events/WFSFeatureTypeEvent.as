package com.supermap.web.events
{
	import com.supermap.web.ogc.wfs.WFSFeatureTypeResult;

	/**
	 * ${events_WFSDescribeFeatureTypeEvent_Title}.
	 * <p>${events_WFSDescribeFeatureTypeEvent_Description}</p> 
	 * @see com.supermap.web.ogc.wfs.DescribeWFSFeatureType
	 * 
	 */	
	public class WFSFeatureTypeEvent extends WFSEvent
	{
		private var _wfsDescribeFeatureTypeResult:WFSFeatureTypeResult
		
		/**
		 * ${events_WFSDescribeFeatureTypeEvent_field_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${events_WFSDescribeFeatureTypeEvent_constructor_D} 
		 * @param type ${events_WFSDescribeFeatureTypeEvent_constructor_param_type}
		 * @param wfsDescribeFeatureTypeResult ${events_WFSDescribeFeatureTypeEvent_constructor_param_wfsDescribeFeatureTypeResult}
		 * @param originResult ${events_WFSDescribeFeatureTypeEvent_constructor_param_originResult}
		 * 
		 */		
		public function WFSFeatureTypeEvent(type:String, wfsDescribeFeatureTypeResult:WFSFeatureTypeResult, originResult:Object)
		{
			super(type, originResult);
			this._wfsDescribeFeatureTypeResult = wfsDescribeFeatureTypeResult;
		}
		
		/**
		 * ${events_WFSDescribeFeatureTypeEvent_attribute_wfsDescribeFeatureTypeResult_D} 
		 * @return 
		 * 
		 */		
		public function get wfsDescribeFeatureTypeResult():WFSFeatureTypeResult
		{
			return _wfsDescribeFeatureTypeResult;
		}
	}
}