package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServer6R_themeServices_ThemeGraduatedSymbol_Title}. 
	 * <p>${iServer6R_themeServices_ThemeGraduatedSymbol_Description}</p>
	 */	
	public class ThemeGraduatedSymbol extends Theme
	{
		private var _baseValue:Number = 0;
		private var _expression:String = "";
		private var _graduatedMode:String = GraduatedMode.CONSTANT;
		private var _offset:ThemeOffset = new ThemeOffset();
		private var _style:ThemeGraduatedSymbolStyle = new ThemeGraduatedSymbolStyle();
		

		/**
		 * ${iServer6R_themeServices_ThemeGraduatedSymbol_constructor_D} 
		 * 
		 */		
		public function ThemeGraduatedSymbol()
		{
			super();
		}

		/**
		 * ${iServerJava6R_ThemeGraduatedSymbol_attribute_style_D} 
		 * @return 
		 * 
		 */		
		public function get style():ThemeGraduatedSymbolStyle
		{
			return _style;
		}

		public function set style(value:ThemeGraduatedSymbolStyle):void
		{
			_style = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraduatedSymbol_attribute_offset_D} 
		 * @return 
		 * 
		 */		
		public function get offset():ThemeOffset
		{
			return _offset;
		}

		public function set offset(value:ThemeOffset):void
		{
			_offset = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraduatedSymbol_attribute_graduatedMode_D}.
		 * <p>${iServerJava6R_ThemeGraduatedSymbol_attribute_graduatedMode_remarks}</p> 
		 * @default GraduatedMode.CONSTANT
		 * @see GraduatedMode
		 * @return 
		 * 
		 */		
		public function get graduatedMode():String
		{
			return _graduatedMode;
		}

		public function set graduatedMode(value:String):void
		{
			_graduatedMode = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraduatedSymbol_attribute_expression_D} 
		 * @return 
		 * 
		 */		
		public function get expression():String
		{
			return _expression;
		}

		public function set expression(value:String):void
		{
			_expression = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraduatedSymbol_attribute_baseValue_D}.
		 * <p>${iServerJava6R_ThemeGraduatedSymbol_attribute_baseValue_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get baseValue():Number
		{
			return _baseValue;
		}

		public function set baseValue(value:Number):void
		{
			_baseValue = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"baseValue\":" +   this.baseValue +  "," ;
			
			json += "\"expression\":" + "\"" + this.expression +  "\"" +"," ;
			
			json += "\"graduatedMode\":" + "\"" + this.graduatedMode + "\"" + "," ;
			
			json += this.offset.toJSON() + ",";
			
			json += this.style.toJSON() +",";
			
			if(super.themeMemoryData){
				json += "\"memoryData\":" +  super.themeMemoryData.toJSON() +  "," ;
			}else{
				json += "\"memoryData\":" +  "null" +  "," ;
			}
			json += "\"type\":" + "\"" +   "GRADUATEDSYMBOL" + "\""  ;
			
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeGraduatedSymbol
		{
			var themeGraduatedSymbol:ThemeGraduatedSymbol = new ThemeGraduatedSymbol();
			if(object)
			{
				themeGraduatedSymbol.baseValue = object.baseValue;
				themeGraduatedSymbol.expression = object.expression;
				themeGraduatedSymbol.graduatedMode = object.graduateMode;
				themeGraduatedSymbol.style = ThemeGraduatedSymbolStyle.fromJson(object.style);
				themeGraduatedSymbol.offset = ThemeOffset.fromJson(object.offset);
			}
			return themeGraduatedSymbol;
		}

	}
}