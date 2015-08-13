package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.DatasetBufferAnalystEvent;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import flash.net.URLVariables;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.DatasetBufferAnalystEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_DatasetBufferAnalystService_Title}.
	 * <p>${iServerJava6R_DatasetBufferAnalystService_Description}</p> 
	 * 
	 */	
	public class DatasetBufferAnalystService extends ServiceBase
	{
		private var _lastResult:DatasetBufferAnalystResult;
		/**
		 * ${iServerJava6R_DatasetBufferAnalystService_constructor_overloads_D} 
		 * @param url ${iServerJava6R_DatasetBufferAnalystService_constructor_param_url}
		 * 
		 */		
		override public function DatasetBufferAnalystService(url:String)
		{
			super(url);
		}
		
		/**
		 * ${iServerJava6R_DatasetBufferAnalystService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_DatasetBufferAnalystService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_DatasetBufferAnalystService_method_ProcessAsync_param_parameters}
		 * @param responder ${iServerJava6R_DatasetBufferAnalystService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_DatasetBufferAnalystService_method_ProcessAsync_return}
		 * 
		 */		
		public function processAsync(parameters:DatasetBufferAnalystParameters, responder:IResponder = null):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			
			var extendURL:String = "datasets/" + parameters.dataset + "/buffer.json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}
			return sendURL(extendURL, parameters.getVariablesJson(), responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = DatasetBufferAnalystResult.toDatasetBufferAnalystResult(object);
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new DatasetBufferAnalystEvent(DatasetBufferAnalystEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
	
		sm_internal function get lastResult():DatasetBufferAnalystResult
		{
			return _lastResult;
		}
	}
}