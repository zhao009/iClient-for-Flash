package com.supermap.web.symbol.grid
{
	import com.supermap.web.symbol.event.GridEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	
	internal class GridSprite extends Sprite
	{
		private var _attributes:Object;
		private var _gridItem:GridItem;
		
		public function GridSprite(gridItem:GridItem = null, attributes:Object = null)
		{
			this._attributes = attributes;
			this._gridItem = gridItem;
			this.addEventListener(Event.ADDED, addedHandler, false, 0, true);
			this.addEventListener(Event.REMOVED, removeHandler, false, 0, true);
		}
		
		public function get gridItem():GridItem
		{
			return _gridItem;
		}

		public function set gridItem(value:GridItem):void
		{
			_gridItem = value;
		}

		public function get attributes():Object
		{
			return _attributes;
		}

		public function set attributes(value:Object):void
		{
			_attributes = value;
		}

		private function addedHandler(event:Event):void
		{
			this.addEventListener(MouseEvent.MOUSE_OVER, this.rollOverHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
		}
		
		private function removeHandler(event:Event):void
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
				this.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
				//派发事件
				this.dispatchCloverEvent(GridEvent.GRID_CLICK, event, Sprite(parent));					
			}
		}
		
		private function rollOverHandler(event:MouseEvent):void
		{
			if(hasEventListener(MouseEvent.MOUSE_OUT))
			{
				removeEventListener(MouseEvent.MOUSE_OUT, this.rollOutHandler);
			}
			addEventListener(MouseEvent.MOUSE_OUT, rollOutHandler);
			this.dispatchCloverEvent(GridEvent.GRID_OVER, event, Sprite(parent));		
		}
		
		private function rollOutHandler(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_OUT, this.rollOutHandler);
			this.dispatchCloverEvent(GridEvent.GRID_OUT, event, Sprite(parent));	
		}
		
		private function dispatchCloverEvent(type:String , event:MouseEvent, sprite:Sprite):void
		{
			var cloverEvent:GridEvent = new GridEvent(type, this.gridItem);
			//cloverEvent.copyProperties(event);
			dispatchEvent(cloverEvent);
		}		
	}
}