package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_LabelSymbolCell_Title}.
	 * <p>${iServerJava6R_LabelSymbolCell_Description}</p> 
	 * @see ThemeLabel
	 * @see LabelImageCell
	 * @see LabelThemeCell
	 */	
	public class LabelSymbolCell extends LabelMatrixCell
	{
		private var _style:ServerStyle = new ServerStyle();;
		private var _symbolIDField:String;
		
		/**
		 * ${iServerJava6R_LabelSymbolCell_constructor_D} 
		 * 
		 */		
		public function LabelSymbolCell()
		{
			super();
			this.type=LabelMatrixCellType.SYMBOL;
		}

		/**
		 * ${iServerJava6R_LabelSymbolCell_attribute_symbolIDField_D} 
		 * @return 
		 * 
		 */		
		public function get symbolIDField():String
		{
			return _symbolIDField;
		}

		public function set symbolIDField(value:String):void
		{
			_symbolIDField = value;
		}

		/**
		 * ${iServerJava6R_LabelSymbolCell_attribute_style_D} 
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
		
		sm_internal function toJson():String
		{
			var json:String = "";
			
			json += "\"type\":" + "\"" + this.type + "\",";
			
			json += "\"symbolIDField\":" + "\"" + this._symbolIDField + "\",";
			
			json += "\"style\":" + this._style.toJSON();
			
			json ="{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):LabelSymbolCell
		{
			var labelSymbol:LabelSymbolCell;
			if(object)
			{
				labelSymbol = new LabelSymbolCell();
				
				labelSymbol._symbolIDField = object.symbolIDField;
				labelSymbol._style = object.style;
				
				if(object.type)
					labelSymbol.type = object.type
				
			}
			return labelSymbol;
		}

	}
}