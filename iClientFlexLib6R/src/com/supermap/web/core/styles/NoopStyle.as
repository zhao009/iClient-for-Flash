package com.supermap.web.core.styles
{
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.mapping.Map;
	
	import flash.display.Sprite;
	/**
	 * @private 
	 * 
	 */	
	public class NoopStyle extends Style
	{
		private static var m_instance:NoopStyle;
		
		public function NoopStyle()
		{
			
		}
		
		override public function draw(sprite:Sprite, geometry:Geometry, attributes:Object, map:Map) : void
		{
			
		}
		
		public static function get instance() : NoopStyle
		{
			if (m_instance == null)
			{
				m_instance = new NoopStyle;
			}
			return m_instance;
		}
	}
}