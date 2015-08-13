package com.supermap.web.iServerJava2.editServices
{
	import com.supermap.web.iServerJava2.ParametersBase;

	/**
	 * ${iServer2_editServices_GetEntityParameters_Title}.
	 * <p>${iServer2_editServices_GetEntityParameters_Description}</p>
	 * 
	 * 
	 */
	public class GetEntityParameters extends ParametersBase
	{
		//要添加实体的图层
		private var _layerName:String;
		//实体对象的SMID值
		private var _id:int;
		
		/**
		 * ${iServer2_editServices_GetEntityParameters_constructor_String_D} 
		 * @param mapName ${iServer2_editServices_GetEntityParameters_constructor_param_mapName}
		 * 
		 */
		public function GetEntityParameters(mapName:String=null)
		{
			super(mapName);
		}
		
		/**
		 * ${iServer2_editServices_GetEntityParameters_attribute_ID_D} 
		 */
		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		/**
		 * ${iServer2_editServices_GetEntityParameters_attribute_layerName_D}
		 */
		public function get layerName():String
		{
			return _layerName;
		}

		public function set layerName(value:String):void
		{
			_layerName = value;
		}

	}
}