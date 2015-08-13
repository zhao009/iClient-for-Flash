package com.supermap.web.iServerJava2.queryServices
{
	
	/**
	 * ${iServer2_QueryBySqlParameters_Title}. 
	 * <br/> ${iServer2_QueryBySqlParameters_Description_as}
	 * 
	 * 
	 */	
	public class QueryBySqlParameters extends QueryParametersBase
	{
		private var _joinItems:Array = new Array();
		/**
		 * ${iServer2_QueryBySqlParameters_constructor_D_as} 
		 * @param mapName ${iServer2_QueryBySqlParameters_constructor_param_mapName_D}
		 * @param queryParam ${iServer2_QueryBySqlParameters_constructor_param_queryParam_D}
		 * 
		 */		
		public function QueryBySqlParameters(mapName:String = null, queryParam:QueryParam = null)
		{
			super(mapName, queryParam);
		}		

		/**
		 * ${iServer2_QueryBySqlParameters_attribute_joinItems_D} 
		 * @see com.supermap.web.iServerJava2.JoinItem
		 * @return 
		 * 
		 */		
		public function get joinItems():Array
		{
			return _joinItems;
		}

		public function set joinItems(value:Array):void
		{
			_joinItems = value;
		}

	}
}