package com.supermap.web.clustering
{
	import com.supermap.web.core.*;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.mapping.*;
	import com.supermap.web.sm_internal;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.PropertyChangeEvent;
	import mx.utils.NameUtil;
	
	use namespace sm_internal;

	/**
	 * ${clustering_RegionClusterer_Title}.
	 * <p>${clustering_RegionClusterer_Description}</p> 
	 * 
	 */	
	public class RegionClusterer extends Clusterer
	{
		private var _regionFeatures:ArrayCollection;
		private var _center:Point2D;
		private var _featureWeightFunction:Function;
		
		/**
		 * ${clustering_RegionClusterer_constructor_D} 
		 * @param regionFeatures ${clustering_RegionClusterer_constructor_param_regionFeatures}
		 * 
		 */		
		public function RegionClusterer(regionFeatures:Object)
		{
			this.regionFeatures = regionFeatures;
			this._featureWeightFunction = this.featureWeightPrivate;
		}
		
		/////////////////////////////////属性///////////////////////////////////
		/**
		 * ${clustering_RegionClusterer_attribute_featureWeightFunction_D} 
		 * @return 
		 * 
		 */		
		public function get featureWeightFunction():Function
		{
			return _featureWeightFunction;
		}	
		public function set featureWeightFunction(value:Function):void
		{
			_featureWeightFunction = value;
			var old_value:Function = this.featureWeightFunction;
			if(old_value !== value)
			{
				this._featureWeightFunction = value;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "featureWeightFunction", old_value, value));
				}
			}
		}
		
		/**
		 * ${clustering_RegionClusterer_attribute_regionFeatures_D} 
		 * @return 
		 * 
		 */		
		public function get regionFeatures():Object
		{
			return this._regionFeatures;
		}	
		public function set regionFeatures(value:Object):void
		{
			var regionFeatures:Array;
			if (this._regionFeatures)
			{
				this._regionFeatures.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			}
			if (value is Array)
			{
				this._regionFeatures = new ArrayCollection(value as Array);
			}
			else if (value is ArrayCollection)
			{
				this._regionFeatures = value as ArrayCollection;
			}
			else
			{
				regionFeatures = [];
				if (value != null)
				{
					regionFeatures.push(value);
				}
				this._regionFeatures = new ArrayCollection(regionFeatures);
			}
			
			this._regionFeatures.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			var event:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
			event.kind = CollectionEventKind.RESET;
			this.collectionChangeHandler(event);		
		}
		
		/////////////////////////////////end属性///////////////////////////////////	
		
		/**
		 * @inheritDoc 
		 * @param featuresLayer
		 * @param featureCollection
		 * @return 
		 * 
		 */		
		override public function clusterFeatures(featuresLayer:FeaturesLayer, featureCollection:ArrayCollection) : Array
		{
			var features:Array = [];
			var clusterDic:Dictionary = new Dictionary();
			//initializeOverallValues();
			var map:Map = featuresLayer.map;
			var viewBounds:Rectangle2D = map.viewBounds;
			var featureItem:Feature;
			if(!_regionFeatures || _regionFeatures.length == 0)
			{
				return features;
			}
			for each (featureItem in featureCollection)
			{	
				if (!featureItem || !featureItem.visible)
				{
					continue;
				}
				var geoPoint:GeoPoint = this._featureToGeoPointFunction(featureItem);
				if (geoPoint)
				{
					var bNotClustered:Boolean = true;
					var regionFeatureItem:Feature;
					for each (regionFeatureItem in this._regionFeatures)
					{
						if (!regionFeatureItem || regionFeatureItem.isInResolutionRange === false)
						{
							continue;
						}
						var region:GeoRegion;
						if(regionFeatureItem.geometry is GeoRegion)
						{
							region = regionFeatureItem.geometry as GeoRegion;
							if(region.bounds.intersects(viewBounds) && region.contains(geoPoint))
							{
								bNotClustered = false;
								if(!regionFeatureItem.id)
								{
									regionFeatureItem.id = NameUtil.createUniqueName(regionFeatureItem);
								}
								var index:String = regionFeatureItem.id;
								var cluster:Cluster = clusterDic[index];
								var weight:Number = this._featureWeightFunction(featureItem);
								if (cluster === null)
								{
									var x:Number = geoPoint.x;
									var y:Number = geoPoint.y;
									clusterDic[index] = new Cluster(new Point2D(x, y), 1, 1,[featureItem]);
								}
								
								else
								{
									var totalWeight:Number = cluster.weight + weight;
									var wx:Number = (cluster.center.x * cluster.weight + geoPoint.x * weight) / totalWeight;
									var wy:Number = (cluster.center.y * cluster.weight + geoPoint.y * weight) / totalWeight;							
									if(region.contains(new GeoPoint(wx, wy)))
									{
										cluster.center = new Point2D(wx, wy);
									}
									else if(cluster.weight < weight)
									{
										cluster.center = new Point2D(geoPoint.x, geoPoint.y);
									}
									cluster.weight = totalWeight;
									cluster.features.push(featureItem);
								}
								break;					
							}	
							continue;
						}		
					}
					if(bNotClustered && viewBounds.contains(geoPoint.x, geoPoint.y))
					{
						features.push(featureItem);
					}
					continue;
				}
				features.push(featureItem);
			}
			this.createFeaturesFromClusters(clusterDic, features);
			this.calculateClusterWeights(clusterDic);
			return features;
		}
		
		private function createFeaturesFromClusters(dict:Dictionary, arrOfFeatures:Array) : void
		{
			var cluster:Cluster = null;
			for each (cluster in dict)
			{		
				this.minCount = this.minCount <= cluster.features.length ? this.minCount : cluster.features.length;
				this.maxCount = this.maxCount >= cluster.features.length ? this.maxCount : cluster.features.length;
				this.minWeight = this.minWeight <= cluster.weight ? this.minWeight : cluster.weight;
				this.maxWeight = this.maxWeight >= cluster.weight ? this.maxWeight : cluster.weight;
				this.createClusterFeature(cluster, arrOfFeatures);
			}
		}
		
		private function collectionChangeHandler(event:CollectionEvent):void
		{
			dispatchEvent(event);
			switch(event.kind)
			{
				case CollectionEventKind.ADD:
				case CollectionEventKind.MOVE:
				case CollectionEventKind.REFRESH:
				case CollectionEventKind.RESET:
				case CollectionEventKind.REMOVE:
				case CollectionEventKind.REPLACE:
				{
					this.dispatchEvent(new Event(Event.CHANGE));
					break;
				}
				default:
				{
					break;
				}
			}			
		}
		
		/**
		 * @inheritDoc 
		 * @param featuresLayer
		 * 
		 */		
		override public function destroy(featuresLayer:FeaturesLayer) : void
		{
			this._center = null;
		}
		
		private function featureWeightPrivate(feature:Feature) : Number
		{
			return 1;
		}
	}
}