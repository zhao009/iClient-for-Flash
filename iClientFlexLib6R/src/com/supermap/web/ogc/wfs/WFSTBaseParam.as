package com.supermap.web.ogc.wfs
{
	/**
	 *  
	 * ${ogc_wfs_WFSTBaseParam_Title}.
	 * <p>${ogc_wfs_WFSTBaseParam_Description}</p>
	 * 
	 */	
	public class WFSTBaseParam
	{
		
		private var _typeName:String;
		
		/**
		 * ${ogc_wfs_WFSTBaseParam_constructor_string_D} 
		 * 
		 */		
		public function WFSTBaseParam()
		{
		}

		/**
		 * ${ogc_wfs_WFSTBaseParam_attribute_typeName_D} 
		 * @return 
		 * 
		 */		
		public function get typeName():String
		{
			return _typeName;
		}

		public function set typeName(value:String):void
		{
			_typeName = value;
		}

	}
}