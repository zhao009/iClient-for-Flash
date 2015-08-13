package com.supermap.web.samples.serviceExtend
{
	import flash.net.URLVariables;

	public class ExtendServiceParameters
	{
		private var _mapName:String = "";
		private var _method:String = "";
		private var _params:URLVariables;
		
		public function ExtendServiceParameters()
		{
		}

		public function get params():URLVariables
		{
			return _params;
		}

		public function set params(value:URLVariables):void
		{
			_params = value;
		}

		public function get method():String
		{
			return _method;
		}

		public function set method(value:String):void
		{
			_method = value;
		}

		public function get mapName():String
		{
			return _mapName;
		}

		public function set mapName(value:String):void
		{
			_mapName = value;
		}
	}
}