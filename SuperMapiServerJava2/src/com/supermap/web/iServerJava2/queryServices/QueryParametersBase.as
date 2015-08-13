package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.iServerJava2.ParametersBase;
	
	/**
	 * ${iServer2_queryParamertersBase_Title}. 
	 * <br/> ${iServer2_queryParamertersBase_Description_as}
	 * 
	 * 
	 */	
	public class QueryParametersBase extends ParametersBase
	{
		private var _queryParam:QueryParam;
		private var _isNeedHightlight:Boolean;
		
		
		/**
		 * ${iServer2_QueryParamertersBase_constructor_D} 
		 * @param mapName ${iServer2_QueryParamertersBase_constructor_param_mapName}
		 * @param queryParam ${iServer2_QueryParamertersBase_constructor_param_queryParam}
		 * 
		 */		
		public function QueryParametersBase(mapName:String = null, queryParam:QueryParam = null)
		{
			super(mapName);
			this.queryParam = queryParam;
			this._isNeedHightlight = false;
		}
		
		/**
		 * ${iServer2_queryParamertersBase_attribute_isNeedHightlight_D} 
		 * @return 
		 * 
		 */		
		public function get isNeedHightlight():Boolean
		{
			return _isNeedHightlight;
		}

		public function set isNeedHightlight(value:Boolean):void
		{
			_isNeedHightlight = value;
		}

		/**
		 * ${iServer2_queryParamertersBase_attribute_QueryParam_D} 
		 */
		public function get queryParam():QueryParam
		{
			return _queryParam;
		}

		public function set queryParam(value:QueryParam):void
		{
			_queryParam = value;
		}

	}
}