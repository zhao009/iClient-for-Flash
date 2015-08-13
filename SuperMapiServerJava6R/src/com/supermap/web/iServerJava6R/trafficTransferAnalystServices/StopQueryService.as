package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.StopQueryEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.StopQueryEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	/**
	 * ${iServerJava6R_StopQueryService_Title}.
	 * 
	 */	
	public class StopQueryService extends ServiceBase
	{
		private var _lastResult:StopQueryResult;
		/**
		 * ${iServerJava6R_StopQueryService_constructor_overloads_D}
		 * @param url ${iServerJava6R_StopQueryService_constructor_param_url}
		 * 
		 */	
		override public function StopQueryService(url:String)
		{
			super(url);
		}

		sm_internal function get lastResult():StopQueryResult
		{
			return _lastResult;
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = StopQueryResult.fromJson(object);//用fromJson进行转换
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			
			this.dispatchEvent(new StopQueryEvent(StopQueryEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
		/**
		 * ${iServerJava6R_StopQueryService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_StopQueryService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_StopQueryService_method_ProcessAsync_param_parameters}
		 * @param responder ${iServerJava6R_StopQueryService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_StopQueryService_method_ProcessAsync_return}
		 * 
		 */	
		public function processAsync(parameters:StopQueryParameters, responder:IResponder = null):AsyncToken
		{
			if (parameters == null)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			} 
			
			var extendURL:String = "stops/keyword/" + parameters.keyword + ".json?returnPosition=" + parameters.returnPosition;
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}  
			
			return sendURL(extendURL, null, responder, this.handleDecodedObject); 
		}
	}
}