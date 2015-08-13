package com.supermap.web.iServerJava2.themeServices
{
	/**
	 * ${iServer2_themeServices_OverLengthLabelMode_Title}.
	 * <p>${iServer2_themeServices_OverLengthLabelMode_remarks}</p> 
	 * 
	 * 
	 */	
	public class OverLengthLabelMode
	{
		/**
		 * ${iServer2_themeServices_OverLengthLabelMode_attribute_none_D} 
		 */		
		public static const NONE:int               = 0; //对超长标签不进行处理，此为默认模式，即在一行中全部显示此超长标签		
		/**
		 * ${iServer2_themeServices_OverLengthLabelMode_attribute_omit_D_as}
		 * @see ThemeLabelItem#MaxLabelLength 
		 */		
		public static const OMIT:int               = 1; //省略超出部分。此模式将超长标签中超出指定的标签最大长度（MaxLabelLength）的部分用省略号表示
		/**
		 * ${iServer2_themeServices_OverLengthLabelMode_attribute_newLine_D} 
		 */		
		public static const NEW_LINE:int           = 2; //换行显示
		
		/**
		 * @private 
		 * 
		 */		
		public function OverLengthLabelMode()
		{
		}
	}
}