package com.supermap.web.ogc.wmts
{
	import com.supermap.web.core.Point2D;

	/**
	 * ${mapping_OGC_TileMatrix_Title}.
	 * <p>${mapping_OGC_TileMatrix_Description}</p> 
	 * 
	 */	
	public class TileMatrix
	{
		private var _name:String;
		private var _scaleDenominator:Number;
		private var _topLeftCorner:Point2D;
		private var _tileWidth:int;
		private var _tileHeight:int;
		private var _matrixWidth:int;
		private var _matrixHeight:int;
		
		/**
		 * ${mapping_OGC_TileMatrix_constructor_string_D} 
		 * 
		 */		
		public function TileMatrix()
		{
		}

		/**
		 * ${mapping_OGC_TileMatrix_attribute_matrixHeight_D} 
		 * @return 
		 * 
		 */		
		public function get matrixHeight():int
		{
			return _matrixHeight;
		}

		public function set matrixHeight(value:int):void
		{
			_matrixHeight = value;
		}

		/**
		 * ${mapping_OGC_TileMatrix_attribute_matrixWidth_D} 
		 * @return 
		 * 
		 */		
		public function get matrixWidth():int
		{
			return _matrixWidth;
		}

		public function set matrixWidth(value:int):void
		{
			_matrixWidth = value;
		}

		/**
		 * ${mapping_OGC_TileMatrix_attribute_tileHeight_D} 
		 * @return 
		 * 
		 */		
		public function get tileHeight():int
		{
			return _tileHeight;
		}

		public function set tileHeight(value:int):void
		{
			_tileHeight = value;
		}

		/**
		 * ${mapping_OGC_TileMatrix_attribute_tileWidth_D} 
		 * @return 
		 * 
		 */		
		public function get tileWidth():int
		{
			return _tileWidth;
		}

		public function set tileWidth(value:int):void
		{
			_tileWidth = value;
		}

		/**
		 * ${mapping_OGC_TileMatrix_attribute_topLeftCorner_D} 
		 * @return 
		 * 
		 */		
		public function get topLeftCorner():Point2D
		{
			return _topLeftCorner;
		}

		public function set topLeftCorner(value:Point2D):void
		{
			_topLeftCorner = value;
		}

		/**
		 * ${mapping_OGC_TileMatrix_attribute_scaleDenominator_D} 
		 * @return 
		 * 
		 */		
		public function get scaleDenominator():Number
		{
			return _scaleDenominator;
		}

		public function set scaleDenominator(value:Number):void
		{
			_scaleDenominator = value;
		}

		/**
		 * ${mapping_OGC_TileMatrix_attribute_name_D} 
		 * @return 
		 * 
		 */		
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

	}
}