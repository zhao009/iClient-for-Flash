package com.supermap.web.events
{
	import com.supermap.web.ogc.wfs.WFSTransactionResult;
	
	/**
	 * ${events_WFSTransactionEvent_Title} 
	 * 
	 */	
	public class WFSTransactionEvent extends WFSEvent
	{
		
		private var _wfsTransactionResult:WFSTransactionResult;
		
		/**
		 * ${events_WFSTransactionEvent_field_PROCESS_COMPLETE_D} 
		 */		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		/**
		 * ${events_WFSTransactionEvent_constructor_D} 
		 * @param type ${events_WFSTransactionEvent_constructor_param_type}
		 * @param originResult ${events_WFSTransactionEvent_constructor_param_originResult}
		 * @param _wfsTransactionResult ${events_WFSTransactionEvent_constructor_param_wfsFeatureResult}
		 * 
		 */		
		public function WFSTransactionEvent(type:String, originResult:Object, _wfsTransactionResult:WFSTransactionResult = null)
		{
			super(type, originResult);
			this._wfsTransactionResult = _wfsTransactionResult;
		}

		/**
		 * ${events_WFSTransactionEvent_attribute_wfsFeatureResult_D} 
		 * @return 
		 * 
		 */		
		public function get wfsTransactionResult():WFSTransactionResult
		{
			return _wfsTransactionResult;
		}

	}
}