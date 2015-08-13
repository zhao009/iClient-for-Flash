package com.supermap.web.utils
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.sm_internal;
	
	import flash.geom.Rectangle;
	
	use namespace sm_internal;
	/**
	 * ${iServer6_JsonUtil_Title}. 
	 * <p>${iServer6_JsonUtil_Description}</p>
	 * 
	 */	
	public class JsonUtil
	{
		/**
		 * ${iServer6_JsonUtil_constructor_D} 
		 * 
		 */		
		public function JsonUtil()
		{
		}
		
		/**
		 * ${iServer6_JsonUtil_method_fromArray_D} 
		 * @param array ${iServer6_JsonUtil_method_fromArray_param_array}
		 * @param key ${iServer6_JsonUtil_method_fromArray_param_key}
		 * @param other ${iServer6_JsonUtil_method_fromArray_param_other}
		 * @return ${iServer6_JsonUtil_method_fromArray_return} 
		 * 
		 */		
		public static function fromArray(array:Array, key:String = null, other:String = null):String
		{
			if (array.length == 0)
				return "";
			
			var isString:Boolean = array[0] is String;
			var isNumber:Boolean = array[0] is Number;
			
			var json:String = "[";
			
			var count:uint = array.length;
			for (var index:uint = 0; index < count; index++)
			{
				
				if (key)
				{
					json += "{"
					json += "\"" + key + "\":";
				}
				
				if (isString)
				{
					json += "\"" + array[index] + "\"";
				}
				else if(isNumber)
				{
					json += array[index].toString();
				}
				else
				{
					json +=  fromPoint2D(array[index]);
				}
				
				if (other)
					json += "," + other;
				
				if (key)
					json += "}";
				
				if (index < count - 1 )
				{
					json += ","
				}
			}
			
			json += "]";
			
			return json;	
		}
		
		/**
		 * ${iServer6_JsonUtil_method_fromRectangle2D_D} 
		 * @param rectangle2D ${iServer6_JsonUtil_method_fromRectangle2D_param_rectangle2D}
		 * @return ${iServer6_JsonUtil_method_fromRectangle2D_return}
		 * 
		 */
		public static function fromRectangle2D(rectangle2D:Rectangle2D) : String
		{
			if (rectangle2D == null)
			{
				return "{}";
			}	
			return "{\"rightTop\":{\"y\":" + rectangle2D.top + ",\"x\":" + rectangle2D.right + "}," +
				    "\"leftBottom\":{\"y\":" + rectangle2D.bottom+ ",\"x\":" + rectangle2D.left + "}}";
		}
		
		/**
		 * ${iServer6_JsonUtil_method_fromPoint2D_D} 
		 * @param point ${iServer6_JsonUtil_method_fromPoint2D_param_point}
		 * @return ${iServer6_JsonUtil_method_fromPoint2D_return}
		 * 
		 */	
		public static function fromPoint2D(point:Point2D) : String
		{
			if (point == null)
			{
				return "{}";
			}
			return "{\"x\":" + point.x + ",\"y\":" + point.y + "}";
		}
	
		/**
		 * ${iServer6_JsonUtil_method_fromPoint2Ds_D} 
		 * @param points ${iServer6_JsonUtil_method_fromPoint2Ds_param_points}
		 * @return ${iServer6_JsonUtil_method_fromPoint2Ds_return}
		 * 
		 */	
		public static function fromPoint2Ds(points:Array) : String
		{
			if (points == null || points.length < 1)
			{
				return "[{}]";
			}
			var pntsjson:String = "[";
			for (var i:int = 0; i < points.length - 1; i++)
			{
				pntsjson += (fromPoint2D(points[i]) + ",");
			}
			pntsjson += (fromPoint2D(points[i]) + "]");
			return pntsjson;
		}
			
	
		/**
		 * ${iServer6_JsonUtil_method_toRectangle2D_D} 
		 * @param jsonObject ${iServer6_JsonUtil_method_toRectangle2D_param_jsonObject}
		 * @return ${iServer6_JsonUtil_method_toRectangle2D_return}
		 * 
		 */	
		public static function toRectangle2D(jsonObject:Object) : Rectangle2D
		{
			if (jsonObject == null)
			{
				return null;
			}
			if (!jsonObject.hasOwnProperty("leftBottom") || !jsonObject.hasOwnProperty("rightTop"))
			{
				return null;
			}
			var mbMinX:Number = jsonObject.leftBottom.x;
			var mbMinY:Number = jsonObject.leftBottom.y;
			var mbMaxX:Number  = jsonObject.rightTop.x;
			var mbMaxY:Number = jsonObject.rightTop.y;
			return new Rectangle2D(mbMinX, mbMinY, mbMaxX, mbMaxY);
		}
		
		/**
		 * ${iServer6_JsonUtil_method_toPoint2D_D} 
		 * @param jsonObject ${iServer6_JsonUtil_method_toPoint2D_param_jsonObject}
		 * @return ${iServer6_JsonUtil_method_toPoint2D_return}
		 * 
		 */	
		public static function toPoint2D(jsonObject:Object) : Point2D
		{
			if (jsonObject == null)
			{
				return null;
			}
			if (!jsonObject.hasOwnProperty("x") || !jsonObject.hasOwnProperty("y"))
			{
				return null;
			}
			return new Point2D(jsonObject.x, jsonObject.y);
		}
		
		/**
		 * ${iServer6_JsonUtil_method_toRectangle_D} 
		 * @param jsonObject ${iServer6_JsonUtil_method_toRectangle_param_jsonObject}
		 * @return ${iServer6_JsonUtil_method_toRectangle_return}
		 * 
		 */
		public static function toRectangle(jsonObject:Object) : Rectangle
		{
			if (jsonObject == null)
			{
				return null;
			}
			if (!jsonObject.hasOwnProperty("leftTop") || !jsonObject.hasOwnProperty("rightBottom"))
			{
				return null;
			}
			var mbMinX:Number = jsonObject.leftTop.x;
			var mbMinY:Number = jsonObject.leftTop.y;
			var width:Number  = jsonObject.rightBottom.x - mbMinX;
			var height:Number = jsonObject.rightBottom.y - mbMinY;
			return new Rectangle(mbMinX, mbMinY, width, height);
		}


		/**
		 * ${iServer6_JsonUtil_method_toCRS_D} 
		 * @param jsonObject ${iServer6_JsonUtil_method_toCRS_param_jsonObject}
		 * @return ${iServer6_JsonUtil_method_toCRS_return}
		 * 
		 */	
		public static function toCRS(jsonObject:Object) : CoordinateReferenceSystem
		{
			if (jsonObject == null)
			{
				
				return null;
			}
			if (!jsonObject.hasOwnProperty("pJCoordSysType") || !jsonObject.hasOwnProperty("coordUnits"))
			{
				return null;
			}
			var crs:CoordinateReferenceSystem = new CoordinateReferenceSystem(jsonObject.pJCoordSysType);
			crs.unit = jsonObject.coordUnits;
			return crs;
		}
		
	}
}