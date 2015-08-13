package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_FindLocationAnalystResult_Title}.
	 * <p>${iServerJava6R_FindLocationAnalystResult_Description}</p>
	 * @see FindLocationService 
	 * 
	 */	
	public class FindLocationResult
	{
		 
		private var _demandResults:Array;
		private var _supplyResults:Array;
		
		/**
		 * ${iServerJava6R_FindLocationAnalystResult_constructor_D} 
		 * 
		 */		
		public function FindLocationResult()
		{
		}
		
		/**
		 * ${iServerJava6R_FindLocationAnalystResult_attribute_SupplyResults_D}
		 * @see SupplyResult 
		 * @return 
		 * 
		 */		
		public function get supplyResults():Array
		{
			return _supplyResults;
		}
 
		/**
		 * ${iServerJava6R_FindLocationAnalystResult_attribute_DemandResults_D}
		 * @see DemandResult 
		 * @return 
		 * 
		 */		
		public function get demandResults():Array
		{
			return _demandResults;
		}
 
		sm_internal static function fromJson(json:Object):FindLocationResult
		{
			if (json == null)
				return null;
			
			var result:FindLocationResult = new FindLocationResult(); 
			
			if (json.demandResults && (json.demandResults as Array).length)
			{ 
				result._demandResults = [];
				var demandResultsLength:int = (json.demandResults as Array).length;
				for (var i:int = 0; i < demandResultsLength; i++)
				{
					result._demandResults.push(DemandResult.fromJson(json.demandResults[i]));
				}
			}
			if (json.supplyResults && (json.supplyResults as Array).length)
			{ 
				result._supplyResults = [];
				var supplyResultsLength:int = (json.supplyResults as Array).length;
				for (i = 0; i < supplyResultsLength; i++)
				{
					result._supplyResults.push(SupplyResult.fromJson(json.supplyResults[i]));
				}
			}
			
			return result;
		}
	}
}