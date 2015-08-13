package com.supermap.web.iServerJava6R.themeServices
{
	/**
	 * ${iServer6R_themeServices_Theme_Title}.
	 * <p>${iServer6R_themeServices_Theme_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.layerServices.ThemeType
	 * 
	 */	
	public class Theme
	{
		private var _themeMemoryData:ThemeMemoryData;
		
		/**
		 * ${iServer6R_themeServices_Theme_constructor_None_D} 
		 * 
		 */		
		public function Theme()
		{
		}

		/**
		 * ${iServer6R_themeServices_Theme_attribute_themeMemoryData_D}.
		 * <p>${iServer6R_themeServices_Theme_attribute_themeMemoryData_remarks}</p> 
		 * @see ThemeGraph
		 * @see ThemeLabel
		 * @see ThemeRange
		 * @see ThemeUnique 
		 * @see ThemeDotDensity
		 * @return 
		 * 
		 */		
		public function get themeMemoryData():ThemeMemoryData
		{
			return _themeMemoryData;
		}

		public function set themeMemoryData(value:ThemeMemoryData):void
		{
			_themeMemoryData = value;
		}

	}
}