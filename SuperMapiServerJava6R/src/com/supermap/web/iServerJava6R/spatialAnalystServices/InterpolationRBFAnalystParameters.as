package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_InterpolationRBFAnalystParameters_Title}.
	 * <p>${iServerJava6R_InterpolationRBFAnalystParameters_Description}</p> 
	 * @see InterpolationAnalystService
	 * 
	 */	
	public class InterpolationRBFAnalystParameters extends InterpolationAnalystParameters
	{
		//定义参数
		private var _searchMode:String = SearchMode.NONE;
		private var _expectedCount:int = 12;		
		private var _smooth:Number = 0.1;
		private var _tension:Number = 40;		
		private var _maxPointCountForInterpolation:int = 200;
		private var _maxPointCountInNode:int = 50;
		
		/**
		 * ${iServerJava6R_InterpolationRBFAnalystParameters_constructor_D} 
		 * 
		 */	
		public function InterpolationRBFAnalystParameters()
		{
		}
		
		/**
		 * ${iServerJava6R_InterpolationRBFAnalystParameters_attribute_searchMode_D} 
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
		 * ${iServerJava6R_InterpolationRBFAnalystParameters_attribute_expectedCount_D}
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
			
		/**
		 * ${iServerJava6R_InterpolationRBFAnalystParameters_attribute_smooth_D} 
		 * @return 
		 * 
		 */	
		public function get smooth():Number
		{
			return _smooth;
		}
		public function set smooth(value:Number):void
		{
			_smooth = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationRBFAnalystParameters_attribute_tension_D} 
		 * @return 
		 * 
		 */
		public function get tension():Number
		{
			return _tension;
		}
		public function set tension(value:Number):void
		{
			_tension = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationRBFAnalystParameters_attribute_maxPointCountForInterpolation_D}
		 * @return
		 */
		public function get maxPointCountForInterpolation():int
		{
			return _maxPointCountForInterpolation;
		}
		public function set maxPointCountForInterpolation(value:int):void
		{
			_maxPointCountForInterpolation = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationRBFAnalystParameters_attribute_maxPointCountInNode_D}
		 * @return
		 */
		public function get maxPointCountInNode():int
		{
			return _maxPointCountInNode;
		}
		public function set maxPointCountInNode(value:int):void
		{
			_maxPointCountInNode = value;
		}
		
		//覆盖父类方法
		override sm_internal function getVariablesJson():String
		{
			var json:String = "";
			
			json += "\"smooth\":" + this.smooth + ",";
			
			json += "\"tension\":" + this.tension + ",";
			
			json += "\"bounds\":" + this.fromRectangle2D(this.bounds) + ",";
			
			json += "\"outputDatasourceName\":\"" + this.outputDatasourceName + "\",";
			
			if(this.clipParam)
				json += "\"clipParam\":\"" + this.clipParam.toJSON() + "\",";
			
			json += "\"searchMode\":\"" + this.searchMode + "\",";
			
			json += "\"expectedCount\":" + this.expectedCount + ",";
			
			json += "\"searchRadius\":" + this.searchRadius + ",";
			
			json += "\"maxPointCountForInterpolation\":" + this.maxPointCountForInterpolation + ",";
			
			json += "\"maxPointCountInNode\":" + this.maxPointCountInNode + ",";
			
			json += "\"zValueFieldName\":\"" + this.zValueFieldName + "\",";
			
			json += "\"zValueScale\":" + this.zValueScale + ",";
			
			json += "\"resolution\":" + this.resolution + ",";
			
			if(this.filterQueryParameter)
				json += "\"filterQueryParameter\":" + this.filterQueryParameter.toJson() + ",";
			
			json += "\"outputDatasetName\":\"" + this.outputDatasetName + "\",";
			
			json += "\"pixelFormat\":\"" + this.pixelFormat + "\",";	
			
			json += "\"inputPoints\":" + this.fromInputPoints(this.inputPoints);
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}