package com.supermap.web.mapping.supportClasses
{
	import com.supermap.web.core.Point2D;
	/**
	 * @private 
	 * 
	 */	
	public class Tile
	{
		private var _coords:Coords;
		private var _point:Point2D;
		private var _offset:Point2D;
		
		public function Tile(coords:Coords, point:Point2D, offset:Point2D)
		{
			this._coords = coords;
			this._point = point;
			this._offset = offset;
		}

		public function get coords():Coords
		{
			return _coords;
		}

		public function set coords(value:Coords):void
		{
			_coords = value;
		}

		public function get point():Point2D
		{
			return _point;
		}

		public function set point(value:Point2D):void
		{
			_point = value;
		}

		public function get offset():Point2D
		{
			return _offset;
		}

		public function set offset(value:Point2D):void
		{
			_offset = value;
		}


	}
}