package com.supermap.query.renderers
{
	
	import mx.core.ClassFactory;
	
	import spark.components.List;
	
	[Event(name="detailItemClick", type="flash.events.Event")]
	public class DetailList extends List
	{
		public function DetailList()
		{
			super();
			this.itemRenderer = new ClassFactory(DetailListRenderer);
		}
	}
}