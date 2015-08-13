package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.iServerJava6R.themeServices.LabelBackShape;
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeLabelBackGround_Title}.
	 * <p>${iServerJava6R_ThemeLabelBackGround_Description}</p> 
	 * 
	 */	
	public class ThemeLabelBackground
	{
		private var _labelBackShape:String = LabelBackShape.NONE;
		private var _backStyle:ServerStyle = new ServerStyle();
		
		/**
		 * ${iServerJava6R_ThemeLabelBackGround_constructor_D} 
		 * 
		 */		
		public function ThemeLabelBackground()
		{
		}

		/**
		 * ${iServerJava6R_ThemeLabelBackGround_attribute_backStyle_D}.
		 * <p>${iServerJava6R_ThemeLabelBackGround_attribute_backStyle_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get backStyle():ServerStyle
		{
			return _backStyle;
		}

		public function set backStyle(value:ServerStyle):void
		{
			_backStyle = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabelBackGround_attribute_labelBackShape_D}.
		 * <p>${iServerJava6R_ThemeLabelBackGround_attribute_labelBackShape_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get labelBackShape():String
		{
			return _labelBackShape;
		}

		public function set labelBackShape(value:String):void
		{
			_labelBackShape = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"labelBackShape\":" + "\"" +  this.labelBackShape +  "\"" +  "," ;
			
			json += "\"backStyle\":" + this.backStyle.toJSON() ;		
						
			return json;
			
		}	
		sm_internal static function  fromJson(object:Object):ThemeLabelBackground
		{
			var themeLabelBackground:ThemeLabelBackground;
			if(object)
			{
				themeLabelBackground = new ThemeLabelBackground();
				themeLabelBackground.labelBackShape = object.labelBackShape;
				themeLabelBackground.backStyle = ServerStyle.fromJson(object.backStyle);
			}
			return themeLabelBackground;
		}

	}
}