package com.supermap.web.gears.print
{
	import flash.geom.Point;

	internal class TiledInfo
	{
		private var _startCol:Number;
		private var _startRow:Number;
		
		private var _endCol:Number;
		private var _endRow:Number;
		
		private var _offsets:Point;
		
		private var _level:int = -1;
		
		
		public function TiledInfo()
		{
		}

		public function get level():int
		{
			return _level;
		}

		public function set level(value:int):void
		{
			_level = value;
		}

		public function get offsets():Point
		{
			return _offsets;
		}

		public function set offsets(value:Point):void
		{
			_offsets = value;
		}

		public function get startCol():Number
		{
			return _startCol;
		}

		public function set startCol(value:Number):void
		{
			_startCol = value;
		}

		public function get startRow():Number
		{
			return _startRow;
		}

		public function set startRow(value:Number):void
		{
			_startRow = value;
		}

		public function get endCol():Number
		{
			return _endCol;
		}

		public function set endCol(value:Number):void
		{
			_endCol = value;
		}

		public function get endRow():Number
		{
			return _endRow;
		}

		public function set endRow(value:Number):void
		{
			_endRow = value;
		}

	}
}