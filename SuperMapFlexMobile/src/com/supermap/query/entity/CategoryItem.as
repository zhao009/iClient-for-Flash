package com.supermap.query.entity
{
	import com.supermap.web.core.Feature;

	public class CategoryItem
	{
		private var _location:String;
		private var _name:String;
		private var _feature:Feature;
		
		public function CategoryItem(feature:Feature, name:String = null, loc:String = null)
		{
			this.feature = feature;
			this.location = loc;
			this.name = name;
		}

		[Bindable]
		public function get feature():Feature
		{
			return _feature;
		}

		public function set feature(value:Feature):void
		{
			_feature = value;
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
		public function get location():String
		{
			return _location;
		}

		public function set location(value:String):void
		{
			_location = value;
		}
	}
}