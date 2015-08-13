package com.supermap.events
{
	import flash.events.Event;
	
	public class QueryInfoWinClickEvent extends Event
	{
		public static const INFOWIN_CLICK:String = "infowinClick";
		
		public function QueryInfoWinClickEvent(type:String)
		{
			super(type);
		}
	}
}