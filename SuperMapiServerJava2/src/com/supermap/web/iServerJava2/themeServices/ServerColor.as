package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_Theme_ServerColor_Title}.
	 * <p>${iServer2_Theme_ServerColor_Description}</p> 
	 * 
	 */	
	public class ServerColor
	{
		
		private var _red:Number = 255;
		private var _green:Number = 0;
		private var _blue:Number = 0;
		
		/**
		 * ${iServer2_Theme_ServerColor_constructor_D} 
		 * @param red ${iServer2_Theme_ServerColor_constructor_param_Red}
		 * @param green ${iServer2_Theme_ServerColor_constructor_param_Green}
		 * @param blue ${iServer2_Theme_ServerColor_constructor_param_Blue}
		 * 
		 */		
		public function ServerColor(red:Number = 0, green:Number = 0, blue:Number = 0)
		{
			this._red 	= red;
			this._green = green;
			this._blue 	= blue;
		}
		
		
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"red\":" + this._red.toString() + ",";
			
			json += "\"green\":" + this._green.toString() + ",";
			
			json += "\"blue\":" + this._blue.toString();
			
			if(json.length > 0)
				json = "{" + json + "}";
			return json;
		}
			
		/**
		 * ${iServer2_Theme_ServerColor_attribute_Red_D} 
		 * @default 255
		 * @return 
		 * 
		 */		
		public function get red():Number
		{
			return this._red
		}
		
		public function set red(value:Number):void
		{
			this._red = value > 255 ? (255) : (value < 0 ? (0) : (value));
		}
		
		/**
		 * ${iServer2_Theme_ServerColor_attribute_Green_D} 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get green():Number
		{
			return this._green;
		}
		
		public function set green(value:Number):void
		{
			this._green = value > 255 ? (255) : (value < 0 ? (0) : (value));
		}
		
		/**
		 * ${iServer2_Theme_ServerColor_attribute_Blue_D} 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get blue():Number
		{
			return this._blue;
		}
		
		public function set blue(value:Number):void
		{
			this._blue = value > 255 ? (255) : (value < 0 ? (0) : (value));
		}
		
		sm_internal static function toServerColor(object:Object):ServerColor
		{
			var serverColor:ServerColor;
			if(object)
			{
				serverColor = new ServerColor;
				serverColor._blue = object.blue;
				serverColor._green = object.green;
				serverColor._red = object.red;
			}
			
			return serverColor;
		}
		
		
	}
}