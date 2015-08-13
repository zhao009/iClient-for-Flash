package com.supermap.web.actions
{
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	
	import mx.managers.*;
	
	use namespace sm_internal;
	
	/**
	 * ${actions_Pan_Title}.
	 * <p>${actions_Pan_Description}</p> 
	 * 
	 * 
	 */	
	public class Pan extends MapAction
	{
		[Embed(source="/../assets/images/action/openpan.png")]
		private var _openCursor:Class;
		
		[Embed(source="/../assets/images/action/closepan.png")]
		private var _closeCursor:Class;
		  
		private var _openCursorID:int = -1;
		private var _closeCursorID:int = -1; 
		private var _mapMouseX:Number;
		private var _mapMouseY:Number;
		private var _mapX:Number;
		private var _mapY:Number;
		private var _mouseDownX:Number;
		private var _mouseDownY:Number;
		private var _mouseDown:Boolean = false;
		private var _targetX:Number;
		private var _targetY:Number;
		private var _scrollRectX:Number;
		private var _scrollRectY:Number;
		private var _offsetFactor:Number = 2; 
		private var offsetX:Number;
		private var offsetY:Number;
		private var _isEffecting:Boolean = false; 
		private var isMouseUp:Boolean = false;
		/**
		 * ${actions_Pan_constructor_D} 
		 * @param map ${actions_Pan_constructor_param_map}
		 * 
		 */		
		public function Pan(map:Map)
		{
			super(map);
		}
	 
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */
		override protected function onMouseDown(event:MouseEvent):void//鼠标按下，作为Pan操作的入口
		{
			super.onMouseDown(event);
			if ((this.map.isTweening && !this.map.isPanning) || MapAction.targetHasEventListener(event) || !this.map.viewBounds)
			{
				return;
			}
			this.map.setFocus();
			if(this._isEffecting == true && this._mouseDown == true)
			{
				this.map.removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
				this.map.dispatchPanEnd(this._mapX, this._mapY);
				this._isEffecting = false;
			}
			this._mapMouseX = this.map.mouseX;
			this._mapMouseY = this.map.mouseY;
			if (!this.map.isPanning)
			{
				this._targetX = this.map.mouseX;
				this._targetY = this.map.mouseY;
				this._mapX = this.map.mouseX;
				this._mapY = this.map.mouseY;
				this._mouseDownX = this.map.mouseX;
				this._mouseDownY = this.map.mouseY;
				this._scrollRectX = this.map.scrollRectX;
				this._scrollRectY = this.map.scrollRectY;
			} 
			this._mouseDown = true;
			this.map.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveFirstHandler);
			this.map.stage.addEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUpHandler);
			
		}
		
		private function stage_mouseMoveFirstHandler(event:MouseEvent) : void
		{
			this.map.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveFirstHandler);
			this.map.cursorManager.removeCursor(this._closeCursorID);
			this._closeCursorID = this.map.cursorManager.setCursor(this._closeCursor, CursorManagerPriority.MEDIUM, -9, -8);
			this.map.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveOtherHandler);
			if (!this.map.isPanning)
			{
				this.map.addEventListener(Event.ENTER_FRAME, this.enterFrameHandler, false, 0, true);
				this.map.oldViewBounds = this.map.viewBounds.clone();
				this.map.dispatchPanStart(this._mapMouseX, this._mapMouseY);
			}
			this.stage_mouseMoveOtherHandler(event);
		}
		 
		private function stage_mouseMoveOtherHandler(event:MouseEvent) : void
		{
			//鼠标拉动开始后 this.map.mouseX是变化的值 而后则就是鼠标按下时候的坐标 故这两个值不一样
			offsetX = this.map.mouseX - this._mapMouseX;
			offsetY = this.map.mouseY - this._mapMouseY;
			this._targetX = this._targetX + offsetX;
			this._targetY = this._targetY + offsetY;
			this._mapMouseX = this.map.mouseX;
			this._mapMouseY = this.map.mouseY;
		}
	 
		private function enterFrameHandler(event:Event) : void
		{
			this._isEffecting = true;
			var offsetX:Number = this._targetX - this._mapX;
			var offsetY:Number = this._targetY - this._mapY; 
			if (this._mouseDown == false && Math.abs(offsetX) < 2 && Math.abs(offsetY) < 2)
			{
				this.map.removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler); 
				this.map.dispatchPanEnd(this._targetX, this._targetY);
				this._isEffecting = false;
			}
			else
			{		
				
				var old_mapX:Number = this._mapX;
				var old_mapY:Number = this._mapY;
				var panEasingFactor:Number = this.map.panEasingFactor;
				
				this._mapX = this._mapX + offsetX * panEasingFactor;
				this._mapY = this._mapY + offsetY * panEasingFactor; 
				offsetX = old_mapX - this._mapX;
				offsetY = old_mapY - this._mapY;
				
				if(!this.map.panXEnable(this._mouseDownX, this._mapX))
				{
					this._targetX = this._mapX = old_mapX;
					offsetX = 0;
				}
				if(!this.map.panYEnable(this._mouseDownY, this._mapY))
				{
					this._targetY = this._mapY = old_mapY;
					offsetY = 0;
				}
				this._scrollRectX += offsetX;
				this._scrollRectY += offsetY;							
				this.map.layerContainer.updateScrollRect(this._scrollRectX, this._scrollRectY);
				this.map.dispatchPanUpdate(this._mouseDownX, this._mouseDownY, this._mapX, this._mapY);
				this.map.endViewBounds = this.map.viewBounds;
			}
		}
		
		sm_internal function stopPanning() : void
		{
			this.map.removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
			this.map.dispatchPanEnd(this._mapX, this._mapY, false);
			this._isEffecting = false;
		}
	 
		private function stage_mouseUpHandler(event:MouseEvent) : void
		{ 
			this.map.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveFirstHandler); 
			this.map.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.stage_mouseMoveOtherHandler);
			this.map.stage.removeEventListener(MouseEvent.MOUSE_UP, this.stage_mouseUpHandler); 
//			this._targetX = this._targetX + offsetX * this._offsetFactor;
//			this._targetY = this._targetY + offsetY * this._offsetFactor; 
			this._mouseDown = false;
			this.map.cursorManager.removeCursor(this._closeCursorID);
			isMouseUp = true;
		}
		  
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */
		override protected function onMouseOver(event:MouseEvent) : void
		{
			if (this.map.panHandCursorVisible)
			{
				this.addOpenCursor();
			}
		}
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */
		override protected function onMouseOut(event:MouseEvent) : void
		{ 
			this.removeOpenCursor();  
		}
		
		private function addOpenCursor():void
		{
			this.setCursor(this._openCursor);
		}
		
		private function removeOpenCursor():void
		{
			this.setCursor(null);
		}
		
		
	}
}