package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServer6R_themeServices_ThemeDotDensity_Title}.
	 * <p>${iServer6R_themeServices_ThemeDotDensity_Description}</p> 
	 * 
	 */	
	public class ThemeDotDensity extends Theme
	{		
		private var _dotExpression:String = "";
		private var _value:Number = 200;
		private var _style:ServerStyle;

		/**
		 * ${iServer6R_themeServices_ThemeDotDensity_constructor_D} 
		 * 
		 */		
		public function ThemeDotDensity()
		{
			super();
			this.style = new ServerStyle();
			this.style.markerSize = 2;
			this.value = 200;
		}

		/**
		 * ${iServer6R_themeServices_ThemeDotDensity_attribute_style_D} 
		 * @return 
		 * 
		 */		
		public function get style():ServerStyle
		{
			return _style;
		}

		public function set style(value:ServerStyle):void
		{
			_style = value;
		}

		/**
		 * ${iServer6R_themeServices_ThemeDotDensity_attribute_Value_D}.
		 * <p>${iServer6R_themeServices_ThemeDotDensity_attribute_Value_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			_value = value;
		}

		/**
		 * ${iServer6R_themeServices_ThemeDotDensity_attribute_dotExpression_D} 
		 * @return 
		 * 
		 */		
		public function get dotExpression():String
		{
			return _dotExpression;
		}

		public function set dotExpression(value:String):void
		{
			_dotExpression = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"dotExpression\":" +  "\"" + this.dotExpression + "\"" +  "," ;
			
			json += "\"value\":" +  this.value +  "," ;
			
			json += "\"style\":" + this.style.toJSON() + "," ;
			
			json += "\"type\":" + "\"" + "DOTDENSITY" + "\"" + ",";	
			
			if(super.themeMemoryData){
				json += "\"memoryData\":" + super.themeMemoryData.toJSON();	
			}else{
				json += "\"memoryData\":" + "null";	
			}
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeDotDensity
		{
			var themeDotDensity:ThemeDotDensity;
			if(object)
			{
				themeDotDensity = new ThemeDotDensity();
				themeDotDensity.dotExpression = object.dotExpression;
				themeDotDensity.value = object.value;
				themeDotDensity.style = ServerStyle.fromJson(object.style);
				
			}
			
			return themeDotDensity;
		}

	}
}