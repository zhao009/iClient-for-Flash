package com.supermap.web.clustering
{
	import com.supermap.web.core.*;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.mapping.*;
	import com.supermap.web.sm_internal;
	
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	use namespace sm_internal;


	/**
	 * ${clustering_CenterClusterer_Title}.
	 * <p>${clustering_CenterClusterer_Description}</p>
	 * 
	 */	
	public class CenterClusterer extends Clusterer
	{
		private var _center:Point2D;
		/**
		 * ${clustering_CenterClusterer_constructor_D} 
		 * 
		 */		
		public function CenterClusterer()
		{
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override public function clusterFeatures(featuresLayer:FeaturesLayer, featureCollection:ArrayCollection) : Array
		{
			var features:Array = [];
			//initializeOverallValues();
			var map:Map = featuresLayer.map;
			var viewBounds:Rectangle2D = map.viewBounds;
			if(viewBounds === null)
			{
				return features;
			}
			if(this._center === null)
			{
				this._center = viewBounds.center;
			}
			var mapCenter:Point2D = viewBounds.center;
			var geoWidth:Number = viewBounds.width;
			var geoHeight:Number = viewBounds.height;
			var widthRatio:Number = geoWidth / map.width;
			var heightRatio:Number = geoHeight / map.height;
			var geoSizeWidth:Number = this.size * widthRatio;
			var geoSizeHeight:Number = this.size * heightRatio;
			var adjustedGeoSizeWidth:Number = Math.ceil(geoWidth * 0.5 / geoSizeWidth) * geoSizeWidth;
			var adjustedGeoSizeHeight:Number = Math.ceil(geoHeight * 0.5 / geoSizeHeight) * geoSizeHeight;
			var clusterBounds:Rectangle2D = new Rectangle2D(mapCenter.x - adjustedGeoSizeWidth, mapCenter.y - adjustedGeoSizeHeight, 
															 mapCenter.x + adjustedGeoSizeWidth, mapCenter.y + adjustedGeoSizeHeight).expand(this._viewBoundsExpandFactor);
			var clusterDic:Dictionary = new Dictionary();
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
						var col:int = (geoPoint.x - this._center.x) / geoSizeWidth;
						var row:int = (geoPoint.y - this._center.y) / geoSizeHeight;
						var index:int = col << 16 | row & 65535;
						var cluster:Cluster = clusterDic[index];
						if (!cluster)
						{
							var x:Number = col * geoSizeWidth + this._center.x + geoSizeWidth * 0.5;
							var y:Number = row * geoSizeHeight + this._center.y + geoSizeHeight * 0.5;
							clusterDic[index] = new Cluster(new Point2D(x, y), 1, 1,[featureItem]);
						}
						else
						{
							cluster.features.push(featureItem);
						}
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
				this.minCount = Math.min(this.minCount, cluster.features.length);
				this.maxCount = Math.max(this.maxCount, cluster.features.length);
				this.createClusterFeature(cluster, arrOfFeatures);
			}
			this.minWeight = this.minCount;
			this.maxWeight = this.maxCount;	
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override public function destroy(featuresLayer:FeaturesLayer) : void
		{
			this._center = null;
		}
	}
}