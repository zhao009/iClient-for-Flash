package com.supermap.components
{
	import com.supermap.web.core.Point2D;

	/**
	 * 提供坐标转换
	 */
	public class CoordinateSwitcher
	{
		private static const RADIANS_PER_DEGREES:Number = Math.PI / 180;
		private static const RADIUS:Number = 6.37814e+006;
		
		/**
		 * 纬度转换化为Y。
		 * @param latitude
		 * @return Y值
		 */
		public static function latitudeToY(latitude:Number) : Number
		{
			var _loc_2:Number = NaN;
			_loc_2 = latitude * RADIANS_PER_DEGREES;
			var _loc_3:* = Math.sin(_loc_2);
			return RADIUS * 0.5 * Math.log((1 + _loc_3) / (1 - _loc_3));
		}
		
		/**
		 * 经度转换化为X。
		 * @param longitude
		 * @return X值
		 */
		public static function longitudeToX(longitude:Number) : Number
		{
			return longitude * RADIANS_PER_DEGREES * RADIUS;
		}
		
		/**
		 * 纬经度转米坐标,纬度转换成x,经度转换成y
		 */
		public static function latLonToMeters(x:Number, y:Number):Point2D
		{
			var mx:Number = y / 180.0 * Math.PI * RADIUS;
			var my:Number = Math.log(Math.tan((90 + x) * Math.PI / 360.0)) / (Math.PI / 180.0);
			my = my / 180.0 * Math.PI * RADIUS;
			return new Point2D(mx, my);
		}
		
		/**
		 * 米坐标转纬经度
		 */
		public static function metersToLatLon(point:Point2D):Point2D
		{
			var lon:Number = point.x / (Math.PI * RADIUS) * 180.0;
			var lat:Number = point.y / (Math.PI * RADIUS) * 180.0;
			lat = 180 / Math.PI * (2 * Math.atan(Math.exp(lat * Math.PI / 180.0)) - Math.PI / 2);
			return new Point2D(lon, lat);
		}
	}
}