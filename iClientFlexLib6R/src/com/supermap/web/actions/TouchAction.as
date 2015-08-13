package com.supermap.web.actions
{
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	import flash.geom.Point;
	
	use namespace sm_internal;	
	
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	public class TouchAction
	{
		private var _map:Map;
		private var _enabled:Boolean;
		private var _isPinching:Boolean;
		
		public function TouchAction(map:Map)
		{
			this._map = map;
		}
		
		public function enable() : void
		{
			if (this._enabled)
			{
				return;
			}
			
			this._map.addEventListener("gestureZoom", this.map_gestureZoomHandler);
			this._map.addEventListener("gestureTwoFingerTap", this.map_gestureTwoFingerTapHandler);
		}
		
		public function disable() : void
		{
			this._map.removeEventListener("gestureZoom", this.map_gestureZoomHandler);
			this._map.removeEventListener("gestureTwoFingerTap", this.map_gestureTwoFingerTapHandler);
			this._enabled = false;
		}
		
		//注：TransformGestureEvent.stageX与stageY取出来的是中心点的坐标（两点触摸）
		protected function map_gestureZoomHandler(event:Event):void
		{		
			var point:Point = null;
			var phase:* = event["phase"];
			var scalex:* = event["scaleX"];			
			
			if (phase == "begin" && (this._map.isPanning ||(!this._map.isTweening)))
			{
//				_zoomScale = scalex;
				this._isPinching = true;
				this._map.pinchStartHandler();
			}
			else
			{
				if(phase == "update" && this._isPinching)
				{
					point = this._map.globalToLocal(new Point(event["stageX"], event["stageY"]));
					this._map.pinchUpdateHandler(event["scaleX"], point.x, point.y);
				}
				else
				{
					if (phase === "end" && this._isPinching)
					{
						this._isPinching = false;
						this._map.pinchEndHandler();
					}
				}
			}		
		}
		
		//快速点击两下 表示缩小
		private function map_gestureTwoFingerTapHandler(event:Event):void
		{
			this._map.zoomOut();			
		}
		
	}
}