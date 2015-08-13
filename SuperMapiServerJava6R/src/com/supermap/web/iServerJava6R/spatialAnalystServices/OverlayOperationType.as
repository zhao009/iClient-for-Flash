package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	/**
	 * ${iServerJava6R_OverlayOperationType_Title}.
	 * <p>${iServerJava6R_OverlayOperationType_Description}</p> 
	 * 
	 */	
	public class OverlayOperationType
	{
		/**
		 * ${iServerJava6R_OverlayOperationType_attribute_CLIP_D}.
		 * <p>${iServerJava6R_OverlayOperationType_attribute_CLIP_remarks}</p> 
		 * @see #INTERSECT
		 */		
		public static const CLIP:String		      	 		= "CLIP";
		
		/**
		 * ${iServerJava6R_OverlayOperationType_attribute_ERASE_D}.
		 * <p>${iServerJava6R_OverlayOperationType_attribute_ERASE_remarks}</p> 
		 * @see #INTERSECT
		 */		
		public static const ERASE:String			 		= "ERASE";
		
		/**
		 * ${iServerJava6R_OverlayOperationType_attribute_IDENTITY_D}.
		 * <p>${iServerJava6R_OverlayOperationType_attribute_IDENTITY_remarks}</p> 
		 * @see UNION
		 */		
		public static const IDENTITY:String		      	 	= "IDENTITY";
		
		/**
		 * ${iServerJava6R_OverlayOperationType_attribute_INTERSECT_D}.
		 * <p>${iServerJava6R_OverlayOperationType_attribute_INTERSECT_remarks}</p> 
		 * @see #CLIP
		 */		
		public static const INTERSECT:String			 	= "INTERSECT";
		
		/**
		 * ${iServerJava6R_OverlayOperationType_attribute_UNION_D}.
		 * <p>${iServerJava6R_OverlayOperationType_attribute_UNION_remarks}</p> 
		 * @see #IDENTITY
		 */		
		public static const UNION:String		      		= "UNION";
		
		/**
		 * ${iServerJava6R_OverlayOperationType_attribute_UPDATE_D}.
		 * <p>${iServerJava6R_OverlayOperationType_attribute_UPDATE_remarks}</p> 
		 * @see #UNION
		 */		
		public static const UPDATE:String			 		= "UPDATE";
		
		/**
		 * ${iServerJava6R_OverlayOperationType_attribute_XOR_D}.
		 * <p>${iServerJava6R_OverlayOperationType_attribute_XOR_remarks}</p> 
		 */		
		public static const XOR:String			 			= "XOR";
	}
}