package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_DatasetGeoReAnalystResult_Title}.
	 * <p>${iServerJava6R_DatasetGeoReAnalystResult_Description}</p> 
	 * @see GeoRelationResult
	 * 
	 */	
	public class GeoRelationAnalystResult
	{
		private var _geoRelationResults:Array = [];
		/**
		 * ${iServerJava6R_DatasetGeoReAnalystResult_constructor_D} 
		 * 
		 */
		public function GeoRelationAnalystResult()
		{
		}
		/**
		 * ${iServerJava6R_DatasetGeoReAnalystResult_attribute_geoRelationResults_D} 
		 * @return 
		 * 
		 */	
		public function get geoRelationResults():Array
		{
			return _geoRelationResults;
		}
		
		sm_internal static function toGeoRelationResults(object:Object):GeoRelationAnalystResult
		{
			var result:GeoRelationAnalystResult;
			if(object)
			{
				result = new GeoRelationAnalystResult();
				var arr:Array = object as Array;
				for(var i:int = 0;i<arr.length;i++)
				{
					var geoRelationResult:GeoRelationResult = GeoRelationResult.toGeoRelationResult(arr[i]);
					result._geoRelationResults.push(geoRelationResult);
				}
				
			}
			return result;
		}

	}
}