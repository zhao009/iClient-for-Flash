package com.supermap.web.ogc.wfs
{
	import com.supermap.web.core.Feature;
	
	import flash.utils.Dictionary;

	/**
	 * ${ogc_wfs_WFSTInsertParam_Title}.
	 * <p>${ogc_wfs_WFSTInsertParam_Description}</p>
	 * 
	 * 
	 */	
	public class WFSTInsertParam extends WFSTBaseParam
	{
		private var _spatialProperty:String = "the_geom";
		private var _features:Array;
		
		/**
		 * ${ogc_wfs_WFSTInsertParam_constructor_string_D} 
		 * 
		 */		
		public function WFSTInsertParam()
		{
		}

		/**
		 * ${ogc_wfs_WFSTInsertParam_attribute_spatialProperty_D} 
		 * @return 
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
		 * ${ogc_wfs_WFSTInsertParam_attribute_features_D} 
		 * @return 
		 * 
		 */		
		public function get features():Array
		{
			return _features;
		}
		
		public function set features(value:Array):void
		{
			_features = value;
		}
	}
}