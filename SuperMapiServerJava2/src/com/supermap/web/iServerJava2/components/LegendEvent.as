package com.supermap.web.iServerJava2.components
{
	import com.supermap.web.iServerJava2.mapServices.GetMapStatusResult;
	import com.supermap.web.sm_internal;
	
	import flash.events.Event;

	use namespace sm_internal;
	/**
	 * @private
	 * @author lirh
	 */
	public class LegendEvent extends Event
	{ 
		//------------------------------------------------------
		//	内部使用
		//------------------------------------------------------
		
		public 	static const PROCESS_COMPLETE:String = "processComplete";
		public static const LEGEND_LOADED:String = "legendLoaded"; 
		sm_internal static const ITEM_VISIBLE_CHANGE:String = "itemVisibleChange";
		sm_internal static const ITEM_VISIBLE_FALSE_TO_TURE:String = "itemVisibleFalseToTrue";
		sm_internal static const ITEM_IMAGESOURCE_CHANGE:String = "itemImagesourceChange";
		sm_internal static const ITEM_NAME_CHANGE:String = "itemNameChange";
		sm_internal static const ITEM_IMAGESIZE_CHANGE:String = "itemImageSizeChange";
		
		
		private var _result:GetMapStatusResult;  
		private var _legendItemInfo:LegendItemInfo;
		
		public function LegendEvent(type:String, result:GetMapStatusResult, legendItemInfo:LegendItemInfo = null)
		{
			super(type);
			this._result = result;
			this._legendItemInfo = legendItemInfo; 
		}

		public function get legendItemInfo():LegendItemInfo
		{
			return _legendItemInfo;
		}
 
		public function get result():GetMapStatusResult
		{
			return _result;
		} 
	    	
		override public function clone():Event
		{
			return new LegendEvent(this.type, this._result, this._legendItemInfo);
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