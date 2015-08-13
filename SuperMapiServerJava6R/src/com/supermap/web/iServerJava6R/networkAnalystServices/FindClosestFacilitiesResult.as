package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ClosestFacilityResult_Title}.
	 * <p>${iServerJava6R_ClosestFacilityResult_Description}</p> 
	 * @see FindClosestFacilitiesParameters
	 * 
	 */	
	public class FindClosestFacilitiesResult
	{ 
		//--------------------------------------------------------------------------
		//
		//  查找最近设施结果
		//
		//--------------------------------------------------------------------------
		 
		private var _facilityPathList:Array;
		/**
		 * ${iServerJava6R_ClosestFacilityResult_constructor_D} 
		 * 
		 */		
		public function FindClosestFacilitiesResult()
		{
		}
		
		/**
		 * ${iServerJava6R_ClosestFacilityResult_attribute_facilityPathList_D}.
		 * <p>${iServerJava6R_ClosestFacilityResult_attribute_facilityPathList_remarks}</p> 
		 * @see ClosestFacilityPath
		 * @return 
		 * 
		 */		
		public function get facilityPathList():Array
		{
			return _facilityPathList;
		}
 
		sm_internal static function fromJson(json:Object):FindClosestFacilitiesResult
		{
			if (json)
			{
				var result:FindClosestFacilitiesResult = new FindClosestFacilitiesResult(); 
				if (json.facilityPathList)
				{
					result._facilityPathList = [];
					var facilityPathListLength:int = (json.facilityPathList as Array).length;
					for (var i:int = 0; i < facilityPathListLength; i++)
					{
						result._facilityPathList.push(ClosestFacilityPath.fromJson(json.facilityPathList[i]));
					}
				} 
				return result;
			} 
			return null;
		}
	}
}