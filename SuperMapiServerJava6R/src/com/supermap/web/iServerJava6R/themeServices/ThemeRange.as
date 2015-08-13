package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ColorGradientType;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ThemeRange_Title}.
	 * <p>${iServerJava6R_ThemeRange_Description}</p> 
	 * 
	 */	
	public class ThemeRange extends Theme
	{
		private var _items:Array;
		private var _rangeExpression:String = "";
		private var _rangeMode:String = RangeMode.EQUALINTERVAL;
		private var _rangeParameter:Number = 0;
		private var _colorGradientType:String = ColorGradientType.YELLOW_BLUE;
		private var _precision:Number = 1.0E-12;
		/**
		 * ${iServerJava6R_ThemeRange_constructor_D} 
		 * 
		 */		
		public function ThemeRange()
		{
			super();
		}

		/**
		 * ${iServerJava6R_ThemeRange_attribute_rangeParameter_D}.
		 * <p>${iServerJava6R_ThemeRange_attribute_rangeParameter_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get rangeParameter():Number
		{
			return _rangeParameter;
		}

		public function set rangeParameter(value:Number):void
		{
			_rangeParameter = value;
		}

		/**
		 * ${iServerJava6R_ThemeRange_attribute_rangeMode_D}.
		 * <p>${iServerJava6R_ThemeRange_attribute_rangeMode_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get rangeMode():String
		{
			return _rangeMode;
		}

		public function set rangeMode(value:String):void
		{
			_rangeMode = value;
		}

		/**
		 * ${iServerJava6R_ThemeRange_attribute_rangeExpression_D}.
		 * <p>${iServerJava6R_ThemeRange_attribute_rangeExpression_remarks}</p> 
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

		/**
		 * ${iServerJava6R_ThemeRange_attribute_items_D}.
		 * <p>${iServerJava6R_ThemeRange_attribute_items_remarks}</p>
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
		 * ${iServerJava6R_ThemeRange_attribute_colorGradientType_D} 
		 * @see com.supermap.web.iServerJava6R.serverTypes.ColorGradientType
		 * @return 
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
		
		sm_internal  function toJSON():String
		{
			var json:String = "";
			
			if(this.items && this.items.length)
			{
				var tempItems:Array = new Array();
				var itemLength:int = this.items.length;
				for(var i:int = 0; i < itemLength; i++)
				{
					//var themeRangeItem:ThemeRangeItem = this.items[i];
					tempItems.push(ThemeRangeItem.toJSON(this.items[i]));
				}
				json += "\"items\":" + "[" + tempItems.join(",") + "]" + ",";
				
			}
			else
				json += "\"items\":" + "[]" + ",";
			
			json += "\"rangeExpression\":" +  "\"" + this.rangeExpression + "\"" +  "," ;
			
			if(super.themeMemoryData){
				json += "\"memoryData\":" + super.themeMemoryData.toJSON() + "," ;
			}else{
				json += "\"memoryData\":" + "null" + "," ;
			}
			
			json += "\"type\":" +  "\"" + "RANGE" + "\"" +  "," ;			
			
			if(this.items)
				json += "\"rangeParameter\":" +  "\"" + this.items.length + "\"" +  "," ;
			else
				json += "\"rangeParameter\":" +  "\"" + this.rangeParameter + "\"" +  "," ;
			
			json += "\"rangeMode\":" +  "\"" + this.rangeMode + "\"" +",";	
			
			json += "\"precision\":" +  "\"" + this._precision + "\"" +",";	
			
			json += "\"colorGradientType\":" +  "\"" + this.colorGradientType + "\"" ;	
			
			json = "{" + json + "}";
			
			return json;
		}
	
		sm_internal static function fromJson(object:Object):ThemeRange
		{
			var themeRange:ThemeRange;
			if(object)
			{
				themeRange = new ThemeRange();
				themeRange.rangeExpression = object.rangeExpression;
				themeRange.rangeMode = object.rangeMode;
				themeRange.rangeParameter = object.rangeParameter;
				if(object.items)
				{
					var tempItems:Array = object.items;
					themeRange.items = new Array();
					for(var i:int = 0; i < tempItems.length; i++)
					{
						themeRange.items.push(ThemeRangeItem.fromJson(tempItems[i]));
					}
				}
				
			}
			return themeRange;
		}

	}
}