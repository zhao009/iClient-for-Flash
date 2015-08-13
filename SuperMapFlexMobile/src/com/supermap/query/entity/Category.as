package com.supermap.query.entity
{
	import mx.collections.ArrayCollection;

	/**
	 * 分类查询的项描述
	 **/
	public class Category
	{
		private var _name:String;
		
		private var _subCategorys:ArrayCollection = new ArrayCollection();
		
		public function Category(name:String = null)
		{
			this.name = name;
		}

		[Bindable]
		public function get subCategorys():ArrayCollection
		{
			return _subCategorys;
		}

		public function set subCategorys(value:ArrayCollection):void
		{
			_subCategorys = value;
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

	}
}