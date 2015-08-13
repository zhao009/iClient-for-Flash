package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeRangeItem_Title}.
	 * <p>${iServerJava6R_ThemeRangeItem_Description}</p> 
	 * 
	 */	
	public class ThemeRangeItem
	{
		private var _caption:String = "";
		private var _end:Number = 0;
		private var _start:Number = 0;
		private var _style:ServerStyle = new ServerStyle();
		private var _visible:Boolean = true;
		
		/**
		 * ${iServerJava6R_ThemeRangeItem_constructor_D} 
		 * 
		 */		
		public function ThemeRangeItem()
		{
		}

		/**
		 * ${iServerJava6R_ThemeRangeItem_attribute_visible_D} 
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
		 * ${iServerJava6R_ThemeRangeItem_attribute_style_D} 
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
		 * ${iServerJava6R_ThemeRangeItem_attribute_start_D}.
		 * <p>${iServerJava6R_ThemeRangeItem_attribute_start_remarks}</p> 
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
		 * ${iServerJava6R_ThemeRangeItem_attribute_end_D}.
		 * <p>${iServerJava6R_ThemeRangeItem_attribute_end_remarks}</p>
		 * @see ThemeRange#rangeExpression 
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
		 * ${iServerJava6R_ThemeRangeItem_attribute_caption_D} 
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
		
		sm_internal static  function toJSON(item:ThemeRangeItem):String
		{
			var json:String = "";
			
			json += "\"caption\":" +  "\"" + item.caption + "\"" + "," ;
			
			json += "\"start\":" + item.start + "," ;
			
			json += "\"end\":" + item.end + "," ;
			
			json += "\"style\":" + item.style.toJSON() + "," ;
			
			json += "\"visible\":" + item.visible ;			
			
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeRangeItem
		{
			var themeRangeItem:ThemeRangeItem;
			if(object)
			{
				themeRangeItem = new ThemeRangeItem();
				themeRangeItem.caption = object.caption;
				themeRangeItem.visible = object.visible;
				themeRangeItem.style = ServerStyle.fromJson(object.style);
				themeRangeItem.start = object.start;
				themeRangeItem.end = object.end;
			}
			
			return themeRangeItem;
		}

	}
}