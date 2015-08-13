package com.supermap.web.ogc.wmts
{
	/**
	 * ${mapping_OGC_TileMatrixSetLink_Title} 
	 * <p>${mapping_OGC_TileMatrixSetLink_Description}</p>
	 * 
	 */	
	public class TileMatrixSetLink
	{
		private var _tileMatrixSet:String;
		private var _tileMatrixSetLimits:Array;
		
		/**
		 * ${mapping_OGC_TileMatrixSetLink_constructor_string_D} 
		 * 
		 */		
		public function TileMatrixSetLink()
		{
		}

		/**
		 * ${mapping_OGC_TileMatrixSetLink_attribute_tileMatrixSetLimits_D} 
		 * @see com.supermap.web.ogc.wmts.TileMatrixLimits
		 * @return 
		 * 
		 */		
		public function get tileMatrixSetLimits():Array
		{
			return _tileMatrixSetLimits;
		}

		public function set tileMatrixSetLimits(value:Array):void
		{
			_tileMatrixSetLimits = value;
		}

		/**
		 * ${mapping_OGC_TileMatrixSetLink_attribute_tileMatrixSet_D} 
		 * @return 
		 * 
		 */		
		public function get tileMatrixSet():String
		{
			return _tileMatrixSet;
		}

		public function set tileMatrixSet(value:String):void
		{
			_tileMatrixSet = value;
		}

	}
}