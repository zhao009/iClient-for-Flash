package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_GetLayersInfoResult_Title}.
	 * <p>${iServerJava6R_GetLayersInfoResult_Description}</p> 
	 * 
	 */	
	public class GetLayersInfoResult
	{  
		private var _layersInfo:Array;
		
		/**
		 * ${iServerJava6R_GetLayersInfoResult_Constructor_D} 
		 * 
		 */		
		public function GetLayersInfoResult()
		{
		}
		
		/**
		 * ${iServerJava6R_GetLayersInfoResult_attribute_LayersInfo_D} 
		 * @see com.supermap.web.iServerJava6R.mapServices.ServerLayer
		 * @return 
		 * 
		 */		
		public function get layersInfo():Array
		{
			return _layersInfo;
		}
 
		sm_internal static function fromJson(json:Object):GetLayersInfoResult
		{
			var result:GetLayersInfoResult = new GetLayersInfoResult();
			if(json == null)
			{
				return null;
			}
			
			var layers:Array = new Array();
			for each(var layerJson:Object in json)
			{
				if(layerJson.subLayers)
				{
					for each(var item:Object in layerJson.subLayers.layers)
					{
						layers.push(ServerLayer.toServerLayer(item));
					}
				}
			}
			result._layersInfo = layers;
			return result;
		}
	}
}