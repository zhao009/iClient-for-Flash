package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerColor;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeGridUniqueItem_Title}.
	 * <p>${iServerJava6R_ThemeGridUniqueItem_Description}</p> 
	 * 
	 */	
	public class ThemeGridUniqueItem
	{
		private var _caption:String = "";
		private var _unique:Number=0;
		private var _color:ServerColor = new ServerColor();
		private var _visible:Boolean = true;
		
		/**
		 * ${iServerJava6R_ThemeGridUniqueItem_constructor_D} 
		 * 
		 */	
		public function ThemeGridUniqueItem()
		{
		}

		/**
		 * ${iServerJava6R_ThemeGridUniqueItem_attribute_unique_D} 
		 * @return 
		 * 
		 */	
		public function get unique():Number
		{
			return _unique;
		}

		public function set unique(value:Number):void
		{
			_unique = value;
		}

		/**
		 * ${iServerJava6R_ThemeGridUniqueItem_attribute_visible_D} 
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
		 * ${iServerJava6R_ThemeGridUniqueItem_attribute_color_D} 
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
		 * ${iServerJava6R_ThemeGridUniqueItem_attribute_caption_D} 
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
		
		sm_internal static function toJSON(item:ThemeGridUniqueItem):String
		{
			var json:String = "";
			
			json += "\"caption\":" +  "\"" + item.caption + "\"" +  "," ;
			
			json += "\"unique\":" + item.unique + "," ;
			
			json += "\"color\":" + item.color.toJSON() + "," ;
			
			json += "\"visible\":" + item.visible ;			
			
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function toThemeGridUniqueItem(object:Object):ThemeGridUniqueItem
		{
			var themeGridUniqueItem:ThemeGridUniqueItem;
			if(object)
			{
				themeGridUniqueItem = new ThemeGridUniqueItem();
				themeGridUniqueItem.caption = object.caption;
				themeGridUniqueItem.unique = object.unique;
				themeGridUniqueItem.color = ServerColor.fromJson(object.color);
				themeGridUniqueItem.visible = object.visible;
			}
			
			return themeGridUniqueItem;
		}	


	}
}