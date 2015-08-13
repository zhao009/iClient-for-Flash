package com.supermap.web.ogc.wmts
{
	import com.supermap.web.utils.CoordinateReferenceSystem;

	/**
	 * ${mapping_OGC_WMTSTileMatrixSetInfo_Title}.
	 * <p>${mapping_OGC_WMTSTileMatrixSetInfo_Description}</p> 
	 * 
	 */	
	public class WMTSTileMatrixSetInfo
	{
		private var _name:String;
		private var _supportedCRS:CoordinateReferenceSystem;
		private var _wellKnownScaleSet:String;
		private var _tileMatrixs:Array;
		
		/**
		 * ${mapping_OGC_WMTSTileMatrixSetInfo_constructor_string_D} 
		 * 
		 */		
		public function WMTSTileMatrixSetInfo()
		{
		}

		/**
		 * ${mapping_OGC_WMTSTileMatrixSetInfo_method_tileMatrixs_D} 
		 * @see com.supermap.web.ogc.wmts.TileMatrix
		 * @return 
		 * 
		 */		
		public function get tileMatrixs():Array
		{
			return _tileMatrixs;
		}

		public function set tileMatrixs(value:Array):void
		{
			_tileMatrixs = value;
		}

		/**
		 * ${mapping_OGC_WMTSTileMatrixSetInfo_attribute_wellKnownScaleSet_D} 
		 * @return 
		 * 
		 */		
		public function get wellKnownScaleSet():String
		{
			return _wellKnownScaleSet;
		}

		public function set wellKnownScaleSet(value:String):void
		{
			_wellKnownScaleSet = value;
		}

		/**
		 * ${mapping_OGC_WMTSTileMatrixSetInfo_attribute_supportedCRS_D} 
		 * @return 
		 * 
		 */		
		public function get supportedCRS():CoordinateReferenceSystem
		{
			return _supportedCRS;
		}

		public function set supportedCRS(value:CoordinateReferenceSystem):void
		{
			_supportedCRS = value;
		}

		/**
		 * ${mapping_OGC_WMTSTileMatrixSetInfo_attribute_name_D} 
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