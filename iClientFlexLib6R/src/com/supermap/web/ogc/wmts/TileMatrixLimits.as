package com.supermap.web.ogc.wmts
{
	/**
	 * ${mapping_OGC_TileMatrixLimits_Title}.
	 * <p>${mapping_OGC_TileMatrixLimits_Description}</p> 
	 * 
	 */	
	public class TileMatrixLimits
	{
		private var _tileMatrix:String;
		private var _minTileRow:int;
		private var _maxTileRow:int;
		private var _minTileCol:int;
		private var _maxTileCol:int;
		
		/**
		 * ${mapping_OGC_TileMatrixLimits_constructor_string_D} 
		 * 
		 */		
		public function TileMatrixLimits()
		{
		}

		/**
		 * ${mapping_OGC_TileMatrixLimits_attribute_maxTileCol_D} 
		 * @return 
		 * 
		 */		
		public function get maxTileCol():int
		{
			return _maxTileCol;
		}

		public function set maxTileCol(value:int):void
		{
			_maxTileCol = value;
		}

		/**
		 * ${mapping_OGC_TileMatrixLimits_attribute_minTileCol_D} 
		 * @return 
		 * 
		 */		
		public function get minTileCol():int
		{
			return _minTileCol;
		}

		public function set minTileCol(value:int):void
		{
			_minTileCol = value;
		}

		/**
		 * ${mapping_OGC_TileMatrixLimits_attribute_maxTileRow_D} 
		 * @return 
		 * 
		 */		
		public function get maxTileRow():int
		{
			return _maxTileRow;
		}

		public function set maxTileRow(value:int):void
		{
			_maxTileRow = value;
		}

		/**
		 * ${mapping_OGC_TileMatrixLimits_attribute_minTileRow_D} 
		 * @return 
		 * 
		 */		
		public function get minTileRow():int
		{
			return _minTileRow;
		}

		public function set minTileRow(value:int):void
		{
			_minTileRow = value;
		}

		/**
		 * ${mapping_OGC_TileMatrixLimits_attribute_tileMatrixName_D} 
		 * @return 
		 * 
		 */		
		public function get tileMatrixName():String
		{
			return _tileMatrix;
		}

		public function set tileMatrixName(value:String):void
		{
			_tileMatrix = value;
		}

	}
}