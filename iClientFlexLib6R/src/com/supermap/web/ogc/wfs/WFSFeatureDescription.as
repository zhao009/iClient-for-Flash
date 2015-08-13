package com.supermap.web.ogc.wfs
{
	/**
	 * ${ogc_wfs_WFSFeatureDescription_Title}.
	 * <p>${ogc_wfs_WFSFeatureDescription_Description}</p> 
	 * 
	 */	
	public class WFSFeatureDescription
	{
		private var _spatialProperty:String;
		private var _properties:Array;
		private var _typeName:String;
		
		/**
		 * ${ogc_wfs_WFSFeatureDescription_constructor_string_D} 
		 * 
		 */		
		public function WFSFeatureDescription()
		{
			this._properties = [];
		}

		/**
		 * ${ogc_wfs_WFSFeatureDescription_attribute_typeName_D}
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

		/**
		 * ${ogc_wfs_WFSFeatureDescription_attribute_properties_D} 
		 * @return 
		 * 
		 */		
		public function get properties():Array
		{
			return _properties;
		}

		public function set properties(value:Array):void
		{
			_properties = value;
		}

		/**
		 * ${ogc_wfs_WFSFeatureDescription_attribute_spatialProperty_D}.
		 * <p>${ogc_wfs_WFSFeatureDescription_attribute_spatialProperty_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get spatialProperty():String
		{
			return _spatialProperty;
		}

		public function set spatialProperty(value:String):void
		{
			_spatialProperty = value;
		}

	}
}