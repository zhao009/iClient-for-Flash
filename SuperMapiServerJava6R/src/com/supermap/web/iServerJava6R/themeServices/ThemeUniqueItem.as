package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeUniqueItem_Title}.
	 * <p>${iServerJava6R_ThemeUniqueItem_Description}</p> 
	 * 
	 */	
	public class ThemeUniqueItem
	{		
		private var _caption:String = "";
		private var _unique:String = "";
		private var _style:ServerStyle = new ServerStyle();
		private var _visible:Boolean = true;

		/**
		 * ${iServerJava6R_ThemeUniqueItem_constructor_D} 
		 * 
		 */		
		public function ThemeUniqueItem()
		{
		}

		/**
		 * ${iServerJava6R_ThemeUniqueItem_attribute_visible_D} 
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
		 * ${iServerJava6R_ThemeUniqueItem_attribute_style_D} 
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
		 * ${iServerJava6R_ThemeUniqueItem_attribute_unique_D} 
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
		 * ${iServerJava6R_ThemeUniqueItem_attribute_caption_D} 
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
			var json:String = "";
			
			json += "\"caption\":" +  "\"" + item.caption + "\"" +  "," ;
			
			json += "\"unique\":" + "\"" + item.unique + "\"" + "," ;
			
			json += "\"style\":" + item.style.toJSON() + "," ;
			
			json += "\"visible\":" + item.visible ;			
			
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function toThemeUniqueItem(object:Object):ThemeUniqueItem
		{
			var themeUniqueItem:ThemeUniqueItem;
			if(object)
			{
				themeUniqueItem = new ThemeUniqueItem();
				themeUniqueItem.caption = object.caption;
				themeUniqueItem.unique = object.unique;
				themeUniqueItem.style = ServerStyle.fromJson(object.style);
				themeUniqueItem.visible = object.visible;
			}
			
			return themeUniqueItem;
		}	

	}
}