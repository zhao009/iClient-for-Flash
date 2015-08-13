package com.supermap.web.rendering
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.styles.Style;

	/**
	 * ${rendering_UniformRenderer_Title}.
	 * <p>${rendering_UniformRenderer_Description}</p> 
	 * 
	 */	
	public class UniformRenderer extends Renderer
	{
		
		private var _style:Style;
		
		/**
		 * ${rendering_UniformRenderer_constructor_D} 
		 * @param style ${rendering_UniformRenderer_constructor_param}
		 * 
		 */		
		public function UniformRenderer(style:Style = null)
		{
			this.style=style;
		}
		
		/**
		 * ${rendering_UniformRenderer_attribute_Style_D} 
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
		 * @inheritDoc 
		 * @param feature
		 * @return 
		 * 
		 */		
		override public function getStyle(feature:Feature):Style
		{	
			return this.style;
		}
		/**
		 * @inheritDoc  
		 * @return 
		 * 
		 */		
		public override function clone() : Renderer
		{
			var renderer:UniformRenderer = null;
			if (this)
			{
				renderer = new UniformRenderer();
				renderer.style=this.style.clone();
			}
			return renderer;
		}
	}
}