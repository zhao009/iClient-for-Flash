package com.supermap.web.events
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.Geometry;
	
	import flash.events.Event;

	/**
	 * ${events_SnapEvent_Title}. 
	 * <p>${events_SnapEvent_Description}</p>
	 * 
	 */	
	public class SnapEvent extends Event
	{
		private var _point:Point2D;
		private var _nodes:Array;
		private var _feature:Feature;
		/**
		 * ${events_SnapEvent_field_SNAP_SUCCEED_D} 
		 */	
		public static const SNAP_SUCCEED:String = "snapSucceed";
		/**
		 * ${events_SnapEvent_field_SNAP_FAILED_D} 
		 */	
		public static const SNAP_FAILED:String = "snapFailed";
		/**
		 * ${events_SnapEvent_constructor_D} 
		 * @param type ${events_SnapEvent_constructor_param_type}
		 * @param point ${events_SnapEvent_constructor_param_point}
		 * 
		 */	
		public function SnapEvent(type:String, point:Point2D,nodes:Array = null,feature:Feature = null)
		{
			super(type);
			this._point = point;
			this._nodes = nodes;
			this._feature = feature;
		}
		/**
		 * ${events_SnapEvent_attribute_point_D} 
		 * @return 
		 * 
		 */	
		public function get point():Point2D
		{
			return _point;
		}
		/**
		 * ${events_SnapEvent_attribute_nodes_D} 
		 * @return 
		 * 
		 */	
		public function get nodes():Array
		{
			return _nodes;
		}
		/**
		 * ${events_SnapEvent_attribute_feature_D} 
		 * @return 
		 * 
		 */	
		public function get feature():Feature
		{
			return _feature;
		}


	}
}