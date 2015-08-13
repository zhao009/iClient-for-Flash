package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.iServerJava2.ServerGeometry;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_Query_QueryByGeometryService_Title}. 
	 * <br/> ${iServer2_Query_QueryByGeometryService_Description}
	 * 
	 * 
	 */	
	public class QueryByGeometryService extends ServiceBase
	{
		private var _lastResult:ResultSet;
		
		/**
		 * ${iServer2_Query_QueryByGeometryService_constructor_String_D_as} 
		 * @param url ${iServer2_Query_QueryByGeometryService_constructor_String_param_url}
		 * 
		 */		
		public function QueryByGeometryService(url:String = null)
		{
			super(url);
		}
		
		/**
		 * ${iServer2_Query_QueryByGeometryService_attribute_lastResult_D} 
		 * 
		 */		
		public function get lastResult():ResultSet
		{
			return this._lastResult;
		}
		
		/**
		 * ${iServer2_Query_QueryByGeometryService_method_execute_D} 
		 * @param responder ${iServer2_Query_QueryByGeometryService_method_execute_param_responder}
		 * @param parameters ${iServer2_Query_QueryByGeometryService_method_execute_param_parameters}
		 * @return ${iServer2_Query_QueryByGeometryService_method_execute_return_AsyncToken_D}
		 *  
		 */			 
		public function execute(responder:IResponder, parameters:QueryByGeometryParameters):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			var reqVar:URLVariables = new URLVariables();
            reqVar.mapName = parameters.mapName;
            reqVar.method = parameters.queryType;
            reqVar.params = "<uis>" + 
            		"<command>" + 
            			"<name>" + parameters.queryType + "</name>" +
            			"<parameter>" +
	            			"<mapName>" + parameters.mapName + "</mapName>" ;
	            			
	       	if(parameters.geometry is GeoPoint)
	       		 reqVar.params += "<point>" + ServerGeometry.fromGeoPoint(parameters.geometry as GeoPoint) + "</point>" +
	       		 				  "<tolerance>0</tolerance>";
	       	else if(parameters.geometry is GeoLine) 
	       		 reqVar.params += "<points>" + ServerGeometry.fromGeoLine(parameters.geometry as GeoLine) + "</points>";
			
			else
				reqVar.params += "<points>" + ServerGeometry.fromGeoRegion(parameters.geometry as GeoRegion) + "</points>";
	       		 
	        reqVar.params += "<queryParam>" + parameters.queryParam.toQueryParam() + "</queryParam>" + 
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