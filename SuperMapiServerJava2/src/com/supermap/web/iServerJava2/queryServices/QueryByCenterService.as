package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	import com.supermap.web.iServerJava2.ServerGeometry;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_Query_QueryByCenterService_Title}.
	 * <br/> ${iServer2_Query_QueryByCenterService_Description}
	 * 
	 * 
	 */	
	public class QueryByCenterService extends ServiceBase
	{	
		private var _lastResult:ResultSet;
		
		/**
		 * ${iServer2_Query_QueryByCenterService_constructor_String_D_as} 
		 * @param url ${iServer2_Query_QueryByCenterService_constructor_String_param_url}
		 * 
		 */		
		public function QueryByCenterService(url:String = null)
		{
			super(url);
		}
		
		/**
		 * ${iServer2_Query_QueryByCenterService_attribute_lastResult_D} 
		 * 
		 */		
		public function get lastResult():ResultSet
		{
			return this._lastResult;
		}
		
		/**
		 * ${iServer2_Query_QueryByCenterService_method_execute_D} 
		 * @param responder ${iServer2_Query_QueryByCenterService_method_execute_param_responder}
		 * @param parameters ${iServer2_Query_QueryByCenterService_method_execute_param_parameters}
		 * @return ${iServer2_Query_QueryByCenterService_method_execute_return_AsyncToken_D}
		 * 
		 */		
		public function execute(responder:IResponder, parameters:QueryByCenterParameters ):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			var queryType:String = parameters.isNearest ? "FindNearest" : "QueryByPoint";
			
			var reqVar:URLVariables = new URLVariables();
            reqVar.mapName = parameters.mapName;
            reqVar.method = queryType;
                        	
            reqVar.params = "<uis>" + 
            		"<command>" + 
            			"<name>" + queryType + "</name>" +
            			"<parameter>" +
	            			"<mapName>" + parameters.mapName + "</mapName>" + 
	            			"<point>" + ServerGeometry.fromGeoPoint(parameters.center) + "</point>" +
	            			"<tolerance>" + parameters.tolerance.toString() + "</tolerance>" +  
	            			"<queryParam>" + parameters.queryParam.toQueryParam() + "</queryParam>" + 
							"<needHighlight>"+parameters.isNeedHightlight+"</needHighlight>"+ 
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