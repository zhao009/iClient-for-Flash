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
	 * ${iServer2_getMapStatus_SetLayerStatusService_Title}.
	 * <p>${iServer2_getMapStatus_SetLayerStatusService_Description}</p> 
	 * 
	 * 
	 */	
	public class SetLayerStatusService extends ServiceBase
	{
		private var _lastResult:SetLayerStatusResult;
		/**
		 * ${iServer2_getMapStatus_SetLayerStatusService_constructor_String_D} 
		 * @param url ${iServer2_getMapStatus_SetLayerStatusService_constructor_String_param_url}
		 * 
		 */		
		public function SetLayerStatusService(url:String=null)
		{
			super(url);
		}
		
		/**
		 * ${iServer2_getMapStatus_SetLayerStatusService_attribute_lastResult_D} 
		 * @return 
		 * 
		 */		
		public function get lastResult():SetLayerStatusResult
		{
			return this._lastResult;
		}
		
		/**
		 * ${iServer2_getMapStatus_SetLayerStatusService_method_execute_D} 
		 * @param responder ${iServer2_getMapStatus_SetLayerStatusService_method_execute_param_responder}
		 * @param layerStatusParameters ${iServer2_getMapStatus_SetLayerStatusService_method_execute_param_SetLayerStatusParameters}
		 * @return ${iServer2_getMapStatus_SetLayerStatusService_method_execute_return_AsyncToken_D}
		 * 
		 */		
		public function execute(responder:IResponder, layerStatusParameters:SetLayerStatusParameters):AsyncToken
		{
			if(!layerStatusParameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			var reqVar:URLVariables = new URLVariables();
            reqVar.mapName = layerStatusParameters.mapName;
            reqVar.method = "setLayerStatus";
           	var jsonArray:Array =  layerStatusParameters.toJSONArray();
            reqVar.params = "<uis>" + 
            		"<command>" + 
            			"<name>setLayerStatus</name>" + 
            			"<parameter>" + 
            				"<mapName>" + layerStatusParameters.mapName + "</mapName>" + 
            				"<layerNames>" + jsonArray[0] + "</layerNames>" + 
            				"<visibleArgs>" + jsonArray[1] + "</visibleArgs>" + 
            				"<queryableArgs>" + jsonArray[2] + "</queryableArgs>" + 
            				"<customParam></customParam>" + 
            			"</parameter>" + 
            		"</command>" + 
            		"</uis>";
            return sendURL("/commonhandler", reqVar, responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			 var responder:IResponder;
            this._lastResult = SetLayerStatusResult.toSetLayerStatusResult(object);
            for each (responder in asyncToken.responders)
            {
                responder.result(this._lastResult);
            }
		}
		
	}
}