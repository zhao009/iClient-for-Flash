package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.iServerJava2.ParametersBase;

	/**
	 * ${iServer2_networkAnalystServices_FindTSPathParameters_Title}.
	 * <p>${iServer2_networkAnalystServices_FindTSPathParameters_Description}</p>
	 * @see TSPPathParam#isEndNodeAssigned
	 * 
	 * 
	 */
	public class FindTSPPathParameters extends ParametersBase
	{
		//用于描述网络数据的模型参数设置
		private var _networkSetting:NetworkModelSetting;
		//该类描述旅行商分析中所用到的网络分析参数和是否指定终点标示
		private var _tspPathParam:TSPPathParam;
		/**
		 * ${iServer2_networkAnalystServices_FindTSPathParameters_constructor_String_D}
		 * @param mapName ${iServer2_networkAnalystServices_FindTSPathParameters_constructor_param_mapName}
		 * 
		 */
		public function FindTSPPathParameters(mapName:String = null)
		{
			super(mapName);
		}
		
		/**
		 * ${iServer2_networkAnalystServices_FindTSPathParameters_attribute_TSPPathParam_D} 
		 */
		public function get tspPathParam():TSPPathParam
		{
			return _tspPathParam;
		}

		public function set tspPathParam(value:TSPPathParam):void
		{
			_tspPathParam = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_FindTSPathParameters_attribute_networkSetting_D}
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