package com.supermap.web.events
{
	import com.supermap.web.core.Feature;
	
	import flash.events.Event;
	
	import mx.events.DataGridEvent;
	
	/**
	 * ${events_FeatureDataGridEvent_Title}.
	 * <p>${events_FeatureDataGridEvent_Description}</p> 
	 * @see com.supermap.web.components.FeatureDataGrid
	 * 
	 */	
	public class FeatureDataGridEvent extends DataGridEvent
	{
		private var _feature:Feature;
		/**
		 * ${events_FeatureDataGridEvent_field_FEATURE_SELECTED_D} 
		 */		
		public static const FEATURE_SELECTED:String = "featureSelected";
		/**
		 * ${events_FeatureDataGridEvent_field_FEATURE_CLICK_D} 
		 */		
		public static const FEATURE_CLICK:String    = "featureClick";
		
		/**
		 * ${events_FeatureDataGridEvent_field_FEATURE_DELETE_D} 
		 */		
		public static const FEATURE_DELETE:String   = "featureDelete";
		/**
		 * ${events_FeatureDataGridEvent_constructor_D} 
		 * @param type ${events_FeatureDataGridEvent_constructor_param_type}
		 * @param feature ${events_FeatureDataGridEvent_constructor_param_feature}
		 * 
		 */		
		public function FeatureDataGridEvent(type:String, feature:Feature = null)
		{
			super(type);
			this._feature = feature;
		}
		
		/**
		 * ${events_FeatureDataGridEvent_field_feature_D} 
		 * @return 
		 * 
		 */		
		public function get feature():Feature
		{
			return _feature;
		}
 
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			return new FeatureDataGridEvent(type, this._feature);
		}
 	
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function toString():String
		{
			return formatToString("FeatureDataGridEvent", "type", "feature"); 
		}
	}
}