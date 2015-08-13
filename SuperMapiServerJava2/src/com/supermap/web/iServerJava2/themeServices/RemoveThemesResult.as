package com.supermap.web.iServerJava2.themeServices
{
	/**
	 * ${iServer2_themeServices_RemoveThemesResult_Title}.
	 * <p>${iServer2_themeServices_RemoveThemesResult_Description}</p> 
	 * 
	 * 
	 */	
	public class RemoveThemesResult
	{
		private var _layerKey:String;
		
		/**
		 * @private
		 * ${iServer2_themeServices_RemoveThemesResult_constructor_None_D} 
		 * 
		 */		
		public function RemoveThemesResult()
		{
			
		}

		/**
		 * ${iServer2_themeServices_RemoveThemesResult_attribute_layerKey_D} 
		 * @return 
		 * 
		 */		
		public function get layerKey():String
		{
			return _layerKey;
		}

		public function set layerKey(value:String):void
		{
			_layerKey = value;
		}

	}
}