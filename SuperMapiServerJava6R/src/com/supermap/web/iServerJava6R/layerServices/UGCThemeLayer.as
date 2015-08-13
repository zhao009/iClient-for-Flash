package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.iServerJava6R.themeServices.Theme;

	/**
	 * ${iServerJava6R_UGCThemeLayer_Title}. 
	 * 
	 */	
	public class UGCThemeLayer extends UGCLayer
	{ 
		private var _theme:Theme;
		private var _themeType:String;
		
		/**
		 * ${iServerJava6R_UGCThemeLayer_constructor_D} 
		 * 
		 */		
		public function UGCThemeLayer()
		{
		}

		/**
		 * ${iServerJava6R_UGCThemeLayer_attribute_ThemeType_D} 
		 * @see ThemeType
		 * @return 
		 * 
		 */		
		public function get themeType():String
		{
			return _themeType;
		}

		public function set themeType(value:String):void
		{
			_themeType = value;
		}

		/**
		 * ${iServerJava6R_UGCThemeLayer_attribute_Theme_D} 
		 * @return 
		 * 
		 */		
		public function get theme():Theme
		{
			return _theme;
		}

		public function set theme(value:Theme):void
		{
			_theme = value;
		}

	}
}