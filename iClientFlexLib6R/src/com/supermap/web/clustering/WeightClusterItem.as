package com.supermap.web.clustering
{
	import flash.events.EventDispatcher;
	
	import mx.events.PropertyChangeEvent;
	
	/**
	 * ${clustering_WeightClusterItem_Title}.
	 * <p>${clustering_WeightClusterItem_Description}</p> 
	 * @see WeightClusterStyle
	 * 
	 */	
	public class WeightClusterItem extends EventDispatcher
	{
		private var _minWeight:Number = 0;
		private var _maxWeight:Number = 0;
		private var _weightClusterStyle:WeightClusterStyle = null;
		private var _defaultWeightClusterStyle:WeightClusterStyle = null;
		
		/**
		 * ${clustering_WeightClusterItem_constructor_D} 
		 * @param minWeight ${clustering_WeightClusterItem_constructor_param_minWeight}
		 * @param maxWeight ${clustering_WeightClusterItem_constructor_param_maxWeight}
		 * @param weightClusterStyle ${clustering_WeightClusterItem_constructor_param_weightClusterStyle}
		 * 
		 */		
		public function WeightClusterItem(minWeight:Number = 0, maxWeight:Number = 0, weightClusterStyle:WeightClusterStyle = null)
		{
			_minWeight = minWeight;
			_maxWeight = maxWeight;
			_weightClusterStyle = weightClusterStyle;
		}
		

		public function get defaultWeightClusterStyle():WeightClusterStyle
		{
			return _defaultWeightClusterStyle;
		}

		public function set defaultWeightClusterStyle(value:WeightClusterStyle):void
		{
			var oldValue:WeightClusterStyle = this.defaultWeightClusterStyle;
			if(this._defaultWeightClusterStyle !== value)
			{
				this._defaultWeightClusterStyle = value;				
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"defaultWeightClusterStyle",oldValue, value));
				}
			}
		}

		public function get weightClusterStyle():WeightClusterStyle
		{
			return _weightClusterStyle;
		}

		public function set weightClusterStyle(value:WeightClusterStyle):void
		{
			var oldValue:WeightClusterStyle = this.weightClusterStyle;
			if(this._weightClusterStyle !== value)
			{
				this._weightClusterStyle = value;				
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightClusterStyle",oldValue, value));
				}
			}
		}

		/**
		 * ${clustering_WeightClusterItem_attribute_maxWeight_D} 
		 * @return 
		 * 
		 */		
		public function get maxWeight():Number
		{
			return _maxWeight;
		}
		
		public function set maxWeight(value:Number):void
		{
			var oldValue:Number = this.maxWeight;
			if(this._maxWeight !== value)
			{
				this._maxWeight = value;				
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"maxWeight",oldValue, value));
				}
			}
		}
		
		/**
		 * ${clustering_WeightClusterItem_attribute_minWeight_D} 
		 * @return 
		 * 
		 */		
		public function get minWeight():Number
		{
			return _minWeight;
		}
		
		public function set minWeight(value:Number):void
		{
			var oldValue:Number = this.minWeight;
			if(this._minWeight !== value)
			{
				this._minWeight = value;				
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"minWeight",oldValue, value));
				}
			}
		}
		
		/**
		 * ${clustering_WeightClusterItem_method_clone_D} 
		 * @return 
		 * 
		 */		
		public function clone():WeightClusterItem
		{
			var weightClusterItem:WeightClusterItem = new WeightClusterItem(this.minWeight, this.maxWeight, this.weightClusterStyle);
			return weightClusterItem;
		}
	}
}