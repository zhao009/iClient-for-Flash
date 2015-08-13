package com.supermap.web.actions
{
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Dictionary;
	
	use namespace sm_internal;	
	
	public class TouchAction
	{
		private var _map:Map;
		private var _enabled:Boolean;
		
		private var _isPinching:Boolean;
		private var _startDistance:Number;
		private var _startCenter:Point;
		
		private var touchIDs:Array = [];
		private var touchPoints:Array = [];
		
		private var TOLERANCE:Number=55;
		private var _firstDistance:Number=0;
		
		public function TouchAction(map:Map)
		{
			this._map = map;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		}
		
		public function enable() : void
		{
			if (this._enabled)
			{
				return;
			}
			
			this._map.addEventListener(TouchEvent.TOUCH_BEGIN, this.map_touchBeginHandler);
			this._map.addEventListener(TouchEvent.TOUCH_MOVE, this.map_touchMoveHandler);
			this._map.addEventListener(TouchEvent.TOUCH_END, this.map_touchEndHandler);
			this._map.addEventListener(TouchEvent.TOUCH_ROLL_OUT, this.map_touchRollOutHandler);
		}
		
		
		protected function map_touchBeginHandler(event:TouchEvent):void
		{
			if( -1 == touchIDs.indexOf(event.touchPointID))
			{
				touchIDs.push(event.touchPointID);
				touchPoints.push(new Point(event.stageX, event.stageY));
			}
			
			if(touchIDs.length >= 2)
			{
				if (!this._map.isTweening || this._map.isPanning)
				{
					this._isPinching = true;
					this._map.pinchStartHandler();
					
					var p1:Point = touchPoints[0];
					var p2:Point = touchPoints[1];
					_startDistance = calcDistanc(p1, p2);
					this._firstDistance = this._startDistance;
					_startCenter = new Point((p1.x + p2.x) / 2, (p1.y + p2.y) / 2);
					
				}
			}
		}
		
		protected function map_touchMoveHandler(event:TouchEvent):void
		{
			if(this.touchIDs.indexOf(event.touchPointID) >= 0)
			{
				var point:Point = this.touchPoints[this.touchIDs.indexOf(event.touchPointID)];
				point.x = event.stageX;
				point.y = event.stageY;
				
				if(touchIDs.length >= 2 && this._isPinching)
				{
					var p1:Point = touchPoints[0];
					var p2:Point = touchPoints[1];
					var newDistance:Number = calcDistanc(p1, p2);
					
					var different:Number=Math.abs(newDistance-this._firstDistance);
					if(different<this.TOLERANCE)return;
						
						
					var newCenter:Point = new Point( (p1.x + p2.x) / 2, (p1.y + p2.y) /2 );
					
					var zoomPoint:Point = this._map.globalToLocal(_startCenter);
					var scale:Number = newDistance / this._startDistance;
					if(scale != 1)
					{
						this._map.pinchUpdateHandler(scale , zoomPoint.x, zoomPoint.y);
					}
					this._startDistance = newDistance;
					this._startCenter = newCenter;
				}
			}
			//如果没有点发生变化，则不作数据处理
		}
		
		protected function map_touchEndHandler(event:TouchEvent):void
		{
			map_touchRollOutHandler(event);
//			if(this.touchIDs.length > 0)
//			{
//				this.touchIDs = [];
//				this.touchPoints = [];
//			}
		}
		
		protected function map_touchRollOutHandler(event:TouchEvent):void
		{
			if(this.touchIDs.indexOf(event.touchPointID) >= 0)
			{
				var index:int = this.touchIDs.indexOf(event.touchPointID);
				this.touchIDs.splice(index, 1);
				this.touchPoints.splice(index, 1);
				
				//多点变成两点的情况,更新数据
				if(this.touchIDs.length >= 2 && this._isPinching)
				{
					var p1:Point = touchPoints[0];
					var p2:Point = touchPoints[1];
					_startDistance = calcDistanc(p1, p2);
				}
				else
				{
					if(this._isPinching)
					{
						this._isPinching = false;
						this._map.pinchEndHandler();
						
					}
				}
			}
		}
		
		
		private function calcDistanc(point1:Point, point2:Point):Number
		{
			var xlen:Number = point1.x - point2.x;
			var ylen:Number = point1.y - point2.y;
			return Math.sqrt(xlen * xlen + ylen * ylen);
		}
		
		public function disable() : void
		{
			this._map.removeEventListener(TouchEvent.TOUCH_BEGIN, this.map_touchBeginHandler);
			this._map.removeEventListener(TouchEvent.TOUCH_MOVE, this.map_touchMoveHandler);
			this._map.removeEventListener(TouchEvent.TOUCH_END, this.map_touchEndHandler);
			this._map.removeEventListener(TouchEvent.TOUCH_ROLL_OUT, this.map_touchRollOutHandler);
			this._enabled = false;
		}
		
//		//快速点击两下 表示缩小
//		private function map_gestureTwoFingerTapHandler(event:GestureEvent):void
//		{
//			this._map.zoomOut();			
//		}
	}
}