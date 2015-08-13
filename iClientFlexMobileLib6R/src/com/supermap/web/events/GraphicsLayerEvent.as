package com.supermap.web.events
{
	import flash.events.Event;

	/**
	 * ${events_GraphicsLayerEvent_Title}.
	 * <p>${events_GraphicsLayerEvent_Description}</p> 
	 * 
	 */	
	public class GraphicsLayerEvent extends Event
	{
		/**
		 * ${events_GraphicsLayerEvent_field_GRAPHICS_ADD_D} 
		 */		
		public static const GRAPHICS_ADD:String = "graphicsAdd";

		/**
		 * ${events_GraphicsLayerEvent_field_GRAPHICS_REMOVE_D} 
		 */		
		public static const GRAPHICS_REMOVE:String = "graphicsRemove";

		/**
		 * ${events_GraphicsLayerEvent_field_GRAPHICS_REMOVE_ALL_D} 
		 */		
		public static const GRAPHICS_REMOVE_ALL:String = "graphicsRemoveAll";

		private var _errorGraphics:Array = [];

		private var _message:String;

		/**
		 * ${events_GraphicsLayerEvent_constructor_D} 
		 * @param type ${events_GraphicsLayerEvent_constructor_param_type}
		 * @param errorGraphics ${events_GraphicsLayerEvent_constructor_param_errorGraphics}
		 * @param message ${events_GraphicsLayerEvent_constructor_param_message}
		 * 
		 */		
		public function GraphicsLayerEvent(type:String, errorGraphics:Array = null, message:String = null)
		{
			super(type);
			this._errorGraphics = errorGraphics;
			this._message = message;
		}

		/**
		 * ${events_GraphicsLayerEvent_attribute_message_D} 
		 * @return 
		 * 
		 */		
		public function get message():String
		{
			return _message;
		}

		/**
		 * ${events_GraphicsLayerEvent_attribute_errorGraphics_D} 
		 * @return 
		 * 
		 */		
		public function get errorGraphics():Array
		{
			return _errorGraphics;
		}

		public function set errorGraphics(value:Array):void
		{
			_errorGraphics = value;
		}


	}
}
