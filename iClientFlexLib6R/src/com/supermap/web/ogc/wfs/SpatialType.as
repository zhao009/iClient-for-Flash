package com.supermap.web.ogc.wfs
{
	/**
	 * ${ogc_wfs_SpatialType_Title}.
	 * <p>${ogc_wfs_SpatialType_Description}</p> 
	 * 
	 */	
	public class SpatialType
	{
		/**
		 * ${ogc_wfs_SpatialType_attribute_BBOX_D} 
		 */		
		public static var BBOX:String = "BBOX";  
		
		/**
		 * ${ogc_wfs_SpatialType_attribute_INTERSECTS_D} 
		 */		
		public static var INTERSECTS:String = "Intersects";  
		
		/**
		 * ${ogc_wfs_SpatialType_attribute_WITHIN_D} 
		 */		
		public static var WITHIN:String = "Within";  
		
		/**
		 * ${ogc_wfs_SpatialType_attribute_CONTAINS_D} 
		 */		
		public static var CONTAINS:String = "Contains";  
		
		/**
		 * ${ogc_wfs_SpatialType_attribute_EQUALS_D} 
		 */		
		public static var EQUALS:String = "Equals";  
		
		/**
		 * ${ogc_wfs_SpatialType_attribute_DISJOINT_D} 
		 */		
		public static var DISJOINT:String = "Disjoint";  
		
		/**
		 * ${ogc_wfs_SpatialType_attribute_TOUCHES_D} 
		 */		
		public static var TOUCHES:String = "Touches"; 
		
		/**
		 * ${ogc_wfs_SpatialType_attribute_OVERLAPS_D} 
		 */		
		public static var OVERLAPS:String = "Overlaps";  
		
		/**
		 * ${ogc_wfs_SpatialType_attribute_CROSSES_D} 
		 */		
		public static var CROSSES:String = "Crosses";  
		
		//iserver暂时不支持这两个操作类型，geosever 支持
		/**
		 * ${ogc_wfs_SpatialType_attribute_DWITHIN_D} 
		 */		
		public static var DWITHIN:String = "DWithin";
		
		/**
		 * ${ogc_wfs_SpatialType_attribute_BEYOND_D} 
		 */		
		public static var BEYOND:String = "Beyond";
		
	}
}