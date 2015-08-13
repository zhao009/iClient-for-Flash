package com.supermap.web.iServerJava6R.themeServices
{	
	import com.supermap.web.iServerJava6R.queryServices.ResourceInfo;
	import com.supermap.web.iServerJava6R.serviceEvents.ThemeEvent;
	import com.supermap.web.iServerJava6R.themeServices.ThemeParameters;
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
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.ThemeEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServer6R_themeServices_ThemeService_Title}.
	 * <p>${iServer6R_themeServices_ThemeService_Description}</p> 
	 * 
	 */	
	public class ThemeService extends ServiceBase
	{
		
		private var _lastResult:ThemeResult = new ThemeResult();		
		/**
		 * ${iServer6R_themeServices_ThemeService_constructor_String_D_as} 
		 * @param url ${iServer6R_themeServices_ThemeService_constructor_String_param_url}
		 * 
		 */		
		override public function ThemeService(url:String)
		{
			super(url);
		}
		
		/**
		 * ${iServer6R_themeServices_ThemeService_method_execute_D}.
		 * <p>${iServerJava6R_ThemeServices_method_execute_remarks}</p> 
		 * @param parameters ${iServer6R_themeServices_ThemeService_method_execute_param_parameters}
		 * @param responder ${iServer6R_themeServices_ThemeService_method_execute_param_responder}
		 * @return ${iServer6R_themeServices_ThemeService_method_execute_return_AsyncToken_D}
		 * 
		 */		
		public function processAsync(parameters:ThemeParameters, responder:IResponder = null):AsyncToken
		{			
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			
//			var reqVar:URLVariables = new URLVariables();
//			reqVar.type =  "\""+"UGC"+"\"";
//			reqVar.subLayers = parameters.toJSON();			
//			reqVar.name = "\""+this.GetServiceMapName()+"\"";
			var extendURL:String = "tempLayersSet.json?X-RequestEntity-ContentType=application/flex&flexAgent=true";
			
			var strJSON:String = "[{" +"type:" + "\""+"UGC"+"\"" + "," +  "subLayers:" + parameters.toJSON() + "," + "name:" + "\""+this.GetServiceMapName()+"\"" + "}]";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}			
			return sendURL(extendURL, strJSON, responder, this.handleDecodedObject);	
		}
		
		private function  GetServiceMapName():String
		{			
			var mapUrl:String = this.url;			
			var ary:Array = mapUrl.split("/");
			var mapName:String = ary[ary.length - 1];			
			return mapName;
		}
		
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;					
			this._lastResult = ThemeResult.fromJson(object);		
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new ThemeEvent(ThemeEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
		
		/**
		 * ${iServer6R_themeServices_ThemeService_attribute_themeResult_D} 
		 * @return 
		 * 
		 */		
		sm_internal function get lastResult():ThemeResult
		{
			return this._lastResult;
		}
	}
}