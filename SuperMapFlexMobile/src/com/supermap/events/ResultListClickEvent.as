package com.supermap.events
{
	import flash.events.Event;
	
	public class ResultListClickEvent extends Event
	{
		public static const ORINGIN_SELECTED:String = "originSelected";
		public static const DEST_SELECTED:String = "destSelected";
		
		public var index:int;
		
		public function ResultListClickEvent(type:String,index:int)
		{
			super(type);
			this.index = index;
		}
	}
}