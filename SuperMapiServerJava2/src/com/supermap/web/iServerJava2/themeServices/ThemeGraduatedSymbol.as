package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeGraduatedSymbol_Title}.
	 * <p>${iServer2_themeServices_ThemeGraduatedSymbol_Description}</p> 
	 * 
	 * 
	 */	
	public class ThemeGraduatedSymbol extends Theme
	{
		private var _baseValue:Number = 1;		
		private var _expression:String;		
		private var _graduatedMode:int = 0;		
		private var _isFlowEnabled:Boolean = false;		
		private var _isLeaderLineDisplayed:Boolean = false;		
		private var _isNegativeDisplayed:Boolean = false;		
		private var _isZeroDisplayed:Boolean = false;		
		private var _leaderLineStyle:ServerStyle ;		
		private var _negativeStyle:ServerStyle;		
		private var _offsetX:String;		
		private var _offsetY:String;		
		private var _positiveStyle:ServerStyle;		
		private var _zeroStyle:ServerStyle;
		
		/**
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_constructor_D} 
		 * 
		 */		
		public function ThemeGraduatedSymbol()
		{
			super();
			positiveStyle = new ServerStyle();			
			positiveStyle.markerSize = 40;
			leaderLineStyle = new ServerStyle();
			negativeStyle = new ServerStyle();
			zeroStyle = new ServerStyle();
			this.themeType = ThemeType.GRADUATED_SYMBOL;
		}
		
		/**
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_zeroStyle_D} 
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
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_positiveStyle_D} 
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

		/**
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_offsetY_D}.
		 * <p>${iServer2_themeServices_ThemeGraduatedSymbol_attribute_offsetY_remarks}</p>
		 * @return 
		 * 
		 */		
		public function get offsetY():String
		{
			return _offsetY;
		}

		public function set offsetY(value:String):void
		{
			_offsetY = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_offsetX_D}.
		 * <p>${iServer2_themeServices_ThemeGraduatedSymbol_attribute_offsetX_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get offsetX():String
		{
			return _offsetX;
		}

		public function set offsetX(value:String):void
		{
			_offsetX = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_negativeStyle_D} 
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
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_leaderLineStyle_D} 
		 * @return 
		 * 
		 */		
		public function get leaderLineStyle():ServerStyle
		{
			return _leaderLineStyle;
		}

		public function set leaderLineStyle(value:ServerStyle):void
		{
			_leaderLineStyle = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_isZeroDisplayed_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get isZeroDisplayed():Boolean
		{
			return _isZeroDisplayed;
		}

		public function set isZeroDisplayed(value:Boolean):void
		{
			_isZeroDisplayed = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_isNegativeDisplayed_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get isNegativeDisplayed():Boolean
		{
			return _isNegativeDisplayed;
		}

		public function set isNegativeDisplayed(value:Boolean):void
		{
			_isNegativeDisplayed = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_isLeaderLineDisplayed_D}.
		 * <p>${iServer2_themeServices_ThemeGraduatedSymbol_attribute_isLeaderLineDisplayed_remarks}</p>
		 * @default false
		 * @see #isFlowEnabled
		 * @return 
		 * 
		 */		
		public function get isLeaderLineDisplayed():Boolean
		{
			return _isLeaderLineDisplayed;
		}

		public function set isLeaderLineDisplayed(value:Boolean):void
		{
			_isLeaderLineDisplayed = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_isFlowEnabled_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get isFlowEnabled():Boolean
		{
			return _isFlowEnabled;
		}

		public function set isFlowEnabled(value:Boolean):void
		{
			_isFlowEnabled = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_graduatedMode_D}.
		 * @default 1
		 * @see GraduatedMode
		 * @return 
		 * 
		 */		
		public function get graduatedMode():int
		{
			return _graduatedMode;
		}

		public function set graduatedMode(value:int):void
		{
			_graduatedMode = value;
		}
		
		/**
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_expression_D} 
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
		 * ${iServer2_themeServices_ThemeGraduatedSymbol_attribute_baseValue_D}.
		 * <p>${iServer2_themeServices_ThemeGraduatedSymbol_attribute_baseValue_remarks}</p> 
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
			
			json += "\"baseValue\":" + this.baseValue + ",";
			
			if(this.expression)
				json += "\"expression\":" + "\"" + this.expression + "\",";
			
			json += "\"graduatedMode\":" + this.graduatedMode + ",";
			
			json += "\"isFlowEnabled\":" + this.isFlowEnabled + "," ;
			
			if(this.isFlowEnabled == false)
				this.isLeaderLineDisplayed = false;
			
			json += "\"isLeaderLineDisplayed\":" + this.isLeaderLineDisplayed + "," ;
			
			json += "\"isNegativeDisplayed\":" + this.isNegativeDisplayed + ",";
			
			json += "\"isZeroDisplayed\":" + this.isZeroDisplayed + ",";
			
			
			if(this.leaderLineStyle)
				json += "\"leaderLineStyle\":" + this.leaderLineStyle.toJSON() + ",";
			if(this.negativeStyle)
				json += "\"negativeStyle\":" + this.negativeStyle.toJSON() + ",";
			
			if(offsetX)
				json += "\"offsetX\":" + "\"" + this.offsetX + "\",";	
			
			if(offsetY)
				json += "\"offsetY\":" + "\"" + this.offsetY + "\",";	
			
			if(this.zeroStyle)
				json += "\"zeroStyle\":" + this.zeroStyle.toJSON() + ",";
			
			json += "\"positiveStyle\":" + this.positiveStyle.toJSON() + ",";
			
			json += "\"themeType\":" + this.themeType;
			
			if(json.length > 0)
				json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function toThemeGraduatedSymbol(object:Object):ThemeGraduatedSymbol
		{
			var themeGraduatedSymbol:ThemeGraduatedSymbol;
			if(object)
			{
				themeGraduatedSymbol = new ThemeGraduatedSymbol();
				
				themeGraduatedSymbol.baseValue = object.baseValue;
				
				themeGraduatedSymbol.expression = object.expression;
				
				themeGraduatedSymbol.graduatedMode = object.graduatedMode;
				
				themeGraduatedSymbol.isFlowEnabled = object.isFlowEnabled;
				
				themeGraduatedSymbol.isLeaderLineDisplayed = object.isLeaderLineDisplayed;
				
				themeGraduatedSymbol.isNegativeDisplayed = object.isNegativeDisplayed;
				
				themeGraduatedSymbol.isZeroDisplayed = object.isZeroDisplayed;
				
				themeGraduatedSymbol.leaderLineStyle = ServerStyle.toServerStyle(object.leaderLineStyle);
				
				themeGraduatedSymbol.negativeStyle = ServerStyle.toServerStyle(object.negativeStyle);
				
				themeGraduatedSymbol.offsetX = object.offsetX;
				
				themeGraduatedSymbol.offsetY = object.offsetY;
				
				themeGraduatedSymbol.positiveStyle = ServerStyle.toServerStyle(object.positiveStyle);
				
				themeGraduatedSymbol.zeroStyle = ServerStyle.toServerStyle(object.zeroStyle);
				
				themeGraduatedSymbol.themeType = object.themeType;
				
			}
			return themeGraduatedSymbol;
		}
	}
}