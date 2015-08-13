package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerColor;
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeGridRangeItem_Title}.
	 * <p>${iServerJava6R_ThemeGridRangeItem_Description}</p> 
	 * 
	 */	
	public class ThemeGridRangeItem
	{
		private var _caption:String = "UntitledThemeGridRangeItem";
		private var _color:ServerColor = new ServerColor();
		private var _end:Number = 0;
		private var _start:Number = 0;
		private var _visible:Boolean = true;
		
		/**
		 * ${iServerJava6R_ThemeGridRangeItem_constructor_D} 
		 * 
		 */	
		public function ThemeGridRangeItem()
		{
		}
		
		/**
		 * ${iServerJava6R_ThemeGridRangeItem_attribute_caption_D} 
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
		 * ${iServerJava6R_ThemeGridRangeItem_attribute_color_D} 
		 * @return 
		 * 
		 */	
		public function get color():ServerColor
		{
			return _color;
		}
		public function set color(value:ServerColor):void
		{
			_color = value;
		}
		
		/**
		 * ${iServerJava6R_ThemeGridRangeItem_attribute_end_D} 
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
		 * ${iServerJava6R_ThemeGridRangeItem_attribute_start_D} 
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
		 * ${iServerJava6R_ThemeGridRangeItem_attribute_visible_D} 
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
		
		sm_internal static  function toJSON(item:ThemeGridRangeItem):String
		{
			var json:String = "";
			
			json += "\"caption\":" +  "\"" + item.caption + "\"" + "," ;
			
			json += "\"color\":" + item.color.toJSON() + ",";
			
			json += "\"end\":" + item.end + "," ;
			
			json += "\"start\":" + item.start + "," ;
					
			json += "\"visible\":" + item.visible ;			
			
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeGridRangeItem
		{
			var themeGridRangeItem:ThemeGridRangeItem;
			if(object)
			{
				themeGridRangeItem = new ThemeGridRangeItem();
				themeGridRangeItem.caption = object.caption;
				themeGridRangeItem.color = ServerColor.fromJson(object.color);
				themeGridRangeItem.end = object.end;
				themeGridRangeItem.start = object.start;
				themeGridRangeItem.visible = object.visible;							
			}
			
			return themeGridRangeItem;
		}
		
	}
}