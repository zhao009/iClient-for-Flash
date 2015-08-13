package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;
	
	use namespace sm_internal;
	
	
	
	/**
	 * ${iServerJava6R_QueryByDistanceService_Tile}.
	 * <p>${iServerJava6R_QueryByDistanceService_Description}</p> 
	 * 
	 */	
	public class QueryByDistanceService extends QueryService
	{
		/**
		 * ${iServerJava6R_QueryByDistanceService_string_constructor} 
		 * @param url ${iServerJava6R_QueryByDistanceService_string_constructor_param_url}
		 * 
		 */		
		public function QueryByDistanceService(url:String = null)
		{
			super(url);
		}
		
		sm_internal override  function getVariablesJson(parameters:QueryParameters):String
		{
			if(parameters)
				var queryByDistanceParam:QueryByDistanceParameters = QueryByDistanceParameters(parameters);
			
			var json:String = "";
			
			if(queryByDistanceParam.isNearest)
			{
				json += "\"queryMode\": \"FindNearest\",";
			}
			else
				json += "\"queryMode\": \"DistanceQuery\",";
			
			json += "\"queryParameters\":" + queryByDistanceParam.toJson() + ",";
			
			json += "\"geometry\":" + ServerGeometry.toJson(ServerGeometry.fromGeometry(queryByDistanceParam.geometry)) + ",";
			
			json += "\"distance\":" + queryByDistanceParam.distance;
                
			if(json.length > 0)
				json ="{" + json + "}";
			
            return json;
		}
		
	}
}

