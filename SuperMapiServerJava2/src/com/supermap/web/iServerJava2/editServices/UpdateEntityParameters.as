package com.supermap.web.iServerJava2.editServices
{
	import com.supermap.web.iServerJava2.ParametersBase;

	/**
	 * ${iServer2_editServices_UpdateEntityParameters_Title}.
	 * <p>${iServer2_editServices_UpdateEntityParameters_Description}</p>
	 * 
	 * 
	 */
	public class UpdateEntityParameters extends ParametersBase
	{
		//要添加实体的图层
		private var _layerName:String;
		//描述空间实体对象的类
		private var _entity:Entity;
		/**
		 * ${iServer2_editServices_UpdateEntityParameters_constructor_String_D}
		 * @param mapName ${iServer2_editServices_UpdateEntityParameters_constructor_param_mapName}
		 * 
		 */
		public function UpdateEntityParameters(mapName:String=null)
		{
			super(mapName);
		}
		
		/**
		 * ${iServer2_editServices_UpdateEntityParameters_attribute_entity_D}
		 */
		public function get entity():Entity
		{
			return _entity;
		}

		public function set entity(value:Entity):void
		{
			_entity = value;
		}

		/**
		 * ${iServer2_editServices_UpdateEntityParameters_attribute_layerName_D}
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