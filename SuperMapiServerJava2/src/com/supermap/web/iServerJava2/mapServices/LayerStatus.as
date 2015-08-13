package com.supermap.web.iServerJava2.mapServices
{
	/**
	 * ${iServer2_LayerStatus_Title}.
	 * <p>${iServer2_LayerStatus_Title}</p>
	 * 
	 */	
	public class LayerStatus
	{
		private var _layerName:String;
		
		private var _isVisible:Boolean = true;
		
		/**
		 * ${iServer2_LayerStatus_constructor_None_D} 
		 * 
		 */		
		public function LayerStatus()
		{
		}

		/**
		 * ${iServer2_LayerStatus_attribute_isVisible_D} 
		 * @return 
		 * 
		 */		
		public function get isVisible():Boolean
		{
			return _isVisible;
		}

		public function set isVisible(value:Boolean):void
		{
			_isVisible = value;
		}

		/**
		 * ${iServer2_LayerStatus_attribute_layerName_D} 
		 * @return 
		 * 
		 */		
		public function get layerName():String
		{
			return _layerName;
		}

		public function set layerName(value:String):void
		{
			_layerName = value;
		}

	}
}