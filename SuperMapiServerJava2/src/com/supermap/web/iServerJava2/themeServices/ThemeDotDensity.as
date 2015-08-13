package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeDotDensity_Title}.
	 * <p>${iServer2_themeServices_ThemeDotDensity_Description}</p> 
	 * 
	 * 
	 */	
	public class ThemeDotDensity extends Theme
	{
		/**
		 * ${iServer2_themeServices_ThemeDotDensity_attribute_dotExpression_D} 
		 */		
		public var dotExpression:String;	
		/**
		 * ${iServer2_themeServices_ThemeDotDensity_attribute_baseValue_D}
		 * @default 1 
		 */		
		public var value:Number = 1;
		/**
		 * ${iServer2_themeServices_ThemeDotDensity_attribute_style_D} 
		 */		
		public var style:ServerStyle;
		
		/**
		 * ${iServer2_themeServices_ThemeDotDensity_constructor_D} 
		 * 
		 */		
		public function ThemeDotDensity()
		{
			super();
			style = new ServerStyle();
			style.markerSize = 2;
			this.themeType = ThemeType.DOT_DENSITY;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			if(this.dotExpression)
				json += "\"dotExpression\":" + "\"" + this.dotExpression + "\",";
			if(this.value)
				json += "\"value\":" + this.value + ",";
			
			json += "\"style\":" + this.style.toJSON() + ",";
			json += "\"themeType\":" + this.themeType;
			
			if(json.length > 0)
				json = "{" + json + "}";
			return json;
		}
		
		sm_internal static function toThemeDotDensity(object:Object):ThemeDotDensity
		{
			var themeDotDensity:ThemeDotDensity;
			if(object)
			{
				themeDotDensity = new ThemeDotDensity();
				themeDotDensity.dotExpression = object.dotExpression;
				
				themeDotDensity.style = ServerStyle.toServerStyle(object.style);
				
				themeDotDensity.value = object.value;
				
				themeDotDensity.themeType = object.themeType;
				
			}
			return themeDotDensity;
		}
	}
}