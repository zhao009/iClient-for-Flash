package com.supermap.web.samples.markertracker
{
	public class MarkerTrackerOptions
	{	
		/**
		 * 与边界的像素距离
		 * MarkerTracker#DEFAULT_PADDING
		 */
		public var padding:Number;
		
		/**
		 * 箭头的颜色
		 * MarkerTracker#DEFAUT_ARROW_COLOR
		 */
		public var arrowColor:Number;
		
		/**
		 * 箭头线的宽度
		 * MarkerTracker#DEFAUT_ARROW_WEIGHT
		 */
		public var arrowWeight:Number;
		
		/**
		 * 箭头线的长度
		 * MarkerTracker#DEFAUT_ARROW_LENGTH
		 */
		public var arrowLength:Number;
		
		/**
		 * 箭头的透明度
		 * MarkerTracker#DEFAUT_ARROW_OPACITY
		 */
		public var arrowOpacity:Number;
		
		/**
		 * 实时更新事件
		 * MarkerTracker#DEFAUT_UPDATE_EVENT
		 */
		public var updateEvent:String;
		
		/**
		 * 更新完成事件
		 * MarkerTracker#DEFAUT_CHANGED_EVENT
		 */
		public var changedEvent:String;
		
		/**
		 * click事件
		 * MarkerTracker#DEFAUT_CLICK_EVENT
		 */
		public var clickEvent:String;
		
		
		public function MarkerTrackerOptions(params:Object = null) 
		{
			if (params == null) return;
			
			var propList:Array = ["padding", "arrowColor", "arrowWeight", 
				"arrowLength", "updateEvent", "changeEvent", "clickEvent"];
			for (var i:Number = 0; i < propList.length; i++) 
			{
				var propName:String = propList[i];
				this[propName] = params[propName];
			}
		}
	}
}