package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_UGCVectorLayer_Title}. 
	 * 
	 */	
	public class UGCVectorLayer extends UGCLayer
	{ 
		private var _style:ServerStyle;
		
		/**
		 * ${iServerJava6R_UGCVectorLayer_constructor_D} 
		 * 
		 */		
		public function UGCVectorLayer()
		{
		}
		
		/**
		 * ${iServerJava6R_UGCVectorLayer_attribute_Style_D} 
		 * @return 
		 * 
		 */		
		public function get style():ServerStyle
		{
			return _style;
		}

		public function set style(value:ServerStyle):void
		{
			_style = value;
		}

		sm_internal static function fromJson(json:Object):UGCVectorLayer
		{ 
			var vectorLayer:UGCVectorLayer;
			if(json)
			{
				vectorLayer = new UGCVectorLayer();
				vectorLayer.style = ServerStyle.fromJson(json); 
			}
			return vectorLayer;
		}
	
	}
}