package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.FilterParameter;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_DatasetExtractParams_Title}.
	 * <p>${iServerJava6R_DatasetExtractParams_Description}</p> 
	 * 
	 */	
	public class DatasetSurfaceAnalystParameters extends SurfaceAnalystParameters
	{
		private var _surfaceAnalystParametersSetting:SurfaceAnalystParametersSetting;
		private var _resultSetting:DataReturnOption = new DataReturnOption();
		private var _filterQueryParameter:FilterParameter;
		private var _zValueFieldName:String;
		private var _dataset:String;
		/**
		 * ${iServerJava6R_DatasetExtractParams_constructor_D} 
		 * 
		 */		
		public function DatasetSurfaceAnalystParameters()
		{
			super();
		}
		
		/**
		 * ${iServerJava6R_DatasetExtractParams_attribute_DatasetName_D} 
		 * @return 
		 * 
		 */		
		public function get dataset():String
		{
			return _dataset;
		}
		
		public function set dataset(value:String):void
		{
			_dataset = value;
		}
		
		/**
		 * ${iServerJava6R_DatasetExtractParams_attribute_ZValuedFieldName_D}.
		 * <p>${iServerJava6R_DatasetExtractParams_attribute_ZValuedFieldName_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get zValueFieldName():String
		{
			return _zValueFieldName;
		}
		
		public function set zValueFieldName(value:String):void
		{
			_zValueFieldName = value;
		}
		
		/**
		 * ${iServerJava6R_DatasetExtractParams_attribute_FilterQueryParam_D}.
		 * <p>${iServerJava6R_DatasetExtractParams_attribute_FilterQueryParam_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get filterQueryParameter():FilterParameter
		{
			return _filterQueryParameter;
		}
		
		public function set filterQueryParameter(value:FilterParameter):void
		{
			_filterQueryParameter = value;
		}
		
		/**
		 * ${iServerJava6R_DatasetExtractParams_attribute_DataReturnOption_D} 
		 * @return 
		 * 
		 */		
		public function get resultSetting():DataReturnOption
		{
			return _resultSetting;
		}
		
		public function set resultSetting(value:DataReturnOption):void
		{
			_resultSetting = value;
		}
		
		/**
		 * ${iServerJava6R_DatasetExtractParams_attribute_ExtractParamsSetting_D} 
		 * @return 
		 * 
		 */		
		public function get surfaceAnalystParametersSetting():SurfaceAnalystParametersSetting
		{
			return _surfaceAnalystParametersSetting;
		}
		
		public function set surfaceAnalystParametersSetting(value:SurfaceAnalystParametersSetting):void
		{
			_surfaceAnalystParametersSetting = value;
		}
		
		sm_internal function getVariablesJson():String
		{
			var json:String = "";
			if(this.surfaceAnalystParametersSetting)
				json += "\"extractParameter\":" + this.surfaceAnalystParametersSetting.toJson() + ",";
			else
				json += "\"extractParameter\":null,";
			
			if(this.resultSetting)
				json += "\"resultSetting\":" + this.resultSetting.toJson() + ",";
			else
				json += "\"resultSetting\":null,";
			
			if(this.filterQueryParameter)
				json += "\"filterQueryParameter\":" + this.filterQueryParameter.toJson() + ",";
			else
				json += "\"filterQueryParameter\":null,";
			
			if(this.zValueFieldName)
				json += "\"zValueFieldName\":\"" + this.zValueFieldName +  "\",";
			else
				json += "\"zValueFieldName\":\"\",";
			
			json += "\"resolution\":" + this.resolution;
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}