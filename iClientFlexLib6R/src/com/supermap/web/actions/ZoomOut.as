package com.supermap.web.actions
{
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${actions_ZoomOut_Title}. 
	 * <p>${actions_ZoomOut_Description}</p>
	 * 
	 */	
	public class ZoomOut extends ZoomAction
	{
		[Embed(source="/../assets/images/action/zoomout.png")]
		private var _zoomOutCursor:Class;
		
		private var _zoomOutCursorID:int = -1;	
		
		/**
		 * ${actions_ZoomOut_constructor_D} 
		 * @param map ${actions_ZoomOut_constructor_Map_param_map}
		 * 
		 */		
		public function ZoomOut(map:Map)
		{
			super(map);
			this.zoomType = "zoomOut";
			this.setCursor(this._zoomOutCursor, -7, -7);
		}
		
//		/**
//		 * @private 
//		 * 
//		 */		
//		override protected function addZoomCursor():void
//		{
//			this.setCursor(this._zoomOutCursor);
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