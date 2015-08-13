package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_QueryBySQlService_Tile}.
	 * <p>${iServerJava6R_QueryBySQlService_Description}</p> 
	 * @see QueryBySQLParameters
	 * 
	 */	
	public class QueryBySQLService extends QueryService
	{
		/**
		 * ${iServerJava6R_QueryBySQlService_constructor_string_url}.
		 * <p>${iServerJava6R_QueryBySQlService_string_constructor_param_url}</p> 
		 * @param url
		 * 
		 */		
		public function QueryBySQLService(url:String = null)
		{
			super(url);
		}
		
		sm_internal override  function getVariablesJson(parameters:QueryParameters):String
		{
			var json:String = "";
			
			json += "\"queryMode\": \"SqlQuery\",";
			
			json += "\"queryParameters\":" + parameters.toJson();
			
			json ="{" + json + "}";
			
			return json;
		}
	}
	
	
}