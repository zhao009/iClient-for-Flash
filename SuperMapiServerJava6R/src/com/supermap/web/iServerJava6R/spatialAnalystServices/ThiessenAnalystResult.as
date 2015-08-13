package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ThiessenAnalystResult_Title}.
	 * 
	 */	
	public class ThiessenAnalystResult extends SpatialAnalystResult
	{
		private var _datasetName:String;
		private var _datasourceName:String;
		private var _regions:Array;
		/**
		 * ${iServerJava6R_ThiessenAnalystResult_constructor_D} 
		 * 
		 */	
		public function ThiessenAnalystResult()
		{
			super();
		}

		/**
		 * ${iServerJava6R_ThiessenAnalystResult_attribute_datasetName_D} 
		 * @return 
		 * 
		 */	
		public function get datasetName():String
		{
			return _datasetName;
		}

		/**
		 * ${iServerJava6R_ThiessenAnalystResult_attribute_datasourceName_D} 
		 * @return 
		 * 
		 */	
		public function get datasourceName():String
		{
			return _datasourceName;
		}

		/**
		 * ${iServerJava6R_ThiessenAnalystResult_attribute_regions_D} 
		 * @return 
		 * 
		 */	
		public function get regions():Array
		{
			return _regions;
		}
		
		sm_internal static function fromJson(object:Object):ThiessenAnalystResult
		{
			var result:ThiessenAnalystResult;
			if(object)
			{
				result = new ThiessenAnalystResult();

				if(object.datasetName || object.datasourceName || object.regions)
				{
					result._datasetName = object.datasetName;
					result._datasourceName = object.datasourceName;
					if(object.regions)
					{
						var arr:Array = object.regions as Array;
						result._regions = [];
						for(var i:int = 0;i<arr.length;i++)
						{
							var servergeo:ServerGeometry = ServerGeometry.fromJson(arr[i]);
							var geoRegion:GeoRegion = servergeo.toGeoRegion();
							result._regions.push(geoRegion);
						}
					}
					result.setSucceedValue(true);
				}
				else
				{
					result.setSucceedValue(object.succeed);
					result.setErrorMsgValue(object.error.errorMsg);
				}
			}
			return result;
		}
	}
}