package com.supermap.web.utils
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import mx.graphics.IStroke;
	import mx.graphics.SolidColorStroke;	
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
    public class StyleUtil
    {
		public static function drawStyledGeoLine(sprite:Sprite, points:Array, stroke:SolidColorStroke, pattern:Array) : void
		{
			var i:int = 0;
			var dash:DashStruct = new DashStruct();
			stroke.apply(sprite.graphics, null, null);
			if (points.length > 1)
			{
				sprite.graphics.moveTo(points[0], points[1]);
				i = 2;				
				while (i < points.length)
				{
					if(points[0] != points[i] || points[1] != points[(i + 1)])
					{
						drawGeoLine(sprite.graphics, stroke, pattern, dash, points[0], points[1], points[i], points[(i + 1)]);								
						points[0] = points[i];
						points[1] = points[(i + 1)];
						i += 2;
					}				
				}
			}
			
		}
		
		public static function drawGeoLine(target:Graphics, stroke:IStroke, pattern:Array, drawingState:DashStruct, x0:Number, y0:Number, x1:Number, y1:Number) : void
		{
			var i:int = 0;
			var offsetX:Number = x1 - x0;
			var offsetY:Number = y1 - y0;
			var distance:Number = Math.sqrt(offsetX * offsetX + offsetY * offsetY);
			offsetX = offsetX / distance;
			offsetY = offsetY / distance;
			var dis:Number = distance;
			var drawOffset:Number = -drawingState.offset;
			var drawing:Boolean = drawingState.drawing;
			var drawIndex:int = drawingState.patternIndex;
			var drawStyleInited:Boolean = drawingState.styleInited;
			while (drawOffset < dis)
			{
				
				drawOffset = drawOffset + pattern[drawIndex];
				if (drawOffset < 0)
				{
					i = 5;
				}
				if (drawOffset >= dis)
				{
					drawingState.offset = pattern[drawIndex] - (drawOffset - dis);
					drawingState.patternIndex = drawIndex;
					drawingState.drawing = drawing;
					drawingState.styleInited = true;
					drawOffset = dis;
				}
				if (drawStyleInited == false)
				{
					if (drawing)
					{
						stroke.apply(target, null, null);
					}
					else
					{
						target.lineStyle(0, 0, 0);
					}
				}
				else
				{
					drawStyleInited = false;
				}
				target.lineTo(x0 + drawOffset * offsetX, y0 + drawOffset * offsetY);				
				drawing = !drawing;
				drawIndex = (drawIndex + 1) % pattern.length;
			}
			
		}
		
    }
	
	
}
	class DashStruct
	{
		public var drawing:Boolean = true;
		public var patternIndex:int = 0;
		public var offset:Number = 0;
		public var styleInited:Boolean = false;
		public function init():void
    	{
        	drawing = true;
        	patternIndex = 0;
        	offset = 0;
    	}
    
	}