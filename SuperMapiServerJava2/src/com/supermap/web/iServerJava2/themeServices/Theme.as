package com.supermap.web.iServerJava2.themeServices
{
	/**
	 * ${iServer2_themeServices_Theme_Title}.
	 * <p>${iServer2_themeServices_Theme_Description}</p> 
	 * @see ThemeType
	 * 
	 * 
	 */	
	public class Theme
	{
		private var _themeType:int;
		
		/**
		 * ${iServer2_themeServices_Theme_constructor_None_D} 
		 * 
		 */		
		public function Theme()
		{
			
		}
		
		/**
		 * ${iServer2_themeServices_Theme_attribute_themeType_D} 
		 * @see ThemeType
		 * 
		 */		
		public function set themeType(value:int):void
		{
			this._themeType = value;
		}
		
		public function get themeType():int
		{
			return this._themeType;
		}
	}
}