package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.iServerJava2.ParametersBase;

	/**
	 * ${iServer2_networkAnalystServices_FindPathParameters_Title}.
	 * <p>${iServer2_networkAnalystServices_FindPathParameters_Description}</p>
	 * @see TurnTableSetting
	 * 
	 * 
	 */
	public class FindPathParameters extends ParametersBase
	{
		//用于描述网络数据的模型参数设置
		private var _networkSetting:NetworkModelSetting;
		//路径分析参数
		private var _pathParam:PathParam;
		
		/**
		 * ${iServer2_networkAnalystServices_FindPathParameters_constructor_String_D}
		 *@param mapName ${iServer2_networkAnalystServices_FindPathParameters_constructor_param_mapName}
		 * 
		 */
		public function FindPathParameters(mapName:String=null)
		{
			super(mapName);
		}
		
		/**
		 * ${iServer2_networkAnalystServices_FindPathParameters_attribute_pathParam_D} 
		 */
		public function get pathParam():PathParam
		{
			return _pathParam;
		}

		public function set pathParam(value:PathParam):void
		{
			_pathParam = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_FindPathParameters_attribute_networkSetting_D} 
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