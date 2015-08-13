package com.supermap.web.rendering
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.styles.Style;	

	/**
	 * ${rendering_UniqueRenderer_Title}.
	 * <p>${rendering_UniqueRenderer_Description}</p> 
	 * 
	 */	
	public class UniqueRenderer extends Renderer
	{
		
		private var _attribute:String;
		private var _defaultStyle:Style;
		private  var _items:Array;
		
		/**
		 * ${rendering_UniqueRenderer_constructor_D} 
		 * @param attribute ${rendering_UniqueRenderer_constructor_param_attribute}
		 * @param defaultStyle ${rendering_UniqueRenderer_constructor_param_defaultStyle}
		 * @param items ${rendering_UniqueRenderer_constructor_param_items}
		 * 
		 */		
		public function UniqueRenderer(attribute:String = null, defaultStyle:Style = null, items:Array = null)
		{
			this.attribute = attribute;
			this.defaultStyle = defaultStyle;
			this._items = items;
			
		}
		
		/**
		 * ${rendering_UniqueRenderer_attribute_defaultStyle_D} 
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
		 * ${rendering_UniqueRenderer_attribute_attribute_D} 
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
		 * ${rendering_UniqueRenderer_attribute_items_D} 
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
		 * @inheritDoc 
		 * @param feature
		 * @return 
		 * 
		 */		
		override public function getStyle(feature:Feature):Style
		{
			var dStyle:Style = this.defaultStyle;
			var attributes:Object;
			var newAttri:Object;
			var key:String;
			var newKey:String;
			
			if (feature.attributes && this.attribute)
			{
				attributes = feature.attributes;
				newAttri = new Object();
				for (key in attributes)
				{
					newKey = key.toUpperCase();
					newAttri[newKey] = attributes[key];				
				}			
				feature.attributes = newAttri;
				var str:String = (feature.attributes[this.attribute.toUpperCase()]).toString();
				var item:UniqueItem;
				for each (item in this.items)
				{
					if (str == item.value)
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
			var renderer:UniqueRenderer = null;
			if (this)
			{
				renderer = new UniqueRenderer();
				if(this.attribute)
				renderer.attribute = this.attribute.toString();
				if(this.defaultStyle)
				renderer.defaultStyle = this.defaultStyle.clone();
				var item:UniqueItem=new UniqueItem();
				if (this._items)
				{
					renderer._items = [];
					for each (item in this.items)
					{						
						renderer.items.push(item.clone());
					}
				}
			}
			return renderer;
		}

	}
}