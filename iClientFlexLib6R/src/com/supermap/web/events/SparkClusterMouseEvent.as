package com.supermap.web.events
{
	import com.supermap.web.clustering.Cluster;
	import com.supermap.web.core.Feature;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;

	use namespace sm_internal;
	
	/**
	 * ${events_SparkClusterMouseEvent_Title}.
	 * <p>${events_SparkClusterMouseEvent_Description}</p> 
	 * @see com.supermap.web.clustering.Clusterer
	 * @see com.supermap.web.clustering.SparkClusterStyle
	 * 
	 */	
	public class SparkClusterMouseEvent extends MouseEvent
	{
		private var _mouseEvent:MouseEvent;
		private var _feature:Feature;
		private var _cluster:Cluster;
		/**
		 * ${events_SparkClusterMouseEvent_field_SPARK_CLICK_D} 
		 */		
		public static const SPARK_CLICK:String = "sparkClick";
		/**
		 * ${events_SparkClusterMouseEvent_field_SPARK_OUT_D} 
		 */		
		public static const SPARK_OUT:String = "sparkOut";
		/**
		 * ${events_SparkClusterMouseEvent_field_SPARK_OUT_D} 
		 */		
		public static const SPARK_OVER:String = "sparkOver";
		
		/**
		 * ${events_SparkClusterMouseEvent_constructor_D} 
		 * @param type ${events_SparkClusterMouseEvent_constructor_param_type}
		 * @param cluster ${events_SparkClusterMouseEvent_constructor_param_cluster}
		 * @param feature ${events_SparkClusterMouseEvent_constructor_param_feature}
		 * 
		 */		
		public function SparkClusterMouseEvent(type:String, cluster:Cluster, feature:Feature)
		{
			super(type, true, true);
			this._cluster = cluster;
			this._feature = feature;
		}
		
		/**
		 * ${events_SparkClusterMouseEvent_attribute_cluster_D} 
		 * @return 
		 * 
		 */		
		public function get cluster():Cluster
		{
			return _cluster;
		}
		public function set cluster(value:Cluster):void
		{
			_cluster = value;
		}

		/**
		 * ${events_SparkClusterMouseEvent_attribute_feature_D} 
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
		override public function get stageX() : Number
		{
			return this._mouseEvent.stageX;
		}	
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function get stageY() : Number
		{
			return this._mouseEvent.stageY;
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			var sparkClusterMouseEvent:SparkClusterMouseEvent = new SparkClusterMouseEvent(type, this._cluster, this._feature);
			sparkClusterMouseEvent.copyProperties(this._mouseEvent);
			return sparkClusterMouseEvent;
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function toString() : String
		{
			return formatToString("SparkClusterMouseEvent", "type", "cluster", "feature", "localX", "localY", "stageX", "stageY", "relatedObject", "ctrlKey", "altKey", "shiftKey", "delta");
		}
		
		sm_internal function copyProperties(event:MouseEvent) : void
		{
			localX = event.localX;
			localY = event.localY;
			relatedObject = event.relatedObject;
			ctrlKey = event.ctrlKey;
			altKey = event.altKey;
			shiftKey = event.shiftKey;
			buttonDown = event.buttonDown;
			delta = event.delta;
			this._mouseEvent = event;
		}
		
	}
}