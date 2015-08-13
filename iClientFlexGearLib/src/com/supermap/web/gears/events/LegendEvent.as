package com.supermap.web.gears.events
{
	import com.supermap.web.gears.components.LegendItemInfo;
	import com.supermap.web.sm_internal;
	
	import flash.events.Event;

	use namespace sm_internal;
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	public class LegendEvent extends Event
	{
		public static const LEGEND_LOADED:String = "legendLoaded";	
		sm_internal static const ITEM_REFRESH:String = "itemRefresh";
		sm_internal static const ITEM_VISIBLE_CHANGE:String = "itemVisibleChange";
		sm_internal static const ITEM_VISIBLE_FALSE_TO_TURE:String = "itemVisibleFalseToTrue";
		sm_internal static const ITEM_IMAGESOURCE_CHANGE:String = "itemImagesourceChange";
		sm_internal static const ITEM_NAME_CHANGE:String = "itemNameChange";
		sm_internal static const ITEM_IMAGESIZE_CHANGE:String = "itemImageSizeChange";
	
		private var _legendItemInfo:LegendItemInfo;
		
		public function LegendEvent(type:String, legendItemInfo:LegendItemInfo = null)
		{
			super(type);
			this._legendItemInfo = legendItemInfo; 
		}

		sm_internal function get legendItemInfo():LegendItemInfo
		{
			return _legendItemInfo;
		}
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new LegendEvent(type, this._legendItemInfo);
		}
		/**
		 * @private 
		 * @return 
		 * 
		 */	
		override public function toString() : String
		{
			return formatToString("LegendEvent", "type");
		}
 
	}
}