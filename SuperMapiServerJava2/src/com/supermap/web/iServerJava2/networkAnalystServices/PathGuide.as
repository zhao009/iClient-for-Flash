package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.*;
	use namespace sm_internal;
	/**
	 * ${iServer2_networkAnalystServices_PathGuide_Title}.
	 * <p>${iServer2_networkAnalystServices_PathGuide_Description}</p>
	 * @see PathGuideItem
	 * 
	 */
	public class PathGuide
	{
		//行驶导引中子项对象集合
		private var _items:Array;
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuide_attribute_items_D}
		 * @see PathGuideItem
		 * 
		 */
		public function get items():Array
		{
			return this._items;
		}
		
		sm_internal static function toPathGuide(object:Object):PathGuide
		{
			var pathGuide:PathGuide;
			if(object)
			{
				pathGuide = new PathGuide();
				
				var tempPathGuideItems:Array = object.items;
				
				if(tempPathGuideItems)
				{
					if(tempPathGuideItems.length > 0)
					{
						pathGuide._items = new Array();
						for(var i:int = 0; i < tempPathGuideItems.length; i++)
							pathGuide._items.push(PathGuideItem.toPathGuideItem(tempPathGuideItems[i]));
					}
				}
			}
			return pathGuide;
		}
		

	}
}