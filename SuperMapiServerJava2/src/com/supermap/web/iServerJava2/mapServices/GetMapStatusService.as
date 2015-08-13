package com.supermap.web.iServerJava2.mapServices
{
	import com.supermap.web.sm_internal;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;


	/**
	 * ${iServer2_getMapStatus_GetMapStatusService_Title}.
	 * <p>${iServer2_getMapStatus_GetMapStatusService_Description}</p>
	 * @see GetMapStatusParameters 
	 * @see GetMapStatusResult 
	 * 
	 * 
	 */	
	public class GetMapStatusService extends ServiceBase
	{
		private var _lastResult:GetMapStatusResult;
		
		/**
		 * ${iServer2_getMapStatus_GetMapStatusService_constructor_String_D} 
		 * @param url ${iServer2_getMapStatus_GetMapStatusService_constructor_String_param_url}
		 * 
		 */		
		public function GetMapStatusService(url:String = "")
		{
			super(url);
		}
		
		/**
		 * ${iServer2_getMapStatus_GetMapStatusService_attribute_lastResult_D} 
		 * @return 
		 * 
		 */		
		public function get lastResult():GetMapStatusResult
		{
			return this._lastResult;
		}
		
		/**
		 * ${iServer2_getMapStatus_GetMapStatusService_method_execute_D} 
		 * @param responder ${iServer2_getMapStatus_GetMapStatusService_method_execute_param_responder}
		 * @param mapStatusParameters ${iServer2_getMapStatus_GetMapStatusService_method_execute_param_GetMapStatusParameters}
		 * @return ${iServer2_getMapStatus_GetMapStatusService_method_execute_return_AsyncToken_D}
		 * 
		 */		
		public function execute(responder:IResponder, mapStatusParameters:GetMapStatusParameters):AsyncToken
		{
			if(!mapStatusParameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			var reqVar:URLVariables = new URLVariables();
            reqVar.mapName = mapStatusParameters.mapName;
            reqVar.method = "GetMapStatus";
            reqVar.params = "<uis>" + 
            		"<command>" + 
            			"<name>GetMapStatus</name>" + 
            			"<parameter>" + 
            				"<mapName>" + mapStatusParameters.mapName + "</mapName>" + 
            				"<mapServicesAddress>" + mapStatusParameters.mapServicesAddress + "</mapServicesAddress>" + 
            				"<mapServicesPort>" + mapStatusParameters.mapServicesPort + "</mapServicesPort>" + 
            				"<customParam></customParam>" + 
            			"</parameter>" + 
            		"</command>" + 
            		"</uis>";
            return sendURL("/commonhandler", reqVar, responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			 var responder:IResponder;
            this._lastResult = GetMapStatusResult.toMapStatusResult(object);
            for each (responder in asyncToken.responders)
            {
                responder.result(this._lastResult);
            }
		}
		
	}
}