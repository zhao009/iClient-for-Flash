package com.supermap.web.ogc.wfs
{
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.core.Rectangle2D;

	
	/**
	 * ${ogc_wfs_FeatureType_Title}.
	 * <p>${ogc_wfs_FeatureType_Description}</p> 
	 * 
	 */	
	public class WFSFeatureType
	{
		private var _typeName:String;
		
		private var _title:String;
		
		private var _SRS:CoordinateReferenceSystem;
		
		private var _bounds:Rectangle2D;
		
		
		/**
		 * ${ogc_wfs_FeatureType_constructor_D}.
		 * 
		 */		
		public function WFSFeatureType()
		{
		}

		/**
		 * ${ogc_wfs_FeatureType_attribute_bounds_D} 
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}

		public function set bounds(value:Rectangle2D):void
		{
			_bounds = value;
		}

		/**
		 * ${ogc_wfs_FeatureType_attribute_SRS_D} 
		 * @return 
		 * 
		 */		
		public function get SRS():CoordinateReferenceSystem
		{
			return _SRS;
		}

		public function set SRS(value:CoordinateReferenceSystem):void
		{
			_SRS = value;
		}

		/**
		 * ${ogc_wfs_FeatureType_attribute_title_D} 
		 * @return 
		 * 
		 */		
		public function get title():String
		{
			return _title;
		}

		public function set title(value:String):void
		{
			_title = value;
		}

		/**
		 * ${ogc_wfs_FeatureType_attribute_typeName_D} 
		 * @return 
		 * 
		 */		
		public function get typeName():String
		{
			return _typeName;
		}

		public function set typeName(value:String):void
		{
			_typeName = value;
		}

	}
}