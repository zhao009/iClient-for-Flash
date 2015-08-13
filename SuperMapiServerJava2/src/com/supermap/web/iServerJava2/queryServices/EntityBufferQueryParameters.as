package com.supermap.web.iServerJava2.queryServices
{

	/**
	 * ${iServer2_EntityBufferQueryParameters_Title}.
	 * <p>${iServer2_EntityBufferQueryParameters_Description_as}</p> 
	 * 
	 * 
	 */
	public class EntityBufferQueryParameters extends BufferQueryParameters
	{
		private var _fromLayer:String;
		/**
		 * ${iServer2_EntityBufferQueryParameters_constructor_D_as} 
		 * @param mapName ${iServer2_EntityBufferQueryParameters_constructor_param_mapName_as}
		 * @param queryParam ${iServer2_EntityBufferQueryParameters_constructor_param_queryParam_as}
		 * 
		 */
		public function EntityBufferQueryParameters(mapName:String=null, queryParam:QueryParam=null)
		{
			super(mapName, queryParam);
		}
		
		
		/**
		 * ${iServer2_BufferQueryParameters_attribute_fromLayer_D_as} 
		 */
		public function get fromLayer():String
		{
			return _fromLayer;
		}
		
		public function set fromLayer(value:String):void
		{
			_fromLayer = value;
		}

	}
}