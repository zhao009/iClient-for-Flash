package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServer6_SetLayerStatusParameter_Title}.
	 * <p>${iServer6_SetLayerStatusParameter_Description}</p> 
	 * 
	 */	
	public class SetLayerStatusParameters
	{ 
		private var _layerStatusList:Array;
		private var _holdTime:int = 10;
		private var _resourceID:String;
		/**
		 * ${iServer6_SetLayerStatusParameter_constructor_D} 
		 * 
		 */		
		public function SetLayerStatusParameters()
		{
		}
	 
		/**
		 * ${iServer6_SetLayerStatusParameter_attribute_ResourceID_D}.
		 * <p>${iServer6_SetLayerStatusParameter_attribute_ResourceID_remarks}</p> 
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
		 * ${iServer6_SetLayerStatusParameter_attribute_HoldTime_D}.
		 * <p>${iServer6_SetLayerStatusParameter_attribute_HoldTime_remarks}</p> 
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
		 * ${iServer6_SetLayerStatusParameter_attribute_layerStatusList_D} 
		 * @see LayerStatus
		 * @return 
		 * 
		 */		
		public function get layerStatusList():Array
		{
			return _layerStatusList;
		}

		public function set layerStatusList(value:Array):void
		{
			_layerStatusList = value;
		}

		sm_internal static function toJson(parameters:SetLayerStatusParameters):String
		{
			var json:String = "{";
			var list:Array = [];
			for each(var item:LayerStatus in parameters.layerStatusList)
			{
				list.push(LayerStatus.toJson(item));
			}
			
			json += String("\"layers\":["+ list.toString() +"]");
			json += "}";
			return json;
		}
	}
}