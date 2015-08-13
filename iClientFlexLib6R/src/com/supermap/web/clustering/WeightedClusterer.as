package com.supermap.web.clustering
{	
	import com.supermap.web.core.*;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.mapping.*;
	import com.supermap.web.sm_internal;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.events.PropertyChangeEvent;
	
	use namespace sm_internal;
	
	/**
	 * ${clustering_WeightedClusterer_Title}.
	 * <p>${clustering_WeightedClusterer_Description}</p> 
	 * 
	 */	
	public class WeightedClusterer extends Clusterer
	{
		private var _center:Point2D;
		private var _clusterDistance2:Number;
		private var _clusterHeight:Number;
		private var _clusterWidth:Number;
		private var _clusterDic:Dictionary;
		private var _overlapExists:Boolean;
		private var _aryClusterDictionary:Array;
		private var _aryClusterDictionaryMerge:Array;

		public function get aryClusterDictionaryMerge():Array
		{
			return _aryClusterDictionaryMerge;
		}

		public function set aryClusterDictionaryMerge(value:Array):void
		{
			_aryClusterDictionaryMerge = value;
		}

		public function get aryClusterDictionary():Array
		{
			return _aryClusterDictionary;
		}

		public function set aryClusterDictionary(value:Array):void
		{
			_aryClusterDictionary = value;
		}

		private var _featureWeightFunction:Function;
		
		/**
		 * ${clustering_WeightedClusterer_constructor_D} 
		 * 
		 */		
		public function WeightedClusterer()
		{
			this._featureWeightFunction = this.featureWeightPrivate;
		}
	
/////////////////////////////////属性///////////////////////////////////
		/**
		 * ${clustering_WeightedClusterer_attribute_featureWeightFunction_D} 
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

/////////////////////////////////end属性///////////////////////////////////		
		
/////////////////////////////////方法///////////////////////////////////		
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
			//initializeOverallValues();
			var map:Map = featuresLayer.map;
			var viewBounds:Rectangle2D = map.viewBounds;
			if(!viewBounds)
			{
				return features;
			}
			if(!this._center)
			{
				this._center = viewBounds.center;
//				trace(this._center.x,this._center.y);
			}
			var clusterBounds:Rectangle2D = viewBounds.expand(this._viewBoundsExpandFactor);
			var geoWidth:Number = viewBounds.width;
			var geoHeight:Number = viewBounds.height;
			var widthRatio:Number = viewBounds.width / map.width;
			var heightRatio:Number = viewBounds.height / map.height;
			this._clusterWidth = this.size * widthRatio;
			this._clusterHeight = this.size * heightRatio;
			this._clusterDistance2 = this._clusterWidth * this._clusterWidth + this._clusterHeight * this._clusterHeight;
			this._clusterDic = new Dictionary();
			this._aryClusterDictionary = [];
			var featureItem:Feature;
			for each (featureItem in featureCollection)
			{
				
				if (!featureItem || !featureItem.visible)
				{
					continue;
				}
				var geoPoint:GeoPoint = this._featureToGeoPointFunction(featureItem);
				if (geoPoint)
				{
					if (clusterBounds.contains(geoPoint.x, geoPoint.y))
					{
						var col:int = toClusterX(geoPoint.x);
						var row:int = toClusterY(geoPoint.y);
						var index:int = col << 16 | row & 65535;	
						//trace("col",col,"row",row,"index",index);
						var weight:Number = this._featureWeightFunction(featureItem);
						var clusterItem:Cluster = this._clusterDic[index];
						if (clusterItem)
						{					
							var totalWeight:Number = clusterItem.weight + weight;
							clusterItem.center.x = (clusterItem.center.x * clusterItem.weight + geoPoint.x * weight) / totalWeight;
							clusterItem.center.y = (clusterItem.center.y * clusterItem.weight + geoPoint.y * weight) / totalWeight;
							clusterItem.weight = totalWeight;
							clusterItem.features.push(featureItem);
						}
						else
						{
							var clusterDic:Cluster = new Cluster(new Point2D(geoPoint.x, geoPoint.y), weight, 1, [featureItem]);
							//this._clusterDic[index] = new Cluster(new Point2D(geoPoint.x, geoPoint.y), weight, 1, [featureItem]);
							this._aryClusterDictionary.push(this._clusterDic[index] = clusterDic);
						}
					}
					continue;
				}
				features.push(featureItem);
			}
			do
			{	
				this.mergeOverlappingClusters();
			}while (this._overlapExists)
			//this._aryClusterDictionaryMerge;
			var cluster:Cluster = null;
			for each (cluster in this._aryClusterDictionaryMerge)
			{	
				//trace("cluster.features.length",cluster.features.length);
				createClusterFeature(cluster, features);
				this.minCount = this.minCount <= cluster.features.length ? this.minCount : cluster.features.length;
				this.maxCount = this.maxCount >= cluster.features.length ? this.maxCount : cluster.features.length;
				this.minWeight = this.minWeight <= cluster.weight ? this.minWeight : cluster.weight;
				this.maxWeight = this.maxWeight >= cluster.weight ? this.maxWeight : cluster.weight;
			}
			for each(cluster in this._aryClusterDictionaryMerge)
			{
				cluster.weightFactor = calculateClusterWeightsFactor(cluster.weight, this.maxWeight, this.levels);
			}
			return features;
		}
		
		/**
		 * @inheritDoc 
		 * @param featuresLayer
		 * 
		 */		
		override public function destroy(featuresLayer:FeaturesLayer) : void
		{
			this._center = null;	
			this._clusterDic = null;
		}
		
		private function featureWeightPrivate(feature:Feature) : Number
		{
			return 1;
		}		
		
		private function mergeOverlappingClusters() : void
		{
			this._aryClusterDictionaryMerge = [];
			var cluster:Cluster = null;
			this._overlapExists = false;
			var clusterDic:Dictionary = new Dictionary();
//			for each (cluster in this._clusterDic)//这里遍历的随机性 导致了下面的聚合点位置也是随机的 当点很多的情况下 就使得聚合点不确定了	
			for(var i:int = 0; i < this._aryClusterDictionary.length; i++)
			{
//				trace((this._aryClusterDictionary[i] as Cluster).features.length);
				cluster = (this._aryClusterDictionary[i] as Cluster);
				if (cluster.features)
				{
					var col:int = this.toClusterX(cluster.center.x);
					var row:int = this.toClusterY(cluster.center.y);
					this.searchAndMerge(cluster, (col + 1), row + 0);
					this.searchAndMerge(cluster, (col - 1), row + 0);
					this.searchAndMerge(cluster, col + 0, (row + 1));
					this.searchAndMerge(cluster, col + 0, (row - 1));
					this.searchAndMerge(cluster, (col + 1), (row + 1));
					this.searchAndMerge(cluster, (col + 1), (row - 1));
					this.searchAndMerge(cluster, (col - 1), (row + 1));
					this.searchAndMerge(cluster, (col - 1), (row - 1));
					var mergeCol:int = this.toClusterX(cluster.center.x);
					var mergeRow:int = this.toClusterY(cluster.center.y);
					var index:int = mergeCol << 16 | mergeRow & 65535;
					//trace("合并后的index",index);
					clusterDic[index] = cluster;
					this._aryClusterDictionaryMerge.push(clusterDic[index] = cluster);
					
				}
			}
			this._clusterDic = clusterDic;
		}
		
		private function searchAndMerge(cluster:Cluster, cx:int, cy:int) : void
		{
			var index:int = cx << 16 | cy & 65535;
			var clusterItem:Cluster = this._clusterDic[index];
			if (clusterItem && clusterItem.features)
			{
				var offsetX:Number = cluster.center.x - clusterItem.center.x;
				var offsetY:Number = cluster.center.y - clusterItem.center.y;
				var distance:Number = offsetX * offsetX + offsetY * offsetY;
				if (distance < this._clusterDistance2)
				{
					this._overlapExists = true;
					this.merge(cluster, clusterItem);
				}
			}
		}
		
		private function merge(lhs:Cluster, rhs:Cluster) : void
		{
			var totalWeight:Number = lhs.weight + rhs.weight;
			lhs.center.x = (lhs.weight * lhs.center.x + rhs.weight * rhs.center.x) / totalWeight;
			lhs.center.y = (lhs.weight * lhs.center.y + rhs.weight * rhs.center.y) / totalWeight;
			lhs.weight = lhs.weight + rhs.weight;
			while (rhs.features.length)
			{			
				lhs.features.push(rhs.features.pop());
			}
			rhs.features = null;
		}
		
		private function toClusterX(x:Number) : int
		{
			return (x - this._center.x) / this._clusterWidth;
		}
		
		private function toClusterY(y:Number) : int
		{
			return (y - this._center.y) / this._clusterHeight;
		}
		
		/////////////////////////////////end方法///////////////////////////////////	
	}
}