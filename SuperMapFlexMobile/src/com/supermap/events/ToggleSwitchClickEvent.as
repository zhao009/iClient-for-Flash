package com.supermap.events
{
	import flash.events.Event;

	public class ToggleSwitchClickEvent extends Event
	{
		private var _data:Object;
		private var _selected:Boolean;

		public static var SWITCH_CLICK:String = "switchClick";
		public static var DELETEBTN_CLICK:String = "deleteBtnClick";

		public function ToggleSwitchClickEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, data:Object = null, selected:Boolean = false)
		{
			super(type, bubbles, cancelable);
			this._data = data;
			this._selected = selected;
		}

		public function get selected():Boolean
		{
			return _selected;
		}

		public function set selected(value:Boolean):void
		{
			_selected = value;
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(value:Object):void
		{
			_data = value;
		}

	}
}
