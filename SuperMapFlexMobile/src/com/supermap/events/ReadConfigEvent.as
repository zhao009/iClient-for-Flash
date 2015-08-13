package com.supermap.events
{
	import flash.events.Event;

	public class ReadConfigEvent extends Event
	{
		public static const READ_COMPLETE:String = "readComplete";
		
		public function ReadConfigEvent(type:String)
		{
			super(type);
		}
	}
}