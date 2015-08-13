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
	 * ${iServer2_editServices_AddEntityService_Title}.
	 * <p>${iServer2_editServices_AddEntityService_Description}</p>
	 * @ see EditResult
	 * 
	 * 
	 */
	public class AddEntityService extends ServiceBase
	{
		private var _lastResult:EditResult;
		
		/**
		 * ${iServer2_editServices_AddEntityService_constructor_String_D} 
		 * @param url ${iServer2_editServices_AddEntityService_constructor_String_param_url}
		 * 
		 */
		public function AddEntityService(url:String=null)
		{
			super(url);
		}
		
		/**
		 * ${iServer2_editServices_AddEntityService_method_execute_D}
		 * @param responder ${iServer2_editServices_AddEntityService_method_execute_param_responder}
		 * @param addEntityParameters ${iServer2_editServices_AddEntityService_method_execute_param_parameters}
		 * @return ${iServer2_editServices_AddEntityService_method_execute_return}
		 * 
		 */
		public function execute(responder:IResponder, addEntityParameters:AddEntityParameters):AsyncToken
		{
			if(!addEntityParameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			
			var reqVar:URLVariables = new URLVariables();
            reqVar.mapName = addEntityParameters.mapName;
            reqVar.method = "AddEntity";
            reqVar.params = "<uis>" + 
            		"<command>" + 
            			"<name>AddEntity</name>" +
            			"<parameter>" +
	            			"<mapName>" + addEntityParameters.mapName + "</mapName>" + 
	            			"<layerName>" + addEntityParameters.layerName + "</layerName>" + 
	            			"<entities>" + addEntityParameters.entity.toJson() + "</entities>" +
	            			"<lockID>" + new Date().getTime() + "</lockID>" +
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
		 * ${iServer2_editServices_AddEntityService_attribute_lastResult_D}.
		 * <p>${iServer2_editServices_AddEntityService_attribute_lastResult_remarks}</p> 
		 * 
		 */		
		public function get lastResult():EditResult
		{
			return this._lastResult;
		}
				
	}
}