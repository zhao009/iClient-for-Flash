package com.supermap.web.ogc.wfs
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;

	/**
	 * ${ogc_wfs_WFSCapabilitiesResult_Title}.
	 * <P>${ogc_wfs_WFSCapabilitiesResult_Description}</P> 
	 * @see com.supermap.web.ogc.wfs.GetWFSCapabilities
	 * 
	 */	
	public class WFSCapabilitiesResult
	{
		private var _featureTypes:Array;
		
		/**
		 * ${ogc_wfs_WFSCapabilitiesResult_constructor_string_D} 
		 * 
		 */		
		public function WFSCapabilitiesResult()
		{
		}

		sm_internal function setFeatureTypes(value:Array):void
		{
			_featureTypes = value;
		}

		/**
		 * ${ogc_wfs_WFSCapabilitiesResult_attribute_featureTypes_D}
		 * @see com.supermap.web.ogc.wfs.FeatureType
		 * @return 
		 * 
		 * 
		 */	
		public function get featureTypes():Array
		{
			return _featureTypes;
		}

	}
}