package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.core.geometry.Geometry;

	/**
	 * ${iServer2_BufferQueryParameters_Title}. 
	 * ${iServer2_BufferQueryParameters_Description_as}
	 * 
	 * 
	 */
	public class BufferQueryParameters extends QueryParametersBase
	{
		//建立缓冲区的相关参数
		private var _bufferParam:BufferAnalystParam;
		//空间查询操作模式常量
		private var _queryMode:int;
		//几何对象类型
		private var _geometry:Geometry;
		/**
		 * ${iServer2_BufferQueryParameters_constructor_None_D_as} 
		 * @param mapName ${iServer2_BufferQueryParameters_constructor_None_param_mapName_as}
		 * @param queryParam ${iServer2_BufferQueryParameters_constructor_None_param_queryParam_as}
		 * 
		 */
		public function BufferQueryParameters(mapName:String=null, queryParam:QueryParam=null)
		{
			super(mapName, queryParam);
		}
		
		/**
		 * ${iServer2_BufferQueryParameters_attribute_geometry_D} 
		 */
		public function get geometry():Geometry
		{
			return _geometry;
		}

		public function set geometry(value:Geometry):void
		{
			_geometry = value;
		}

		/**
		 * ${iServer2_BufferQueryParameters_attribute_queryMode_D} 
		 */
		public function get queryMode():int
		{
			return _queryMode;
		}

		public function set queryMode(value:int):void
		{
			_queryMode = value;
		}

		/**
		 * ${iServer2_BufferQueryParameters_attribute_bufferParam_D} 
		 */
		public function get bufferParam():BufferAnalystParam
		{
			return _bufferParam;
		}

		public function set bufferParam(value:BufferAnalystParam):void
		{
			_bufferParam = value;
		}

	}
}