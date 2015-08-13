package com.supermap.web.iServerJava6R.dataServices
{
	import com.supermap.web.core.geometry.Geometry;

	/**
	 * ${iServerJava6R_GetFeaturesByGeometryParameters_Title}.
	 * <p>${iServerJava6R_GetFeaturesByGeometryParameters_Description}</p> 
	 * 
	 */	
	public class GetFeaturesByGeometryParameters extends GetFeaturesParametersBase
	{
		private var _geometry:Geometry;
		private var _spatialQueryMode:String;
		private var _attributeFilter:String;
		private var _fields:Array;
		
		/**
		 * ${iServerJava6R_GetFeaturesByGeometryParameters_constructor_D} 
		 * 
		 */		
		public function GetFeaturesByGeometryParameters()
		{
		}

		/**
		 * ${iServerJava6R_GetFeaturesByGeometryParameters_attribute_attributeFilter_D}.
		 * <p>${iServerJava6R_GetFeaturesByGeometryParameters_attribute_attributeFilter_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get attributeFilter():String
		{
			return _attributeFilter;
		}

		public function set attributeFilter(value:String):void
		{
			_attributeFilter = value;
		}

		/**
		 * ${iServerJava6R_GetFeaturesByGeometryParameters_attribute_fields_D}.
		 * <p>${iServerJava6R_GetFeaturesByGeometryParameters_attribute_fields_remarks}</p> 
		 * @see GetFeaturesResult#features
		 * @return 
		 * 
		 */		
		public function get fields():Array
		{
			return _fields;
		}

		public function set fields(value:Array):void
		{
			_fields = value;
		}

		/**
		 * ${iServerJava6R_GetFeaturesByGeometryParameters_attribute_geometry_D} 
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
		 * ${iServerJava6R_GetFeaturesByGeometryParameters_attribute_spatialQueryMode_D}
		 * @see  com.supermap.web.iServerJava6R.queryServices.SpatialQueryMode
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