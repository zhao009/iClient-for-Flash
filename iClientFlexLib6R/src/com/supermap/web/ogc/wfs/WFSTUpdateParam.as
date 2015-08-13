package com.supermap.web.ogc.wfs
{
	import com.supermap.web.core.Feature;

	/**
	 * ${ogc_wfs_WFSTUpdateParam_Title}. 
	 * <p>${ogc_wfs_WFSTUpdateParam_Description}</p>
	 * 
	 */	
	public class WFSTUpdateParam extends WFSTBaseParam
	{
		
		private var _featureIDs:Array;
		private var _filter:Filter;
		private var _spatialProperty:String = "the_geom";
		private var _modifyFeature:Feature;
		
		/**
		 * ${ogc_wfs_WFSTUpdateParam_constructor_string_D} 
		 * 
		 */		
		public function WFSTUpdateParam()
		{
		}

		/**
		 * ${ogc_wfs_WFSTUpdateParam_attribute_modifyFeature_D} 
		 * @see #filter
		 * @see #featureIDs
		 * @return 
		 * 
		 */		
		public function get modifyFeature():Feature
		{
			return _modifyFeature;
		}
		
		public function set modifyFeature(value:Feature):void
		{
			_modifyFeature = value;
		}

		/**
		 * ${ogc_wfs_WFSTUpdateParam_attribute_spatialProperty_D} 
		 * 
		 */	
		public function get spatialProperty():String
		{
			return _spatialProperty;
		}
		
		public function set spatialProperty(value:String):void
		{
			_spatialProperty = value;
		}

		/**
		 * ${ogc_wfs_WFSTUpdateParam_attribute_filter_D} 
		 * @see #featureIDs
		 * @return 
		 * 
		 */		
		public function get filter():Filter
		{
			return _filter;
		}

		public function set filter(value:Filter):void
		{
			_filter = value;
		}

		/**
		 * ${ogc_wfs_WFSTUpdateParam_attribute_featureIDs_D} 
		 * @see #filter
		 * @return 
		 * 
		 */		
		public function get featureIDs():Array
		{
			return _featureIDs;
		}

		public function set featureIDs(value:Array):void
		{
			_featureIDs = value;
		}

	}
}