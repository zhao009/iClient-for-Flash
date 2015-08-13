package com.supermap.web.clustering
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.sm_internal;

	/**
	 * @private 
	 * 
	 */	
	public class Cluster
	{
		private var _center:Point2D;
		private var _weight:Number;
		private var _weightFactor:Number;
		private var _features:Array;
		
		public function Cluster(center:Point2D = null, weight:Number = 0, weightFactor:Number = 0, features:Array = null)
		{
			this._center = center;
			this._weight = weight;
			this._weightFactor = weightFactor;
			this._features = features;
		}

		sm_internal function get center():Point2D
		{
			return _center;
		}
		sm_internal function set center(value:Point2D):void
		{
			_center = value;
		}

		sm_internal function get features():Array
		{
			return _features;
		}
		sm_internal function set features(value:Array):void
		{
			_features = value;
		}

		sm_internal function get weight():Number
		{
			return _weight;
		}
		sm_internal function set weight(value:Number):void
		{
			_weight = value;
		}
		
		sm_internal function get weightFactor():Number
		{
			return _weightFactor;
		}
		sm_internal function set weightFactor(value:Number):void
		{
			_weightFactor = value;
		}


		

	}
}