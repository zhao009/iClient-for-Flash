package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_QueryByBoundsService_Tile}.
	 * <p>${iServerJava6R_QueryByBoundsService_Description}</p> 
	 * 
	 */	
	public class QueryByBoundsService extends QueryService
	{
		/**
		 * ${iServerJava6R_QueryByBoundsService_string_constructor} 
		 * @param url ${iServerJava6R_QueryByBoundsService_string_constructor_param_url}
		 * 
		 */		
		public function QueryByBoundsService(url:String=null)
		{
			super(url);
		}
		
		sm_internal override  function getVariablesJson(parameters:QueryParameters):String
		{
			if(parameters)
				var queryByBoundsParam:QueryByBoundsParameters = parameters as QueryByBoundsParameters;
			
			var json:String = "";
			
			json += "\"queryMode\": \"BoundsQuery\",";
			
			json += "\"queryParameters\":" + queryByBoundsParam.toJson() + ",";
			
			if(queryByBoundsParam.bounds)
			{
				json += "\"bounds\":" + "{" + "\"leftBottom\":" + "{" + "\"x\":"+ queryByBoundsParam.bounds.left + "," +
					"\"y\":"+ queryByBoundsParam.bounds.bottom + "}" + "," + "\"rightTop\":" + "{" + "\"x\":"+ queryByBoundsParam.bounds.right + "," +
					"\"y\":"+ queryByBoundsParam.bounds.top + "}" + "}";
			}
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}