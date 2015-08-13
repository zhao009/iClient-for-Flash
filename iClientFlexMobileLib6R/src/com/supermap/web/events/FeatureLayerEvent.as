package com.supermap.web.events
{
	import com.supermap.web.core.Feature;
	
	import flash.events.Event;
	
	/**
	 * ${events_FeatureLayerEvent_Title}.
	 * <p>${events_FeatureLayerEvent_Description}</p> 
	 * @see com.supermap.web.mapping.FeaturesLayer
	 * 
	 */	
	public class FeatureLayerEvent extends Event
	{
		private var _feature:Feature;
		/**
		 * ${events_FeatureLayerEvent_field_FEATURE_ADD_D}
		 */		
		public static const FEATURE_ADD:String = "featureAdd";
		/**
		 * ${events_FeatureLayerEvent_field_FEATURE_REMOVE_D} 
		 */		
		public static const FEATURE_REMOVE:String = "featureRemove";
		/**
		 * ${events_FeatureLayerEvent_field_FEATURE_REMOVE_ALL_D} 
		 */		
		public static const FEATURE_REMOVE_ALL:String = "featureRemoveAll";
		
		/**
		 * ${events_FeatureLayerEvent_constructor_D} 
		 * @param type ${events_FeatureLayerEvent_constructor_param_type}
		 * @param feature ${events_FeatureLayerEvent_constructor_param_feature}
		 * 
		 */		
		public function FeatureLayerEvent(type:String, feature:Feature = null)
		{
			super(type);
			this.feature = feature;
		}
		
		/**
		 * ${events_FeatureLayerEvent_attribute_feature_D} 
		 * @return 
		 * 
		 */		
		public function get feature():Feature
		{
			return _feature;
		}

		public function set feature(value:Feature):void
		{
			_feature = value;
		}

		/**
		 * @private
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new FeatureLayerEvent(type, this.feature);
		}
		/**
		 * @private 
		 * @return 
		 * 
		 */	
		override public function toString() : String
		{
			return formatToString("FeatureEvent", "type", "feature");
		}
	}
}