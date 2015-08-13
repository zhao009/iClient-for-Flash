package com.supermap.web.iServerJava2
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;

	use namespace sm_internal;
	
	/**
	 * ${iServer2_ServerGeometry_Title}. 
	 * <br/> ${iServer2_ServerGeometry_Description}
	 * 
	 * 
	 */	
	public class ServerGeometry
	{
		private var _id:int;
	    private var _feature:int;
	    private var _parts:Array;
	    private var _point2Ds:Array;
			
		/**
		 * ${iServer2_ServerGeometry_constructor_None_D_as} 
		 * 
		 */		
		public function ServerGeometry()
		{
		}
		/**
		 * ${iServer2_ServerGeometry_attribute_id_D}  
		 * 
		 */		
		public function get id():int
		{
			return this._id;
		}
		public function set id(value:int):void
		{
			this._id = value;
		}
			
		/**
		 * ${iServer2_ServerGeometry_attribute_feature_D} 
		 * 
		 */		 
		public function get feature():int
		{
			return this._feature;
		}	
		public function set feature(value:int):void
		{
			this._feature = value;
		}
		
		 /**
		  * ${iServer2_ServerGeometry_attribute_parts_D}.
		  * <p>${iServer2_ServerGeometry_attribute_parts_remarks}</p> 
		  * 
		  */		 
		public function get parts():Array
		{
			return this._parts;
		}	
		
		public function set parts(value:Array):void
		{
			this._parts = value;
		}
		
		/**
		 * ${iServer2_ServerGeometry_attribute_point2Ds_D}.
		 * <p>${iServer2_ServerGeometry_attribute_point2Ds_remarks}</p> 
		 * 
		 */		
		public function get point2Ds():Array
		{
			return this._point2Ds;
		}
		
		public function set point2Ds(value:Array):void
		{
			this._point2Ds = value;
		}
		
		sm_internal static function fromGeoPoint(point:GeoPoint) : String
		{
			if (point == null)
			{
				return "{}";	
			}
			return "{\"x\":" + point.x + ",\"y\":" + point.y + "}";
		}
		
		sm_internal static function fromGeoLine(geoLine:GeoLine):String
		{
			var json:String = "";
			
			var ptCount:int = geoLine.partCount;
			for (var i:int = 0; i < ptCount; i++)
			{
				json += "["
				var part:Array = geoLine.parts[i] as Array;
				var partLength:int = part.length;
				for (var j:int = 0; j < partLength; j++)
				{
					if (part[j] is Point2D)
					{
						json += JsonUtil.fromPoint2D(part[j] as Point2D);
						if (j < partLength - 1 )
						{
							json += ","
						}
					}
				}
				json += "]"
				if (i < ptCount - 1 )
				{
					json += ","
				}
			}
			
			if (json.length > 0)
				return json;
			
			return "[]";
		}
		
		sm_internal static function fromGeoRegion(geoRegion:GeoRegion):String
		{
			var json:String = "";
			
			var ptCount:int = geoRegion.partCount;
			for (var i:int = 0; i < ptCount; i++)
			{
				json += "["
				var part:Array = geoRegion.parts[i] as Array;
				var partLength:int = part.length;
				for (var j:int = 0; j < partLength; j++)
				{
					if (part[j] is Point2D)
					{
						json += JsonUtil.fromPoint2D(part[j] as Point2D);
						if (j < partLength - 1 )
						{
							json += ","
						}
					}
				}
				json += "]"
				if (i < ptCount - 1 )
				{
					json += ","
				}
			}
			
			if (json.length > 0)
				return json;
			
			return "[]";
		}
		
		/**
		 * ${iServer2_ServerGeometry_method_fromGeometry_D} 
		 * @see com.supermap.web.core.geometry.Geometry
		 * 
		 */		
		public static function fromGeometry(geo:Geometry):ServerGeometry
		{
			var serverGeometry:ServerGeometry;
			if(geo)
			{
				serverGeometry = new ServerGeometry();
				var points:Array = [];
				var parts:Array = [];
				var partCount:int;
				if(geo is GeoRegion)
				{
					var geoRegion:GeoRegion = geo as GeoRegion;
					partCount = geoRegion.partCount;
					for(var m:int = 0; m < partCount; m++)
					{
						var partPoints:Array = geoRegion.getPart(m);
						var partPointsLength:int = partPoints.length;
						
						for(var n:int = 0; n < partPointsLength; n++)
						{
							points.push(partPoints[n]);
						}
						parts.push(partPoints.length);
					}
					serverGeometry.feature = ServerFeatureType.POLYGON;
				}
				else if(geo is GeoLine)
				{
					var geoLine:GeoLine = geo as GeoLine;
					partCount = geoLine.partCount;
					for(var k:int = 0; k < partCount; k++)
					{
						var linePartPoints:Array = geoLine.getPart(k);
						var linePartPointsLength:int = linePartPoints.length;
						
						for(var p:int = 0; p < linePartPointsLength; p++)
						{
							points.push(linePartPoints[p]);
						}
						parts.push(linePartPoints.length);
					}
					serverGeometry.feature = ServerFeatureType.LINE;
				}
				else if(geo is GeoPoint)
				{
					var geoPoint:GeoPoint = geo as GeoPoint;
					points.push(new Point2D(geoPoint.x, geoPoint.y));
					parts.push(1);
					serverGeometry.feature = ServerFeatureType.POINT;
				}
				serverGeometry.id = -1;
				serverGeometry.parts = parts;
				serverGeometry.point2Ds = points;
			}
			
			return serverGeometry;
		}
		
		/**
		 * ${iServer2_ServerGeometry_method_toGeometry_D} 
		 * @see com.supermap.web.core.geometry.Geometry
		 * 
		 */		
		public static function toGeometry(serverGeometry:ServerGeometry):Geometry
		{		
			switch(serverGeometry.feature)
			{
				case ServerFeatureType.POINT:
					return serverGeometry.toGeoPoint();
				case ServerFeatureType.POLYGON:
					return serverGeometry.toGeoRegion();
				case ServerFeatureType.LINE:
				case ServerFeatureType.LINEM:
					return serverGeometry.toGeoLine();
				default:
					return null;
			}
		}
		
		
		/**
		 * ${iServer2_ServerGeometry_method_toGeoPoint_D} 
		 * 
		 */		
		public function toGeoPoint():GeoPoint
		{
			if(this._point2Ds)
			{
				var geoPoint:GeoPoint = new GeoPoint(this._point2Ds[0].x, this._point2Ds[0].y);
				return geoPoint;
			}
			return null;
		}
		
		/**
		 * ${iServer2_ServerGeometry_method_toGeoLines_D} 
		 * 
		 */		
		public function toGeoLine():GeoLine
		{
			if(this._parts)
			{
				if(this._point2Ds)
				{
					var geoLine:GeoLine = new GeoLine();
					var lineStartCount:int = 0;
					for(var j:int = 0; j < this._parts.length; j++)
					{
						var line:Array = new Array();
						for(var k:int = 0; k < this._parts[j]; k++)
						{
							var linePoint2D:Point2D = new Point2D(this._point2Ds[lineStartCount + k].x, this._point2Ds[lineStartCount + k].y);
							line.push(linePoint2D);
						}
						geoLine.addPart(line);
						lineStartCount += this._parts[j];
					}
					return geoLine;
				}
			}
			return null;
		}
		
		/**
		 * ${iServer2_ServerGeometry_method_toGeoRegions_D} 
		 * 
		 */		
		public function toGeoRegion():GeoRegion
		{
			if(this._parts)
			{
				if(this._point2Ds)
				{
					var geoRegion:GeoRegion = new GeoRegion();
					var regionStartCount:int = 0;
					for(var m:int = 0; m < this._parts.length; m++)
					{
						var region:Array = new Array();
						
						for(var n:int = 0; n < this._parts[m]; n++)
						{
							var regionPoint2D:Point2D = new Point2D(this._point2Ds[regionStartCount + n].x, this._point2Ds[regionStartCount + n].y);
							
							region.push(regionPoint2D);
						}
						
						geoRegion.addPart(region);
						regionStartCount += this._parts[m];
						
					}
					return geoRegion;
				}
			}
			return null;
		}
		
		/**
		 * @private 
		 * @param object
		 * @return 
		 * 
		 */		
		public  static function fromJson(object:Object):ServerGeometry
		{
			var geometry:ServerGeometry;
		 	if(object)
            {
               	geometry = new ServerGeometry();
              	geometry.feature = object.feature;
               	geometry.id = object.id;
               
               	var tempParts:Array = object.parts;
               	if(tempParts)
               	{
               	 	if(tempParts.length > 0)
               	 	{
               	 		geometry.parts = tempParts;
               	 	}
               	}
               
               	var tempPoint2Ds:Array = object.point2Ds;
               	
				if(tempPoint2Ds && tempPoint2Ds.length)
				{
					var point2Ds:Array = new Array();
					for each(var p:Object in tempPoint2Ds)
					point2Ds.push(new Point2D(p.x, p.y));
					geometry.point2Ds = point2Ds;
				}
            }
            return geometry;
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */
		public static function toJson(serverGeometry:ServerGeometry):String
		{
			var json:String = "";
			
			if (serverGeometry.parts)
			{
				if(serverGeometry.parts.length > 0)
				json += "\"parts\":" + "[" + serverGeometry.parts.join(",") + "],";
			}
			else
				json += "\"parts\":" + null + ",";
				
			if (serverGeometry.point2Ds)
			{
				if(serverGeometry.point2Ds.length > 0)
				{
					var tempPoint2Ds:Array = new Array();
					for(var i:int = 0; i < serverGeometry.point2Ds.length; i++)
					{
						var p:Point2D = serverGeometry.point2Ds[i] as Point2D;
						if((p.x > -Number.MAX_VALUE) && (p.y > -Number.MAX_VALUE))
							tempPoint2Ds.push(JsonUtil.fromPoint2D(serverGeometry.point2Ds[i] as Point2D));
					}
					
					var point2DsStr:String = "[" + tempPoint2Ds.join(",") + "],";
					json += "\"point2Ds\":" + point2DsStr;
				}
			}
			
			if(serverGeometry.id >= 0)
				json += "\"id\":" + serverGeometry.id + ",";
			
			if(serverGeometry.feature >= -1)
				json += "\"feature\":" + serverGeometry.feature;
			
			if(json.charAt(json.length - 1) == ",")
				json = json.substring(0, json.length - 1);
			
			if(json.length > 0)
			json ="{" + json + "}";
			
            return json;
  		}
	}
}