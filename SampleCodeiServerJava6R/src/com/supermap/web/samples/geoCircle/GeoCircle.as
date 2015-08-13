package com.supermap.web.samples.geoCircle
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoRegion;

	public class GeoCircle extends GeoRegion
	{
		private var _radius:Number;
		private var _circleCenter:Point2D;
//		protected var _center:Point2D;
		public function GeoCircle()
		{
			super();
		}

		public function get circleCenter():Point2D
		{
			return this._circleCenter;
		}

		public function set circleCenter(value:Point2D):void
		{
			_circleCenter = value;
			if(this._radius)
				createCircle();
		}

		public function get radius():Number
		{
			return _radius;
		}

		public function set radius(value:Number):void
		{
			_radius = value;
			if(this._circleCenter)
				createCircle();
		}
		
		private function createCircle():void
		{
			var point2Ds:Array = [];
			this.parts = [];
			for(var i:int = 0; i < 360; i++)
			{
				var radians:Number = (i + 1) * Math.PI / 180;
				var circlePoint:Point2D = new Point2D(Math.cos(radians) * this._radius + this._circleCenter.x, Math.sin(radians) * this._radius + this._circleCenter.y);
				point2Ds.push(circlePoint);
			}
			this.parts.push(point2Ds);
		}
	}
}