package com.supermap.web.samples.trafficTransfer
{
	import mx.core.ClassFactory;
	
	import spark.components.List;
	import applications.PathListRenderer;
	
	[Event(name="pathResultClick",type="flash.events.Event")]
	
	public class PathList extends List
	{
		public function PathList()
		{
			super();
			this.itemRenderer = new ClassFactory(PathListRenderer);
		}
	}
}