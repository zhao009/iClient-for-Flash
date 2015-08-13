package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.FilterParameter;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_DatasetThiessenParams_Title}.
	 * <p>${iServerJava6R_DatasetThiessenParams_Description}</p> 
	 * 
	 */	
	public class DatasetThiessenAnalystParameters extends ThiessenAnalystParameters
	{
		private var _dataset:String;
		private var _filterQueryParameter:FilterParameter;
		/**
		 * ${iServerJava6R_DatasetThiessenParams_constructor_D} 
		 * 
		 */	
		public function DatasetThiessenAnalystParameters()
		{
			createResultDataset = false;
			returnResultRegion = true;
		}
		/**
		 * ${iServerJava6R_DatasetThiessenParams_attribute_filterQueryParameter_D} 
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
		 * ${iServerJava6R_DatasetThiessenParams_attribute_dataset_D} 
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
		sm_internal function getVariablesJson():String
		{
			var json:String = "";
			if(this.clipRegion)
			{
				var sg:ServerGeometry = ServerGeometry.fromGeometry(this.clipRegion);
				json += "\"clipRegion\":" + ServerGeometry.toJson(sg) + ",";
			}	
			json += "\"dataset\":\"" + this.dataset + "\",";
			json += "\"createResultDataset\":" + this.createResultDataset + ",";
			json += "\"resultDatasetName\":\"" + this.resultDatasetName + "\",";
			json += "\"resultDatasourceName\":\"" + this.resultDatasourceName + "\",";
			json += "\"returnResultRegion\":" + this.returnResultRegion + ",";
			if(this.filterQueryParameter)
				json += "\"filterQueryParameter\":"+this.filterQueryParameter.toJson();
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}