package com.supermap.web.samples.serviceExtend
{
	public class ExtendServiceParameters
	{
		private var _arg:String;
		public function ExtendServiceParameters()
		{
			this._arg = "北京";
		}

		public function get arg():String
		{
			return _arg;
		}

		public function set arg(value:String):void
		{
			_arg = value;
		}

	}
}