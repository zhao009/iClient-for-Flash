package com.supermap.topbar.containers
{
	import spark.components.Button;
	import spark.components.Image;
	
	public class TopNavButton extends Button
	{
		[SkinPart(required="false")]
		public var bgImage:Image;
		private var _state:String = "open";
		private var _source:String = "";
		private var _source2:String = "";
		public function TopNavButton()
		{
			super();
		}

		public function get source2():String
		{
			return _source2;
		}

		public function set source2(value:String):void
		{
			_source2 = value;
		}

		public function get state():String
		{
			return _state;
		}

		public function set state(value:String):void
		{
			_state = value;
		}

		public function get source():String
		{
			return _source;
		}

		public function set source(value:String):void
		{
			_source = value;
		}
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			if(bgImage == instance)
			{
				bgImage.source = _source;
			}
		}
		
		public function show():void
		{
			this._state = "open";
			bgImage.source = _source;
		}
		
		public function hide():void
		{
			this._state = "closed";
			bgImage.source = _source2;
		}	
	}
}