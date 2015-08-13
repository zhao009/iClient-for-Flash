package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeRangeParam_Title}.
	 * <p>${iServer2_themeServices_ThemeRangeParam_Description}</p> 
	 * 
	 * 
	 */	
	public class ThemeRangeParam
	{
		private var _layerName:String;		
		private var _colorGradientType:int = ColorGradientType.YELLOW_GREEN;		
		private var _rangeMode:int = RangeMode.EQUAL_INTERVAL;		
		private var _rangeParameter:Number = 3;
		
		/**
		 * ${iServer2_themeServices_ThemeRangeParam_constructor_None_D} 
		 * 
		 */		
		public function ThemeRangeParam()
		{
		}
		
		/**
		 * ${iServer2_themeServices_ThemeRangeParam_attribute_rangeParameter_D} 
		 * @default 3
		 * @return 
		 * 
		 */		
		public function get rangeParameter():Number
		{
			return _rangeParameter;
		}

		public function set rangeParameter(value:Number):void
		{
			_rangeParameter = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeRangeParam_attribute_rangeMode_D}.
		 * <p>${iServer2_themeServices_ThemeRangeParam_attribute_rangeMode_remarks}</p> 
		 * @see RangeMode
		 * @return 
		 * 
		 */		
		public function get rangeMode():int
		{
			return _rangeMode;
		}

		public function set rangeMode(value:int):void
		{
			_rangeMode = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeRangeParam_attribute_colorGradientType_D} 
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

		/**
		 * ${iServer2_themeServices_ThemeRangeParam_attribute_layerName_D} 
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

		sm_internal function toJSON():String
		{
			var json:String = "";
			
			if(this.layerName)
				json += "\"layerName\":" + "\"" + this.layerName + "\",";
			
			
			json += "\"colorGradientType\":" + this.colorGradientType + ",";
			
			json += "\"rangeMode\":" + this.rangeMode + ",";
			
			json += "\"rangeParameter\":" + this.rangeParameter;
			
			if(json.length > 0)
				json = "{" + json + "}";
			return json;
		}
		
		sm_internal static function toThemeRangeParam(object:Object):ThemeRangeParam
		{
			var themeRangeParam:ThemeRangeParam;
			if(object)
			{
				themeRangeParam = new ThemeRangeParam();
				themeRangeParam.layerName = object.layerName;
				themeRangeParam.rangeParameter = object.rangeParameter;
				themeRangeParam.rangeMode = object.rangeMode;
				themeRangeParam.colorGradientType = object.colorGradientType;
			}
			return themeRangeParam;
		}
	}
}