package com.supermap.web.mapping.supportClasses
{
	import com.supermap.web.core.Rectangle2D;
	/**
	 * @private 
	 * 
	 */	
	public class CandidateTileInfo
	{
		private var _tile:Tile;
		private var _level:int;
		private var _resolution:Number;
		private var _bounds:Rectangle2D;
		
		public function CandidateTileInfo(tile:Tile, resolution:Number, bounds:Rectangle2D, level:int = -1)
		{
			this._tile = tile;
			this._resolution = resolution;
			this._bounds = bounds;
			this._level = level;
		}

		public function get tile():Tile
		{
			return _tile;
		}

		public function set tile(value:Tile):void
		{
			_tile = value;
		}

		public function get resolution():Number
		{
			return _resolution;
		}
		

		public function set resolution(value:Number):void
		{
			_resolution = value;
		}
		
		public function get level():int
		{
			return _level;
		}
		
		
		public function set level(value:int):void
		{
			_level = value;
		}

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