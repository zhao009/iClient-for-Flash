package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ChartFeatureInfoSpecsResult_Title}.
	 * <p>${iServerJava6R_ChartFeatureInfoSpecsResult_Description}</p> 
	 * @see ChartFeatureInfoSpec
	 */	
	public class ChartFeatureInfoSpecsResult
	{
		/**
		 * ${iServerJava6R_ChartFeatureInfoSpecsResult_Constructor_D} 
		 * 
		 */	
		public function ChartFeatureInfoSpecsResult()
		{
		}
		
		private var _chartFeatureInfoSpecs:Array;
		
		/**
		 * ${iServerJava6R_ChartFeatureInfoSpecsResult_attribute_chartFeatureInfoSpecs_D} 
		 * 
		 */	
		public function get chartFeatureInfoSpecs():Array
		{
			return _chartFeatureInfoSpecs;
		}
		
		sm_internal static function fromJson(json:Object):ChartFeatureInfoSpecsResult
		{
			if(json == null)
			{
				return null;
			}
			
			var result:ChartFeatureInfoSpecsResult = new ChartFeatureInfoSpecsResult();
			
			var chartFeatures:Array = [];
			
			for each (var item:Object in json)
			{
				chartFeatures.push(ChartFeatureInfoSpec.fromJson(item));
			}
			
			result._chartFeatureInfoSpecs = chartFeatures;
			return result;
		}
		
	}
}