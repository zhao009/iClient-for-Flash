package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_RemoveThemesService_Title}.
	 * <p>${iServer2_themeServices_RemoveThemesService_Description}</p> 
	 * 
	 * 
	 */	
	public class RemoveThemesService extends ServiceBase
	{
		private var _removeResult:RemoveThemesResult;
		
		/**
		 * ${iServer2_themeServices_RemoveThemesService_constructor_String_D_as} 
		 * @param url ${iServer2_themeServices_RemoveThemesService_constructor_String_param_url}
		 * 
		 */		
		public function RemoveThemesService(url:String=null)
		{
			super(url);
		}		
		
		/**
		 * ${iServer2_themeServices_RemoveThemesService_method_execute_D} 
		 * @param responder ${iServer2_themeServices_RemoveThemesService_method_execute_param_responder}
		 * @param parameters ${iServer2_themeServices_RemoveThemesService_method_execute_param_parameters}
		 * @return ${iServer2_themeServices_RemoveThemesService_method_execute_return_AsyncToken_D}
		 * 
		 */		
		public function execute(responder:IResponder, parameters:RemoveThemesParameters):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			var reqVar:URLVariables = new URLVariables();
			reqVar.mapName = parameters.mapName;
			reqVar.method = "removeSuperMapLayers";
			var themeStr:String;
			
			reqVar.params = "<uis>" + 
				"<command>" + 
				"<name>" + "removeSuperMapLayers"+ "</name>" +
				"<parameter>" +
				"<mapName>" + parameters.mapName + "</mapName>" +
				"<layerNames>" + parameters.toJSON() + "</layerNames>" +
				"<customParam></customParam>" +
				"</parameter>" + 
				"</command>" + 
				"</uis>";
			
			return sendURL("/commonhandler", reqVar, responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			if(object)
				this._removeResult = new RemoveThemesResult();
			this._removeResult.layerKey = object.toString();
			
			for each (responder in asyncToken.responders)
			{
				responder.result(this._removeResult);
			}
		}
	}
}