package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import com.supermap.web.iServerJava2.JoinItem;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_Query_QueryBySQLService_Title}.
	 * <br/> ${iServer2_Query_QueryBySQLService_Description} 
	 * 
	 * 
	 */	
	public class QueryBySqlService extends ServiceBase
	{
		
		private var _lastResult:ResultSet;
		
		/**
		 * ${iServer2_Query_QueryBySQLService_constructor_String_D_as} 
		 * @param url ${iServer2_Query_QueryBySQLService_constructor_String_param_url}
		 * 
		 */			
		public function QueryBySqlService(url:String = null)
		{
			super(url);
		}	
		
		/**
		 * ${iServer2_Query_QueryBySQLService_attribute_lastResult_D} 
		 * 
		 */		
		public function get lastResult():ResultSet
		{
			return this._lastResult;
		}
		  
		/**
		 * ${iServer2_Query_QueryBySQLService_method_execute_D} 
		 * @param responder ${iServer2_Query_QueryBySQLService_method_execute_param_responder}
		 * @param parameters ${iServer2_Query_QueryBySQLService_method_execute_param_parameters}
		 * @return ${iServer2_Query_QueryBySQLService_method_execute_return_AsyncToken_D}
		 * 
		 */		
		public function execute(responder:IResponder, parameters:QueryBySqlParameters):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			
			var jsonJoinItems:Array = new Array();
			var queryName:String;
			if(parameters.joinItems && parameters.joinItems.length >0)
			{
				queryName = "QueryBySqlAndJoin";
				for each(var joinItem:JoinItem in parameters.joinItems)
				{
					jsonJoinItems.push(JoinItem.toJson(joinItem));
				}
			}
			else
				queryName = "QueryBySql"
			
			var reqVar:URLVariables = new URLVariables();
            reqVar.mapName = parameters.mapName;
            reqVar.method = queryName;
			
            reqVar.params = "<uis>" + 
            		"<command>" + 
            			"<name>" + queryName + "</name>" +
            			"<parameter>" +
	            			"<mapName>" + parameters.mapName + "</mapName>" + 
	            			"<queryParam>" + parameters.queryParam.toQueryParam() + "</queryParam>" + 
							"<joinItems>"+"[" + jsonJoinItems.join(",") +"]"+ "</joinItems>" +
							"<needHighlight>"+parameters.isNeedHightlight+"</needHighlight>" + 
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
				 this._lastResult = ResultSet.toResultSet(object);
            for each (responder in asyncToken.responders)
            {
                responder.result(this._lastResult);
            }
		}		
		
		
	}
}