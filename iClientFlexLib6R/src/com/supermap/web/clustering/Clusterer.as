package com.supermap.web.clustering
{
	import com.supermap.web.core.*;
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.core.styles.*;
	import com.supermap.web.mapping.FeaturesLayer;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	import flash.utils.Dictionary;
	
	import mx.collections.*;
	import mx.events.*;
	
	use namespace sm_internal;
	
	/**
	 * ${clustering_Clusterer_Title}. 
	 * <p>${clustering_Clusterer_Description}</p>
	 * 
	 */	
	public class Clusterer extends EventDispatcher
	{
		/**
		 * @private 
		 */		
		protected var _viewBoundsExpandFactor:Number;	
		/**
		 * @private 
		 */	
		protected var _clusterWeightFunction:Function;
		/**
		 * @private 
		 */	
		protected var _featureToGeoPointFunction:Function;	
		/**
		 * @private 
		 */	
		protected var _sizeInPixels:Number;
		/**
		 * @private 
		 */	
		protected var _style:Style;
		/**
		 * @private 
		 */	
		protected var _minFeatureCount:int;
		private var _minCount:int = 0;
		private var _maxCount:int = 0;
		private var _minWeight:Number = Number.MAX_VALUE;
		private var _maxWeight:Number = Number.MIN_VALUE;
		/**
		 * @private 
		 */	
		protected var _levels:int;
		
		/**
		 * ${clustering_Clusterer_constructor_D} 
		 * 
		 */		
		public function Clusterer()
		{
			this._clusterWeightFunction = this.clusterWeightPrivate;
			this._featureToGeoPointFunction = this.featureToGeoPointPrivate;
			this._viewBoundsExpandFactor = 3;
			this._minFeatureCount = 1;
			this._sizeInPixels = 70;
			this._levels = 5;
			this._style = SimpleClusterStyle.instance;
		}
	
/////////////////////////////////属性///////////////////////////////////
		
		/**
		 * ${clustering_Clusterer_attribute_clusterWeightFunction_D} 
		 * @return 
		 * 
		 */		
		public function get clusterWeightFunction():Function
		{
			return this._clusterWeightFunction === this.clusterWeightPrivate ? (null) : (this._clusterWeightFunction);
		}	
		public function set clusterWeightFunction(value:Function):void
		{
			var old_value:Function = this.clusterWeightFunction;
			if (old_value !== value)
			{
				this._clusterWeightFunction = value === null ? (this.clusterWeightPrivate) : (value);
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "clusterWeightFunction", old_value, value));
				}
			}
		}

		/**
		 * ${clustering_Clusterer_attribute_featureToGeoPointFunction_D}.
		 * <p>${clustering_Clusterer_attribute_featureToGeoPointFunction_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get featureToGeoPointFunction():Function
		{
			return this._featureToGeoPointFunction === this.featureToGeoPointPrivate ? (null) : (this._featureToGeoPointFunction);
		}
		public function set featureToGeoPointFunction(value:Function):void
		{
			var old_value:Function = this.featureToGeoPointFunction;
			if (old_value !== value)
			{
				this._featureToGeoPointFunction = value === null ? (this.featureToGeoPointPrivate) : (value);
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "featureToGeoPointFunction", old_value, value));
				}
			}
		}
		
		//分多少级别显示，最多不能超过10级
		/**
		 * ${clustering_Clusterer_attribute_levels_D}. 
		 * <p>${clustering_Clusterer_attribute_levels_remarks}</p>
		 * @default 5
		 * @return 
		 * 
		 */		
		public function get levels():int
		{
			return _levels;
		}
		public function set levels(value:int):void
		{
			var old_value:Number = this.levels;
			if (old_value !== value)
			{
				this._levels = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "levels", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_Clusterer_attribute_minFeatureCount_D} 
		 * @default 1
		 * @return 
		 * 
		 */		
		public function get minFeatureCount():int
		{
			return _minFeatureCount;
		}
		public function set minFeatureCount(value:int):void
		{
			var old_value:int = this.minFeatureCount;
			if (old_value !== value)
			{
				this._minFeatureCount = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "minFeatureCount", old_value, value));
				}
			}
		}

		/**
		 * ${clustering_Clusterer_attribute_size_D} 
		 * @return 
		 * 
		 */		
		public function get size():Number
		{
			return _sizeInPixels;
		}
		public function set size(value:Number):void
		{
			var old_value:Number = this.size;
			if (old_value !== value)
			{
				this._sizeInPixels = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "sizeInPixels", old_value, value));
				}
			}
		}

		/**
		 * ${clustering_Clusterer_attribute_style_D} 
		 * @default SimpleClusterStyle
		 * @see SimpleClusterStyle
		 * @return 
		 * 
		 */		
		public function get style():Style
		{
			return _style;
		}

		public function set style(value:Style):void
		{
			if (value !== this._style)
			{
				this._style = value;
				dispatchEventChange();
			}
		}

		/**
		 * ${clustering_Clusterer_attribute_totalMinCount_D} 
		 * @return 
		 * 
		 */		
		public function get minCount():int
		{
			return _minCount;
		}

		public function set minCount(value:int):void
		{
			_minCount = value;
		}

		/**
		 * ${clustering_Clusterer_attribute_totalMaxCount_D} 
		 * @return 
		 * 
		 */		
		public function get maxCount():int
		{
			return _maxCount;
		}

		public function set maxCount(value:int):void
		{
			_maxCount = value;
		}

		/**
		 * ${clustering_Clusterer_attribute_totalMinWeight_D} 
		 * @return 
		 * 
		 */		
		public function get minWeight():Number
		{
			return _minWeight;
		}

		public function set minWeight(value:Number):void
		{
			_minWeight = value;
		}

		/**
		 * ${clustering_Clusterer_attribute_maxWeight_D} 
		 * @return 
		 * 
		 */		
		public function get maxWeight():Number
		{
			return _maxWeight;
		}

		public function set maxWeight(value:Number):void
		{
			_maxWeight = value;
		}
		
//		/**
//		 * ${clustering_Clusterer_attribute_viewBoundsExpandFactor_D} 
//		 * @return 
//		 * 
//		 */		
//		public function get viewBoundsExpandFactor():Number
//		{
//			return _viewBoundsExpandFactor;
//		}
//		
//		public function set viewBoundsExpandFactor(value:Number):void
//		{
//			var old_value:Number = this.viewBoundsExpandFactor;
//			if (old_value !== value)
//			{
//				this._viewBoundsExpandFactor = value;
//				dispatchEventChange();
//				if (this.hasEventListener("propertyChange"))
//				{
//					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "viewBoundsExpandFactor", old_value, value));
//				}
//			}
//		}
/////////////////////////////////end属性///////////////////////////////////		
		
/////////////////////////////////方法///////////////////////////////////	
		/**
		 * ${clustering_Clusterer_method_calculateClusterWeights_D} 
		 * @param clusters ${clustering_Clusterer_method_calculateClusterWeights_param_clusters}
		 * 
		 */		
		protected function calculateClusterWeights(clusters:Dictionary) : void
		{
			var cluster:Cluster = null;
			for each (cluster in clusters)
			{		
				this._clusterWeightFunction(cluster);
				cluster.weightFactor = calculateClusterWeightsFactor(cluster.weight, this._maxWeight, this._levels);
			}
		}
		
		/**
		 * ${clustering_Clusterer_method_clusterFeatures_D}.
		 * <p>${clustering_Clusterer_method_clusterFeatures_remarks}</p> 
		 * @param featuresLayer ${clustering_Clusterer_method_clusterFeatures_param_featuresLayer}
		 * @param featureCollection ${clustering_Clusterer_method_clusterFeatures_param_featureCollection}
		 * @return ${clustering_Clusterer_method_clusterFeatures_return}
		 * 
		 */		
		public function clusterFeatures(featuresLayer:FeaturesLayer, featureCollection:ArrayCollection) : Array
		{
			return null;
		}
		
		private function clusterWeightPrivate(cluster:Cluster) : void
		{
			cluster.weight = cluster.features.length;
		}
		
		/**
		 * ${clustering_Clusterer_method_createClusterFeature_D} 
		 * <p>${clustering_Clusterer_method_createClusterFeature_remarks}</p>
		 * @param cluster ${clustering_Clusterer_method_createClusterFeature_param_cluster}
		 * @param arr ${clustering_Clusterer_method_createClusterFeature_param_arr}
		 * @see #minFeatureCount
		 * @see com.supermap.web.core.Feature
		 * 
		 */		
		protected function createClusterFeature(cluster:Cluster, arr:Array) : void
		{
			var index:int = 0;
			var length:int = cluster.features.length;
			if (length <= this._minFeatureCount)
			{
				index = length;
				while (index)
				{		
					arr.push(cluster.features[--index]);
				}
			}
			else
			{
				arr.push(new ClusterFeature(new GeoPoint(cluster.center.x, cluster.center.y), this.style, cluster));
			}
		}
		
		/**
		 * ${clustering_Clusterer_method_destroy_D} 
		 * @param featuresLayer ${clustering_Clusterer_method_destroy_param}
		 * 
		 */		
		public function destroy(featuresLayer:FeaturesLayer) : void
		{
		}
		
		/**
		 * ${clustering_Clusterer_method_dispatchEventChange_D} 
		 * 
		 */		
		protected function dispatchEventChange() : void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function featureToGeoPointPrivate(feature:Feature) : GeoPoint
		{
			return feature.geometry as GeoPoint;
		}
		
		/**
		 * ${clustering_Clusterer_method_initialize_D} 
		 * @param featuresLayer ${clustering_Clusterer_method_initialize_param}
		 * 
		 */		
		public function initialize(featuresLayer:FeaturesLayer) : void
		{
		}
		
//		/**
//		 * ${clustering_Clusterer_method_initializeOverallValues_D} 
//		 * 
//		 */		
//		protected function initializeOverallValues() : void
//		{
//			this._minCount = 0;
//			this._maxCount = 0;
//			this._minWeight = 0;
//			this._maxWeight = 0;
//		}
		
	
/////////////////////////////////end方法///////////////////////////////////	
		
		sm_internal static function calculateClusterWeightsFactor(weight:Number, maxWeight:Number, totalLevels:int) : Number
		{
			var weightFactor:Number = (weight / maxWeight);
			var step:Number = 1 / totalLevels;
			weightFactor = Math.floor(weightFactor / step) * 0.1 + (1 - 0.1 * totalLevels + 0.1);
			return weightFactor < 0.1 ? 0.1 : weightFactor;
		}
	}
}