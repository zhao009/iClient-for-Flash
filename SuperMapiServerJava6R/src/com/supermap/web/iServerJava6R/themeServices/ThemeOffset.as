package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ThemeOffset_Title}.
	 * <p>${iServerJava6R_ThemeOffset_Description}</p> 
	 * 
	 */	 
	public class ThemeOffset
	{
		private var _offsetFixed:Boolean = false;
		private var _offsetX:String = "";
		private var _offsetY:String = "";
		
		/**
		 * ${iServerJava6R_ThemeOffset_constructor_D} 
		 * 
		 */		
		public function ThemeOffset()
		{
		}

		 /**
		  * ${iServerJava6R_ThemeOffset_attribute_offsetY_D}.
		  * <p>${iServerJava6R_ThemeOffset_attribute_offsetY_remarks}</p> 
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
		 * ${iServerJava6R_ThemeOffset_attribute_offsetX_D}.
		 * <p>${iServerJava6R_ThemeOffset_attribute_offsetX_remarks}</p> 
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
		 * 专题图是否固定偏移量。固定偏移量，则统计图的偏移量不随地图的缩放而变化。
		 */
		/**
		 * ${iServerJava6R_ThemeOffset_attribute_offsetFixed_D}.
		 * <p>${iServerJava6R_ThemeOffset_attribute_offsetFixed_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get offsetFixed():Boolean
		{
			return _offsetFixed;
		}
		public function set offsetFixed(value:Boolean):void
		{
			_offsetFixed = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"offsetFixed\":" + this.offsetFixed+ "," ;
			
			json += "\"offsetX\":" + "\"" + this.offsetX + "\"" + "," ;
			
			json += "\"offsetY\":" + "\"" + this.offsetY + "\"" ;
			
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ThemeOffset
		{
			var themeOffset:ThemeOffset;
			if(object)
			{
				themeOffset.offsetFixed = object.offsetFixed;
				themeOffset.offsetX = object.offsetX;
				themeOffset.offsetY = object.offsetY;
				
			}
			return themeOffset;
		}

	}
}