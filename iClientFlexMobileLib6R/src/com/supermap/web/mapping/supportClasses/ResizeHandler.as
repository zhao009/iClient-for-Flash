package com.supermap.web.mapping.supportClasses
{
	import com.supermap.web.core.*;
	import com.supermap.web.mapping.*;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	
	import mx.events.*;
	
	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */	
	public class ResizeHandler
	{
		private var _map:Map;
		private var _oldWidth:Number;
		private var _oldHeight:Number;
		private var _timer:Timer;
		private static const DELAY:Number = 250;
		
		public function ResizeHandler(map:Map)
		{
			this._map = map;
			this._map.addEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
		}
		
		private function onCreationComplete(event:FlexEvent) : void
		{
			this._map.removeEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
			this._map.addEventListener(ResizeEvent.RESIZE, this.onResizeFirst);
			this._map.scrollRect = new Rectangle(0, 0, this._map.width, this._map.height);
		}
		
		private function onResizeFirst(event:ResizeEvent) : void
		{
			if (event.oldWidth > 0 && event.oldHeight > 0)//如果宽高都为零 也就没必要重新计算了
			{
				this._oldWidth = event.oldWidth;
				this._oldHeight = event.oldHeight;
				if (this._map.viewBounds)
				{
					this._map.isResizing = true;
					this._map.removeEventListener(ResizeEvent.RESIZE, this.onResizeFirst);
					this._map.addEventListener(ResizeEvent.RESIZE, this.onResizeAfter);
					this._timer = new Timer(DELAY, 1);
					this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
					this._timer.start();
				}
			}
			
			this.updateMapScrollRect();
		}
		
		private function onResizeAfter(event:ResizeEvent) : void
		{
			this._timer.reset();
			this._timer.start();
			this.updateMapScrollRect();
			return;
		}
		
		private function onTimerComplete(event:TimerEvent) : void
		{
			if (this._map.isTweening)
			{
				this._timer.reset();
				this._timer.start();
			}
			else
			{
				this._map.isResizing = false;
				this._map.removeEventListener(ResizeEvent.RESIZE, this.onResizeAfter);
				this._map.addEventListener(ResizeEvent.RESIZE, this.onResizeFirst);
				this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerComplete);
				this._timer = null;
				if (this._map.width > 0 && this._map.height > 0)
				{
					this.updateViewBounds();
				}
			}
		}
		
		private function updateMapScrollRect() : void
		{
			var rect:Rectangle = null;
			if (this._map.width > 0 && this._map.height > 0)
			{
				rect = this._map.scrollRect;
				rect.width = this._map.width;
				rect.height = this._map.height;
				this._map.scrollRect = rect;
			}
			return;
		}
		
		private function updateViewBounds() : void
		{
			this.updateMapScrollRect();
			var widthChangeRatio:Number = this._map.width / this._oldWidth;
			var heightChangeRatio:Number = this._map.height / this._oldHeight;
			
			var old_viewBounds:Rectangle2D = this._map.viewBounds;
			var new_rect:Rectangle = new Rectangle(old_viewBounds.left, old_viewBounds.top, old_viewBounds.width * widthChangeRatio, old_viewBounds.height * heightChangeRatio);
			var viewBounds:Rectangle2D = new Rectangle2D(new_rect.x, new_rect.y - new_rect.height, new_rect.x + new_rect.width, new_rect.y);

			this._map.animateViewBounds = false;
			this._map.viewBounds = viewBounds;
		}
	}
}