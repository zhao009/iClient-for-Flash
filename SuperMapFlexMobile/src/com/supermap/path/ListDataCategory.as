package com.supermap.path
{
	import com.supermap.web.core.Feature;

	public class ListDataCategory
	{
		public function ListDataCategory()
		{
		}
		private var _title:String;
		private var _detail:String;
		private var _feature:Feature;

		public function get feature():Feature
		{
			return _feature;
		}

		public function set feature(value:Feature):void
		{
			_feature = value;
		}

		public function get detail():String
		{
			return _detail;
		}

		public function set detail(value:String):void
		{
			_detail = value;
		}

		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}

	}
}