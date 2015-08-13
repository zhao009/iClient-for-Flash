package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.trafficTransferAnalystServices.TransferPathResult;
	import flash.events.Event;
	
	public class TransferPathEvent extends Event
	{
		private var _result:TransferPathResult;
		
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		public function TransferPathEvent(type:String, result:TransferPathResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}

		public function get result():TransferPathResult
		{
			return _result;
		}

	}
}