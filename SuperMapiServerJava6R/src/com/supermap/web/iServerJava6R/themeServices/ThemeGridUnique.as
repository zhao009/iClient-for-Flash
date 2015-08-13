package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerColor;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeGridUnique_Title}.
	 * <p>${iServerJava6R_ThemeGridUnique_Description}</p> 
	 * 
	 */	
	public class ThemeGridUnique extends Theme
	{		
		private var _items:Array;

		private var _defaultcolor: ServerColor = new ServerColor();
		
		/**
		 * ${iServerJava6R_ThemeGridUnique_constructor_D} 
		 * 
		 */		
		public function ThemeGridUnique()
		{
			super();
		}

		/**
		 * ${iServerJava6R_ThemeGridUnique_attribute_items_D}.
		 * <p>${iServerJava6R_ThemeGridUnique_attribute_items_remarks}</p> 
		 * @return 
		 * 
		 */	
		public function get items():Array
		{
			return _items;
		}

		public function set items(value:Array):void
		{
			_items = value;
		}

		/**
		 * ${iServerJava6R_ThemeGridUnique_attribute_defaultColor_D}.
		 * <p>${iServerJava6R_ThemeGridUnique_attribute_defaultColor_remarks}</p> 
		 * @return 
		 * 
		 */	
		public function get defaultcolor():ServerColor
		{
			return _defaultcolor;
		}

		public function set defaultcolor(value:ServerColor):void
		{
			_defaultcolor = value;
		}

		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			if(this.items)
			{
				if(this.items.length > 0)
				{
					var tempItems:Array = new Array();
					var itemLength:int = this.items.length;
					for(var i:int = 0; i < itemLength; i++)
					{
						tempItems.push(ThemeGridUniqueItem.toJSON(this.items[i]));
					}
					json += "\"items\":" + "[" + tempItems.join(",") + "]" + ",";
				}
			}
			else
				json += "\"items\":" + "[]" + ",";
			
			json += "\"type\":" +  "\"" + "GRIDUNIQUE" + "\"" +  "," ;			
			
			json += "\"defaultcolor\":" + this.defaultcolor.toJSON();
			
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeGridUnique
		{
			var themeGridUnique:ThemeGridUnique;
			if(object)
			{
				themeGridUnique = new ThemeGridUnique();
				themeGridUnique.defaultcolor = ServerColor.fromJson(object.defaultColor);
				
				if(object.items)
				{
					var tempItems:Array = object.items;
					themeGridUnique.items = new Array();
					for(var i:int = 0; i < tempItems.length; i++)
					{
						themeGridUnique.items.push(ThemeGridUniqueItem.toThemeGridUniqueItem(tempItems[i]));
					}
				}
			}
			return themeGridUnique;
		}	
	}
}