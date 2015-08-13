package com.supermap.web.iServerJava6R.themeServices
{
	//统计图注记设置类
	import com.supermap.web.utils.serverTypes.ServerTextStyle;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeGraphText_Title}. 
	 * <p>${iServerJava6R_ThemeGraphText_Description}</p>
	 * 
	 */	
	public class ThemeGraphText
	{
		private var _graphTextDisplayed:Boolean = false;
		private var _graphTextFormat:String = ThemeGraphTextFormat.CAPTION;
		private var _graphTextStyle:ServerTextStyle = new ServerTextStyle();

		/**
		 * ${iServerJava6R_ThemeGraphText_constructor_D} 
		 * 
		 */		
		public function ThemeGraphText()
		{
		}

		/**
		 * ${iServerJava6R_ThemeGraphText_attribute_graphTextStyle_D} 
		 * @return 
		 * 
		 */		
		public function get graphTextStyle():ServerTextStyle
		{
			return _graphTextStyle;
		}

		public function set graphTextStyle(value:ServerTextStyle):void
		{
			_graphTextStyle = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraphText_attribute_graphTextFormat_D}.
		 * <p>${iServerJava6R_ThemeGraphText_attribute_graphTextFormat_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get graphTextFormat():String
		{
			return _graphTextFormat;
		}

		public function set graphTextFormat(value:String):void
		{
			_graphTextFormat = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraphText_attribute_graphTextDisplayed_D} 
		 * @return 
		 * 
		 */		
		public function get graphTextDisplayed():Boolean
		{
			return _graphTextDisplayed;
		}

		public function set graphTextDisplayed(value:Boolean):void
		{
			_graphTextDisplayed = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"graphTextDisplayed\":" +  this.graphTextDisplayed +  "," ;
			
			json += "\"graphTextFormat\":" + "\"" + this.graphTextFormat + "\"" +  "," ;
			
			json += "\"graphTextStyle\":" + this.graphTextStyle.toJSON();
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeGraphText
		{
			var themeGraphText:ThemeGraphText;
			if(object)
			{
				themeGraphText.graphTextDisplayed = object.graphTextDisplayed;
				themeGraphText.graphTextFormat = object.graphTextFormat;
				themeGraphText.graphTextStyle = ServerTextStyle.fromJson(object.graphTextStyle);
			}
			
			return themeGraphText;
		}

	}
}