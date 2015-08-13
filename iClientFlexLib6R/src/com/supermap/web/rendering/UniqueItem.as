package com.supermap.web.rendering
{
	import com.supermap.web.core.styles.Style;
	
	/**
	 * ${rendering_UniqueItem_Title}.
	 * <p>${rendering_UniqueItem_Description}</p> 
	 * 
	 */	
	public class UniqueItem extends Object
	{

		private var _style:Style;
		private var _value:String;
		
		/**
		 * ${rendering_UniqueItem_constructor_D} 
		 * @param style ${rendering_UniqueItem_constructor_param_style}
		 * @param value ${rendering_UniqueItem_constructor_param_value}
		 * 
		 */		
		public function UniqueItem(style:Style = null, value:String = null)
		{
			this.style = style;
			this.value = value;
			
		}
		
		/**
		 * ${rendering_UniqueItem_attribute_value_D} 
		 * @return 
		 * 
		 */		
		public function get value():String
		{
			return _value;
		}

		public function set value(value:String):void
		{
			_value = value;
		}

		/**
		 * ${rendering_UniqueItem_attribute_style_D} 
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
		 * ${clustering_UniqueItem_method_clone_D} 
		 * @return 
		 * 
		 */		
		public  function clone() : UniqueItem
		{
			var item:UniqueItem = null;
			if (this)
			{
				item = new UniqueItem;
				item.style = this.style.clone();
				item.value = this.value.toString();
			}
			return item;
		}
	}
}