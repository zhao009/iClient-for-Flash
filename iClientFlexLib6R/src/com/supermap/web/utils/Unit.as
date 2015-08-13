package com.supermap.web.utils
{	
	/**
	 * ${core_Unit_Title}.
	 * <p>${core_Unit_Description}</p> 
	 * 
	 * 
	 */	
	public final class Unit
	{
		//这些常量是需要对外使用的，返回字符串比以前的返回一堆数字要好
		/**
		 * ${core_Unit_field_METER_D} 
		 */		
		public static var METER:String = "meter";      //米,默认值
		/**
		 * ${core_Unit_field_DECIMETER_D} 
		 */		
		public static var DECIMETER:String = "decimeter";    //分米DECIMETER
		/**
		 * ${core_Unit_field_CENTIMETER_D} 
		 */		
		public static var CENTIMETER:String = "centimeter";   //厘米METERCENTIMETER
		/**
		 * ${core_Unit_field_MILLIMETER_D} 
		 */		
		public static var MILLIMETER:String = "millimeter";   //豪米
		/**
		 * ${core_Unit_field_KILOMETER_D} 
		 */		
		public static var KILOMETER:String = "kilometer";    //千米
		
		/**
		 * ${core_Unit_field_FOOT_D} 
		 */		
		public static var FOOT:String = "foot";  //英尺
		/**
		 * ${core_Unit_field_MILE_D} 
		 */		
		public static var MILE:String = "mile";  //英里
		/**
		 * ${core_Unit_field_INCH_D}
		 */
		public static var INCH:String = "inch";  //英寸
		/**
		 * ${core_Unit_field_YARD_D} 
		 */		
		public static var YARD:String = "yard";  //码（1码=3英尺）
		
		/**
		 * ${core_Unit_field_DEGREE_D} 
		 */		
		public static var DEGREE:String = "degree";  //度
		/**
		 * ${core_Unit_field_DECIMAL_DEGREE_D} 
		 */		
		public static var DECIMAL_DEGREE:String = "decimal_degree";  //不好翻译，天宝补充一下
		/**
		 * ${core_Unit_field_MINUTE_D} 
		 */		
		public static var MINUTE:String = "minute";  //分
		/**
		 * ${core_Unit_field_SECOND_D} 
		 */		
		public static var SECOND:String = "second";  //秒
		/**
		 * ${core_Unit_field_RADIAN_D} 
		 */		
		public static var RADIAN:String = "radian";  //弧度
		/**
		 * ${core_Unit_field_UNDEFINED_D} 
		 */		
		public static var UNDEFINED:String = "Undefined";  //未定义
		//public static var POINT:String = "point";  //点，可以理解成像素点，参考ESRI
		

/*		/**
		 * 换算方法，其他单位与Meter之间的换算
		 *
		 * @param unit 需换算的单位常量
		 * @return 换算成以Meter为单位的值
		 */
		/**
		 * ${core_Unit_static_method_getMetersPerUnit_D} 
		 * @param unit ${core_Unit_static_method_getMetersPerUnit_param_unit}
		 * @return ${core_Unit_static_method_getMetersPerUnit_param_return}
		 * 
		 */		
		public static function getMetersPerUnit(unit:String):Number
		{
			switch(unit)
			{
				case Unit.METER:
					return 1.0;
					break;
				case Unit.DECIMETER:
					return 0.1;
					break;
				case Unit.CENTIMETER:
					return 0.01;
					break;
				case Unit.MILLIMETER:
					return 0.001;
					break;
				case Unit.KILOMETER:
					return 1000;
					break;
				case Unit.FOOT:
					return 0.3048;
					break;
				case Unit.INCH:
					return 0.0254;
					break;
				case Unit.MILE:
					return 1609.34;
					break;
				case Unit.YARD:
					return 0.9144;
					break;
				case Unit.DEGREE:
					return 1001745329;
					break;
				case Unit.DECIMAL_DEGREE:
					return 0;
					break;
				case Unit.MINUTE:
					return 1000029089;
					break;
				case Unit.SECOND:
					return 1000000485;
					break;
				case Unit.RADIAN:
					return 1100000000;
					break;
				default:
					return 0;
					break;
			}
		}
		
		public static function getUnitFronMillimetre(millimetre:String):String
		{
			switch(millimetre)
			{
				case "10000":
					return Unit.METER;
					break;
				case "1000":
					return Unit.DECIMETER;
					break;
				case "100":
					return Unit.CENTIMETER;
					break;
				case "10":
					return Unit.MILLIMETER;
					break;
				case "10000000":
					return Unit.KILOMETER;
					break;
				case "3048":
					return Unit.FOOT;
					break;
				case "254":
					return Unit.INCH;
					break;
				case "16090000":
					return Unit.MILE;
					break;
				case "9144":
					return Unit.YARD;
					break;
				case "1001745329":
					return Unit.DEGREE;
					break;
				case "0":
					return Unit.DECIMAL_DEGREE;
					break;
				case "1000029089":
					return Unit.MINUTE;
					break;
				case "1000000485":
					return Unit.SECOND;
					break;
				case "1100000000":
					return Unit.RADIAN;
					break;
				default:
					return "undefined";
					break;
			}
		}
	}
}