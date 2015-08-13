package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeResult_Title}.
	 * ${iServer2_themeServices_ThemeResult_Description} 
	 * 
	 * 
	 */	
	public class ThemeResult
	{
		private var _name:String;
		private var _key:String;		
		
		/**
		 * @private
		 * ${iServer2_themeServices_ThemeResult_constructor_None_D} 
		 * 
		 */		
		public function ThemeResult()
		{
			
		}
		
		/**
		 * ${iServer2_themeServices_ThemeResult_attribute_name_D} 
		 * @return 
		 * 
		 */		
		public function get name():String
		{
			return this._name;
		}
		
		/**
		 * ${iServer2_themeServices_ThemeResult_attribute_key_D} 
		 * @return 
		 * 
		 */		
		public function get key():String
		{
			return this._key;
		}
		
		
		sm_internal static function toThemeResult(object:Object):ThemeResult
		{
			var themeResult:ThemeResult = new ThemeResult();
			var tempResult:Array = object.toString().split(",");
			
			themeResult._name = tempResult[0];
			themeResult._key = tempResult[1];
			
			return themeResult;
		}
	}
}