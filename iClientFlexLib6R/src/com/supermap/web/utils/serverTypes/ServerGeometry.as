package com.supermap.web.utils.serverTypes
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.PointWithMeasure;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.geometry.Route;
	import com.supermap.web.serialization.json.JSONDecoder;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	import com.supermap.web.utils.serverTypes.ServerTextStyle;
	
	import mx.collections.ArrayCollection;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ServerType_ServerGeometry_Tile}.
	 * <p>${iServerJava6R_ServerType_ServerGeometry_Description}</p> 
	 * 
	 */	
	public class ServerGeometry
	{
		private var _id:int;
		private var _style:ServerStyle;
		private var _parts:Array;
		private var _type:String;
		private var _epsgCode:int;
		private var _points:Array;
		private var _center:Point2D;
		
		//新增文本几何对象的文本样式和内容
		private var _textStyle:ServerTextStyle;
		private var _text:Array;
		
		
		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_attribute_text_D} 
		 * @return 
		 * 
		 */		
		public function get text():Array
		{
			return _text;
		}

		public function set text(value:Array):void
		{
			_text = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_attribute_textStyle_D} 
		 * @see com.supermap.web.core.styles.TextStyle
		 * @return 
		 * 
		 */		
		public function get textStyle():ServerTextStyle
		{
			return _textStyle;
		}

		public function set textStyle(value:ServerTextStyle):void
		{
			_textStyle = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_attribute_center_D}.
		 * @return 
		 * 
		 */		
		public function get center():Point2D
		{
			return _center;
		}

		public function set center(value:Point2D):void
		{
			_center = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_constructor_None_D} 
		 * 
		 */		
		public function ServerGeometry():void
		{
			
		}
				
		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_attribute_Points_D}.
		 * <p>${iServerJava6R_ServerType_ServerGeometry_attribute_Points_remarks}</p> 
		 * @see #parts
		 * @return 
		 * 
		 */		
		public function get points():Array
		{
			return _points;
		}

		public function set points(value:Array):void
		{
			_points = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_attribute_type_D} 
		 * @see GeometryType
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
		 * ${iServerJava6R_ServerType_ServerGeometry_attribute_epsgCode_D} 
		 * @return 
		 * 
		 */		
		public function get epsgCode():int
		{
			return _epsgCode;
		}
		
		public function set epsgCode(value:int):void
		{
			_epsgCode = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_attribute_parts_D}.
		 * <p>${iServerJava6R_ServerType_ServerGeometry_attribute_parts_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get parts():Array
		{
			return _parts;
		}

		public function set parts(value:Array):void
		{
			_parts = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_attribute_Style_D} 
		 * @return 
		 * 
		 */		
		public function get style():ServerStyle
		{
			return _style;
		}

		public function set style(value:ServerStyle):void
		{
			_style = value;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_attribute_id_D} 
		 * @return 
		 * 
		 */		
		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}
	

		//以后再补全
		//暂时定义为pullic
		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_method_fromJson_D} 
		 * @param object ${iServerJava6R_ServerType_ServerGeometry_method_fromJson_param_jsonObject}
		 * @return ${iServerJava6R_ServerType_ServerGeometry_method_fromJson_return}
		 * 
		 */			
		public static function fromJson(object:Object):ServerGeometry
		{
			var serverGeometry:ServerGeometry;
			if(object)
			{
				if(object is String)
				{
					var jsonDecoder:JSONDecoder = new JSONDecoder(object as String, true);  
					object = jsonDecoder.getValue();
				}
				serverGeometry = new ServerGeometry();
				serverGeometry.id = object.id;			
				serverGeometry.style = ServerStyle.fromJson(object.style);
				serverGeometry.type = object.type;
				if(serverGeometry.type == "TEXT")
				{
					serverGeometry.textStyle = ServerTextStyle.fromJson(object.textStyle);
					serverGeometry.text = object.texts; 
				}
				
				var c:Object = object.center;
				if(c)
				{
					serverGeometry.center = new Point2D(c.x, c.y);
				}
				var tempParts:Array = object.parts;
				if(tempParts && tempParts.length)
				{
					serverGeometry.parts = tempParts;
				}
				var tempPoint2Ds:Array = object.points;
				
				//类型不为LINEM时添加Point2D
				if(tempPoint2Ds && tempPoint2Ds.length && serverGeometry.type != "LINEM")
				{
					var point2Ds:Array = [];
					
					for each(var p:Object in tempPoint2Ds)
						point2Ds.push(new Point2D(p.x, p.y));
						
					serverGeometry.points = point2Ds;
				}
				
				//单独处理LINEM时的情况
				if(tempPoint2Ds && tempPoint2Ds.length && serverGeometry.type == "LINEM")
				{
					var point2DWithMeasures:Array = [];
					
					for each(var pointWithMeasure:Object in tempPoint2Ds)
					point2DWithMeasures.push(PointWithMeasure.fromJson(pointWithMeasure));
					
					serverGeometry.points = point2DWithMeasures;
				}
			}
			
			return serverGeometry;
		}
		
		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_method_toJson_D} 
		 * @param serverGeometry ${iServerJava6R_ServerType_ServerGeometry_method_toJson_param_serverGeometry}
		 * @return ${iServerJava6R_ServerType_ServerGeometry_method_toJson_return_D}
		 * 
		 */		
		public static function toJson(serverGeometry:ServerGeometry):String
		{
			var json:String = "";
			
			if (serverGeometry.parts && serverGeometry.parts.length)
			{
				json += "\"parts\":" + "[" + serverGeometry.parts.join(",") + "],";
			}
			else
				json += "\"parts\":" + null + ",";
			
			if (serverGeometry.points && serverGeometry.points.length)
			{
				var tempPoints:Array = [];
				var length:int = serverGeometry.points.length;
				for(var i:int = 0; i < length; i++)
				{			
					var p:Point2D = serverGeometry.points[i] as Point2D;
					if(p && (p.x > -Number.MAX_VALUE) && (p.y > -Number.MAX_VALUE))
						tempPoints.push(JsonUtil.fromPoint2D(p));
				}
				var pointsStr:String = "[" + tempPoints.join(",") + "],";
				json += "\"points\":" + pointsStr;
			}
			
			json += "\"id\":" + serverGeometry.id;
			
			if(serverGeometry.type)
				json += ",\"type\":" + "\"" + serverGeometry.type + "\"";
			
			if(serverGeometry.epsgCode)
				json += ",\"prjCoordSys\":{" +"\"epsgCode\":"+ serverGeometry.epsgCode + "}";
			
			if(serverGeometry.style)
			{
				json += ",\"style\":" + serverGeometry.style.toJSON() ;
			}
			else
				json += ",\"style\":" + null;
			
			if(serverGeometry.text)
			{
				json += ",\"texts\":" + "[\"" + serverGeometry.text.toString() + "\"]";
			}
			
			if(serverGeometry.textStyle)
			{
				json += ",\"textStyle\":" + serverGeometry.textStyle.toJSON();
			}
			
			json ="{" + json + "}";
			
			return json;
		}
		 
		sm_internal function toGeoPoint():GeoPoint
		{
			if (points != null && (type == ServerGeometryType.POINT || type == ServerGeometryType.TEXT))
			{
				var geoPoint:GeoPoint = new GeoPoint(points[0].x, points[0].y);
				geoPoint.setCenter(center);
				geoPoint.type = type;
				return geoPoint;
			}
			return null;
		}
 
		sm_internal function toGeoLine():GeoLine
		{
			if (this.parts != null)
			{
				var pss:ArrayCollection = new ArrayCollection();
				var copy:ArrayCollection = new ArrayCollection();
				for each(var item:Point2D in this.points)
				{
					copy.addItem(item);
				}
				 
				var partsLength:int = this._parts.length;
				for (var i:int = 0; i < partsLength; i++)
				{
					var temp:ArrayCollection = new ArrayCollection();
					for (var j:int = 0; j < this.parts[i]; j++)
					{
						temp.addItem(copy[j]);
					}
					pss.addItem(temp);  
					//下面等价于copy.RemoveRange(0, this.Parts[i]); 
					for(var a:int = 0; a < this.parts[i]; a++)
					{
						copy.removeItemAt(0);
					}
				}
				copy.removeAll();
				var line:GeoLine = new GeoLine();
				for each (var items:ArrayCollection in pss)
				{ 
					var array:Array = [];
					array = items.toArray();
					line.addPart(array);
				}
				line.setCenter(center);
				return line;
			}
			return null;
		}
  
		sm_internal function toGeoLinem():Route
		{
			return Route.fromJson(this);
		}
		
		sm_internal function toGeoRegion():GeoRegion
		{
			if (this.parts != null)
			{
				var pss:ArrayCollection = new ArrayCollection();
				var copy:ArrayCollection = new ArrayCollection();
				for each(var item:Point2D in this.points)
				{
					copy.addItem(item);
				}
				
				var partsLength:int = this._parts.length;
				for (var i:int = 0; i < partsLength; i++)
				{
					var temp:ArrayCollection = new ArrayCollection();
					for (var j:int = 0; j < this.parts[i]; j++)
					{
						temp.addItem(copy[j]);
					}
					pss.addItem(temp);  
					//下面等价于copy.RemoveRange(0, this.Parts[i]); 
					for(var a:int = 0; a < this.parts[i]; a++)
					{
						copy.removeItemAt(0);
					}
				}
				copy.removeAll();
				var region:GeoRegion = new GeoRegion();
				for each (var items:ArrayCollection in pss)
				{ 
					var array:Array = [];
					array = items.toArray();
					region.addPart(array);
				}
				region.setCenter(center);
				return region;
			}
			return null;
		}
		
		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_method_fromGeometry_D} 
		 * @param geo ${iServerJava6R_ServerType_ServerGeometry_method_fromGeometry_param_geometry}
		 * @return ${iServerJava6R_ServerType_ServerGeometry_method_fromGeometry_return_D}
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
					serverGeometry.type = ServerGeometryType.REGION;
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
					serverGeometry.type = ServerGeometryType.LINE;
				}
				else if(geo is GeoPoint)
				{
					var geoPoint:GeoPoint = geo as GeoPoint;
					points.push(new Point2D(geoPoint.x, geoPoint.y));
					parts.push(1);
					serverGeometry.type = ServerGeometryType.POINT;
				}
				serverGeometry.id = -1;
				serverGeometry.parts = parts;
				serverGeometry.points = points;
				serverGeometry.epsgCode=geo.SRID;
			}
			
			return serverGeometry;
		}
		
		/**
		 * ${iServerJava6R_ServerType_ServerGeometry_method_ToGeometry_D} 
		 * @param serverGeometry ${iServerJava6R_ServerType_ServerGeometry_method_ToGeometry_param_serverGeometry}
		 * @return ${iServerJava6R_ServerType_ServerGeometry_method_ToGeometry_return}
		 * 
		 */		
		public static function toGeometry(serverGeometry:ServerGeometry):Geometry
		{	
			if(serverGeometry)
			{
				switch(serverGeometry.type)
				{
					case ServerGeometryType.POINT:
						return serverGeometry.toGeoPoint();
					case ServerGeometryType.REGION:
						return serverGeometry.toGeoRegion();
					case ServerGeometryType.LINE:
						return serverGeometry.toGeoLine();
					case ServerGeometryType.LINEM:
						return serverGeometry.toGeoLinem();
					case ServerGeometryType.TEXT:
						return serverGeometry.toGeoPoint();
					default:
						return null;
				}
			}
			return null;
		}

	}
}