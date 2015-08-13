package com.supermap.web.symbol.clover
{
	import com.supermap.web.sm_internal;
	import com.supermap.web.symbol.event.CloverEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	
	use namespace sm_internal;
	
	internal class SectorSprite extends Sprite
	{
		private var _attributes:Object;
		private var _sectorItem:SectorItem;
		
		public function SectorSprite(sectorItem:SectorItem = null, attributes:Object = null)
		{
			this._attributes = attributes;
			this._sectorItem = sectorItem;
			this.addEventListener(Event.ADDED, addedHandler, false, 0, true);
			this.addEventListener(Event.REMOVED, removeHandler, false, 0, true);
		}

		public function get sectorItem():SectorItem
		{
			return _sectorItem;
		}

		public function set sectorItem(value:SectorItem):void
		{
			_sectorItem = value;
		}

		public function get attributes():Object
		{
			return _attributes;
		}

		public function set attributes(value:Object):void
		{
			_attributes = value;
		}

		private function addedHandler(event:Event) : void
		{
//			this.addEventListener(MouseEvent.ROLL_OVER, this.rollOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER, this.rollOverHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
		}
		
		private function removeHandler(event:Event) : void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
			this.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
		}
		
		private function mouseDownHandler(event:MouseEvent):void
		{
			if(event.eventPhase === EventPhase.AT_TARGET)
			{
				this.addEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
			}
		}
		
		private function mouseUpHandler(event:MouseEvent) : void
		{
			if(event.eventPhase === EventPhase.AT_TARGET)
			{
//				event.stopPropagation();
				this.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
				//派发事件
				this.dispatchCloverEvent(CloverEvent.CLOVER_CLICK, event, Sprite(parent));					
			}
		}
		
		private function rollOverHandler(event:MouseEvent):void
		{
			if(hasEventListener(MouseEvent.MOUSE_OUT))
			{
				removeEventListener(MouseEvent.MOUSE_OUT, this.rollOutHandler);
			}
			addEventListener(MouseEvent.MOUSE_OUT, rollOutHandler);
			this.dispatchCloverEvent(CloverEvent.CLOVER_OVER, event, Sprite(parent));		
		}
		
		private function rollOutHandler(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_OUT, this.rollOutHandler);
			this.dispatchCloverEvent(CloverEvent.CLOVER_OUT, event, Sprite(parent));	
		}
		
		private function dispatchCloverEvent(type:String , event:MouseEvent, sprite:Sprite):void
		{
			var cloverEvent:CloverEvent = new CloverEvent(type, this.sectorItem);
			cloverEvent.copyProperties(event);
			dispatchEvent(cloverEvent);
		}
	}
}