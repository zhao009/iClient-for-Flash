package com.supermap.web.ogc.wfs
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	import flash.utils.Dictionary;

	/**
	 * ${ogc_wfs_WFSDescribeFeatureTypeResult_Title}. 
	 * <p>${ogc_wfs_WFSDescribeFeatureTypeResult_Description}</p>
	 * 
	 */
	public class WFSFeatureTypeResult
	{
		private var _featureDescriptions:Dictionary;
		private var _descriptionNamespaces:Array;
		
		/**
		 * ${ogc_wfs_WFSDescribeFeatureTypeResult_constructor_string_D} 
		 * 
		 */	
		public function WFSFeatureTypeResult()
		{
			_descriptionNamespaces = [];
			_featureDescriptions = new Dictionary();
		}

		/**
		 * ${ogc_wfs_WFSDescribeFeatureTypeResult_attribute_descriptionNamespaces_D} 
		 * @see DescribeWFSFeatureType#typeNames
		 * @return 
		 * 
		 */
		public function get descriptionNamespaces():Array
		{
			return _descriptionNamespaces;
		}

//		sm_internal function setFeatureNamespaces(value:Array):void
//		{
//			_featureNamespaces = value;
//		}

		/**
		 * ${ogc_wfs_WFSDescribeFeatureTypeResult_attribute_featureDescriptions_D} 
		 * @see com.supermap.web.ogc.wfs.WFSFeatureDescription
		 * @return 
		 * 
		 */
		public function get featureDescriptions():Dictionary
		{
			return _featureDescriptions;
		}

//		sm_internal function featureDescriptions(value:Dictionary):void
//		{
//			_featureDescriptions = value;
//		}

	}
}