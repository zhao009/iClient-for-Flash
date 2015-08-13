package com.supermap.path
{
	import mx.core.ClassFactory;
	
	import spark.components.List;
	
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