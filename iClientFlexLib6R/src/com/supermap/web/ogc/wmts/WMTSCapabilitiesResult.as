package com.supermap.web.ogc.wmts
{
	/**
	 * ${mapping_OGC_WMTSCapabilitiesResult_Title}.
	 * <p>${mapping_OGC_WMTSCapabilitiesResult_Description}</p> 
	 * 
	 */	
	public class WMTSCapabilitiesResult
	{
		private var _version:String;
		private var _layerInfos:Array;
		private var _WMTSTileMatrixSetInfos:Array;
		
		/**
		 * ${mapping_OGC_WMTSCapabilitiesResult_constructor_string_D} 
		 * 
		 */		
		public function WMTSCapabilitiesResult()
		{
			
		}

		/**
		 * ${mapping_OGC_WMTSCapabilitiesResult_method_layerInfos_D} 
		 * @see com.supermap.web.ogc.wmts.WMTSLayerInfo
		 * @return 
		 * 
		 */		
		public function get layerInfos():Array
		{
			return _layerInfos;
		}

		public function set layerInfos(value:Array):void
		{
			_layerInfos = value;
		}

		/**
		 * ${mapping_OGC_WMTSCapabilitiesResult_method_WMTSTileMatrixSetInfos_D} 
		 * @see com.supermap.web.ogc.wmts.WMTSTileMatrixSetInfo
		 * @return 
		 * 
		 */		
		public function get WMTSTileMatrixSetInfos():Array
		{
			return _WMTSTileMatrixSetInfos;
		}

		public function set WMTSTileMatrixSetInfos(value:Array):void
		{
			_WMTSTileMatrixSetInfos = value;
		}

		/**
		 * ${mapping_OGC_WMTSCapabilitiesResult_method_version_D} 
		 * @return 
		 * 
		 */		
		public function get version():String
		{
			return _version;
		}

		public function set version(value:String):void
		{
			_version = value;
		}

	}
}