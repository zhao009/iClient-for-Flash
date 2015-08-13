package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	/**
	 * ${iServer2_themeServices_ThemeLableItem_Title}.
	 * <p>${iServer2_themeServices_ThemeLableItem_Description}</p> 
	 * 
	 * 
	 */	
	public class ThemeLabelItem
	{
		private var _caption:String;		
		private var _start:Number;		
		private var _end:Number;		
		private var _style:ServerTextStyle = new ServerTextStyle();		
		private var _visible:Boolean = true;	
		
		/**
		 * ${iServer2_themeServices_ThemeLableItem_constructor_None_D} 
		 * 
		 */		
		public function ThemeLabelItem()
		{
		}
		
		/**
		 * ${iServer2_themeServices_ThemeLableItem_attribute_visible_D}
		 * @default true 
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
		 * ${iServer2_themeServices_ThemeLableItem_attribute_style_D} 
		 * @return 
		 * 
		 */		
		public function get style():ServerTextStyle
		{
			return _style;
		}

		public function set style(value:ServerTextStyle):void
		{
			_style = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeLableItem_attribute_end_D}.
		 * <p>${iServer2_themeServices_ThemeLableItem_attribute_end_remarks}</p> 
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
		 * ${iServer2_themeServices_ThemeLableItem_attribute_start_D}.
		 * <p>${iServer2_themeServices_ThemeLableItem_attribute_start_remarks}</p> 
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
		 * ${iServer2_themeServices_ThemeLableItem_attribute_caption_D} 
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

		sm_internal static function toJSON(item:ThemeLabelItem):String
		{
			var json:String = "";
			
			if(item.caption)
				json += "\"caption\":" + "\"" + item.caption + "\"," ;
			
			if(item.style)
				json += "\"style\":" + item.style.toJSON()+ "," ;
			
			if(item.start >= 0)
				json += "\"start\":" + item.start + "," ;
			
			if(item.end >= 0)
				json += "\"end\":" + item.end + "," ;
			
			json += "\"visible\":" + item.visible ;
			
			if(json.length > 0)
				json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function toThemeLabelItem(object:Object):ThemeLabelItem
		{
			var themeLabelItem:ThemeLabelItem;
			if(object)
			{
				themeLabelItem = new ThemeLabelItem();
				
				themeLabelItem.caption = object.caption;
				
				themeLabelItem.end = object.end;
				
				themeLabelItem.start = object.start;
				
				themeLabelItem.visible = object.visible;
				
				themeLabelItem.style = ServerTextStyle.toServerTextStyle(object.style);
			}
			
			return themeLabelItem;
		}
	}
}