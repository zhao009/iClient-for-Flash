package com.supermap.web.iServerJava2.editServices
{
	import com.supermap.web.iServerJava2.ParametersBase;
	/**
	 * ${iServer2_editServices_DeleteEntityParameters_Title}.
	 * <p>${iServer2_editServices_DeleteEntityParameters_Description}</p>
	 * 
	 * 
	 */
	public class DeleteEntityParameters extends ParametersBase
	{
		//要删除实体的图层
		private var _layerName:String;
		//要删除的实体的id数组
		private var _ids:Array;
		
		/**
		 * ${iServer2_editServices_DeleteEntityParameters_constructor_String_D} 
		 * @param mapName ${iServer2_editServices_DeleteEntityParameters_constructor_param_mapName}
		 * 
		 */
		public function DeleteEntityParameters(mapName:String=null)
		{
			super(mapName);
		}
		
		/**
		 * ${iServer2_editServices_DeleteEntityParameters_attribute_IDs_D} 
		 */
		public function get ids():Array
		{
			return _ids;
		}

		public function set ids(value:Array):void
		{
			_ids = value;
		}

		/**
		 * ${iServer2_editServices_DeleteEntityParameters_attribute_layerName_D} 
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