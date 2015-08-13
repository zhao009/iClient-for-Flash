package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.QueryEvent;
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
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.QueryEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_Query_QueryService_Title}.
	 * <p>${iServerJava6R_Query_QueryService_Description}</p> 
	 * 
	 */	
	public class QueryService extends ServiceBase
	{
		private var _lastResult:QueryResult;
		private var _queryParam:QueryParameters;
		
		/**
		 * ${iServerJava6R_Query_QueryService_constructor_string_D} 
		 * @param url ${iServerJava6R_Query_QueryService_constructor_string_param_url}
		 * 
		 */		
		public function QueryService(url:String=null)
		{
			super(url);
		}
		
		/**
		 * ${iServerJava6R_Query_QueryService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_Query_QueryService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_Query_QueryService_method_ProcessAsync_param_parameters}
		 * @param responder ${iServerJava6R_Query_QueryService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_Query_QueryService_method_ProcessAsync_return}
		 * 
		 */		
		public function processAsync(parameters:QueryParameters, responder:IResponder = null):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
         	var extendURL:String = "queryResults.json?returnContent=" + parameters.returnContent + "&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}
		  
            return sendURL(extendURL, getVariablesJson(parameters), responder, this.handleDecodedObject);	
		}
		
		sm_internal function getVariablesJson(parameters:QueryParameters):String
		{
			return null;
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			this._lastResult = QueryResult.fromJson(object);
			var responder:IResponder;
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
				
			this.dispatchEvent(new QueryEvent(QueryEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
			
		sm_internal function get lastResult():QueryResult
		{
			return this._lastResult;
		}
		
		
	}
}