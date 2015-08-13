package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.utils.serverTypes.ColorGradientType;
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeUnique_Title}.
	 * <p>${iServerJava6R_ThemeUnique_Description}</p> 
	 * 
	 */	
	public class ThemeUnique extends Theme
	{		
		private var _items:Array;
		private var _uniqueExpression:String = "";
		private var _defaultStyle:ServerStyle = new ServerStyle();
		private var _colorGradientType:String = ColorGradientType.YELLOW_BLUE;

		/**
		 * ${iServerJava6R_ThemeUnique_constructor_D} 
		 * 
		 */		
		public function ThemeUnique()
		{
			super();
		}

		/**
		 * ${iServerJava6R_ThemeUnique_attribute_defaultStyle_D}.
		 * <p>${iServerJava6R_ThemeUnique_attribute_defaultStyle_remarks}</p> 
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
		 * ${iServerJava6R_ThemeUnique_attribute_uniqueExpression_D}.
		 * <p>${iServerJava6R_ThemeUnique_attribute_uniqueExpression_remarks}</p> 
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
		 * ${iServerJava6R_ThemeUnique_attribute_items_D}.
		 * <p>${iServerJava6R_ThemeUnique_attribute_items_remarks}</p> 
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
		
		/**
		 * ${iServerJava6R_ThemeUnique_attribute_colorGradientType_D} 
		 * @return 
		 * @see com.supermap.web.iServerJava6R.serverTypes.ColorGradientType
		 * 
		 */		
		public function get colorGradientType():String
		{
		     return  _colorGradientType;
		}
		
		public function set colorGradientType(value:String):void
		{
		    _colorGradientType = value;
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
						tempItems.push(ThemeUniqueItem.toJSON(this.items[i]));
					}
					json += "\"items\":" + "[" + tempItems.join(",") + "]" + ",";
				}
			}
			else
				json += "\"items\":" + "[]" + ",";
			
			json += "\"uniqueExpression\":" +  "\"" + this.uniqueExpression + "\"" +  "," ;
			
			if(super.themeMemoryData){
				json += "\"memoryData\":" +  super.themeMemoryData.toJSON() +  "," ;
			}else{
				json += "\"memoryData\":" + "null" + ",";
			}
			
			json += "\"type\":" +  "\"" + "UNIQUE" + "\"" +  "," ;			
			
			json += "\"defaultStyle\":" + this.defaultStyle.toJSON() + ",";
			
			json += "\"colorGradientType\":" +  "\"" + this.colorGradientType + "\"" ;	
					
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeUnique
		{
			var themeUnique:ThemeUnique;
			if(object)
			{
				themeUnique = new ThemeUnique();
				themeUnique.defaultStyle = ServerStyle.fromJson(object.defaultStyle);
				themeUnique.uniqueExpression = object.uniqueExpression;				
				
				if(object.items)
				{
					var tempItems:Array = object.items;
					themeUnique.items = new Array();
					for(var i:int = 0; i < tempItems.length; i++)
					{
						themeUnique.items.push(ThemeUniqueItem.toThemeUniqueItem(tempItems[i]));
					}
				}
			}
			return themeUnique;
		}


	}
}