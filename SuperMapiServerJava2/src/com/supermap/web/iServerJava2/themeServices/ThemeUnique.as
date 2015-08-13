package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeUnique_Title}.
	 * <p>${iServer2_themeServices_ThemeUnique_Description}</p> 
	 * 
	 * 
	 */	
	public class ThemeUnique extends Theme
	{		
		private var _items:Array;		
		private var _uniqueExpression:String = null;		
		private var _makeDefaultParam:ThemeUniqueParam;		
		private var _defaultStyle:ServerStyle = new ServerStyle();		
		
		/**
		 * ${iServer2_themeServices_ThemeUnique_constructor_None_D_as} 
		 * 
		 */		
		public function ThemeUnique()
		{
			super();
			this.themeType = ThemeType.UNIQUE;
		}
				
		/**
		 * ${iServer2_themeServices_ThemeUnique_attribute_defaultStyle_D} 
		 * @return 
		 * 
		 */		
		public function get defaultStyle():ServerStyle
		{
			return _defaultStyle;
		}

		public function set defaultStyle(value:ServerStyle):void
		{
			_defaultStyle = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeUnique_attribute_makeDefaultParam_D} 
		 * @return 
		 * 
		 */		
		public function get makeDefaultParam():ThemeUniqueParam
		{
			return _makeDefaultParam;
		}

		public function set makeDefaultParam(value:ThemeUniqueParam):void
		{
			_makeDefaultParam = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeUnique_attribute_uniqueExpression_D}.
		 * <p>${iServer2_themeServices_ThemeUnique_attribute_uniqueExpression_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get uniqueExpression():String
		{
			return _uniqueExpression;
		}

		public function set uniqueExpression(value:String):void
		{
			_uniqueExpression = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeUnique_attribute_items_D}
		 * @see ThemeUniqueItem 
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

		sm_internal function toJSON():String
		{
			var json:String = "";
			if(this.items)
			{
				if(this.items.length > 0)
				{
					var tempItems:Array = new Array();
					
					for(var i:int = 0; i < this.items.length; i++)
					{
						tempItems.push(ThemeUniqueItem.toJSON(this.items[i]));
					}
					json += "\"items\":" + "[" + tempItems.join(",") + "]" + ",";
				}
			}
			else
				json += "\"items\":" + "[]" + ",";
			
			json += "\"defaultStyle\":" + this.defaultStyle.toJSON() + "," ;
			
			json += "\"uniqueExpression\":" + "\"" + this.uniqueExpression + "\"," ;
			
			json += "\"themeType\":" + this.themeType + "," ;
			
			if(this.makeDefaultParam)
			{
				json += "\"makeDefaultParam\":" + this.makeDefaultParam.toJSON();
			}
			
			if(json.charAt(json.length - 1) == ",")
				json = json.substring(0, json.length - 1);
			
			if(json.length > 0)
				json = "{" + json + "}";
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeUnique
		{
			var themeUnique:ThemeUnique;
			if(object)
			{
				themeUnique = new ThemeUnique();
				themeUnique.defaultStyle = ServerStyle.toServerStyle(object.defaultStyle);
				themeUnique.uniqueExpression = object.uniqueExpression;
				themeUnique.makeDefaultParam = ThemeUniqueParam.toThemeUniqueParam(object.makeDefaultParam);
				
				if(object.items)
				{
					var tempItems:Array = object.items;
					themeUnique.items = new Array();
					for(var i:int = 0; i < tempItems.length; i++)
					{
						themeUnique.items.push(ThemeUniqueItem.fromJson(tempItems[i]));
					}
				}
			}
			return themeUnique;
		}
	}
}