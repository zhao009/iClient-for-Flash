package com.supermap.web.utils
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.display.Sprite;
	
	use namespace sm_internal;
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	public class GraphicsUtil extends Object
	{
		public function GraphicsUtil()
		{
			
		}
		
		private static function toScreenX(map:Map, local:Number):Number
		{ 
			return map.mapToContainerX(local); 
		}
		private static function toScreenY(map:Map, local:Number):Number
		{ 
			return map.mapToContainerY(local);
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public function
		//
		//--------------------------------------------------------------------------
		
		public static  function getPointScale(pStart:Point2D, pEnd:Point2D, param:Number = 1):Point2D
		{ 
			var px:Number = (pStart.x * param + pEnd.x ) / (param + 1);
			var py:Number = (pStart.y * param + pEnd.y ) / (param + 1);
			var p:Point2D = new Point2D(px, py);
			return p; 
		}
	 
		public static function getInsertPoints(points:Array):Array//中点插值算法
		{
			var newPoints:Array = [];
			var p:Point2D = points[0];
			for(var i:int = 0; i < points.length; i++)
			{
				newPoints[i] = getPointScale(p, points[i]);
				p = points[i];//对迭代变量还原
			} 
			newPoints.push(points[points.length - 1]);
			return newPoints;
		}
		
		public static function moveTo(point:Point2D,  map:Map, sprite:Sprite):void
		{ 	 
			sprite.graphics.moveTo(toScreenX(map, point.x) - sprite.x, toScreenY(map, point.y)- sprite.y); 
		}
		
		public static function lineTo(point:Point2D, map:Map, sprite:Sprite):void
		{
			sprite.graphics.lineTo(toScreenX(map, point.x) - sprite.x, toScreenY(map, point.y)- sprite.y);   
		}
		
		public static function curveTo(control:Point2D, anchor:Point2D, map:Map, sprite:Sprite):void
		{ 
			sprite.graphics.curveTo(
				toScreenX(map, control.x) - sprite.x, toScreenY(map, control.y)- sprite.y,
				toScreenX(map, anchor.x) - sprite.x,toScreenY(map, anchor.y)- sprite.y
			);   
		} 
		
//		public static function curveTo2(controlOne:Point2D, controlTwo:Point2D, anchor:Point2D, map:Map, sprite:Sprite):void
//		{ 
//			var middle:Point2D = getPointScale(controlOne, controlTwo);
//			curveTo(controlOne, middle, map, sprite);
//			curveTo(controlTwo, anchor, map, sprite);
//		}
//		
//		public static function curveTo3(controlOne:Point2D, controlTwo:Point2D,controlThree:Point2D, anchor:Point2D, map:Map, sprite:Sprite):void
//		{ 
//			var middle:Point2D = getPointScale(controlOne, controlTwo);
//			var middle2:Point2D = getPointScale(controlTwo, controlThree);
//			curveTo(controlOne, middle, map, sprite);
//			curveTo(controlTwo, middle2, map, sprite);
//			curveTo(controlTwo, anchor, map, sprite);
//		}
		
		public static function bezierTo(points:Array, map:Map, sprite:Sprite, insertCount:int = 1, isBone:Boolean = true):void
		{ 
			var once:Array = getInsertPoints(points);//使用一次插值; 
			for(var n:int; n < insertCount - 1; n++)
			{
				once  = getInsertPoints(once);//使用一次插值 
			}
			var twice:Array = getInsertPoints(once);//使用二次插值  
			
			if(isBone)
			{ 
				for(var a:int = 1; a < points.length; a++)//有多少条线段就调用多少次
				{
					lineTo(points[a], map, sprite);
				} 
				moveTo(points[0], map, sprite);
				for(a = 1; a < once.length; a++)//有多少条线段就调用多少次
				{
					lineTo(once[a], map, sprite);
				}
				moveTo(points[0], map, sprite);
				for(a = 1; a < twice.length; a++)//有多少条线段就调用多少次
				{
					lineTo(twice[a], map, sprite);
				}
				moveTo(points[0], map, sprite);
			}
			
			for(var i:int = 0; i < once.length; i++)//有多少条线段就调用多少次
			{
				sprite.graphics.lineStyle(3, 0xff00ff, 0.5);
				curveTo(once[i], twice[i + 1], map, sprite);
			}
		} 
	}
}