package com.supermap.web.events
{
	import com.supermap.web.clustering.Cluster;
	
	import flash.events.Event;
	
	/**
	 * ${events_SparkClusterEvent_Title}.
	 * <p>${events_SparkClusterEvent_Description}</p> 
	 * @see com.supermap.web.clustering.Clusterer
	 * @see com.supermap.web.clustering.SparkClusterStyle
	 */	
	public class SparkClusterEvent extends Event
	{
		private var _cluster:Cluster;
		/**
		 * ${events_SparkClusterEvent_field_SPARK_OUT_START_D} 
		 */		
		public static const SPARK_OUT_START:String = "sparkOutStart";
		/**
		 * ${events_SparkClusterEvent_field_SPARK_OUT_COMPLETE_D} 
		 */		
		public static const SPARK_OUT_COMPLETE:String = "sparkOutComplete";
		/**
		 * ${events_SparkClusterEvent_field_SPARK_OUT_START_D} 
		 */		
		public static const SPARK_IN_START:String = "sparkInStart";
		/**
		 * ${events_SparkClusterEvent_field_SPARK_IN_COMPLETE_D} 
		 */		
		public static const SPARK_IN_COMPLETE:String = "sparkInComplete";
		
		/**
		 * ${events_SparkClusterEvent_constructor_D} 
		 * @param type ${events_SparkClusterEvent_constructor_param_type}
		 * @param cluster ${events_SparkClusterEvent_constructor_param_cluster}
		 * 
		 */		
		public function SparkClusterEvent(type:String, cluster:Cluster)
		{
			super(type, true, true);
			this._cluster = cluster;
		}
		
		/**
		 * ${events_SparkClusterEvent_attribute_cluster_D} 
		 * @return 
		 * 
		 */		
		public function get cluster():Cluster
		{
			return _cluster;
		}

		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new SparkClusterEvent(type, this.cluster);
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function toString() : String
		{
			return formatToString("SparkClusterEvent", "type", "cluster");
		}
		
	}
}