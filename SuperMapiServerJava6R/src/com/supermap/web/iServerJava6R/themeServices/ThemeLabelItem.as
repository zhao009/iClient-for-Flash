package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerTextStyle;
	
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeLabelItem_Title}.
	 * <p>${iServerJava6R_ThemeLabelItem_Description}</p> 
	 * 
	 */	
	public class ThemeLabelItem
	{
		private var _caption:String = "";		
		private var _start:Number = 0;		
		private var _end:Number = 0;		
		private var _style:ServerTextStyle = new ServerTextStyle();		
		private var _visible:Boolean = true;	
			
		/**
		 * ${iServerJava6R_ThemeLabelItem_constructor_D} 
		 * 
		 */		
		public function ThemeLabelItem()
		{
		}
		
			
		/**
		 * ${iServerJava6R_ThemeLabelItem_attribute_visible_D} 
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
		 * ${iServerJava6R_ThemeLabelItem_attribute_style_D}.
		 * <p>${iServerJava6R_ThemeLabelItem_attribute_style_remarks}</p> 
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
		 * ${iServerJava6R_ThemeLabelItem_attribute_end_D}.
		 * <p>${iServerJava6R_ThemeLabelItem_attribute_end_remarks}</p> 
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
		 * ${iServerJava6R_ThemeLabelItem_attribute_start_D}.
		 * <p>${iServerJava6R_ThemeLabelItem_attribute_start_remarks}</p> 
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
		 * ${iServerJava6R_ThemeLabelItem_attribute_caption_D} 
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
			
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeLabelItem
		{
			var themeLabelItem:ThemeLabelItem;
			if(object)
			{
				themeLabelItem = new ThemeLabelItem();
				
				themeLabelItem.caption = object.caption;
				
				themeLabelItem.end = object.end;
				
				themeLabelItem.start = object.start;
				
				themeLabelItem.visible = object.visible;
				
				themeLabelItem.style = ServerTextStyle.fromJson(object.style);
			}
			
			return themeLabelItem;
		}
	}
}