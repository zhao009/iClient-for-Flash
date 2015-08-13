package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
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
	 * ${iServer2_BufferQueryService_Title}.
	 * <p>${iServer2_BufferQueryService_Description}</p>
	 * 
	 * 
	 */
	public class BufferQueryService extends ServiceBase
	{
		private var _lastResult:ResultSet;
		
		/**
		 * ${iServer2_BufferQueryService_constructor_String_D_as}
		 * @param url ${iServer2_BufferQueryService_constructor_String_param_url}
		 */
		
		public function BufferQueryService(url:String=null)
		{
			super(url);
		}
		
		/**
		 * ${iServer2_BufferQueryService_attribute_lastResult_D} 
		 * 
		 */
		public function get lastResult():ResultSet
		{
			return this._lastResult;
		}
		
		/**
		 * ${iServer2_BufferQueryService_method_ProcessAsync_D} 
		 * @param responder ${iServer2_BufferQueryService_method_execute_param_responder}
		 * @param parameters ${iServer2_BufferQueryService_method_ProcessAsync_param_parameters}
		 * @return ${iServer2_BufferQueryService_method_execute_return_AsyncToken_D}
		 */
		public function execute(responder:IResponder, parameters:BufferQueryParameters):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			var pointStr:String;
			var queryMethod:String;
			if(parameters.geometry is GeoPoint)
			{
				queryMethod = "PointBufferQuery";
				
				pointStr = "<point>" + ServerGeometry.fromGeoPoint(parameters.geometry as GeoPoint) + "</point>";
			}
			else if(parameters.geometry is GeoLine)
			{
				queryMethod = "LineBufferQuery";
				
				pointStr = "<points>" + ServerGeometry.fromGeoLine(parameters.geometry as GeoLine) + "</points>";
			}
			else
			{
				queryMethod = "PolygonBufferQuery";
				
				pointStr = "<points>" +  ServerGeometry.fromGeoRegion(parameters.geometry as GeoRegion) + "</points>";
			}
			
			var reqVar:URLVariables = new URLVariables();
            reqVar.mapName = parameters.mapName;
            reqVar.method = queryMethod;
            reqVar.params = "<uis>" + 
            		"<command>" + 
            			"<name>" + queryMethod + "</name>" +
            			"<parameter>" +
	            			"<mapName>" + parameters.mapName + "</mapName>" + 
	            			pointStr +
	            			"<bufferParam>" + parameters.bufferParam.toBufferAnalystParam() + "</bufferParam>" + 
	            			"<queryMode>" + parameters.queryMode.toString() + "</queryMode>" + 
	            			"<queryParam>" + parameters.queryParam.toQueryParam() + "</queryParam>" + 
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