package com.supermap.web.events
{
	import com.supermap.web.ogc.wfs.WFSCapabilitiesResult;

	/**
	 * ${events_WFSCapabilitiesEvent_Title}.
	 * <p>${events_WFSCapabilitiesEvent_Description}</p>
	 * @see com.supermap.web.ogc.wfs.GetWFSCapabilities 
	 * 
	 */	
	public class WFSCapabilitiesEvent extends WFSEvent
	{
		private var _wfsCapabilitiesResult:WFSCapabilitiesResult;
		
		/**
		 * ${events_WFSCapabilitiesEvent_field_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${events_WFSCapabilitiesEvent_constructor_D} 
		 * @param type ${events_WFSCapabilitiesEvent_constructor_param_type}
		 * @param wfsCapabilitiesResult ${events_WFSCapabilitiesEvent_constructor_param_wfsCapabilitiesResult}
		 * @param originResult ${events_WFSCapabilitiesEvent_constructor_param_originResult}
		 * 
		 */		
		public function WFSCapabilitiesEvent(type:String, wfsCapabilitiesResult:WFSCapabilitiesResult, originResult:Object)
		{
			super(type, originResult);
			this._wfsCapabilitiesResult = wfsCapabilitiesResult;
		}

		/**
		 * ${events_WFSCapabilitiesEvent_attribute_wfsCapabilitiesResult_D} 
		 * @return 
		 * 
		 */		
		public function get wfsCapabilitiesResult():WFSCapabilitiesResult
		{
			return _wfsCapabilitiesResult;
		}

	}
}