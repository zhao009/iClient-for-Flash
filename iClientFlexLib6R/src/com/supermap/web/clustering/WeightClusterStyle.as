package com.supermap.web.clustering
{
	import flash.events.EventDispatcher;
	
	import mx.events.PropertyChangeEvent;

	/**
	 * ${clustering_WeightClusterStyle_Title}.
	 * <p>${clustering_WeightClusterStyle_Description}</p> 
	 * 
	 */	
	public class WeightClusterStyle extends EventDispatcher
	{		
		private var _weightBackgroundColor:uint = 0x0000ff;
		private var _weightBackgroundAlpha:Number = 1;
		
		private var _weightBorderColor:uint = 0xffffff;
		private var _weightBorderAlpha:Number = 0.8;
		private var _weightBorderThickness:Number = 2;
	
		/**
		 * ${clustering_WeightClusterStyle_constructor_D} 
		 * @param weightBackgroundColor ${clustering_WeightClusterStyle_constructor_param_weightBackgroundColor}
		 * @param weightBackgroundAlpha ${clustering_WeightClusterStyle_constructor_param_weightBackgroundAlpha}
		 * @param weightBorderColor ${clustering_WeightClusterStyle_constructor_param_weightBorderColor}
		 * @param weightBorderAlpha ${clustering_WeightClusterStyle_constructor_param_weightBorderAlpha}
		 * @param weightBorderThickness ${clustering_WeightClusterStyle_constructor_param_weightBorderThickness}
		 * 
		 */		
		public function WeightClusterStyle(weightBackgroundColor:uint = 0x0000ff, weightBackgroundAlpha:Number = 0.8, weightBorderColor:uint = 0xffffff, weightBorderAlpha:Number = 0.8, weightBorderThickness:Number = 2)
		{
			_weightBackgroundColor = weightBackgroundColor;
			_weightBackgroundAlpha = weightBackgroundAlpha;
			_weightBorderColor = weightBorderColor;
			_weightBorderAlpha = weightBorderAlpha;
			_weightBorderThickness = weightBorderThickness;
		}

		/**
		 * ${clustering_WeightClusterStyle_attribute_weightBorderThickness_D} 
		 * @return 
		 * 
		 */		
		public function get weightBorderThickness():Number
		{
			return _weightBorderThickness;
		}

		public function set weightBorderThickness(value:Number):void
		{
			var oldValue:Number = this.weightBorderAlpha;
			if(this._weightBorderThickness !== value)
			{
				this._weightBorderThickness = value;				
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightBorderThickness",oldValue, value));
				}
			}
		}

		/**
		 * ${clustering_WeightClusterStyle_attribute_weightBorderAlpha_D} 
		 * @return 
		 * 
		 */		
		public function get weightBorderAlpha():Number
		{
			return _weightBorderAlpha;
		}

		public function set weightBorderAlpha(value:Number):void
		{
			var oldValue:Number = this.weightBorderAlpha;
			if(this._weightBorderAlpha !== value)
			{
				this._weightBorderAlpha = value;				
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightBorderAlpha",oldValue, value));
				}
			}
		}

		/**
		 * ${clustering_WeightClusterStyle_attribute_weightBorderColor_D} 
		 * @return 
		 * 
		 */		
		public function get weightBorderColor():uint
		{
			return _weightBorderColor;
		}

		public function set weightBorderColor(value:uint):void
		{
			var oldValue:uint = this.weightBorderColor;
			if(this._weightBorderColor !== value)
			{
				this._weightBorderColor = value;				
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightBorderColor",oldValue, value));
				}
			}
		}

		/**
		 * ${clustering_WeightClusterStyle_attribute_weightBackgroundAlpha_D} 
		 * @return 
		 * 
		 */		
		public function get weightBackgroundAlpha():Number
		{
			return _weightBackgroundAlpha;
		}

		public function set weightBackgroundAlpha(value:Number):void
		{
			var oldValue:Number = this.weightBackgroundAlpha;
			if(this._weightBackgroundAlpha !== value)
			{
				this._weightBackgroundAlpha = value;				
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightBackgroundAlpha",oldValue, value));
				}
			}
		}

		/**
		 * ${clustering_WeightClusterStyle_attribute_weightBackgroundColor_D} 
		 * @return 
		 * 
		 */		
		public function get weightBackgroundColor():uint
		{
			return _weightBackgroundColor;
		}

		public function set weightBackgroundColor(value:uint):void
		{
			var oldValue:uint = this.weightBackgroundColor;
			if(this._weightBackgroundColor !== value)
			{
				this._weightBackgroundColor = value;				
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"weightBackgroundColor",oldValue, value));
				}
			}
		}
		
		/**
		 * ${clustering_WeightClusterStyle_method_clone_D} 
		 * @return 
		 * 
		 */		
		public function clone():WeightClusterStyle
		{
			var weightClusterStyle:WeightClusterStyle = new WeightClusterStyle(this.weightBackgroundColor, this.weightBorderColor, this.weightBorderAlpha, this.weightBorderThickness);
			return weightClusterStyle;
		}

	}
}