package com.supermap.web.iServerJava6R.dataServices
{
	/**
	 * ${iServerJava6R_GetFeaturesParametersBase_Title}.
	 * <p>${iServerJava6R_GetFeaturesParametersBase_Description}</p> 
	 * 
	 */	
	public class GetFeaturesParametersBase
	{
		private var _fromIndex:int;
		private var _toIndex:int;
		private var _datasetNames:Array;
		
		/**
		 * ${iServerJava6R_GetFeaturesParametersBase_constructor_D} 
		 * 
		 */		
		public function GetFeaturesParametersBase()
		{
			fromIndex = 0;
			toIndex = 19;
		}

		/**
		 * ${iServerJava6R_GetFeaturesParametersBase_attribute_datasetNames_D}.
		 * <p>${iServerJava6R_GetFeaturesParametersBase_attribute_datasetNames_remarks}</p> 
		 * @see com.supermap.web.iServerJava6R.dataServices.GetFeaturesBySQLParameters
		 * @return 
		 * 
		 */		
		public function get datasetNames():Array
		{
			return _datasetNames;
		}

		public function set datasetNames(value:Array):void
		{
			_datasetNames = value;
		}

		/**
		 * ${iServerJava6R_GetFeaturesParametersBase_attribute_fromIndex_D}.
		 * <p>${iServerJava6R_GetFeaturesParametersBase_attribute_fromIndex_remarks}</p> 
		 * @see #toIndex
		 * @return 
		 * 
		 */		
		public function get fromIndex():int
		{
			return _fromIndex;
		}

		public function set fromIndex(value:int):void
		{
			_fromIndex = value;
		}

		/**
		 * ${iServerJava6R_GetFeaturesParametersBase_attribute_toIndex_D}.
		 * <p>${iServerJava6R_GetFeaturesParametersBase_attribute_toIndex_remarks}</p> 
		 * @see #fromIndex
		 * @return 
		 * 
		 */		
		public function get toIndex():int
		{
			return _toIndex;
		}

		public function set toIndex(value:int):void
		{
			_toIndex = value;
		}

	}
}