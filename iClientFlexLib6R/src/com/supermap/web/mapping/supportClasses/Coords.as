package com.supermap.web.mapping.supportClasses
{
	/**
	 * @private 
	 * 
	 */	
	public class Coords
	{
		private var _row:int;
		private var _col:int;
		
		public function Coords(row:int, col:int)
		{
			this._row = row;
			this._col = col;
		}

		public function get row():int
		{
			return _row;
		}

		public function set row(value:int):void
		{
			_row = value;
		}

		public function get col():int
		{
			return _col;
		}

		public function set col(value:int):void
		{
			_col = value;
		}


	}
}