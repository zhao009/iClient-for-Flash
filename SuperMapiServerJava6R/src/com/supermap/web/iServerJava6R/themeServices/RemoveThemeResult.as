package com.supermap.web.iServerJava6R.themeServices
{
	/**
	 * ${iServerJava6R_RemoveThemeResult_Title} .
	 * 
	 */	
	public class RemoveThemeResult
	{
		private var _succeed:Boolean;
		/**
		 * ${iServerJava6R_RemoveThemeResult_constructor_D} 
		 * 
		 */		
		public function RemoveThemeResult()
		{
		}

		/**
		 * ${iServerJava6R_RemoveThemeResult_attribute_succeed_D} 
		 * @param value
		 * 
		 */		
		public function set succeed(value:Boolean):void
		{
			_succeed = value;
		}

		public function get succeed():Boolean
		{
			return _succeed;
		}

	}
}