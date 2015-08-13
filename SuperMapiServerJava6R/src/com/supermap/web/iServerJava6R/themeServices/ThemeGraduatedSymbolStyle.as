package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeGraduatedSymbolStyle_Title}.
	 * <p>${iServerJava6R_ThemeGraduatedSymbolStyle_Description}</p> 
	 * 
	 */	
	public class ThemeGraduatedSymbolStyle
	{
		private var _positiveStyle:ServerStyle = new ServerStyle();
		private var _negativeStyle:ServerStyle = new ServerStyle();
		private var _negativeDisplayed:Boolean = false;
		private var _zeroStyle:ServerStyle = new ServerStyle();
		private  var _zeroDisplayed:Boolean = false ;

		/**
		 * ${iServerJava6R_ThemeGraduatedSymbolStyle_constructor_D} 
		 * 
		 */		
		public function ThemeGraduatedSymbolStyle()
		{
		}

		/**
		 * ${iServerJava6R_ThemeGraduatedSymbolStyle_attribute_zeroDisplayed_D} 
		 * @return 
		 * 
		 */		
		public function get zeroDisplayed():Boolean
		{
			return _zeroDisplayed;
		}

		public function set zeroDisplayed(value:Boolean):void
		{
			_zeroDisplayed = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraduatedSymbolStyle_attribute_zeroStyle_D} 
		 * @return 
		 * 
		 */		
		public function get zeroStyle():ServerStyle
		{
			return _zeroStyle;
		}

		public function set zeroStyle(value:ServerStyle):void
		{
			_zeroStyle = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraduatedSymbolStyle_attribute_negativeDisplayed_D} 
		 * @return 
		 * 
		 */		
		public function get negativeDisplayed():Boolean
		{
			return _negativeDisplayed;
		}

		public function set negativeDisplayed(value:Boolean):void
		{
			_negativeDisplayed = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraduatedSymbolStyle_attribute_negativeStyle_D} 
		 * @return 
		 * 
		 */		
		public function get negativeStyle():ServerStyle
		{
			return _negativeStyle;
		}

		public function set negativeStyle(value:ServerStyle):void
		{
			_negativeStyle = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraduatedSymbolStyle_attribute_positiveStyle_D} 
		 * @return 
		 * 
		 */		
		public function get positiveStyle():ServerStyle
		{
			return _positiveStyle;
		}

		public function set positiveStyle(value:ServerStyle):void
		{
			_positiveStyle = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"positiveStyle\":" +  this.positiveStyle.toJSON()  +  "," ;
			
			json += "\"negativeStyle\":" +  this.negativeStyle.toJSON() +  "," ;
			
			json += "\"negativeDisplayed\":" + this.negativeDisplayed + "," ;
			
			json += "\"zeroStyle\":" + this.zeroStyle.toJSON() + ",";	
			
			json += "\"zeroDisplayed\":" + this.zeroDisplayed;			
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeGraduatedSymbolStyle
		{
			var themeGraduatedSymbolStyle:ThemeGraduatedSymbolStyle;
			if(object)
			{
				themeGraduatedSymbolStyle = new ThemeGraduatedSymbolStyle();
				themeGraduatedSymbolStyle.negativeDisplayed = object.negativeDisplayed;
				themeGraduatedSymbolStyle.zeroDisplayed = object.zeroDisplayed;
				themeGraduatedSymbolStyle.negativeStyle = ServerStyle.fromJson(object.negativeStyle);
				themeGraduatedSymbolStyle.positiveStyle = ServerStyle.fromJson(object.positiveStyle);
				themeGraduatedSymbolStyle.zeroStyle = ServerStyle.fromJson(object.zeroStyle);
			}
			
			return themeGraduatedSymbolStyle;
			
		}

	}
}