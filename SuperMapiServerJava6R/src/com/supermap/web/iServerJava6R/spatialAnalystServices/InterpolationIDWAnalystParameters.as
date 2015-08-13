package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_InterpolationIDWAnalystParameters_Title}.
	 * <p>${iServerJava6R_InterpolationIDWAnalystParameters_Description}</p> 
	 * @see InterpolationAnalystService
	 * 
	 */	
	public class InterpolationIDWAnalystParameters extends InterpolationAnalystParameters
	{
		
		//定义参数
		private var _power:int = 2;
		private var _searchMode:String = SearchMode.NONE;
		private var _expectedCount:int = 12;
		
		/**
		 * ${iServerJava6R_InterpolationIDWAnalystParameters_constructor_D} 
		 * 
		 */	
		public function InterpolationIDWAnalystParameters()
		{	
		}
		
		/**
		 * ${iServerJava6R_InterpolationIDWAnalystParameters_attribute_power_D} 
		 * @return 
		 * 
		 */		
		public function get power():int
		{
			return _power;
		}		
		public function set power(value:int):void
		{
			_power = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationIDWAnalystParameters_attribute_searchMode_D} 
		 * @see SearchMode
		 * @return 
		 * 
		 */		
		public function get searchMode():String
		{
			return _searchMode;
		}
		
		public function set searchMode(value:String):void
		{
			_searchMode = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationIDWAnalystParameters_attribute_expectedCount_D}
		 * @return
		 */
		public function get expectedCount():int
		{
			return _expectedCount;
		}
		public function set expectedCount(value:int):void
		{
			_expectedCount = value;
		}
		
		//覆盖父类方法，添加新的属性值
		override sm_internal function getVariablesJson():String
		{
			var json:String = "";
			
			json += "\"power\":" + this.power + ",";
			
			json += "\"bounds\":" + this.fromRectangle2D(this.bounds) + ",";
			
			json += "\"searchMode\":\"" + this.searchMode + "\",";
			
			json += "\"expectedCount\":" + this.expectedCount + ",";
			
			json += "\"searchRadius\":" + this.searchRadius + ",";
			
			json += "\"zValueFieldName\":\"" + this.zValueFieldName + "\",";
			
			json += "\"zValueScale\":" + this.zValueScale + ",";
			
			json += "\"resolution\":" + this.resolution + ",";
			
			if(this.filterQueryParameter)
				json += "\"filterQueryParameter\":" + this.filterQueryParameter.toJson() + ",";
			
			json += "\"outputDatasetName\":\"" + this.outputDatasetName + "\",";
			
			json += "\"outputDatasourceName\":\"" + this.outputDatasourceName + "\",";
			
			if(this.clipParam)
				json += "\"clipParam\":\"" + this.clipParam.toJSON() + "\",";
			
			json += "\"pixelFormat\":\"" + this.pixelFormat + "\",";
						
			json += "\"inputPoints\":" + this.fromInputPoints(this.inputPoints);
			
			json =  "{" + json + "}";
			
			return json;
		}
		
	}
}