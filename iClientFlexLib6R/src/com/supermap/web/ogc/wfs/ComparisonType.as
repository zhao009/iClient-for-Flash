package com.supermap.web.ogc.wfs
{
	/**
	 * ${ogc_wfs_ComparisonType_Title}.
	 * <p>${ogc_wfs_ComparisonType_Description}</p>
	 * @see ComparisonType 
	 * 
	 */	
	public class ComparisonType
	{	
		/**
		 * ${ogc_wfs_ComparisonType_attribute_EQUAL_TO_D}.
		 * <p>${ogc_wfs_ComparisonType_attribute_EQUAL_TO_remarks}</p> 
		 */		
		public static var EQUAL_TO:String = "PropertyIsEqualTo";  
		/**
		 * ${ogc_wfs_ComparisonType_attribute_NOT_EQUAL_TO_D} 
		 */		
		public static var NOT_EQUAL_TO:String = "PropertyIsNotEqualTo";  
		/**
		 * ${ogc_wfs_ComparisonType_attribute_LESS_THAN_D}.
		 * <p>${ogc_wfs_ComparisonType_attribute_LESS_THAN_remarks}</p> 
		 */		
		public static var LESS_THAN:String = "PropertyIsLessThan";
		/**
		 * ${ogc_wfs_ComparisonType_attribute_GREATER_THAN_D} 
		 */		
		public static var GREATER_THAN:String = "PropertyIsGreaterThan";  
		/**
		 * ${ogc_wfs_ComparisonType_attribute_LESS_THAN_OR_EQUAL_TO_D} 
		 */		
		public static var LESS_THAN_OR_EQUAL_TO:String = "PropertyIsLessThanOrEqualTo";  
		/**
		 * ${ogc_wfs_ComparisonType_attribute_GREATER_THAN_OR_EQUAL_TO_D} 
		 */		
		public static var GREATER_THAN_OR_EQUAL_TO:String = "PropertyIsGreaterThanOrEqualTo";
		/**
		 * ${ogc_wfs_ComparisonType_attribute_LIKE_D}.
		 * <p>${ogc_wfs_ComparisonType_attribute_LIKE_remarks}</p> 
		 */		
		public static var LIKE:String = "PropertyIsLike";  
		/**
		 * ${ogc_wfs_ComparisonType_attribute_NULL_D} 
		 */		
		public static var NULL:String = "PropertyIsNull";  
		/**
		 * ${ogc_wfs_ComparisonType_attribute_BETWEEN_D}.
		 * <p>${ogc_wfs_ComparisonType_attribute_BETWEEN_remarks}</p> 
		 */		
		public static var BETWEEN:String = "PropertyIsBetween";
		
		/**
		 * @private 
		 * 
		 */		
		public function ComparisonType()
		{
		}
	}
}