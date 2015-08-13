package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;

	/**
	 * ${iServerJava6R_InterpolationDensityAnalystParameters_Title}.
	 * <p>${iServerJava6R_InterpolationDensityAnalystParameters_Description}</p> 
	 * @see InterpolationAnalystService
	 * 
	 */	
	public class InterpolationDensityAnalystParameters extends InterpolationAnalystParameters
	{

		/**
		 * ${iServerJava6R_InterpolationDensityAnalystParameters_constructor_D} 
		 * 
		 */		
		public function InterpolationDensityAnalystParameters()
		{
		}
		
		override sm_internal function getVariablesJson():String
		{
			var json:String = "";
			
			json += "\"searchRadius\":" + this.searchRadius + ",";
			
			json += "\"pixelFormat\":\"" + this.pixelFormat + "\",";
			
			json += "\"zValueFieldName\":\"" + this.zValueFieldName + "\",";
			
			json += "\"zValueScale\":" + this.zValueScale + ",";
			
			json += "\"resolution\":" + this.resolution + ",";
			
			json += "\"bounds\":" + this.fromRectangle2D(this.bounds) + ",";
			
			if(this.filterQueryParameter)
				json += "\"filterQueryParameter\":" + this.filterQueryParameter.toJson() + ",";
			
			json += "\"outputDatasetName\":\"" + this.outputDatasetName + "\",";			
			
			json += "\"outputDatasourceName\":\"" + this.outputDatasourceName + "\",";
			
			if(this.clipParam)
				json += "\"clipParam\":\"" + this.clipParam.toJSON() + "\",";
			
			json += "\"inputPoints\":" + this.fromInputPoints(this.inputPoints);
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}