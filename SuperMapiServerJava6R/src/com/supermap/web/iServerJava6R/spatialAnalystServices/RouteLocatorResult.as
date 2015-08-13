package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.sm_internal;
	
	import flash.geom.Point;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_RouteLocatorResult_Title}.
	 * 
	 */	
	public class RouteLocatorResult extends SpatialAnalystResult
	{
		private var _image:Object;
		private var _message:String;
		private var _resultGeometry:Geometry;
		/**
		 * ${iServerJava6R_RouteLocatorResult_constructor_D} 
		 * 
		 */	
		public function RouteLocatorResult()
		{
			super();
		}
		
		/**
		 * ${iServerJava6R_RouteLocatorResult_attribute_image_D} 
		 * @return 
		 * 
		 */	
		public function get image():Object
		{
			return _image;
		}
		
		public function set image(value:Object):void
		{
			_image = value;
		}
		
		/**
		 * ${iServerJava6R_RouteLocatorResult_attribute_message_D} 
		 * @return 
		 * 
		 */	
		public function get message():String
		{
			return _message;
		}
		
		public function set message(value:String):void
		{
			_message = value;
		}
		
		/**
		 * ${iServerJava6R_RouteLocatorResult_attribute_resultGeometry_D} 
		 * @return 
		 * 
		 */	
		public function get resultGeometry():Geometry
		{
			return _resultGeometry;
		}
		
		public function set resultGeometry(value:Geometry):void
		{
			_resultGeometry = value;
		}

		sm_internal static function fromJson(object:Object):RouteLocatorResult
		{
			var result:RouteLocatorResult;
			if(object.succeed)
			{
				result = new RouteLocatorResult();
				result.setSucceedValue(object.succeed);
				if(object.image){
					result.image = object.image;
				}
				result.message = object.message;
				var x:Number;
				var y:Number;
				if(object.resultGeometry.type === "POINT"){
					x = object.resultGeometry.points[0].x;
					y = object.resultGeometry.points[0].y;
					result.resultGeometry = new GeoPoint(x, y);
				}
				if(object.resultGeometry.type === "LINE"){
					var geoLine:GeoLine = new GeoLine();
					var length:Number = object.resultGeometry.points.length;
					var points:Array = new Array();
					for(var i:Number = 0;i<length;i++){
						x = object.resultGeometry.points[i].x;
						y = object.resultGeometry.points[i].y;
						var point:Point2D = new Point2D(x, y);
						points.push(point);
					}
					geoLine.addPart(points);
					result.resultGeometry = geoLine;
				}
			}
			return result;
		}
	}
}