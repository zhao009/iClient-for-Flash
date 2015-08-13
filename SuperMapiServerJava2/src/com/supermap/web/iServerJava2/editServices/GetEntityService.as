package com.supermap.web.iServerJava2.editServices
{
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	use namespace sm_internal;

	/**
	 * ${iServer2_editServices_GetEntityService_Title}.
	 * <p>${iServer2_editServices_GetEntityService_Description}</p>
	 * 
	 * 
	 */
	public class GetEntityService extends ServiceBase
	{
		private var _lastResult:Entity;
		/**
		 * ${iServer2_editServices_GetEntityService_constructor_String_D}
		 * @param url ${iServer2_editServices_GetEntityService_constructor_String_param_url}
		 * 
		 */
		public function GetEntityService(url:String=null)
		{
			super(url);
		}
		
		/**
		 * ${iServer2_editServices_GetEntityService_method_execute_D}
		 * @param responder ${iServer2_editServices_GetEntityService_method_execute_param_responder}
		 * @param getEntityParameters ${iServer2_editServices_GetEntityService_method_execute_param_parameters}
		 * @return ${iServer2_editServices_GetEntityService_method_execute_return}
		 * 
		 */
		public function execute(responder:IResponder, getEntityParameters:GetEntityParameters):AsyncToken
		{
			if(!getEntityParameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			
			var reqVar:URLVariables = new URLVariables();
            reqVar.mapName = getEntityParameters.mapName;
            reqVar.method = "GetEntity";
            reqVar.params = "<uis>" + 
            		"<command>" + 
            			"<name>GetEntity</name>" +
            			"<parameter>" +
	            			"<mapName>" + getEntityParameters.mapName + "</mapName>" + 
	            			"<layerName>" + getEntityParameters.layerName + "</layerName>" + 
	            			"<id>" + getEntityParameters.id + "</id>" +
	            			"<needHighlight>false</needHighlight>" + 
	            			"<customParam></customParam>" +
            			"</parameter>" + 
            		"</command>" + 
            		"</uis>";
            return sendURL("/commonhandler", reqVar, responder, this.handleDecodedObject); 
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
            this._lastResult = Entity .toEntity(object);
            for each (responder in asyncToken.responders)
            {
                responder.result(this.lastResult);
            }
		}
		
		/**
		 * ${iServer2_editServices_GetEntityService_attribute_lastResult_D}
		 * 
		 */
		public function get lastResult():Entity
		{
			return this._lastResult;
		}
	}
}