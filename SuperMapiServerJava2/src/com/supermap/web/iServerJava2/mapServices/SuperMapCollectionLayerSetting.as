package com.supermap.web.iServerJava2.mapServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_getMapStatus_SuperMapCollectionLayerSetting_Title}.
	 * ${iServer2_getMapStatus_SuperMapCollectionLayerSetting_Description} 
	 * 
	 * 
	 */	
	public class SuperMapCollectionLayerSetting extends ServerLayerSetting
	{
		private var _mapName:String;
		
		private var _serviceAddress:String;
		
		private var _servicePort:int;
		
		/**
		 * ${iServer2_getMapStatus_SuperMapCollectionLayerSetting_constructor_String_D} 
		 * 
		 */		
		public function SuperMapCollectionLayerSetting()
		{
			super();
		}
		
		/**
		 * ${iServer2_getMapStatus_SuperMapCollectionLayerSetting_attribute_mapName_D} 
		 * @return 
		 * 
		 */		
		public function get mapName():String
		{
			return this._mapName;
		}
		
		
		/**
		 * ${iServer2_getMapStatus_SuperMapCollectionLayerSetting_attribute_serviceAddress_D} 
		 * @return 
		 * 
		 */		
		public function get serviceAddress():String
		{
			return this._serviceAddress;
		}
		
		/**
		 * ${iServer2_getMapStatus_SuperMapCollectionLayerSetting_attribute_servicePort_D} 
		 * @return 
		 * 
		 */		
		public function get servicePort():int
		{
			return this._servicePort;
		}
		
		sm_internal static function toSuperMapCollectionLayerSetting(object:Object):SuperMapCollectionLayerSetting
		{
			var superMapCollectionLayerSetting:SuperMapCollectionLayerSetting;
			if(object)
			{
				superMapCollectionLayerSetting = new SuperMapCollectionLayerSetting();
				superMapCollectionLayerSetting._mapName = object.mapName;
				superMapCollectionLayerSetting._serviceAddress = object.serviceAddress;
				superMapCollectionLayerSetting._servicePort = object.servicePort;
				superMapCollectionLayerSetting._serverLayerSettingType = 12;
				
			}
			return superMapCollectionLayerSetting;
		}
	}
}