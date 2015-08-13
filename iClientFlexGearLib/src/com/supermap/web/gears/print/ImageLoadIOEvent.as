package com.supermap.web.gears.print
{
	import flash.events.Event;
	
	/**
	 * ${gears_print_ImageLoadIOEvent_Title} 
	 * 
	 */	
	public class ImageLoadIOEvent extends Event
	{
		/**
		 * ${gears_print_ImageLoadIOEvent_attribute_IMAGELOAD_IOERROR_D} 
		 */		
		public static const IMAGELOAD_IOERROR:String = "imagelaod_ioerror";
	
		private var _mess:String = "";
		
		/**
		 * ${gears_print_ImageLoadIOEvent_constructor_D} 
		 * @param type ${gears_print_ImageLoadIOEvent_constructor_param_type}
		 * @param mess ${gears_print_ImageLoadIOEvent_constructor_param_mess}
		 * 
		 */		
		public function ImageLoadIOEvent(type:String, mess:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this._mess = mess;
			super(type, bubbles, cancelable);
		}
		
		/**
		 * ${gears_print_ImageLoadIOEvent_attribute_mess_D} 
		 * @return 
		 * 
		 */		
		public function get mess():String
		{
			return _mess;
		}

		public function set mess(value:String):void
		{
			_mess = value;
		}

	}
}