package com.supermap.web.iServerJava6R.dataServices
{
	/**
	 * ${iServerJava6R_GetFeaturesByIDsParameters_Title}. 
	 * <p>${iServerJava6R_GetFeaturesByIDsParameters_Description}</p>
	 */	
	public class GetFeaturesByIDsParameters extends GetFeaturesParametersBase
	{
		private var _IDs:Array;
		private var _fields:Array;
		
		/**
		 * ${iServerJava6R_GetFeaturesByIDsParameters_constructor_D} 
		 * 
		 */		
		public function GetFeaturesByIDsParameters()
		{
		}

		/**
		 * ${iServerJava6R_GetFeaturesByIDsParameters_attribute_fields_D}.
		 * <p>${iServerJava6R_GetFeaturesByIDsParameters_attribute_fields_remarks}</p> 
		 * @see GetFeaturesResult#features
		 * @return 
		 * 
		 */		
		public function get fields():Array
		{
			return _fields;
		}

		public function set fields(value:Array):void
		{
			_fields = value;
		}

		/**
		 * ${iServerJava6R_GetFeaturesByIDsParameters_attribute_ids_D} 
		 * @return 
		 * 
		 */		
		public function get IDs():Array
		{
			return _IDs;
		}

		public function set IDs(value:Array):void
		{
			_IDs = value;
		}

	}
}