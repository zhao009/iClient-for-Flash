package com.supermap.web.iServerJava2.mapServices
{
	import com.supermap.web.iServerJava2.ParametersBase;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;

	/**
	 * ${iServer2_getMapStatus_SetLayerStatusParameters_Title}.
	 * <p>${iServer2_getMapStatus_SetLayerStatusParameters_Description}</p> 
	 * 
	 * 
	 */	
	public class SetLayerStatusParameters extends ParametersBase
	{
		private var _layerStatusList:Array;
		
		/**
		 * ${iServer2_getMapStatus_SetLayerStatusParameters_constructor_String_D} 
		 * @param mapName ${iServer2_getMapStatus_SetLayerStatusParameters_constructor_String_param_mapName}
		 * 
		 */		
		public function SetLayerStatusParameters(mapName:String=null)
		{
			super(mapName);
		}

		/**
		 * ${iServer2_getMapStatus_SetLayerStatusParameters_attribute_layerStatusList_D} 
		 */
		public function get layerStatusList():Array
		{
			return _layerStatusList;
		}

		public function set layerStatusList(value:Array):void
		{
			_layerStatusList = value;
		}

		sm_internal function toJSONArray():Array
		{
			var layerNameStr:String;
			var visibleArgStr:String;
			var queryableStr:String;
			
			var layerNames:Array = new Array();
			var visibleArgs:Array = new Array();
			var queryableArgs:Array = new Array();
			
			for(var i:int = 0; i < layerStatusList.length; i++)
			{
				var layerStatus:LayerStatus = layerStatusList[i];
				visibleArgs.push(layerStatus.isVisible);
				layerNames.push("\"" + layerStatus.layerName + "\"");
				queryableArgs.push(true);
			}
			if(visibleArgs.length > 0)
				visibleArgStr = "[" + visibleArgs.join(",") + "]";
			if(layerNames.length > 0)
				layerNameStr = "[" + layerNames.join(",") + "]";
			if(queryableArgs.length > 0)
				queryableStr = "[" + queryableArgs.join(",") + "]";
			
			var jsonArray:Array = new Array();
			jsonArray.push(layerNameStr);
			jsonArray.push(visibleArgStr);
			jsonArray.push(queryableStr);
			
			return jsonArray;
		}
	}
}