package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.PointWithMeasure;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.geometry.Route;
	import com.supermap.web.sm_internal;
	
	import flashx.textLayout.factory.StringTextLineFactory;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_RouteLocatorParameters_Title}.
	 * <p>${iServerJava6R_RouteLocatorParameters_Description}</p> 
	 * 
	 */	
	public class RouteLocatorParameters
	{
		private var _sourceRoute:Route = new Route();
		private var _type:String;
		private var _measure:Number;
		private var _offset:Number;
		private var _isIgnoreGap:Boolean = false;
		private var _startMeasure:Number;
		private var _endMeasure:Number;
		private var _dataset:String;
		private var _routeIDField:String;
		private var _routeID:int;
		
		/**
		 * ${iServerJava6R_RouteLocatorParameters_constructor_D} 
		 * 
		 */	
		public function RouteLocatorParameters()
		{
		}
		
		/**
		 * ${iServerJava6R_RouteLocatorParameters_attribute_sourceRoute_D}.
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
		 * ${iServerJava6R_RouteLocatorParameters_attribute_dataset_D}.
		 * @return 
		 * 
		 */	
		public function get dataset():String
		{
			return _dataset;
		}
		
		public function set dataset(value:String):void
		{
			_dataset = value;
		}
		
		/**
		 * ${iServerJava6R_RouteLocatorParameters_attribute_routeIDField_D}.
		 * @return 
		 * 
		 */	
		public function get routeIDField():String
		{
			return _routeIDField;
		}
		
		public function set routeIDField(value:String):void
		{
			_routeIDField = value;
		}
		
		/**
		 * ${iServerJava6R_RouteLocatorParameters_attribute_routeID_D}.
		 * @return 
		 * 
		 */	
		public function get routeID():int
		{
			return _routeID;
		}
		
		public function set routeID(value:int):void
		{
			_routeID = value;
		}
		
		
		/**
		 * ${iServerJava6R_RouteLocatorParameters_attribute_type_D}.
		 * @return 
		 * 
		 */	
		public function get type():String
		{
			return _type;
		}
		
		public function set type(value:String):void
		{
			_type = value;
		}
		
		/**
		 * ${iServerJava6R_RouteLocatorParameters_attribute_measure_D}.
		 * @return 
		 * 
		 */	
		public function get measure():Number
		{
			return _measure;
		}
		
		public function set measure(value:Number):void
		{
			_measure = value;
		}
		
		/**
		 * ${iServerJava6R_RouteLocatorParameters_attribute_offset_D}.
		 * @return 
		 * 
		 */	
		public function get offset():Number
		{
			return _offset;
		}
		
		public function set offset(value:Number):void
		{
			_offset = value;
		}
		
		/**
		 * ${iServerJava6R_RouteLocatorParameters_attribute_isIgnoreGap_D}.
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
		
		/**
		 * ${iServerJava6R_RouteLocatorParameters_attribute_startMeasure_D}.
		 * @return 
		 * 
		 */	
		public function get startMeasure():Number
		{
			return _startMeasure;
		}
		
		public function set startMeasure(value:Number):void
		{
			_startMeasure = value;
		}
		
		/**
		 * ${iServerJava6R_RouteLocatorParameters_attribute_endMeasure_D}.
		 * @return 
		 * 
		 */	
		public function get endMeasure():Number
		{
			return _endMeasure;
		}
		
		public function set endMeasure(value:Number):void
		{
			_endMeasure = value;
		}


		sm_internal function getVariablesJson():String
		{
			var json:String="";
			json+="\"type\":" + this.type + ",";
			if(this.sourceRoute)
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
				
				json+="\"sourceRoute\":" + "{\"type\":" + this.sourceRoute.type + ",\"parts\":[" + lengthP + "],\"points\":" + sourceRouteStr + "},";		
			}
			else if(this.dataset)
			{
				json+="\"routeIDField\":"+this.routeIDField+",";	
				json+="\"dataset\":"+this.dataset+",";
				json+="\"routeID\":"+this.routeID+",";		 
			}
			if (this.measure)
			{
				json+="\"measure\":" + this.measure + ",";
			}
			if (this.offset)
			{
				json+="\"offset\":" + this.offset + ",";
			}
			json+="\"isIgnoreGap\":" + this.isIgnoreGap + ",";
			if (this.startMeasure)
			{
				json+="\"startMeasure\":" + this.startMeasure + ",";
			}
			if (this.endMeasure)
			{
				json+="\"endMeasure\":" + this.endMeasure;
			}
			json="{" + json + "}";
			return json;
		}
	}
}