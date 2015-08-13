package com.supermap.path
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.mapping.Map;

	public class ZoomToScaleUtil
	{
		public function ZoomToScaleUtil()
		{
		}
		public static function zoomToScale(geometrys:Array,map:Map):void
		{
			var XScale:Number;
			var YScale:Number;
			var maxX:Number = geometrys[0].parts[0][0].x;
			var minX:Number = geometrys[0].parts[0][0].x;
			var maxY:Number = geometrys[0].parts[0][0].y;
			var minY:Number = geometrys[0].parts[0][0].y;
			for (var i:int = 0; i < geometrys.length; i++) {
				for (var j:int = 0; j < geometrys[i].parts.length; j++) {
					for(var k:int = 0;k < geometrys[i].parts[j].length;k++)
					{
						if (geometrys[i].parts[j][k].x > maxX) {maxX = geometrys[i].parts[j][k].x; }
						if (geometrys[i].parts[j][k].x < minX) { minX = geometrys[i].parts[j][k].x; }
						if (geometrys[i].parts[j][k].y > maxY) { maxY = geometrys[i].parts[j][k].y; }
						if (geometrys[i].parts[j][k].y < minY) { minY = geometrys[i].parts[j][k].y; } 
					}
				}
			}
			var rect:Rectangle2D = new Rectangle2D(minX,minY,maxX,maxY);
			map.viewBounds = rect.expand(1.5);
		}
	}
}