package com.supermap.web.iServerJava2.mapServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_getMapStatus_SetLayerStatusResult_Title}.
	 * <p>${iServer2_getMapStatus_SetLayerStatusResult_Description}</p> 
	 * 
	 * 
	 */	
	public class SetLayerStatusResult
	{
		private var _layerKey:String;
		
		/**
		 * ${iServer2_getMapStatus_SetLayerStatusResult_attribute_layerKey_D} 
		 * @return 
		 * 
		 */		
		public function get layerKey():String
		{
			return this._layerKey;
		}
		
		sm_internal static function toSetLayerStatusResult(object:Object):SetLayerStatusResult
		{
			var setLayerStatusResult:SetLayerStatusResult;
			if(object)
			{
				setLayerStatusResult = new SetLayerStatusResult();
				setLayerStatusResult._layerKey = object.toString();
			}
			return setLayerStatusResult;
		}
	}
}