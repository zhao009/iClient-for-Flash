package com.supermap.web.iServerJava2.mapServices
{

	/**
	 * ${iServer2_getMapStatus_GetMapStatusParameters_Title}.
	 * <p>${iServer2_getMapStatus_GetMapStatusParameters_Description}</p> 
	 * 
	 * 
	 */	
	public class GetMapStatusParameters
	{
		
		private var _mapName:String;
		private var _mapServicesAddress:String;	
		private var _mapServicesPort:String;
		
		/**
		 * ${iServer2_getMapStatus_GetMapStatusParameters_constructor_String_D} 
		 * @param mapName ${iServer2_getMapStatus_GetMapStatusParameters_constructor_String_param_mapName}
		 * @param mapServicesAddress ${iServer2_getMapStatus_GetMapStatusParameters_constructor_String_param_mapServicesAddress}
		 * @param mapServicesPort ${iServer2_getMapStatus_GetMapStatusParameters_constructor_String_param_mapServicesPort}
		 * 
		 */		
		public function GetMapStatusParameters(mapName:String=null, mapServicesAddress:String="localhost", mapServicesPort:String="8600")
		{
			this._mapName = mapName;
			this._mapServicesAddress = mapServicesAddress;
			this._mapServicesPort = mapServicesPort;
		}
		
		
		/**
		 * @copy com.supermap.web.mapping.DynamicIServerLayer#mapServicePort
		 * 
		 */		
		public function get mapServicesPort():String
		{
			return _mapServicesPort;
		}

		public function set mapServicesPort(value:String):void
		{
			_mapServicesPort = value;
		}

		/**
		 * @copy com.supermap.web.mapping.DynamicIServerLayer#mapServiceAddress 
		 * @return 
		 * 
		 */		
		public function get mapServicesAddress():String
		{
			return _mapServicesAddress;
		}

		public function set mapServicesAddress(value:String):void
		{
			_mapServicesAddress = value;
		}

		/**
		 * @copy com.supermap.web.mapping.DynamicIServerLayer#mapName 
		 * @return 
		 * 
		 */		
		public function get mapName():String
		{
			return _mapName;
		}

		public function set mapName(value:String):void
		{
			_mapName = value;
		}

	}
}