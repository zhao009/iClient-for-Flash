package com.supermap.web.iServerJava6R.themeServices
{
	//统计专题图坐标轴设置类
	import com.supermap.web.utils.serverTypes.ServerColor;
	import com.supermap.web.utils.serverTypes.ServerTextStyle;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeGraphAxes_Title}.
	 * <p>${iServerJava6R_ThemeGraphAxes_Description}</p> 
	 * 
	 */	
	public class ThemeGraphAxes
	{
		private var _axesColor:ServerColor = new ServerColor(); //坐标轴颜色，AxesDisplayed=true 时有效
		private var _axesDisplayed:Boolean = false;
		private var _axesGridDisplayed:Boolean = false;   //是否在统计图坐标轴上显示网格
		private var _axesTextDisplayed:Boolean = false;  //是否显示坐标轴的文本标注
		private var _axesTextStyle:ServerTextStyle = new ServerTextStyle();//坐标轴文本风格。AxesTextDisplayed=true 时有效。

		/**
		 * ${iServerJava6R_ThemeGraphAxes_constructor_D} 
		 * 
		 */		
		public function ThemeGraphAxes()
		{
		}

		/**
		 * ${iServerJava6R_ThemeGraphAxes_attribute_axesTextStyle_D}
		 * @see #axesTextDisplayed
		 * @return 
		 * 
		 */		
		public function get axesTextStyle():ServerTextStyle
		{
			return _axesTextStyle;
		}

		public function set axesTextStyle(value:ServerTextStyle):void
		{
			_axesTextStyle = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraphAxes_attribute_axesTextDisplayed_D} 
		 * @return 
		 * 
		 */		
		public function get axesTextDisplayed():Boolean
		{
			return _axesTextDisplayed;
		}

		public function set axesTextDisplayed(value:Boolean):void
		{
			_axesTextDisplayed = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraphAxes_attribute_axesGridDisplayed_D} 
		 * @return 
		 * 
		 */		
		public function get axesGridDisplayed():Boolean
		{
			return _axesGridDisplayed;
		}

		public function set axesGridDisplayed(value:Boolean):void
		{
			_axesGridDisplayed = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraphAxes_attribute_axesDisplayed_D}.
		 * <p>${iServerJava6R_ThemeGraphAxes_attribute_axesDisplayed_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get axesDisplayed():Boolean
		{
			return _axesDisplayed;
		}

		public function set axesDisplayed(value:Boolean):void
		{
			_axesDisplayed = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraphAxes_attribute_axesColor_D} 
		 * @return 
		 * 
		 */		
		public function get axesColor():ServerColor
		{
			return _axesColor;
		}

		public function set axesColor(value:ServerColor):void
		{
			_axesColor = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"axesColor\":" +  this.axesColor.toJSON() +  "," ;
			
			json += "\"axesDisplayed\":" +  this.axesDisplayed +  "," ;
			
			json += "\"axesGridDisplayed\":" + this.axesGridDisplayed + "," ;
			
			json += "\"axesTextDisplayed\":" + "\"" + this.axesTextDisplayed + "\"" +  "," ;
			
			json += "\"axesTextStyle\":" + this.axesTextStyle.toJSON() ;
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeGraphAxes
		{
			var themeGraphAxes:ThemeGraphAxes;
			if(object)
			{
				themeGraphAxes.axesColor = object.axesColor;
				themeGraphAxes.axesDisplayed = object.axesDisplayed;
				themeGraphAxes.axesGridDisplayed = object.axesGridDisplayed;
				themeGraphAxes.axesTextDisplayed = object.axesTextDisplayed;
				themeGraphAxes.axesTextStyle = ServerTextStyle.fromJson(object.axesTextStyle);
			}
			return themeGraphAxes;
		}

	}
}