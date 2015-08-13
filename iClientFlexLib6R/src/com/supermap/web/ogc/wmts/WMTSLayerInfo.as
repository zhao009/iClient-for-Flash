package com.supermap.web.ogc.wmts
{
	import com.supermap.web.core.Rectangle2D;

	/**
	 * ${mapping_OGC_WMTSLayerInfo_Title}.
	 * <p>${mapping_OGC_WMTSLayerInfo_Description}</p> 
	 * 
	 */	
	public class WMTSLayerInfo
	{
		private var _name:String;
		private var _bounds:Rectangle2D;
		private var _style:String;
		private var _imageFormat:String;
		private var _tileMatrixSetLinks:Array;
		
		/**
		 * ${mapping_OGC_WMTSLayerInfo_constructor_string_D} 
		 * 
		 */		
		public function WMTSLayerInfo()
		{
		}

		//一个图层只对应一个TileMatrixSetLink，一个matrixSet，多个 TileMatrixLimits
		public function get tileMatrixSetLinks():Array
		{
			return _tileMatrixSetLinks;
		}

		public function set tileMatrixSetLinks(value:Array):void
		{
			_tileMatrixSetLinks = value;
		}

		/**
		 * ${mapping_OGC_WMTSLayerInfo_attribute_imageFormat_D} 
		 * @return 
		 * 
		 */		
		public function get imageFormat():String
		{
			return _imageFormat;
		}

		public function set imageFormat(value:String):void
		{
			_imageFormat = value;
		}

		/**
		 * ${mapping_OGC_WMTSLayerInfo_attribute_style_D} 
		 * @return 
		 * 
		 */		
		public function get style():String
		{
			return _style;
		}

		public function set style(value:String):void
		{
			_style = value;
		}

		/**
		 * ${mapping_OGC_WMTSLayerInfo_attribute_bounds_D} 
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}

		public function set bounds(value:Rectangle2D):void
		{
			_bounds = value;
		}

		/**
		 * ${mapping_OGC_WMTSLayerInfo_attribute_name_D} 
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