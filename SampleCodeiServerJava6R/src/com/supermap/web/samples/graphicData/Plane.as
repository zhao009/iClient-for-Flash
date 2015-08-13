package com.supermap.web.samples.graphicData
{
	import com.supermap.web.core.Graphic;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.mapping.Map;
	
	import flash.geom.Point;

	public class Plane
	{
		public var graphic:Graphic;
		public var destination:GeoPoint;
		public static var map:Map;
		//斜率
		public var k:Number;
		//图片旋转弧度
		public var angle:Number;
		//起点与终点的x跨度
		public var lenX:Number;
		//飞行轨迹
		public var line:Graphic;

		public function Plane(graphic:Graphic, destination:GeoPoint)
		{
			this.graphic = graphic;
			this.destination = destination;

			var geo1:GeoPoint = graphic.geometry as GeoPoint;
			var geo2:GeoPoint = destination;
			lenX = geo2.x - geo1.x;
			k = (geo2.y - geo1.y) / (geo2.x - geo1.x);

			var point1:Point = map.mapToScreen(new Point2D(geo1.x, geo1.y));
			var point2:Point = map.mapToScreen(new Point2D(geo2.x, geo2.y));

			// Math.PI * 0.75  为图片本身的旋转角度,默认水平方向平行为０度角
			angle = 180*(Math.atan2(point2.y - point1.y, point2.x - point1.x)+ Math.PI * 0.75)/Math.PI;

			line = new Graphic();
			var geoLine:GeoLine = new GeoLine();
			geoLine.addPart([new Point2D(geo1.x, geo1.y), new Point2D(destination.x, destination.y)]);
			line.geometry = geoLine;
		}

	}
}
