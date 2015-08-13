package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.RouteLocatorEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.RouteLocatorEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_RouteLocatorService_Title}.
	 * <p>${iServerJava6R_RouteLocatorService_Description}</p> 
	 * 
	 */	
	public class RouteLocatorService extends ServiceBase
	{
		private var _lastResult:RouteLocatorResult;
		/**
		 * ${iServerJava6R_RouteLocatorService_constructor_String_D} 
		 * @param url ${iServerJava6R_RouteLocatorService_constructor_param_url}
		 * 
		 */
		override public function RouteLocatorService(url:String)
		{
			super(url);
		}
		/**
		 * ${iServerJava6R_RouteLocatorService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_RouteLocatorService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_RouteLocatorService_method_ProcessAsync_param_parameters}
		 * @param responder ${iServerJava6R_RouteLocatorService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_RouteLocatorService_method_ProcessAsync_return} 
		 * 
		 */	
		public function processAsync(parameters:RouteLocatorParameters, responder:IResponder = null):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			
			var extendURL:String = "geometry/routelocator.json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
			if (parameters.dataset)
			{
				extendURL="datasets/"+ parameters.dataset + "/linearreferencing/routelocator.json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
				parameters.sourceRoute=null;
			}
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}
			return sendURL(extendURL, parameters.getVariablesJson(), responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = RouteLocatorResult.fromJson(object);
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new RouteLocatorEvent(RouteLocatorEvent.PROCESS_COMPLETE, this._lastResult, object));
		}

		sm_internal function get lastResult():RouteLocatorResult
		{
			return _lastResult;
		}
	}
}