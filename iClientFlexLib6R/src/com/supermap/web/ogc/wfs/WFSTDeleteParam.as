package com.supermap.web.ogc.wfs
{

	/**
	 * ${ogc_wfs_WFSTDeleteParam_Title}.
	 * <p>${ogc_wfs_WFSTDeleteParam_Description}</p>
	 * 
	 */	
	public class WFSTDeleteParam extends WFSTBaseParam
	{
		
		private var _featureIDs:Array;
		
		private var _filter:Filter;
		
		/**
		 * ${ogc_wfs_WFSTDeleteParam_constructor_string_D} 
		 * 
		 */		
		public function WFSTDeleteParam()
		{
		}

		/**
		 * ${ogc_wfs_WFSTDeleteParam_attribute_filter_D} 
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
		 * ${ogc_wfs_WFSTDeleteParam_attribute_featureIDs_D} 
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