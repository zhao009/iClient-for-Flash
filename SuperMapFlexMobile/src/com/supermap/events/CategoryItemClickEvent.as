package com.supermap.events
{
	import com.supermap.query.entity.SubCategory;
	
	import flash.events.Event;
	
	public class CategoryItemClickEvent extends Event
	{
		private var _data:String;
		private var _subCategory:SubCategory;
		
		public function CategoryItemClickEvent(type:String, subCategory:SubCategory, data:String = null)
		{
			super(type);
			_subCategory = subCategory;
			_data = data;
		}

		public function get subCategory():SubCategory
		{
			return _subCategory;
		}

		public function set subCategory(value:SubCategory):void
		{
			_subCategory = value;
		}

		public function get data():String
		{
			return _data;
		}

		public function set data(value:String):void
		{
			_data = value;
		}

	}
}