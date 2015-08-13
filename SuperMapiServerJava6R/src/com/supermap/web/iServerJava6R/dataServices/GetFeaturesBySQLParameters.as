package com.supermap.web.iServerJava6R.dataServices
{
	import com.supermap.web.iServerJava6R.FilterParameter;

	/**
	 * ${iServerJava6R_GetFeaturesBySQLParameters_Title}.
	 * <P>${iServerJava6R_GetFeaturesBySQLParameters_Description}</P> 
	 * 
	 */	
	public class GetFeaturesBySQLParameters extends GetFeaturesParametersBase
	{
		/**
		 * ${iServerJava6R_GetFeaturesBySQLParameters_constructor_D} 
		 * 
		 */		
		public function GetFeaturesBySQLParameters()
		{
		}
		private var _filterParameter:FilterParameter;

		/**
		 * ${iServerJava6R_GetFeaturesBySQLParameters_attribute_attributeFilter_D} 
		 * @return 
		 * 
		 */		
		public function get filterParameter():FilterParameter
		{
			return _filterParameter;
		}

		public function set filterParameter(value:FilterParameter):void
		{
			_filterParameter = value;
		}

	}
}