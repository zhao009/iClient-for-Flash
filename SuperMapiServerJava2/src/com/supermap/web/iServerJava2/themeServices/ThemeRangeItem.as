package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeRangeItem_Title}.
	 * <p>${iServer2_themeServices_ThemeRangeItem_Description}</p> 
	 * 
	 * 
	 */	
	public class ThemeRangeItem
	{
		private var _caption:String;	
		private var _start:Number;		
		private var _end:Number;	
		private var _style:ServerStyle ;
		private var _visible:Boolean = true;
		
		/**
		 * ${iServer2_themeServices_ThemeRangeItem_constructor_None_D} 
		 * 
		 */		
		public function ThemeRangeItem()
		{
		}
		
		/**
		 * ${iServer2_themeServices_ThemeRangeItem_attribute_visible_D} 
		 * @return 
		 * 
		 */		
		public function get visible():Boolean
		{
			return _visible;
		}

		public function set visible(value:Boolean):void
		{
			_visible = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeRangeItem_attribute_style_D} 
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
		 * ${iServer2_themeServices_ThemeRangeItem_attribute_end_D}.
		 * <p>${iServer2_themeServices_ThemeRangeItem_attribute_end_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get end():Number
		{
			return _end;
		}

		public function set end(value:Number):void
		{
			_end = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeRangeItem_attribute_start_D}.
		 * <p>${iServer2_themeServices_ThemeRangeItem_attribute_start_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get start():Number
		{
			return _start;
		}

		public function set start(value:Number):void
		{
			_start = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeRangeItem_attribute_caption_D} 
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

		sm_internal static function toJSON(item:ThemeRangeItem):String
		{
			if(!item)
				return null;
			
			var json:String = "";
			
			if (item.caption)
			{
				json += "\"caption\":" + "\"" + item.caption + "\",";
			}
			
			if (Math.abs(item.start) >= 0)
			{
				json += "\"start\":" + item.start + ",";
			}
			
			if (Math.abs(item.end) >= 0)
			{
				json += "\"end\":" + item.end + ",";
			}
			
			if (item.style)
			{
				json += "\"style\":" + item.style.toJSON() + ",";
			}
			
			json += "\"visible\":" + item.visible;
			
			if(json.length > 0)
				json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function toThemeRangeItem(object:Object):ThemeRangeItem
		{
			var themeRangeItem:ThemeRangeItem;
			if(object)
			{
				themeRangeItem = new ThemeRangeItem();
				themeRangeItem.caption = object.caption;
				themeRangeItem.visible = object.visible;
				themeRangeItem.style = ServerStyle.toServerStyle(object.style);
				themeRangeItem.start = object.start;
				themeRangeItem.end = object.end;
			}
			
			return themeRangeItem;
		}
	}
}