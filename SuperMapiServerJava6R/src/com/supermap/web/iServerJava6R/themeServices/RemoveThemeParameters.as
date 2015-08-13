package com.supermap.web.iServerJava6R.themeServices
{
	/**
	 * ${iServerJava6R_RemoveThemeParameters_Title}.
	 * <p>${iServerJava6R_RemoveThemeParameters_Description}</p> 
	 * 
	 */	
	public class RemoveThemeParameters
	{
		private var _id:String = "";
		
		/**
		 * ${iServerJava6R_RemoveThemeParameters_constructor_D} 
		 * 
		 */		
		public function RemoveThemeParameters()
		{
		}

		/**
		 * ${iServerJava6R_ThemeParameters_attribute_id_D} 
		 * @see ThemeResult
		 * @return 
		 * 
		 */		
		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value;
		}

	}
}