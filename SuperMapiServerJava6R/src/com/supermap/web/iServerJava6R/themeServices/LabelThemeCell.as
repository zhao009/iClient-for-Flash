package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_LabelThemeCell_Title}.
	 * <p>${iServerJava6R_LabelThemeCell_Description}</p> 
	 * 
	 */	
	public class LabelThemeCell extends LabelMatrixCell
	{
		private var _themeLabel:ThemeLabel;
		
		/**
		 * ${iServerJava6R_LabelThemeCell_constructor_D} 
		 * 
		 */		
		public function LabelThemeCell()
		{
			super();
			this.type=LabelMatrixCellType.THEME;
		}

		/**
		 * ${iServerJava6R_LabelThemeCell_attribute_themeLabel_D} 
		 * @return 
		 * 
		 */		
		public function get themeLabel():ThemeLabel
		{
			return _themeLabel;
		}

		public function set themeLabel(value:ThemeLabel):void
		{
			_themeLabel = value;
		}
		
		sm_internal function toJson():String
		{
			var json:String = "";
			
			json += "\"type\":" + "\"" + this.type + "\",";
			
			if(this._themeLabel)
				json += "\"themeLabel\":" + this._themeLabel.toJSON();
			else
				json += "\"themeLabel\":null";
			
			json ="{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):LabelThemeCell
		{
			var labelTheme:LabelThemeCell;
			if(object)
			{
				labelTheme = new LabelThemeCell();
				
				labelTheme._themeLabel = ThemeLabel.fromJson(object);
				
				if(object.type)
					labelTheme.type = object.type
			}
			return labelTheme;
		}

	}
}