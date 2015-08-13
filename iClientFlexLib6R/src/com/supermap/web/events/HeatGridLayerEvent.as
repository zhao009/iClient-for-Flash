package com.supermap.web.events
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.sm_internal;
	
	import flash.events.Event;
	/**
	 * ${events_HeatGridLayerEvent_Title}. 
	 * <p>${events_HeatGridLayerEvent_Description}</p>
	 * 
	 */	
	public class HeatGridLayerEvent extends Event
	{
		/**
		 * ${events_HeatGridLayerEvent_field_CLICK_GRID_D}
		 */
		public static const CLICK_GRID:String = "clickGrid";
		/**
		 * ${events_HeatGridLayerEvent_field_MOUSEOVER_GRID_D}
		 */
		public static const MOUSEOVER_GRID:String = "mouseoverGrid";
		/**
		 * ${events_HeatGridLayerEvent_field_MOUSEOUT_GRID_D}
		 */
		public static const MOUSEOUT_GRID:String = "mouseoutGrid";
		//存储格网feature
		private var _gridFeature:Feature;
		//存储格网所代表的的点数据
		private var _pointFeatures:Array;
		/**
		 * ${events_HeatGridLayerEvent_constructor_D} 
		 * @param type ${events_HeatGridLayerEvent_constructor_param_type}
		 * @param gridFeature ${events_HeatGridLayerEvent_constructor_param_gridFeature}
		 * 
		 */	
		public function HeatGridLayerEvent(type:String, gridFeature:Feature)
		{
			super(type);
			this._gridFeature = gridFeature;
			this._pointFeatures = gridFeature.sm_internal::childFeatrues.toArray();
		}
		
		/**
		 * ${events_HeatGridLayerEvent_attribute_pointFeatures_D} 
		 * @return 
		 * 
		 */	
		public function get pointFeatures():Array
		{
			return _pointFeatures;
		}
		
		/**
		 * ${events_HeatGridLayerEvent_attribute_gridFeature_D} 
		 * @return 
		 * 
		 */	
		public function get gridFeature():Feature
		{
			return _gridFeature;
		}
		
		
	}
}