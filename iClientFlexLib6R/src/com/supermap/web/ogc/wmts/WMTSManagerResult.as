package  com.supermap.web.ogc.wmts
{
	/**
	 * ${mapping_OGC_WMTSManagerResult_Title}.
	 * <p>${mapping_OGC_WMTSManagerResult_Description}</p> 
	 * 
	 */	
	public class WMTSManagerResult extends WMTSCapabilitiesResult
	{
		private var _wmtsLayerInfo:WMTSLayerInfo;
		private var _wmtsTileMatrixSetInfo:WMTSTileMatrixSetInfo;
		
		/**
		 * ${mapping_OGC_WMTSManagerResult_constructor_string_D} 
		 * 
		 */		
		public function WMTSManagerResult()
		{
		}

		/**
		 * ${mapping_OGC_WMTSManagerResult_method_wmtsTileMatrixSetInfo_D} 
		 * @return 
		 * 
		 */		
		public function get wmtsTileMatrixSetInfo():WMTSTileMatrixSetInfo
		{
			return _wmtsTileMatrixSetInfo;
		}

		public function set wmtsTileMatrixSetInfo(value:WMTSTileMatrixSetInfo):void
		{
			_wmtsTileMatrixSetInfo = value;
		}

		/**
		 * ${mapping_OGC_WMTSManagerResult_method_wmtsLayerInfo_D} 
		 * @return 
		 * 
		 */		
		public function get wmtsLayerInfo():WMTSLayerInfo
		{
			return _wmtsLayerInfo;
		}

		public function set wmtsLayerInfo(value:WMTSLayerInfo):void
		{
			_wmtsLayerInfo = value;
		}

	}
}