package com.supermap.web.samples.trafficTransfer
{
	import flash.events.Event;
	
	public class TransferTacticEvent extends Event
	{
		public static var TRANSFER_TACTIC_CHANGE:String = "transferTacticChange";
		private var _tacticInfo:String;
		
		public function TransferTacticEvent(type:String, tacticInfo:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this._tacticInfo = tacticInfo;
		}

		public function get tacticInfo():String
		{
			return _tacticInfo;
		}

		public function set tacticInfo(value:String):void
		{
			_tacticInfo = value;
		}

	}
}