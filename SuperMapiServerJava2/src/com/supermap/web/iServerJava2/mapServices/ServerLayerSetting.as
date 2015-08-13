package com.supermap.web.iServerJava2.mapServices
{
	/**
	 * ${iServer2_getMapStatus_ServerLayerSetting_Title}.
	 * 
	 * 
	 */	
	public class ServerLayerSetting
	{
	
		/**
		 * @private 
		 */		
		internal var _serverLayerSettingType:int;
		
		/**
		 * ${iServer2_getMapStatus_ServerLayerSetting_attribute_serverLayerSettingType_D} 
		 * @see ServerLayerSettingType
		 * @return 
		 * 
		 */		
		public function get serverLayerSettingType():int
		{
			return this._serverLayerSettingType;
		}
		
	}
}