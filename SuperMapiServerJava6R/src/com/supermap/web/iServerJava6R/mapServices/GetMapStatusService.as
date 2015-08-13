package com.supermap.web.iServerJava6R.mapServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.GetMapStatusEvent;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.GetMapStatusEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_GetMapStatusService_Title}.
	 * <p>${iServerJava6R_GetMapStatusService_Description}</p> 
	 * 
	 */	
	public class GetMapStatusService extends ServiceBase
	{
		private var _lastResult:GetMapStatusResult;
		
		/**
		 * ${iServerJava6R_GetMapStatusService_constructor_String_D} 
		 * @param url ${iServerJava6R_GetMapStatusService_constructor_String_param_url}
		 * 
		 */		
		public function GetMapStatusService(url:String)
		{
			super(url);
		}
		
		sm_internal function get lastResult():GetMapStatusResult
		{
			return this._lastResult;
		}
		 
		/**
		 * ${iServerJava6R_GetMapStatusService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_GetMapStatusService_method_ProcessAsync_remarks}</p> 
		 * @param responder ${iServerJava6R_GetMapStatusService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_GetMapStatusService_method_ProcessAsync_return}
		 * 
		 */		
		public function processAsync(responder:IResponder = null):AsyncToken
		{ 
			var extendURL:String = ".json";
		 	if(this.url.charAt(this.url.length - 1) == "/")
			{ 
				this.url = this.url.substr(0, this.url.length - 1);
			} 
			return sendURL(extendURL, null, responder, this.handleDecodedObject);  	
		} 
	 
		sm_internal function handleDecodedObject(jsonObject:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = GetMapStatusResult.fromJson(jsonObject);
			for each(responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new GetMapStatusEvent(GetMapStatusEvent.PROCESS_COMPLETE, this._lastResult, jsonObject));//用事件派发结果
		}
	}
}