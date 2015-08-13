package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.iServerJava2.ParametersBase;
	
	/**
	 * ${iServer2_themeServices_ThemeParameters_Title}.
	 * <p>${iServer2_themeServices_ThemeParameters_Description}</p> 
	 * 
	 * 
	 */	
	public class ThemeParameters extends ParametersBase
	{
		private var _theme:Theme;
		private var _layerName:String;
		private var _index:int = 0;
		private var _joinItems:Array = new Array();
		
		/**
		 * ${iServer2_themeServices_ThemeParameters_constructor_D} 
		 * @param mapName ${iServer2_themeServices_ThemeParameters_constructor_param_mapName_D}
		 * 
		 */		
		public function ThemeParameters(mapName:String=null)
		{
			super(mapName);
		}
		
		/**
		 * ${iServer2_themeServices_ThemeParameters_attribute_joinItems_D}
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

		/**
		 * ${iServer2_themeServices_ThemeParameters_attribute_index_D} 
		 * @return 
		 * 
		 */		
		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeParameters_attribute_theme_D} 
		 * @return 
		 * 
		 */		
		public function get theme():Theme
		{
			return this._theme;
		}
		public function set theme(value:Theme):void
		{
			this._theme = value;
		}
		
		/**
		 * ${iServer2_themeServices_ThemeParameters_attribute_layerName_D} 
		 * 
		 */	
		public function get layerName():String
		{
			return this._layerName;
		}
		public function set layerName(value:String):void
		{
			this._layerName = value;
		}
	}
}