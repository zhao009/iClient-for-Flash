package com.supermap.web.ogc.wfs
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.sm_internal;
	
	import flash.geom.Point;

	use namespace sm_internal;
	
	/**
	 * ${ogc_wfs_Spatial_Title}.
	 * <p>${ogc_wfs_Spatial_Description}</p>
	 * @see SpatialGeometry
	 * @see SpatialRect 
	 * 
	 */
	public class Spatial extends Filter
	{
		private var _type:String;
		private var _propertyName:String;
		
		/**
		 * ${ogc_wfs_Spatial_constructor_string_D} 
		 * 
		 */	
		public function Spatial()
		{
			super();
		}
		
		/**
		 * ${ogc_wfs_Spatial_attribute_type_D}
		 * @see SpatialType 
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
		 * ${ogc_wfs_Spatial_attribute_propertyName_D} 
		 * @see WFSFeatureDescription#spatialProperty
		 * @return 
		 * 
		 */		
		public function get propertyName():String
		{
			return _propertyName;
		}

		public function set propertyName(value:String):void
		{
			_propertyName = value;
		}

		private function point2DToString(p:Point2D):String
		{
			return  p.x + "," + p.y;
		}
		
		internal function GetSinglePointStr(p:Point2D):String
		{
			var str:String = null;
			if(p)
			{
				str = point2DToString(p);
			}
			return str;
		}
		
		internal function GetPointPairStr(p1:Point2D, p2:Point2D):String
		{
			var str:String = null;
			if(p1 && p2)
			{
				str = point2DToString(p1) + " " + point2DToString(p2);
			}
			return str;
		}
		
		internal function GetPointsStr(ps:Array):String
		{
			var str:String = null;
			if(ps && ps.length)
			{
				var strArray:Array = [];
				for each(var p:Point2D in ps)
				{
					strArray.push(point2DToString(p));
				}
				str = strArray.join(" ");
			}
			return str;
		}
	}
}