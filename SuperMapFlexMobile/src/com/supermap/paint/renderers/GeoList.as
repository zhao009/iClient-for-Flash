package com.supermap.paint.renderers
{
	import mx.core.ClassFactory;
	
	import spark.components.List;
	
	[Event(name="geoItemClick", type="flash.events.Event")]
	
	public class GeoList extends List
	{
		public function GeoList()
		{
			super();
			this.itemRenderer = new ClassFactory(GeoListRenderer);
		}
	}
}