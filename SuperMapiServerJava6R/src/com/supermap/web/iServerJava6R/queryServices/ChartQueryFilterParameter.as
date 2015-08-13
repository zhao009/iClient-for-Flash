package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ChartQueryParam_Tile}.
	 * <p>${iServerJava6R_ChartQueryParam_Description}</p> 
	 * 
	 */	
	public class ChartQueryFilterParameter
	{
		private var _isQueryPoint:Boolean;
		private var _isQueryLine:Boolean;
		private var _isQueryRegion:Boolean;
		private var _attributeFilter:String;
		private var _chartFeatureInfoSpecCode:int;
		
		/**
		 * ${iServerJava6R_ChartQueryParam_constructor_None_D} 
		 * 
		 */	
		public function ChartQueryFilterParameter()
		{
		}

		/**
		 * ${iServerJava6R_ChartQueryParam_attribute_isQueryPoint_D}
		 * 
		 */	
		public function get isQueryPoint():Boolean
		{
			return _isQueryPoint;
		}

		public function set isQueryPoint(value:Boolean):void
		{
			_isQueryPoint = value;
		}
		/**
		 * ${iServerJava6R_ChartQueryParam_attribute_isQueryLine_D}
		 * 
		 */	
		public function get isQueryLine():Boolean
		{
			return _isQueryLine;
		}

		public function set isQueryLine(value:Boolean):void
		{
			_isQueryLine = value;
		}
		/**
		 * ${iServerJava6R_ChartQueryParam_attribute_isQueryRegion_D}
		 * 
		 */	
		public function get isQueryRegion():Boolean
		{
			return _isQueryRegion;
		}

		public function set isQueryRegion(value:Boolean):void
		{
			_isQueryRegion = value;
		}
		/**
		 * ${iServerJava6R_ChartQueryParam_attribute_attributeFilter_D}
		 * 
		 */	
		public function get attributeFilter():String
		{
			return _attributeFilter;
		}

		public function set attributeFilter(value:String):void
		{
			_attributeFilter = value;
		}
		/**
		 * ${iServerJava6R_ChartQueryParam_attribute_chartFeatureInfoSpecCode_D}
		 * @see ChartFeatureInfoSpecsService
		 * @see ChartFeatureInfoSpec
		 */	
		public function get chartFeatureInfoSpecCode():int
		{
			return _chartFeatureInfoSpecCode;
		}

		public function set chartFeatureInfoSpecCode(value:int):void
		{
			_chartFeatureInfoSpecCode = value;
		}
		
		sm_internal function toJson():String
		{
			var json:String = "";		
			
			json += "\"isQueryPoint\":" + this.isQueryPoint + ",";
			json += "\"isQueryLine\":" + this.isQueryLine + ",";
			json += "\"isQueryRegion\":" + this.isQueryRegion + ",";
			if(this.attributeFilter)
				json += "\"attributeFilter\": \""+this.attributeFilter+"\",";
			json += "\"chartFeatureInfoSpecCode\":" + this.chartFeatureInfoSpecCode;
			json ="{" + json + "}";
			
			return json;
		}
		
	}
}