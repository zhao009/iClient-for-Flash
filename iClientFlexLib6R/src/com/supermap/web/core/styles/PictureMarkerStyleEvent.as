package com.supermap.web.core.styles
{
	import flash.events.Event;
	/**
	 * @private 
	 * 
	 */	
	internal class PictureMarkerStyleEvent extends Event
	{
		public static const COMPLETE:String = "Complete";
		
		function PictureMarkerStyleEvent(type:String)
		{
			super(type);
			
		}
		
		override public function clone() : Event
		{
			return new PictureMarkerStyleEvent(type);
		}
	}
}