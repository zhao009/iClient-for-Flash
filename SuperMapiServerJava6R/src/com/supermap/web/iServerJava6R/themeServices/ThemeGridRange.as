package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ColorGradientType;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeGridRange_Title}.
	 * <p>${iServerJava6R_ThemeGridRange_Description}</p> 
	 * 
	 */	
	public class ThemeGridRange extends Theme
	{
		private var _colorGradientType:String = ColorGradientType.YELLOW_BLUE;
		private var _items:Array;
		private var _rangeMode:String = RangeMode.EQUALINTERVAL;
		private var _rangeParameter:Number = 0;
		private var _reverseColor:Boolean = false;
		
		/**
		 * ${iServerJava6R_ThemeGridRange_constructor_D} 
		 * 
		 */
		public function ThemeGridRange()
		{
			super();
		}
		
		/**
		 * ${iServerJava6R_ThemeGridRange_attribute_colorGradientType_D} 
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
		
		/**
		 * ${iServerJava6R_ThemeGridRange_attribute_items_D}.
		 * <p>${iServerJava6R_ThemeGridRange_attribute_items_remarks}</p>
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
		 * ${iServerJava6R_ThemeGridRange_attribute_rangeMode_D}.
		 * <p>${iServerJava6R_ThemeGridRange_attribute_rangeMode_remarks}</p> 
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
		 * ${iServerJava6R_ThemeGridRange_attribute_rangeParameter_D}.
		 * <p>${iServerJava6R_ThemeGridRange_attribute_rangeParameter_remarks}</p> 
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
		 * ${iServerJava6R_ThemeGridRange_attribute_reverseColor_D}.
		 * @return 
		 * 
		 */	
		public function get reverseColor():Boolean
		{
			return _reverseColor;
		}
		public function set reverseColor(value:Boolean):void
		{
			_reverseColor = value;
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
					tempItems.push(ThemeGridRangeItem.toJSON(this.items[i]));
				}
				json += "\"items\":" + "[" + tempItems.join(",") + "]" + ",";
				
			}
			else
				json += "\"items\":" + "[]" + ",";
			
			
			json += "\"type\":" +  "\"" + "GRIDRANGE" + "\"" +  "," ;			
			
			if(this.items)
				json += "\"rangeParameter\":" +  "\"" + this.items.length + "\"" +  "," ;
			else
				json += "\"rangeParameter\":" +  "\"" + this.rangeParameter + "\"" +  "," ;
			
			json += "\"rangeMode\":" +  "\"" + this.rangeMode + "\"" +",";	
			
			json += "\"reverseColor\":" +  "\"" + this.reverseColor + "\"" +",";	
			
			json += "\"colorGradientType\":" +  "\"" + this.colorGradientType + "\"" ;
						
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeGridRange
		{
			var themeGridRange:ThemeGridRange;
			if(object)
			{
				themeGridRange = new ThemeGridRange();
				if(object.items)
				{
					var tempItems:Array = object.items;
					themeGridRange.items = new Array();
					for(var i:int = 0; i < tempItems.length; i++)
					{
						themeGridRange.items.push(ThemeGridRangeItem.fromJson(tempItems[i]));
					}
				}
				themeGridRange.rangeMode = object.rangeMode;
				themeGridRange.rangeParameter = object.rangeParameter;
				themeGridRange.reverseColor = object.reverseColor;				
				
			}
			return themeGridRange;
		}
	}
}