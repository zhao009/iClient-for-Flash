package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.utils.serverTypes.ServerFeature;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_GeoRelationResult_Title}.
	 * 
	 */	
	public class GeoRelationResult
	{
		private var _result:Array;
		private var _count:int;
		private var _source:Object;
		/**
		 * ${iServerJava6R_GeoRelationResult_constructor_D} 
		 * 
		 */
		public function GeoRelationResult()
		{
		}
		/**
		 * ${iServerJava6R_GeoRelationResult_attribute_result_D} 
		 * @return 
		 * 
		 */	
		public function get result():Array
		{
			return _result;
		}
		/**
		 * ${iServerJava6R_GeoRelationResult_attribute_count_D} 
		 * @return 
		 * 
		 */	
		public function get count():int
		{
			return _count;
		}
		/**
		 * ${iServerJava6R_GeoRelationResult_attribute_source_D} 
		 * @return 
		 * 
		 */	
		public function get source():Object
		{
			return _source;
		}

		sm_internal static function toGeoRelationResult(object:Object):GeoRelationResult
		{
			var geoRelationResult:GeoRelationResult;
			if(object)
			{
				geoRelationResult = new GeoRelationResult();
				geoRelationResult._count = object.count;
				if(object.source is int)
				{//返回结果result为ID组成的数组
					geoRelationResult._source = object.source as int;
					geoRelationResult._result = object.result as Array;
				}
				else
				{//返回结果result为Feature数组
					var serverFeature:ServerFeature = ServerFeature.fromJson(object.source);
					geoRelationResult._source = ServerFeature.toFeature(serverFeature);
					
					var arr:Array = object.result as Array;
					var results:Array = [];
					for(var i:int = 0;i<arr.length;i++)
					{
						var serF:ServerFeature = ServerFeature.fromJson(arr[i]);
						results.push(ServerFeature.toFeature(serF));
					}
					geoRelationResult._result = results;
				}
			}
			return geoRelationResult;
		}
	}
}