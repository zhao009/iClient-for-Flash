package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.RemoveThemeEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.RemoveThemeEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	
	/**
	 * ${iServerJava6R_RemoveThemeService_Title}.
	 * <p>${iServerJava6R_RemoveThemeService_Description}</p> 
	 * 
	 */	
	public class RemoveThemeService extends ServiceBase
	{		
		private var _lastResult:RemoveThemeResult = new RemoveThemeResult();
		/**
		 * ${iServerJava6R_RemoveThemeService_constructor_D} 
		 * @param url ${iServerJava6R_RemoveThemeService_constructor_param_url}
		 * 
		 */		
		override public function RemoveThemeService(url:String)
		{
			super(url);
		}

		sm_internal function get lastResult():RemoveThemeResult
		{
			return _lastResult;
		}
		
		/**
		 * ${iServerJava6R_RemoveThemeService_method_execute_D}.
		 * <p>${iServerJava6R_RemoveThemeService_method_execute_remarks}</p> 
		 * @param parameters ${iServerJava6R_RemoveThemeService_method_execute_param_parameters}
		 * @param responder ${iServerJava6R_RemoveThemeService_method_execute_param_responder}
		 * @return ${iServerJava6R_RemoveThemeService_method_execute_return_AsyncToken_D}
		 * 
		 */		
		public function processAsync(parameters:RemoveThemeParameters, responder:IResponder = null):AsyncToken
		{			
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
	
			var layersID:String = parameters.id;
			var extendURL:String = "/tempLayersSet/" + layersID + ".json?_method=DELETE&X-RequestEntity-ContentType=application/flex";
						
			return sendURL(extendURL, null, responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult.succeed = object.succeed as Boolean;
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			
			this.dispatchEvent(new RemoveThemeEvent(RemoveThemeEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
	}
}