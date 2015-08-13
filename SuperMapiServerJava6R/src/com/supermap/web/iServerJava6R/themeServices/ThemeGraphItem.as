package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServer6R_themeServices_ThemeGraphItem_Title}.
	 * <p>${iServer6R_themeServices_ThemeGraphItem_Description}</p> 
	 * 
	 */	
	public class ThemeGraphItem
	{		
		private var _caption:String = "";
		private var _graphExpression:String = "";		
		private var _uniformStyle:ServerStyle = new ServerStyle();
		private var _memoryDoubleValues:Array;

		/**
		 * ${iServer6R_themeServices_ThemeGraphItem_constructor_None_D} 
		 * 
		 */		
		public function ThemeGraphItem()
		{
		}

		/**
		 * ${iServer6R_themeServices_ThemeGraphItem_attribute_memoryDoubleValues_D}.
		 * <p>${iServer6R_themeServices_ThemeGraphItem_attribute_memoryDoubleValues_remarks}</p> 
		 * @see ThemeGraph#memoryKeys
		 * @return 
		 * 
		 */		
		public function get memoryDoubleValues():Array
		{
			return _memoryDoubleValues;
		}

		public function set memoryDoubleValues(value:Array):void
		{
			_memoryDoubleValues = value;
		}

		/**
		 * ${iServer6R_themeServices_ThemeGraphItem_attribute_uniformStyle_D} 
		 * @return 
		 * 
		 */		
		public function get uniformStyle():ServerStyle
		{
			return _uniformStyle;
		}

		public function set uniformStyle(value:ServerStyle):void
		{
			_uniformStyle = value;
		}

//		public function get rangeSetting():ThemeRange
//		{
//			return _rangeSetting;
//		}
//
//		public function set rangeSetting(value:ThemeRange):void
//		{
//			_rangeSetting = value;
//		}

		/**
		 * ${iServer6R_themeServices_ThemeGraphItem_attribute_graphExpression_D}.
		 * <p>${iServer6R_themeServices_ThemeGraphItem_attribute_graphExpression_remarks}</p> 
		 * @return 
		 * 
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
		 * ${iServer6R_themeServices_ThemeGraphItem_attribute_caption_D} 
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
		
		sm_internal static function toJSON(item:ThemeGraphItem):String
		{
			var json:String = "";
			
			if(item.caption)
				json += "\"caption\":" + "\"" + item.caption + "\"" +"," ;
			
			if(item.graphExpression)
				json += "\"graphExpression\":" + "\"" + item.graphExpression + "\"" + "," ;
			
			if(item.memoryDoubleValues && item.memoryDoubleValues.length > 0)
				json += "\"memoryDoubleValues\":" + "[" + item.memoryDoubleValues + "]" + "," ;
			else
				json += "\"memoryDoubleValues\":" + "null" + "," ;				
			
			if(item.uniformStyle)
				json += "\"uniformStyle\":" + item.uniformStyle.toJSON() ;
			
			if(json.length > 0)
				json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeGraphItem
		{
			var themeGraphItem:ThemeGraphItem;
			if(object)
			{
				themeGraphItem = new ThemeGraphItem();
				themeGraphItem.caption = object.caption;
				themeGraphItem.graphExpression = object.graphExpression;
				themeGraphItem.memoryDoubleValues = object.memoryDoubleValues;
				themeGraphItem.uniformStyle = ServerStyle.fromJson(object.uniformStyle);
			}
			return themeGraphItem;
		}

	}
}