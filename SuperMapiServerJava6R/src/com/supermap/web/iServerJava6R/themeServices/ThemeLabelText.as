package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerTextStyle;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ThemeLabelText_Title}.
	 * <p>${iServerJava6R_ThemeLabelText_Description}</p> 
	 * 
	 */	
	public class ThemeLabelText
	{
		private var _maxTextHeight:int = 0
		private var _maxTextWidth:int = 0 ;
		private var _minTextHeight:int = 0;
		private var _minTextWidth:int = 0;
		private var _uniformStyle:ServerTextStyle = new ServerTextStyle();
		private var _uniformMixedStyle:LabelMixedTextStyle = null;

		/**
		 * ${iServerJava6R_ThemeLabelText_constructor_D} 
		 * 
		 */		
		public function ThemeLabelText()
		{
		}

		/**
		 * ${iServerJava6R_ThemeLabelText_attribute_uniformMixedSytle_D}.
		 * <p>${iServerJava6R_ThemeLabelText_attribute_uniformMixedSytle_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get uniformMixedStyle():LabelMixedTextStyle
		{
			return _uniformMixedStyle;
		}

		public function set uniformMixedStyle(value:LabelMixedTextStyle):void
		{
			_uniformMixedStyle = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabelText_attribute_uniformSytle_D}.
		 * <p>${iServerJava6R_ThemeLabelText_attribute_uniformSytle_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get uniformStyle():ServerTextStyle
		{
			return _uniformStyle;
		}

		public function set uniformStyle(value:ServerTextStyle):void
		{
			_uniformStyle = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabelText_attribute_minTextWidth_D}.
		 * <p>${iServerJava6R_ThemeLabelText_attribute_minTextWidth_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get minTextWidth():Number
		{
			return _minTextWidth;
		}

		public function set minTextWidth(value:Number):void
		{
			_minTextWidth = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabelText_attribute_minTextHeight_D}.
		 * <p>${iServerJava6R_ThemeLabelText_attribute_minTextHeight_remarks}</p> 
		 * @return 
		 * 
		 */			
		public function get minTextHeight():Number
		{
			return _minTextHeight;
		}

		public function set minTextHeight(value:Number):void
		{
			_minTextHeight = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabelText_attribute_maxTextWidth_D}.
		 * <p>${iServerJava6R_ThemeLabelText_attribute_maxTextWidth_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get maxTextWidth():Number
		{
			return _maxTextWidth;
		}

		public function set maxTextWidth(value:Number):void
		{
			_maxTextWidth = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabelText_attribute_maxTextHeight_D}.
		 * <p>${iServerJava6R_ThemeLabelText_attribute_maxTextHeight_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get maxTextHeight():Number
		{
			return _maxTextHeight;
		}

		public function set maxTextHeight(value:Number):void
		{
			_maxTextHeight = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"minTextHeight\":" +  this.minTextHeight +  "," ;
			
			json += "\"maxTextWidth\":" + this.maxTextWidth + "," ;
			
			json += "\"minTextWidth\":" + this.minTextWidth + "," ;
			
			json += "\"maxTextHeight\":" + this.maxTextHeight + "," ;
			
			json += "\"uniformStyle\":" + this.uniformStyle.toJSON() + ",";			
				
			if(this.uniformMixedStyle)
				json += "\"uniformMixedStyle\":" + this.uniformMixedStyle.toJSON();
			else
				json += "\"uniformMixedStyle\":" + "null";
			
			return json;
		}


	}
}