package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.iServerJava2.ParametersBase;;
	/**
	 * ${iServer2_networkAnalystServices_ClosestFacilityParameters_Title}.
	 * <p>${iServer2_networkAnalystServices_ClosestFacilityParameters_Description}</p>
	 * 
	 * 
	 */
	public class ClosestFacilityParameters extends ParametersBase
	{
		//用于描述网络数据的模型参数设置
		private var _networkSetting:NetworkModelSetting;
		//事件点坐标
		private var _eventPoint:Point2D;
		//最近设施分析参数
		private var _proximityParam:ProximityParam;
		
		/**
		 * ${iServer2_networkAnalystServices_ClosestFacilityParameters_constructor_String_D} 
		 * @param mapName ${iServer2_networkAnalystServices_ClosestFacilityParameters_constructor_param_mapName}
		 * 
		 */
		public function ClosestFacilityParameters(mapName:String=null)
		{
			super(mapName);
		}

		/**
		 * ${iServer2_networkAnalystServices_ClosestFacilityParameters_attribute_proximityParam_D}.
		 * <p>${iServer2_networkAnalystServices_ClosestFacilityParameters_attribute_proximityParam_remarks}</p> 
		 */
		public function get proximityParam():ProximityParam
		{
			return _proximityParam;
		}

		public function set proximityParam(value:ProximityParam):void
		{
			_proximityParam = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_ClosestFacilityParameters_attribute_eventPoint_D} 
		 */
		public function get eventPoint():Point2D
		{
			return _eventPoint;
		}

		public function set eventPoint(value:Point2D):void
		{
			_eventPoint = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_ClosestFacilityParameters_attribute_networkSetting_D}
		 * <p>${iServer2_networkAnalystServices_ClosestFacilityParameters_attribute_networkSetting_remarks}</p> 
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