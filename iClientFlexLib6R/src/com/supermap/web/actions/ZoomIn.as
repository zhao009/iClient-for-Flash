package com.supermap.web.actions
{
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${actions_ZoomIn_Title}.
	 * <p>${actions_ZoomIn_Description}</p> 
	 * 
	 */	
	public class ZoomIn extends ZoomAction
	{
		
		[Embed(source="/../assets/images/action/zoomin.png")]
		private var _zoomInCursor:Class;
		
		private var _zoomInCursorID:int = -1;
		
		/**
		 * ${actions_ZoomIn_constructor_D} 
		 * @param map ${actions_ZoomIn_constructor_Map_param_map}
		 * 
		 */		
		public function ZoomIn(map:Map)
		{
			super(map);
			this.zoomType = "zoomIn";
			this.setCursor(this._zoomInCursor, -7, -7);
		}
//		
//		/**
//		 * @private 
//		 * 
//		 */		
//		override protected function addZoomCursor():void
//		{
//			this.setCursor(this._zoomInCursor);
//		}
//		
//		/**
//		 * @private 
//		 * 
//		 */		
//		override protected function removeZoomCursor():void
//		{
//			this.setCursor(null);
//		}
	}
}