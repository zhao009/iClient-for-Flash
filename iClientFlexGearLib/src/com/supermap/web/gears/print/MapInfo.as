package com.supermap.web.gears.print
{
	import com.supermap.web.core.Rectangle2D;

	/**
	 * ${gears_print_MapInfo_Title}.
	 * <p>${gears_print_MapInfo_Description}</p> 
	 */	
	public class MapInfo
	{
		private var _viewBounds:Rectangle2D;
		
		private var _width:Number;
		
		private var _height:Number;
		/**
		 * ${gears_print_MapInfo_constructor_D} 
		 * 
		 */		
		public function MapInfo()
		{
		}

		/**
		 * ${gears_print_MapInfo_attribute_height_D} 
		 */	
		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
		}

		/**
		 * ${gears_print_MapInfo_attribute_width_D} 
		 */
		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
		}

		/**
		 * ${gears_print_MapInfo_attribute_viewBounds_D} 
		 */
		public function get viewBounds():Rectangle2D
		{
			return _viewBounds;
		}

		public function set viewBounds(value:Rectangle2D):void
		{
			_viewBounds = value;
		}

	}
}