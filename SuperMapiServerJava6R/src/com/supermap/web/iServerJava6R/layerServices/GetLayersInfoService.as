package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.GetLayersInfoEvent;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.GetLayersInfoEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_GetLayersInfoService_Title}.
	 * <p>${iServerJava6R_GetLayersInfoService_Description}</p> 
	 * 
	 */	
	public class GetLayersInfoService extends ServiceBase
	{
		private var _result:GetLayersInfoResult;
		/**
		 * ${iServerJava6R_GetLayersInfoService_constructor_String_D} 
		 * @param url ${iServerJava6R_GetLayersInfoService_constructor_String_param_url}
		 * 
		 */		
		public function GetLayersInfoService(url:String)
		{
			super(url);
		}

		sm_internal function get result():GetLayersInfoResult
		{
			return _result;
		} 
		
		/**
		 * ${iServerJava6R_GetLayersInfoService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_GetLayersInfoService_method_ProcessAsync_remarks}</p> 
		 * @param responder ${iServerJava6R_GetLayersInfoService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_GetLayersInfoService_method_ProcessAsync_return}
		 * 
		 */		
		public function processAsync(responder:IResponder):AsyncToken
		{ 
			var extendURL:String = "layers.json?X-RequestEntity-ContentType=application/flex";
			if(this.url.charAt(this.url.length - 1) != "/")//如果url不以“/”结尾，则添加一个“/”
			{
				extendURL = "/" + extendURL;
			} 
			return sendURL(extendURL, null, responder, this.handleDecodedObject);  	
		} 
		
		private function handleDecodedObject(jsonObject:Object, asyncToken:AsyncToken):void
		{ 
			var responder:IResponder;
			this._result = GetLayersInfoResult.fromJson(jsonObject);
			for each(responder in asyncToken.responders)
			{
				responder.result(this._result);
			}
			this.dispatchEvent(new GetLayersInfoEvent(GetLayersInfoEvent.PROCESS_COMPLETE, this._result, jsonObject));//用事件派发结果
		}
	}
}