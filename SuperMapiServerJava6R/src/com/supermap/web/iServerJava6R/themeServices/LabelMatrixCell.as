package com.supermap.web.iServerJava6R.themeServices
{
	/**
	 * ${iServerJava6R_LabelMatrixCell_Title}.
	 * <p>${iServerJava6R_LabelMatrixCell_Description}</p>
	 * @see ThemeLabel
	 * @see LabelSymbolCell
	 * @see LabelThemeCell
	 * @see LabelImageCell
	 */	
	public class LabelMatrixCell
	{
		private var _type:String = LabelMatrixCellType.IMAGE;
		
		/**
		 * ${iServerJava6R_LabelMatrixCell_constructor_D} 
		 * 
		 */		
		public function LabelMatrixCell()
		{
		}

		/**
		 * ${iServerJava6R_LabelMatrixCell_attribute_type_D} 
		 * @see LabelMatrixCellType
		 * @return 
		 * 
		 */		
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

	}
}