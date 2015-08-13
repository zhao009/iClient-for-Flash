package com.supermap.query.entity
{
	public class SubCategory
	{
		private var _name:String;
		private var _keyword:String;
		
		public function SubCategory(name:String = null, keyword:String = null)
		{
			_name = name;
			_keyword = keyword;
		}

		[Bindable]
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}
		
		[Bindable]
		public function get keyword():String
		{
			return _keyword;
		}
		
		public function set keyword(value:String):void
		{
			_keyword = value;
		}
	}
}