package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.EdgeWeightEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLRequestMethod;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.EdgeWeightEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_GetEdgeWeightService_Title}.
	 * <p>${iServerJava6R_GetEdgeWeightService_Description}</p> 
	 * @see EdgeWeightResult
	 * @see com.supermap.web.iServerJava6R.serviceEvents.EdgeWeightEvent
	 * 
	 */	
	public class UpdateEdgeWeightService extends ServiceBase
	{
		private var _lastResult:EdgeWeightResult;
		
		/**
		 * ${iServerJava6R_GetEdgeWeightService_constructor_D} 
		 * @param url ${iServerJava6R_GetEdgeWeightService_constructor_param_url}
		 * 
		 */		
		public function UpdateEdgeWeightService(url:String)
		{
			super(url);
		}
		 
		sm_internal function get lastResult():EdgeWeightResult
		{
			return _lastResult;
		}

		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = EdgeWeightResult.fromJson(object);//用fromJson进行转换
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new EdgeWeightEvent(EdgeWeightEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
		
		/**
		 * ${iServerJava6R_GetEdgeWeightService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_GetEdgeWeightService_method_ProcessAsync_remarks}</p> 
		 * @param responder ${iServerJava6R_GetEdgeWeightService_method_ProcessAsync_param_responder}
		 * @return ${iServerJava6R_GetEdgeWeightService_method_ProcessAsync_param_return}
		 * 
		 */	
		public function processAsync(parameters:EdgeWeightParameters, responder:IResponder = null):AsyncToken
		{		
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			//20/fromnode/26/tonode/109/weightfield/time.json 
			
			var extendURL:String ="edgeweight/"+ parameters.edgeID + "/fromnode/"+parameters.fromNodeID+"/tonode/"+parameters.toNodeID+"/weightfield/"+ parameters.weightField+".json?_method=PUT&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}  
			
			
			//var params:Object = {f: "text", value: parameters["weight"]};
			this.method = URLRequestMethod.POST;
			return sendURL(extendURL, parameters.weight.toString(), responder, this.handleDecodedObject);	
		}
		
		
	}
}