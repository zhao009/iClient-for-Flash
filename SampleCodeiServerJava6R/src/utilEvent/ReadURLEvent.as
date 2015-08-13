package utilEvent
{
	import flash.events.Event;

	public class ReadURLEvent extends Event
	{
		public static const READ_COMPLETE:String = "readComplete";
		
		public function ReadURLEvent(type:String)
		{
			super(type);
		}
	}
}