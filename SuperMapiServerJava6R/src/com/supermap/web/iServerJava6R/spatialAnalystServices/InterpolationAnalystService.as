package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;
	
	use namespace sm_internal;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.iServerJava6R.serviceEvents.InterpolationAnalystEvent;
	
	/**
	 * ${iServerJava6R_InterpolationAnalystSerivice_event_processComplete_D} 
	 */	
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.InterpolationAnalystEvent")]
	/**
	 * ${iServerJava6R_InterpolationAnalystSerivice_event_fault_D} 
	 */	
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_InterpolationAnalystSerivice_Title}.
	 * <p>${iServerJava6R_InterpolationAnalystSerivice_Description}</p> 
	 * 
	 */	
	public class InterpolationAnalystService extends ServiceBase
	{
		private var _lastResult:InterpolationAnalystResult;
		
		/**
		 * ${iServerJava6R_InterpolationAnalystSerivice_constructor_String_D} 
		 * @param url ${iServerJava6R_InterpolationAnalystSerivice_constructor_param_url}
		 * 
		 */		
		override public function InterpolationAnalystService(url:String = null)
		{
			super(url);
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystSerivice_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_InterpolationAnalystSerivice_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_InterpolationAnalystSerivice_method_ProcessAsync_param_parameters}
		 * @param responder ${iServerJava6R_InterpolationAnalystSerivice_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_InterpolationAnalystSerivice_method_ProcessAsync_return}
		 * @see com.supermap.web.iServerJava6R.serviceEvents.InterpolationAnalystEvent
		 * 
		 */		
		public function processAsync(parameters:InterpolationAnalystParameters, responder:IResponder = null):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			var extendURL:String;
			if(parameters is InterpolationDensityAnalystParameters)
			{
				if(parameters.InterpolationAnalystType == "dataset")
				{
					extendURL = "datasets/" + parameters.dataset + "/interpolation/density.json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
				}
				if(parameters.InterpolationAnalystType == "geometry")
				{
					extendURL = "geometry/interpolation/density.json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
				}				
			}
			if(parameters is InterpolationIDWAnalystParameters)
			{
				if(parameters.InterpolationAnalystType == "dataset")
				{
					extendURL = "datasets/" + parameters.dataset + "/interpolation/idw.json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
				}
				if(parameters.InterpolationAnalystType == "geometry")
				{
					extendURL = "geometry/interpolation/idw.json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
				}
			}
			if(parameters is InterpolationRBFAnalystParameters)
			{
				if(parameters.InterpolationAnalystType == "dataset")
				{
					extendURL = "datasets/" + parameters.dataset + "/interpolation/rbf.json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
				}
				if(parameters.InterpolationAnalystType == "geometry")
				{
					extendURL = "geometry/interpolation/rbf.json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
				}				
			}
			if(parameters is InterpolationKrigingAnalystParameters)
			{
				if(parameters.InterpolationAnalystType == "dataset")
				{
					extendURL = "datasets/" + parameters.dataset + "/interpolation/kriging.json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
				}
				if(parameters.InterpolationAnalystType == "geometry")
				{
					extendURL = "geometry/interpolation/kriging.json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
				}
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
			this._lastResult = InterpolationAnalystResult.fromJson(object);
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			
			this.dispatchEvent(new InterpolationAnalystEvent(InterpolationAnalystEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
		
		sm_internal function get lastResult():InterpolationAnalystResult
		{
			return _lastResult;
		}
		
	}
}