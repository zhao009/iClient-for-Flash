package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeUniqueParam_Title}.
	 * <p>${iServer2_themeServices_ThemeUniqueParam_Description}</p> 
	 * 
	 * 
	 */	
	public class ThemeUniqueParam
	{
		
		private var _layerName:String;		
		private  var _colorGradientType:int = ColorGradientType.YELLOW_GREEN;
		
		/**
		 * ${iServer2_themeServices_ThemeUniqueParam_constructor_None_D} 
		 * 
		 */		
		public function ThemeUniqueParam()
		{
		}		
		
		/**
		 * ${iServer2_themeServices_ThemeUniqueParam_attribute_layerName_D} 
		 * @return 
		 * 
		 */			
		public function get layerName():String
		{
			return _layerName;
		}

		public function set layerName(value:String):void
		{
			_layerName = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeUniqueParam_attribute_colorGradientType_D}
		 * @default ColorGradientType.YELLOW_GREEN
		 * @see ColorGradientType 
		 * @return 
		 * 
		 */		
		public function get colorGradientType():int
		{
			return _colorGradientType;
		}

		public function set colorGradientType(value:int):void
		{
			_colorGradientType = value;
		}

		sm_internal function toJSON():String
		{
			var json:String = "";			
			json += "\"colorGradientType\":" + this._colorGradientType + ",";
			if(this.layerName)
				json += "\"layerName\":" + "\"" + this.layerName + "\"";			
			if(json.length > 0)
				json = "{" + json + "}";
			return json;
		}
		
		sm_internal static function toThemeUniqueParam(object:Object):ThemeUniqueParam
		{
			var themeUniqueParam:ThemeUniqueParam;
			if(object)
			{
				themeUniqueParam = new ThemeUniqueParam();
				themeUniqueParam.layerName = object.layerName;
				themeUniqueParam.colorGradientType = object.clorGradientType;
			}
			return themeUniqueParam;
		}
		
		
	}
}