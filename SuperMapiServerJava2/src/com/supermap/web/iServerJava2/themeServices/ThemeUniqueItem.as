package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeUniqueItem_Title}.
	 * <p>${iServer2_themeServices_ThemeUniqueItem_Description}</p>
	 * 
	 * 
	 */	
	public class ThemeUniqueItem
	{
		
		private var _caption:String;		
		private var _unique:String;		
		private var _style:ServerStyle;		
		private var _visible:Boolean = true;		
		
		/**
		 * ${iServer2_themeServices_ThemeUniqueItem_constructor_None_D} 
		 * 
		 */		
		public function ThemeUniqueItem()
		{
		}		
		
		/**
		 * ${iServer2_themeServices_ThemeUniqueItem_attribute_visible_D} 
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
		 * ${iServer2_themeServices_ThemeUniqueItem_attribute_style_D} 
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
		 * ${iServer2_themeServices_ThemeUniqueItem_attribute_unique_D} 
		 * @return 
		 * 
		 */		
		public function get unique():String
		{
			return _unique;
		}

		public function set unique(value:String):void
		{
			_unique = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeUniqueItem_attribute_caption_D} 
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

		sm_internal static function toJSON(item:ThemeUniqueItem):String
		{
			if(!item)
				return null;
			
			var json:String = "";
			
			if (item.caption)
			{
				json += "\"caption\":" + item.caption + ",";
			}
			
			if (item.unique)
			{
				json += "\"unique\":" + item.unique + ",";
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
		
		sm_internal static function fromJson(object:Object):ThemeUniqueItem
		{
			var themeUniqueItem:ThemeUniqueItem;
			if(object)
			{
				themeUniqueItem = new ThemeUniqueItem();
				themeUniqueItem.caption = object.caption;
				themeUniqueItem.unique = object.unique;
				themeUniqueItem.style = ServerStyle.toServerStyle(object.style);
				themeUniqueItem.visible = object.visible;
			}
			
			return themeUniqueItem;
		}	
	}
}