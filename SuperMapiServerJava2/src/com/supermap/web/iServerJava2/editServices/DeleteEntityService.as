package com.supermap.web.iServerJava2.editServices
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
	 * ${iServer2_editServices_DeleteEntityService_Title}.
	 * <p>${iServer2_editServices_DeleteEntityService_Description}</p>
	 * 
	 * 
	 */
	public class DeleteEntityService extends ServiceBase
	{
		private var _lastResult:EditResult;
		/**
		 * ${iServer2_editServices_DeleteEntityService_constructor_String_D}
		 * @param url ${iServer2_editServices_DeleteEntityServicee_constructor_String_param_url}
		 * 
		 */
		public function DeleteEntityService(url:String = null)
		{
			super(url);
		}
		
		/**
		 * ${iServer2_editServices_DeleteEntityService_method_execute_D} 
		 * @param responder ${iServer2_editServices_DeleteEntityService_method_execute_param_responder}
		 * @param deleteEntityParameters {iServer2_editServices_DeleteEntityService_method_execute_param_parameters}
		 * @return ${iServer2_editServices_DeleteEntityService_method_execute_return}
		 * 
		 */
		public function execute(responder:IResponder, deleteEntityParameters:DeleteEntityParameters):AsyncToken
		{
			if(!deleteEntityParameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			
			var reqVar:URLVariables = new URLVariables();
            reqVar.mapName = deleteEntityParameters.mapName;
            reqVar.method = "DeleteEntity";
            reqVar.params = "<uis>" + 
            		"<command>" + 
            			"<name>DeleteEntity</name>" +
            			"<parameter>" +
	            			"<mapName>" + deleteEntityParameters.mapName + "</mapName>" + 
	            			"<layerName>" + deleteEntityParameters.layerName + "</layerName>" + 
	            			"<ids>[" + deleteEntityParameters.ids.join(",") + "]</ids>" +
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
            this._lastResult = EditResult.toEditResult(object);
            for each (responder in asyncToken.responders)
            {
                responder.result(this.lastResult);
            }
		}
		
		/**
		 * ${iServer2_editServices_DeleteEntityService_attribute_lastResult_D}
		 * 
		 */
		public function get lastResult():EditResult
		{
			return this._lastResult;
		}
	}
}