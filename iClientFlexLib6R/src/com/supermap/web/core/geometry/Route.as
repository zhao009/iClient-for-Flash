package com.supermap.web.core.geometry
{
	import com.supermap.web.core.PointWithMeasure;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_Route_Title}.
	 * <p>${iServerJava6R_Route_Description}</p> 
	 * 
	 */	
	public class Route extends GeoLine
	{
		private var _length:Number = 0;
		private var _maxM:Number = 0;
		private var _minM:Number = 0;

		/**
		 * ${iServerJava6R_Route_constructor_D} 
		 * 
		 */		
		public function Route()
		{
		}

		/**
		 * ${iServerJava6R_Route_attribute_minM_D} 
		 * @return 
		 * 
		 */		
		public function get minM():Number
		{
			return _minM;
		}
 
		/**
		 * ${iServerJava6R_Route_attribute_maxM_D} 
		 * @return 
		 * 
		 */		
		public function get maxM():Number
		{
			return _maxM;
		}
 
		/**
		 * ${iServerJava6R_Route_attribute_length_D} 
		 * @return 
		 * 
		 */		
		public function get length():Number
		{
			return _length;
		}
		
		/**
		 * @inheritDoc 
		 * @see Geometry
		 * @return 
		 * 
		 */		
		public override function get type():String
		{
			return "LINEM";
		}

		sm_internal static function fromJson(json:Object):Route
		{
			if (json == null)
				return null;

			var result:Route=new Route();
			var pointsLength:int=(json.points as Array).length;
			var partsJson:Array=[];
			var i:int;
			if (json is ServerGeometry)
			{
				if (json.type)
				{
					result.type=json.type;
				}


				if (json.points)
				{
					for (i=0; i < pointsLength; i++)
					{
						partsJson.push(PointWithMeasure.fromJson(json.points[i]));
					}
					result.parts.push(partsJson);
				}

				return result;
			}
			else
			{
				for (var item:String in json)
				{
					switch (item)
					{
						case "length":
						{
							result._length=json.length;
							break;
						}
						case "maxM":
						{
							result._maxM=json.maxM;
							break;
						}
						case "minM":
						{
							result._minM=json.minM;
							break;
						}
						case "type":
						{
							result.type=json.type;
							break;
						}
						case "points":
						{

							for (i=0; i < pointsLength; i++)
							{
								partsJson.push(PointWithMeasure.fromJson(json.points[i]));
							}
							result.parts.push(partsJson);
							break;
						}
						default:
						{
							break;
						}
					}
				}
				return result;
			}
		}
 
	}
}