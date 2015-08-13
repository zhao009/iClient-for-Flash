package com.supermap.web.iServerJava2
{
	/**
	 * ${iServer2_paramertersBase_Title}. 
	 * <br/> ${iServer2_ParamertersBase_Description}
	 * 
	 * 
	 */	
	public class ParametersBase
	{
		private var _mapName:String;
		
		/**
		 * ${iServer2_paramertersBase_constructor_D} 
		 * 
		 */		
		public function ParametersBase(mapName:String = null)
		{
			this.mapName = mapName;
		}

		/**
		 * ${iServer2_paramertersBase_attribute_mapName_D} 
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