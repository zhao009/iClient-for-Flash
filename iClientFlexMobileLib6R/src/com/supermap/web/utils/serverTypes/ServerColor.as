package com.supermap.web.utils.serverTypes
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ServerType_ServerColor_Tile}.
	 * <p>${iServerJava6R_ServerType_ServerColor_Description}</p> 
	 * 
	 */	
	public class ServerColor
	{
		
		private var _red:Number = 255;
		private var _green:Number = 0;
		private var _blue:Number = 0;
		
		/**
		 * ${iServerJava6R_ServerType_ServerColor_constructor_String_D} 
		 * @param red ${iServerJava6R_ServerType_ServerColor_constructor_param_red}
		 * @param green ${iServerJava6R_ServerType_ServerColor_constructor_param_green}
		 * @param blue ${iServerJava6R_ServerType_ServerColor_constructor_param_blue}
		 * 
		 */		
		public function ServerColor(red:Number = 0, green:Number = 0, blue:Number = 0)
		{
			this._red 	= red;
			this._green = green;
			this._blue 	= blue;
		}
		
		/**
		 * ${iServerJava6R_ServerType_ServerColor_attribute_red_D} 
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
		 * ${iServerJava6R_ServerType_ServerColor_attribute_Green_D} 
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
		 * ${iServerJava6R_ServerType_ServerColor_attribute_Blue_D} 
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
		
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"red\":" + this._red.toString() + ",";
			
			json += "\"green\":" + this._green.toString() + ",";
			
			json += "\"blue\":" + this._blue.toString();
			
			json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function fromJson(object:Object):ServerColor
		{
			var serverColor:ServerColor;
			if(object)
			{
				serverColor = new ServerColor();
				
				serverColor._blue = object.blue;
				serverColor._green = object.green;
				serverColor._red = object.red;
			}
			return serverColor;
		}
	}
}