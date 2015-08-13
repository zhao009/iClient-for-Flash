package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.SurfaceAnalystEvent;
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
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.SurfaceAnalystEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_SurfaceAnalystService_Title}.
	 * <p>${iServerJava6R_SurfaceAnalystService_Description}</p> 
	 * 
	 */	
	public class SurfaceAnalystService extends ServiceBase
	{
		private var _lastResult:SurfaceAnalystResult;
		
		/**
		 * ${iServerJava6R_SurfaceAnalystService_constructor_String_D}
		 * @param url ${iServerJava6R_SurfaceAnalystService_constructor_param_url}
		 * 
		 */		
		override public function SurfaceAnalystService(url:String)
		{
			super(url);
		}
		
		/**
		 * ${iServerJava6R_SurfaceAnalystService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_SurfaceAnalystService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_SurfaceAnalystService_method_ProcessAsync_param_parameters}
		 * @param responder ${iServerJava6R_SurfaceAnalystService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_SurfaceAnalystService_method_ProcessAsync_return}
		 * 
		 */		
		public function processAsync(parameters:SurfaceAnalystParameters, responder:IResponder = null):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			var extendURL:String;
			var reqVarJson:String;
			
			if(parameters is DatasetSurfaceAnalystParameters)
			{
				var datasetParams:DatasetSurfaceAnalystParameters = parameters as DatasetSurfaceAnalystParameters;
				extendURL = "datasets/" + datasetParams.dataset + "/" + datasetParams.surfaceAnalystMethod.toLowerCase() + ".json?returnContent=true&X-RequestEntity-ContentType=application/flex&debug=true";
				reqVarJson = datasetParams.getVariablesJson();
			}
			else
			{
				var geometryParams:GeometrySurfaceAnalystParameters = parameters as GeometrySurfaceAnalystParameters;
				extendURL = "geometry/" + geometryParams.surfaceAnalystMethod.toLowerCase() + ".json?returnContent=true&X-RequestEntity-ContentType=application/flex&flexAgent=true";
				reqVarJson = geometryParams.getVariablesJson();
			}
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}
			return sendURL(extendURL, reqVarJson, responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = SurfaceAnalystResult.fromJson(object);
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new SurfaceAnalystEvent(SurfaceAnalystEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
		
		sm_internal function get lastResult():SurfaceAnalystResult
		{
			return _lastResult;
		}

	}
}