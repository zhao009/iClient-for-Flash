package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_themeServices_ThemeRange_Title}.
	 * <p>${iServer2_themeServices_ThemeRange_Description}</p>
	 * <p>${iServer2_themeServices_ThemeRange_Description_1}</p> 
	 * 
	 * 
	 */	
	public class ThemeRange extends Theme
	{
		private var _rangeExpression:String;		
		private var _items:Array;		
		private var _makeDefaultParam:ThemeRangeParam;
		
		/**
		 * ${iServer2_themeServices_ThemeRange_constructor_None_D_as} 
		 * 
		 */		
		public function ThemeRange()
		{
			super();
			this.themeType = ThemeType.RANGE;
		}
		
		/**
		 * ${iServer2_themeServices_ThemeRange_attribute_makeDefaultParam_D} 
		 * @return 
		 * 
		 */		
		public function get makeDefaultParam():ThemeRangeParam
		{
			return _makeDefaultParam;
		}

		public function set makeDefaultParam(value:ThemeRangeParam):void
		{
			_makeDefaultParam = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeRange_attribute_items_D}
		 * @see ThemeRangeItem 
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
		 * ${iServer2_themeServices_ThemeRange_attribute_RangeExpression_D}.
		 * <p>${iServer2_themeServices_ThemeRange_attribute_RangeExpression_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get rangeExpression():String
		{
			return _rangeExpression;
		}

		public function set rangeExpression(value:String):void
		{
			_rangeExpression = value;
		}

		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"rangeExpression\":" + "\"" + this.rangeExpression + "\"," ;
			if(this.items)
			{
				trace(this.items[0],this.items[1],this.items[2]);
				if(this.items.length > 0)
				{
					var tempItems:Array = new Array();
					var j:int = 1;
					for(var i:int = 0; i < this.items.length; i++)
					{
						var itemFirst:Number = this.items[i].end;						
						var itemSecond:Number = this.items[j].start;
						if(itemFirst == itemSecond)
						{
							tempItems.push(ThemeRangeItem.toJSON(this.items[i]));
						}
						else
						{
							throw new SmError(SmResource.THEMERANGEITEM_START_END);
						}
						j++;
						if(j == this.items.length)
						{
							tempItems.push(ThemeRangeItem.toJSON(this.items[i+1]));
							break;
						}
						//i++;						
					}
					json += "\"items\":" + "[" + tempItems.join(",") + "]" + ",";
				}
			}
			else
				json += "\"items\":" + "[]" + ",";
			
			
			if(this.makeDefaultParam)
			{
				json += "\"makeDefaultParam\":" + this.makeDefaultParam.toJSON() + ",";
			}
			
			json += "\"themeType\":" + this.themeType;    
			
			if(json.charAt(json.length - 1) == ",")
				json = json.substring(0, json.length - 1);
			
			if(json.length > 0)
				json = "{" + json + "}";
			return json;
		}
		
		sm_internal static function toThemeRange(object:Object):ThemeRange
		{
			var themeRange:ThemeRange;
			if(object)
			{
				themeRange = new ThemeRange();
				themeRange.rangeExpression = object.rangeExpression;
				themeRange.makeDefaultParam = ThemeRangeParam.toThemeRangeParam(object.makeDefaultParam);
				if(object.items)
				{
					var tempItems:Array = object.items;
					themeRange.items = new Array();
					for(var i:int = 0; i < tempItems.length; i++)
					{
						themeRange.items.push(ThemeRangeItem.toThemeRangeItem(tempItems[i]));
					}
				}
				
				themeRange.themeType = object.themeType;
			}
			return themeRange;
		}
	}
}