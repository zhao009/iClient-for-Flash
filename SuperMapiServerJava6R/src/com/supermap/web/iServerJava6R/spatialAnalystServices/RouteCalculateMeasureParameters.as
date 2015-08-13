package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.PointWithMeasure;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.geometry.Route;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_RouteCalculateMeasureParameters_Title}.
	 * <p>${iServerJava6R_RouteCalculateMeasureParameters_Description}</p> 
	 * 
	 */	
	public class RouteCalculateMeasureParameters
	{
		private var _sourceRoute:Route = new Route();
		private var _point:Point2D =new Point2D();
		private var _tolerance:Number;
		private var _isIgnoreGap:Boolean;
		
		/**
		 * ${iServerJava6R_RouteCalculateMeasureParameters_constructor_D} 
		 * 
		 */	
		public function RouteCalculateMeasureParameters()
		{
		}
		
		/**
		 * ${iServerJava6R_RouteCalculateMeasureParameters_attribute_sourceRoute_D}.
		 * @return 
		 * 
		 */	
		public function get sourceRoute():Route
		{
			return _sourceRoute;
		}

		public function set sourceRoute(value:Route):void
		{
			_sourceRoute = value;
		}

		/**
		 * ${iServerJava6R_RouteCalculateMeasureParameters_attribute_point_D}.
		 * @return 
		 * 
		 */	
		public function get point():Point2D
		{
			return _point;
		}

		public function set point(value:Point2D):void
		{
			_point = value;
		}

		/**
		 * ${iServerJava6R_RouteCalculateMeasureParameters_attribute_tolerance_D}.
		 * @return 
		 * 
		 */	
		public function get tolerance():Number
		{
			return _tolerance;
		}

		public function set tolerance(value:Number):void
		{
			_tolerance = value;
		}

		/**
		 * ${iServerJava6R_RouteCalculateMeasureParameters_attribute_isIgnoreGap_D}.
		 * @return 
		 * 
		 */	
		public function get isIgnoreGap():Boolean
		{
			return _isIgnoreGap;
		}

		public function set isIgnoreGap(value:Boolean):void
		{
			_isIgnoreGap = value;
		}


		sm_internal function getVariablesJson():String
		{
			var sourceRouteStr:String="[";
			var points:Array=this.sourceRoute.parts[0];
			var lengthP:Number=points.length;
			for (var j:Number=0; j < lengthP; j++)
			{
				var item:PointWithMeasure=points[j];
				if (j != lengthP - 1)
				{
					sourceRouteStr+="{\"measure\":" + item.measure + ",\"x\":" + item.x + ",\"y\":" + item.y + "},";
				}
				else
				{
					sourceRouteStr+="{\"measure\":" + item.measure + ",\"x\":" + item.x + ",\"y\":" + item.y + "}]";
				}
			}
			var json:String="";
			json+="\"sourceRoute\":" + "{\"type\":" + this.sourceRoute.type + ",\"parts\":[" + lengthP + "],\"points\":" + sourceRouteStr + "},";
			json+="\"tolerance\":" + this.tolerance + ",";
			json+="\"point\":{\"x\":" + this.point.x + ",\"y\":" + this.point.y + "},";
			json+="\"isIgnoreGap\":" + this.isIgnoreGap;
			json="{" + json + "}";
			return json;
		}
	}
}