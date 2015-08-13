package com.supermap.web.iServerJava6R.themeServices
{
	//图表尺寸类
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeGraphSize_Title}.
	 * <p>${iServerJava6R_ThemeGraphSize_Description}</p> 
	 * 
	 */	
	public class ThemeGraphSize
	{
		private var  _maxGraphSize:Number = 0;	
		private var _minGraphSize:Number = 0;

		/**
		 * ${iServerJava6R_ThemeGraphSize_constructor_D} 
		 * 
		 */		
		public function ThemeGraphSize()
		{
		}

		/**
		 * ${iServerJava6R_ThemeGraphSize_attribute_minGraphSize_D} 
		 * @return 
		 * 
		 */		
		public function get minGraphSize():Number
		{
			return _minGraphSize;
		}

		public function set minGraphSize(value:Number):void
		{
			_minGraphSize = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraphSize_attribute_maxGraphSize_D} 
		 * @return 
		 * 
		 */		
		public function get maxGraphSize():Number
		{
			return _maxGraphSize;
		}

		public function set maxGraphSize(value:Number):void
		{
			_maxGraphSize = value;
		}
		
		sm_internal  function toJSON():String
		{
			var json:String = "";
			
			json += "\"maxGraphSize\":" + this.maxGraphSize  +  "," ;
			
			json += "\"minGraphSize\":" +  this.minGraphSize;
			
			return json;
			 
		}
		
		sm_internal static function fromJson(object:Object):ThemeGraphSize
		{
			var themeGraphSize:ThemeGraphSize;
			if(object)
			{
				themeGraphSize.maxGraphSize = object.maxGraphSize;
				themeGraphSize.minGraphSize = object.minGraphSize;
			}
			return themeGraphSize;
		}

	}
}