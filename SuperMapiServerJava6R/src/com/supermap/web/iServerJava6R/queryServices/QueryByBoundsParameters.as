package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.core.Rectangle2D;

	/**
	 * ${iServerJava6R_QueryByBoundsParameters_Tile}.
	 * <p>${iServerJava6R_QueryByBoundsParameters_Description}</p> 
	 * 
	 */	
	public class QueryByBoundsParameters extends QueryParameters
	{
		private var _bounds:Rectangle2D;
		/**
		 * ${iServerJava6R_QueryByBoundsParameters_constructor_None_D} 
		 * 
		 */		
		public function QueryByBoundsParameters()
		{
			super();
		}

		/**
		 * ${iServerJava6R_QueryByBoundsParameters_attribute_bounds_D}
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}

		public function set bounds(value:Rectangle2D):void
		{
			_bounds = value;
		}

	}
}