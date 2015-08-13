package com.supermap.web.samples.rollerScreen
{ 
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.*;
	
	import mx.core.UIComponent;
	import mx.managers.CursorManagerPriority;
	
	/**
	 * @private 
	 * 
	 */
	
	public class RectangleBox extends UIComponent
	{ 
		private var _startX:Number = 0;
		private var _startY:Number = 0;
		private var _endX:Number = 0;
		private var _endY:Number = 0;
	   
		private var _borderAlpha:Number = 0.5;
		private var _borderColor:uint = 0;
		private var _borderWidth:uint = 2;
		private var _fillAlpha:Number = 0.3; 
		private var _fillColor:uint = 0;
		
		public function get fillAlpha():Number
		{
			return _fillAlpha;
		}

		public function set fillAlpha(value:Number):void
		{
			_fillAlpha = value;
		}

		public static function createIndexBox(
			x:Number, y:Number, _endX:Number, _endY:Number,
			fillColor:uint = 0, fillAlpha:Number = 0.3,borderColor:uint = 0, borderAlpha:Number = 0.5, borderWidth:uint = 2 ):RectangleBox
		{
			var box:RectangleBox = new RectangleBox();
			box._startX = x;
			box._startY = y;
			box._endX = _endX;
			box._endY = _endY;
			
			box._fillColor = fillColor;
			box._fillAlpha = fillAlpha;
			
			box._borderAlpha = borderAlpha;
			box._borderColor = borderColor;
			box._borderWidth = borderWidth;
			
			box.invalidateDisplayList();
			return box;
		}
		
		public function RectangleBox()
		{
			super();
	 
		}
								
		override public function get width():Number
		{
			return Math.abs(_startX - _endX);
		}
		
		override public function get height():Number
		{
			return Math.abs(_startY - _endY);
		}
		
		public function resetSize(rect:Rectangle):void
		{ 
			this._startX = rect.x;
			this._startY = rect.y;
			this._endX = rect.x + rect.width;
			this._endY = rect.y + rect.height;
			invalidateDisplayList();		
		}
		 
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
		{
			var indexWidth:Number = this.width;
			var indexHeight:Number = this.height; 
		   
			graphics.clear();
			graphics.lineStyle(this._borderWidth, this._borderColor, this._borderAlpha);
			graphics.beginFill(this._fillColor, this._fillAlpha);
			
			graphics.drawRect(_startX, _startY, indexWidth , indexHeight); 
			graphics.endFill();
		} 
	}
}