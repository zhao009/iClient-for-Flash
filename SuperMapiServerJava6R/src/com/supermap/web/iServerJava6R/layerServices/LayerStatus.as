package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_LayerStatus_Title}.
	 * <p>${iServerJava6R_LayerStatus_Description}</p> 
	 * 
	 */	
	public class LayerStatus
	{
		private var _layerName:String;
		private var _isVisible:Boolean = true;
		private var _displayFilter:String;
		private var _maxScale:Number;
		private var _minScale:Number;
		
		/**
		 * ${iServerJava6R_LayerStatus_Constructor_D} 
		 * 
		 */		
		public function LayerStatus()
		{
		}
	 
		

		/**
		 * ${iServerJava6R_LayerStatus_attribute_displayFilter_D} 
		 * @return 
		 * 
		 */		
		public function get displayFilter():String
		{
			return _displayFilter;
		}

		public function set displayFilter(value:String):void
		{
			_displayFilter = value;
		}

		/**
		 * ${iServerJava6R_LayerStatus_attribute_isVisible_D} 
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
		 * ${iServerJava6R_LayerStatus_attribute_layerName_D} 
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
		
		/**
		 * ${iServerJava6R_LayerStatus_attribute_maxScale_D} 
		 * @return 
		 * 
		 */		
		public function get maxScale():Number
		{
			return _maxScale;
		}
		
		public function set maxScale(value:Number):void
		{
			_maxScale = value;
		}
		
		/**
		 * ${iServerJava6R_LayerStatus_attribute_minScale_D} 
		 * @return 
		 * 
		 */	
		public function get minScale():Number
		{
			return _minScale;
		}
		
		public function set minScale(value:Number):void
		{
			_minScale = value;
		}
		

		sm_internal static function toJson(layerStatus:LayerStatus):String
		{
			var json:String = "{";
			json += String("\"type\":\"UGC\",");
			json += String("\"name\":\""+ layerStatus.layerName +"\",");
			if(layerStatus.displayFilter)
				json += String("\"displayFilter\":\""+ layerStatus.displayFilter + "\",");
			if((layerStatus.maxScale &&  layerStatus.maxScale.toString().length > 0) || layerStatus.maxScale == 0)
				json += String("\"maxScale\":"+ layerStatus.maxScale.toString() + ",");
			if((layerStatus.minScale &&  layerStatus.minScale.toString().length > 0) || layerStatus.minScale == 0)
				json += String("\"minScale\":"+ layerStatus.minScale.toString() + ",");
			json += String("\"visible\":"+ layerStatus.isVisible);
			json += "}";
			return json;
		}
	}
}