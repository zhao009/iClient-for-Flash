package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.ChartFeatureInfoSpecsEvent;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.ChartFeatureInfoSpecsEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	
	/**
	 * ${iServerJava6R_ChartFeatureInfoSpecsService_Title}.
	 * <p>${iServerJava6R_ChartFeatureInfoSpecsService_Description}</p> 
	 * @see ChartFeatureInfoSpecsResult
	 * @see com.supermap.web.iServerJava6R.serviceEvents.ChartFeatureInfoSpecsEvent
	 */	
	public class ChartFeatureInfoSpecsService extends ServiceBase
	{
		private var _result:ChartFeatureInfoSpecsResult;
		
		/**
		 * ${iServerJava6R_ChartFeatureInfoSpecsService_Constructor_D} 
		 * @param url ${iServerJava6R_ChartFeatureInfoSpecsService_constructor_param_url}
		 * 
		 */	
		public function ChartFeatureInfoSpecsService(url:String)
		{
			super(url);
		}

		/**
		 * ${iServerJava6R_ChartFeatureInfoSpecsService_attribute_result_D} 
		 * 
		 */	
		public function get result():ChartFeatureInfoSpecsResult
		{
			return _result;
		}
		/**
		 * ${iServerJava6R_ChartFeatureInfoSpecsService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_ChartFeatureInfoSpecsService_method_ProcessAsync_remarks}</p> 
		 * @param responder ${iServerJava6R_ChartFeatureInfoSpecsService_method_ProcessAsync_param_responder}
		 * @return ${iServerJava6R_ChartFeatureInfoSpecsService_method_ProcessAsync_param_return}
		 * 
		 */	
		public function processAsync(responder:IResponder):AsyncToken
		{ 
			var extendURL:String = "chartFeatureInfoSpecs.json";
			if(this.url.charAt(this.url.length - 1) != "/")//如果url不以“/”结尾，则添加一个“/”
			{
				extendURL = "/" + extendURL;
			} 
			return sendURL(extendURL, null, responder, this.handleDecodedObject);  	
		} 
		
		private function handleDecodedObject(jsonObject:Object, asyncToken:AsyncToken):void
		{ 
			var responder:IResponder;
			
			_result = ChartFeatureInfoSpecsResult.fromJson(jsonObject);
			
			for each(responder in asyncToken.responders)
			{
				responder.result(this._result);
			}
			this.dispatchEvent(new ChartFeatureInfoSpecsEvent(ChartFeatureInfoSpecsEvent.PROCESS_COMPLETE, this._result, jsonObject));//用事件派发结果
		}

	}
}