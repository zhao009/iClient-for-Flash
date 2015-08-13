package com.supermap.web.rendering
{
	import com.supermap.web.core.styles.Style;

	/**
	 * ${rendering_RangeItem_Title}.
	 * <p>${rendering_RangeItem_Description}</p>
	 * 
	 */	
	public class RangeItem extends Object
	{
		private var _maxValue:Number = 1;
		private var _minValue:Number = -1;
		private var _style:Style;
		
		/**
		 * ${rendering_RangeItem_constructor_D} 
		 * @param style ${rendering_RangeItem_constructor_param_style}
		 * @param minValue ${rendering_RangeItem_constructor_param_minValue}
		 * @param maxValue ${rendering_RangeItem_constructor_param_maxValue}
		 * 
		 */		
		public function RangeItem(style:Style = null, minValue:Number = -1, maxValue:Number = 1)
		{
			this.style = style;
			this.maxValue = maxValue;
			this.minValue = minValue;
			
		}
		
		/**
		 * ${rendering_RangeItem_attribute_style_D} 
		 * @return 
		 * 
		 */		
		public function get style():Style
		{
			return _style;
		}

		public function set style(value:Style):void
		{
			_style = value;
		}

		/**
		 * ${rendering_RangeItem_attribute_start_D} 
		 * @return 
		 * 
		 */		
		public function get minValue():Number
		{
			return _minValue;
		}
		
		public function set minValue(value:Number):void
		{
			_minValue = value;
		}

		/**
		 * ${rendering_RangeItem_attribute_end_D} 
		 * @return 
		 * 
		 */		
		public function get maxValue():Number
		{
			return _maxValue;
		}

		public function set maxValue(value:Number):void
		{
			_maxValue = value;
		}

		/**
		 * ${clustering_RegionClusterer_method_clone_D} 
		 * @return 
		 * 
		 */		
		public function clone() : RangeItem
		{
			var rangeItem:RangeItem = null;
			if (this)
			{
				rangeItem = new RangeItem();
				rangeItem.minValue = this.minValue;
				rangeItem.maxValue = this.maxValue
				//rangeItem.style = StylelFactory.toSymbol(this.style);
				if(this.style)
					rangeItem.style = this.style.clone();
			}
			return rangeItem;
		}
	}
}