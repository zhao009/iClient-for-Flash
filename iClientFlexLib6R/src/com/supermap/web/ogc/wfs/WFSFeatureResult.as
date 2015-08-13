package com.supermap.web.ogc.wfs
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.sm_internal;
	
	import flash.utils.Dictionary;
	use namespace sm_internal;
	

	/**
	 * ${ogc_wfs_WFSFeatureResult_Title}.
	 * <p>${ogc_wfs_WFSFeatureResult_Description}</p> 
	 * 
	 */	
	public class WFSFeatureResult
	{
		private var _bounds:Rectangle2D;
		
		private var _features:Dictionary;
		
		/**
		 * ${ogc_wfs_WFSFeatureResult_constructor_string_D} 
		 * 
		 */	
		public function WFSFeatureResult()
		{
			this._features = new Dictionary();
		}

		/**
		 * ${ogc_wfs_WFSFeatureResult_attribute_featurePair_D} 
		 * @see WFSFeatureDescription#typeName
		 * @return 
		 * 
		 */		
		public function get features():Dictionary
		{
			return _features;
		}

//		sm_internal function setFeaturePair(value:Dictionary):void
//		{
//			_featurePair = value;
//		}

		/**
		 * ${ogc_wfs_WFSFeatureResult_attribute_bounds_D} 
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}

		sm_internal function setBounds(value:Rectangle2D):void
		{
			_bounds = value;
		}

	}
}