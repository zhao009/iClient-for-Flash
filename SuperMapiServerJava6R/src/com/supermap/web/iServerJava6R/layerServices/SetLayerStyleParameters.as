package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.utils.serverTypes.ServerStyle;

	/**
	 * ${iServer6_SetLayerStyleParameters_Title}.
	 * <p>${iServer6_SetLayerStyleParameters_Description}</p> 
	 * 
	 */	
	public class SetLayerStyleParameters
	{ 
		private var _layerName:String;
		private var _style:ServerStyle = new ServerStyle();
		private var _resourceID:String;
		private var _holdTime:int = 10;
		
		/**
		 * ${iServer6_SetLayerStyleParameters_constructor_D} 
		 * 
		 */		
		public function SetLayerStyleParameters()
		{
		}

		/**
		 * ${iServer6_SetLayerStyleParameters_attribute_HoldTime_D}.
		 * <p>${iServer6_SetLayerStyleParameters_attribute_HoldTime_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get holdTime():int
		{
			return _holdTime;
		}

		public function set holdTime(value:int):void
		{
			_holdTime = value;
		}

		/**
		 * ${iServer6_SetLayerStyleParameters_attribute_ResourceID_D} 
		 * @return 
		 * 
		 */		
		public function get resourceID():String
		{
			return _resourceID;
		}

		public function set resourceID(value:String):void
		{
			_resourceID = value;
		}

		/**
		 * ${iServer6_SetLayerStyleParameters_attribute_Style_D} 
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

		/**
		 * ${iServer6_SetLayerStyleParameters_attribute_LayerName_D} 
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