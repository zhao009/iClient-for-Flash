package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_QueryByGeometryService_Tile}.
	 * <p>${iServerJava6R_QueryByGeometryService_Description}</p> 
	 * @see QueryByGeometryParameters
	 * 
	 */	
	public class QueryByGeometryService extends QueryService
	{
		/**
		 * ${iServerJava6R_QueryByGeometryService_string_constructor} 
		 * @param url ${iServerJava6R_QueryByGeometryService_string_constructor_param_url}
		 * 
		 */		
		public function QueryByGeometryService(url:String = null)
		{
			super(url);
		}
		
		sm_internal override  function getVariablesJson(parameters:QueryParameters):String
		{
			if(parameters)
				var queryByGeometryParam:QueryByGeometryParameters = QueryByGeometryParameters(parameters);
			
			var json:String = "";
			
			json += "\"queryMode\": \"SpatialQuery\",";
			
			json += "\"queryParameters\":" + queryByGeometryParam.toJson() + ",";
			
			json += "\"geometry\":" + ServerGeometry.toJson(ServerGeometry.fromGeometry(queryByGeometryParam.geometry)) + ",";
			
			json += "\"spatialQueryMode\":" + queryByGeometryParam.spatialQueryMode;
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}