package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.iServerJava2.ParametersBase;
	
	/**
	 * ${iServer2_networkAnalystServices_ServiceAreaParameters_Title}.
	 * <p>${iServer2_networkAnalystServices_ServiceAreaParameters_Description}</p> 
	 * 
	 */	
	public class ServiceAreaParameters extends ParametersBase
	{
		private var _networkSetting:NetworkModelSetting;		
		private var _serviceAreaParam:ServiceAreaParam;
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaParameters_constructor_String_D} 
		 * @param mapName ${iServer2_networkAnalystServices_ServiceAreaParameters_param_mapName}
		 * 
		 */		
		public function ServiceAreaParameters(mapName:String=null)
		{
			super(mapName);
		}

		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaParameters_attribute_ServiceAreaParam_D} 
		 * @return 
		 * 
		 */		
		public function get serviceAreaParam():ServiceAreaParam
		{
			return _serviceAreaParam;
		}

		public function set serviceAreaParam(value:ServiceAreaParam):void
		{
			_serviceAreaParam = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaParameters_attribute_networkSetting_D} 
		 * @return 
		 * 
		 */		
		public function get networkSetting():NetworkModelSetting
		{
			return _networkSetting;
		}

		public function set networkSetting(value:NetworkModelSetting):void
		{
			_networkSetting = value;
		}

	}
}