package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;	
	
	/**
	 * ${iServerJava6R_InterpolationKrigingAnalystParameters_Title}.
	 * <p>${iServerJava6R_InterpolationKrigingAnalystParameters_Description}</p> 
	 * @see InterpolationAnalystService
	 * 
	 */	
	public class InterpolationKrigingAnalystParameters extends InterpolationAnalystParameters
	{
		//定义参数
		private var _searchMode:String = SearchMode.NONE;
		private var _expectedCount:int = 12;
		private var _maxPointCountForInterpolation:int = 200;
		private var _maxPointCountInNode:int = 50;
		private var _type:String;
		private var _mean:Number;
		private var _angle:Number = 0;
		private var _nugget:Number = 0;
		private var _range:Number = 0;
		private var _sill:Number = 0;
		private var _variogramMode:String = VariogramMode.SPHERICAL;
		private var _exponent:String = Exponent.EXP1;
			
		/**
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_constructor_D} 
		 * 
		 */	
		public function InterpolationKrigingAnalystParameters()
		{
		}
		
		/**
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_searchMode_D} 
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
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_expectedCount_D} 
		 * @return 
		 * 
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
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_maxPointCountForInterpolation_D} 
		 * @return 
		 * 
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
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_maxPointCountInNode_D} 
		 * @return 
		 * 
		 */
		public function get maxPointCountInNode():int
		{
			return _maxPointCountInNode;
		}
		public function set maxPointCountInNode(value:int):void
		{
			_maxPointCountInNode = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_type_D} 
		 * @return 
		 * 
		 */	
		public function get type():String
		{
			return _type;
		}
		public function set type(value:String):void
		{
			_type = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_mean_D} 
		 * @return 
		 * 
		 */	
		public function get mean():Number
		{
			return _mean;
		}
		public function set mean(value:Number):void
		{
			_mean = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_angle_D} 
		 * @return 
		 * 
		 */	
		public function get angle():Number
		{
			return _angle;
		}
		public function set angle(value:Number):void
		{
			_angle = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_nugget_D} 
		 * @return 
		 * 
		 */	
		public function get nugget():Number
		{
			return _nugget;
		}
		public function set nugget(value:Number):void
		{
			_nugget = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_range_D} 
		 * @return 
		 * 
		 */
		public function get range():Number
		{
			return _range;
		}
		public function set range(value:Number):void
		{
			_range = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_sill_D} 
		 * @return 
		 * 
		 */
		public function get sill():Number
		{
			return _sill;
		}
		public function set sill(value:Number):void
		{
			_sill = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_variogramMode_D} 
		 * @see VariogramMode
		 * @return 
		 * 
		 */
		public function get variogramMode():String
		{
			return _variogramMode;
		}
		public function set variogramMode(value:String):void
		{
			_variogramMode = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationKrigingAnalystParameters_attribute_exponent_D} 
		 * @see Exponent
		 * @return 
		 * 
		 */
		public function get exponent():String
		{
			return _exponent;
		}
		public function set exponent(value:String):void
		{
			_exponent = value;
		}
		
		//覆盖父类方法
		override sm_internal function getVariablesJson():String
		{
			var json:String = "";
			
			json += "\"type\":" + this.type + ",";
			
			json += "\"mean\":" + this.mean + ",";
			
			json += "\"angle\":" + this.angle + ",";
			
			json += "\"nugget\":" + this.nugget + ",";
			
			json += "\"range\":" + this.range + ",";
			
			json += "\"sill\":" + this.sill + ",";
			
			json += "\"variogramMode\":\"" + this.variogramMode + "\",";
			
			json += "\"exponent\":\"" + this.exponent + "\",";
			
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