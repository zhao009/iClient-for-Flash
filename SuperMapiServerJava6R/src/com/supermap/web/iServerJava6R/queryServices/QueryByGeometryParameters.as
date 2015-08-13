package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.core.geometry.Geometry;
	
	/**
	 * ${iServerJava6R_QueryByGeometryParameters_Tile}.
	 * <p>${iServerJava6R_QueryByGeometryParameters_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.FilterParameter
	 * 
	 */	
	public class QueryByGeometryParameters extends QueryParameters
	{
		private var _spatialQueryMode:String;
		
		private var _geometry:Geometry;
		
		/**
		 * ${iServerJava6R_QueryByGeometryParameters_constructor_None_D} 
		 * 
		 */		
		public function QueryByGeometryParameters()
		{
			super();
		}
		
		/**
		 * ${iServerJava6R_QueryByGeometryParameters_attribute_Geometry_D} 
		 * @return 
		 * 
		 */		
		public function get geometry():Geometry
		{
			return _geometry;
		}

		public function set geometry(value:Geometry):void
		{
			_geometry = value;
		}

		/**
		 * ${iServerJava6R_QueryByGeometryParameters_attribute_SpatialQueryMode_D}.
		 * <p>${iServerJava6R_QueryByGeometryParameters_attribute_SpatialQueryMode_remarks}</p> 
		 * @see SpatialQueryMode
		 * @return 
		 * 
		 */		
		public function get spatialQueryMode():String
		{
			return _spatialQueryMode;
		}

		public function set spatialQueryMode(value:String):void
		{
			_spatialQueryMode = value;
		}

	}
}