package com.supermap.web.rendering
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.styles.Style;
	
	import mx.collections.ArrayList;

	/**
	 * ${rendering_RangeRenderer_Title}. 
	 * <p>${rendering_RangeRenderer_Description}</p>
	 * 
	 */	
	public class RangeRenderer extends Renderer
	{
		private var _attribute:String;
		private var _defaultStyle:Style;
		private var _items:Array;
		
		/**
		 * ${rendering_RangeRenderer_constructor_D} 
		 * @param attribute ${rendering_RangeRenderer_constructor_param_attribute}
		 * @param defaultStyle ${rendering_RangeRenderer_constructor_param_defaultStyle}
		 * @param items ${rendering_RangeRenderer_constructor_param_items}
		 * 
		 */		
		public function RangeRenderer(attribute:String = null, defaultStyle:Style = null, items:Array = null)
		{
			this.attribute = attribute;
			this.defaultStyle = defaultStyle;
			this.items = items;
			
		}
		
		/**
		 * ${rendering_RangeRenderer_attribute_items_D}
		 * @see RangeItem 
		 * @return 
		 * 
		 */		
		public function get items():Array
		{
			return _items;
		}

		public function set items(value:Array):void
		{
			_items = value;
		}

		/**
		 * ${rendering_RangeRenderer_attribute_defaultStyle_D} 
		 * @return 
		 * 
		 */		
		public function get defaultStyle():Style
		{
			return _defaultStyle;
		}

		public function set defaultStyle(value:Style):void
		{
			_defaultStyle = value;
		}

		/**
		 * ${rendering_RangeRenderer_attribute_attribute_D} 
		 * @return 
		 * 
		 */		
		public function get attribute():String
		{
			return _attribute;
		}

		public function set attribute(value:String):void
		{
			_attribute = value;
		}

		/**
		 * @inheritDoc 
		 * @param feature
		 * @return 
		 * 
		 */		
		override public function getStyle(feature:Feature) :Style
		{
			var numValue:Number = NaN;
			var item:RangeItem = null;
			var dStyle:Style = this.defaultStyle;	
			var newAttri:Object;
			var key:String;
			var newKey:String;
			var attributes:Object;
			if (this.attribute)						
			{   
				if(feature.attributes)
				
				{
					attributes = feature.attributes;
					newAttri = new Object();
					for (key in attributes)
				      {
					     newKey = key.toUpperCase();
					     newAttri[newKey] = attributes[key];				
				      }
					
					feature.attributes = newAttri;
					
				}
						
				numValue = feature.attributes ? (Number(feature.attributes[this.attribute.toUpperCase()])) : (NaN);
			}
			if (!isNaN(numValue))
			{
				for each (item in this.items)
				{
				    if (item.minValue <= numValue && numValue < item.maxValue)
					{
						dStyle = item.style;
						break;
					}
				}
			}
			return dStyle;
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		public override function clone() : Renderer
		{
			var rangeRenderer:RangeRenderer = null;
			var item:RangeItem = null;
			if (this)
			{
				rangeRenderer = new RangeRenderer();
				if(this.attribute)
					rangeRenderer.attribute = this.attribute.toString();
				if(this.defaultStyle)
		        	rangeRenderer.defaultStyle = this.defaultStyle.clone();
				if (this.items)
				{
					rangeRenderer.items = [];
					for each (item in this.items)
					{
						rangeRenderer.items.push(item.clone());
					}
				}
			}
			return rangeRenderer;
		}
	}
}