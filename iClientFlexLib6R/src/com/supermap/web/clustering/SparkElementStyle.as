package com.supermap.web.clustering
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${clustering_SparkElementStyle_Title}.
	 * <p>${clustering_SparkElementStyle_Description}</p> 
	 * 
	 */	
	public class SparkElementStyle
	{
		private var _borderColor:uint;
		private var _borderThickness:Number;
		private var _borderAlpha:Number;
		private var _backgroundColor:uint;
		private var _backgroundAlpha:Number;
		private var _radius:Number;
		
		sm_internal var isSetBorderColor:Boolean;
		sm_internal var isSetBackgroundColor:Boolean;
		
		/**
		 * ${clustering_SparkElementStyle_constructor_D} 
		 * 
		 */		
		public function SparkElementStyle()
		{
		}

		/**
		 * ${clustering_SparkElementStyle_attribute_radius_D}
		 * @return 
		 * 
		 */		
		public function get radius():Number
		{
			return _radius;
		}

		public function set radius(value:Number):void
		{
			_radius = value;
		}

		/**
		 * ${clustering_SparkElementStyle_attribute_backgroundAlpha_D} 
		 * @return 
		 * 
		 */		
		public function get backgroundAlpha():Number
		{
			return _backgroundAlpha;
		}

		public function set backgroundAlpha(value:Number):void
		{
			_backgroundAlpha = value;
		}

		/**
		 * ${clustering_SparkElementStyle_attribute_backgroundColor_D} 
		 * @return 
		 * 
		 */		
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}

		public function set backgroundColor(value:uint):void
		{
			isSetBackgroundColor = true;
			_backgroundColor = value;
		}

		/**
		 * ${clustering_SparkElementStyle_attribute_borderAlpha_D} 
		 * @return 
		 * 
		 */		
		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}

		public function set borderAlpha(value:Number):void
		{
			_borderAlpha = value;
		}

		/**
		 * ${clustering_SparkElementStyle_attribute_borderThickness_D} 
		 * @return 
		 * 
		 */		
		public function get borderThickness():Number
		{
			return _borderThickness;
		}

		public function set borderThickness(value:Number):void
		{
			_borderThickness = value;
		}

		/**
		 * ${clustering_SparkElementStyle_attribute_borderColor_D} 
		 * @return 
		 * 
		 */		
		public function get borderColor():uint
		{
			return _borderColor;
		}

		public function set borderColor(value:uint):void
		{
			isSetBorderColor = true;
			_borderColor = value;
		}

	}
}