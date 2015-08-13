package com.supermap.web.samples.serviceExtend
{
	public class ExtendServiceResult
	{
		private var _result:String;
		public function ExtendServiceResult()
		{
			_result = new String();
		}

		public function get result():String
		{
			return _result;
		}

		public function set result(value:String):void
		{
			_result = value;
		}

	}
}