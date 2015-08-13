package com.supermap.web.clustering
{
	import com.supermap.web.core.*;
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.core.styles.*;
	
	/**
	 * @private
	 * ${clustering_ClusterFeature_Title}.
	 * <p>${clustering_ClusterFeature_Description}</p> 
	 * 
	 */	
	internal class ClusterFeature extends Feature
	{
		public function ClusterFeature(geoPoint:GeoPoint=null, style:Style=null, cluster:Cluster=null)
		{
			super(geoPoint, style, cluster);
		}
		
		public function get geoPoint() : GeoPoint
		{
			return geometry as GeoPoint;
		}
		
		public function get cluster() : Cluster
		{
			return attributes as Cluster;
		}
	}
}