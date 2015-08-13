package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeGraphItem_Title}.
	 * <p>${iServer2_themeServices_ThemeGraphItem_Description}</p> 
	 * 
	 */	
	public class ThemeGraphItem extends Theme
	{
		private var _caption:String;
		//统计专题图的专题变量,专题变量可以是一个字段或字段表达式
		private var _graphExpression:String;
		//统计专题图子项的显示风格
		private var _uniformStyle:ServerStyle = new ServerStyle();
		//统计专题图子项的分段风格。通过rangeSetting属性，可以对作为专题变量的字段或表达式进行分段，并对每段赋予不同的显示风格
		private var _rangeSetting:ThemeRange;
		
		/**
		 * ${iServer2_themeServices_ThemeGraphItem_constructor_None_D} 
		 * 
		 */
		public function ThemeGraphItem()
		{
			super();
		}
		
		/**
		 * ${iServer2_themeServices_ThemeGraphItem_attribute_rangeSetting_D}.
		 * <p>${iServer2_themeServices_ThemeGraphItem_attribute_rangeSetting_remarks}</p> 
		 */
		public function get rangeSetting():ThemeRange
		{
			return _rangeSetting;
		}

		public function set rangeSetting(value:ThemeRange):void
		{
			_rangeSetting = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraphItem_attribute_uniformStyle_D} 
		 */
		public function get uniformStyle():ServerStyle
		{
			return _uniformStyle;
		}

		public function set uniformStyle(value:ServerStyle):void
		{
			_uniformStyle = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraphItem_attribute_graphExpression_D}.
		 * <p>${iServer2_themeServices_ThemeGraphItem_attribute_graphExpression_remarks}</p> 
		 */
		public function get graphExpression():String
		{
			return _graphExpression;
		}

		public function set graphExpression(value:String):void
		{
			_graphExpression = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraphItem_attribute_caption_D} 
		 * @return 
		 * 
		 */		
		public function get caption():String
		{
			return _caption;
		}

		public function set caption(value:String):void
		{
			_caption = value;
		}

		/**
		 * @private 
		 * @param item
		 * @return 
		 * 
		 */
		sm_internal static function toJSON(item:ThemeGraphItem):String
		{
			var json:String = "";
			if(item.caption)
				json += "\"caption\":" + "\"" + item.caption + "\"," ;
			if(item.graphExpression)
				json += "\"graphExpression\":" + "\"" + item.graphExpression + "\"," ;
			
			json += "\"uniformStyle\":" + item.uniformStyle.toJSON() + "," ;
			if(item.rangeSetting)
				json += "\"rangeSetting\":" + item.rangeSetting.toJSON();
			
			if(json.charAt(json.length - 1) == ",")
				json = json.substring(0, json.length - 1);
			
			if(json.length > 0)
				json = "{" + json + "}";
			return json;
		}
		
		sm_internal static function toThemeGraphItem(object:Object):ThemeGraphItem
		{
			var themeGraphItem:ThemeGraphItem;
			if(object)
			{
				themeGraphItem = new ThemeGraphItem();
				themeGraphItem.caption = object.caption;
				themeGraphItem.graphExpression = object.graphExpression;
				themeGraphItem.rangeSetting = ThemeRange.toThemeRange(object.rangeSetting);
				themeGraphItem.uniformStyle = ServerStyle.toServerStyle(object.uniformStyle);
				themeGraphItem.themeType = object.themeType;
			}
			return themeGraphItem;
		}
	}
}