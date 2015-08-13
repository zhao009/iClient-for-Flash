package com.supermap.web.iServerJava2.networkAnalystServices
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
	 * ${iServer2_networkAnalystServices_FindPathService_Title}.
	 * <p>${iServer2_networkAnalystServices_FindPathService_Description}</p>
	 * @see NetworkAnalystResult
	 * 
	 * 
	 */
	public class FindPathService extends ServiceBase
	{
		private var _lastResult:NetworkAnalystResult;
		
		/**
		 * ${iServer2_networkAnalystServices_FindPathService_constructor_String_D} 
		 * @param url ${iServer2_networkAnalystServices_FindPathService_constructor_String_param_url}
		 * 
		 */
		public function FindPathService(url:String=null)
		{
			super(url);
		}
		
		/**
		 * ${iServer2_networkAnalystServices_FindPathService_attribute_lastResult_D}
		 * 
		 */
		public function get lastResult():NetworkAnalystResult
		{
			return this._lastResult;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_FindPathService_method_execute_D}
		 * @param responder ${iServer2_networkAnalystServices_FindPathService_method_execute_param_responder}
		 * @param parameters ${iServer2_networkAnalystServices_FindPathService_method_execute_param_parameters}
		 * @return ${iServer2_networkAnalystServices_FindPathService_method_ProcessAsync_return}
		 * 
		 */
		public function execute(responder:IResponder, parameters:FindPathParameters):AsyncToken
		{

			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			var reqVar:URLVariables = new URLVariables();
            reqVar.mapName = parameters.mapName;
            reqVar.method = "FindPath";
            reqVar.params = "<uis>" + 
            		"<command>" + 
            			"<name>FindPath</name>" +
            			"<parameter>" +
	            			"<mapName>" + parameters.mapName + "</mapName>" + 
	            			"<networkSetting>" + parameters.networkSetting.toJson() + "</networkSetting>" +
	            			"<pathParam>" + parameters.pathParam.toJson() + "</pathParam>" +
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
			if(object)
				 this._lastResult = NetworkAnalystResult.toNetworkAnalystResult(object);
            for each (responder in asyncToken.responders)
            {
                responder.result(this._lastResult);
            }
		}
		
	}
}