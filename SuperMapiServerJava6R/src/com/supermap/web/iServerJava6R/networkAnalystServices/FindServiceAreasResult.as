package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ServiceAreasResult_Title}.
	 * <p>${iServerJava6R_ServiceAreasResult_Description}</p> 
	 * 
	 */	
	public class FindServiceAreasResult
	{
		//服务区分析结果类
		
		private var _serviceAreaList:Array;
		
		/**
		 * ${iServerJava6R_ServiceAreasResult_constructor_D} 
		 * 
		 */		
		public function FindServiceAreasResult()
		{
		}
		
		/**
		 * ${iServerJava6R_ServiceAreasResult_attribute_ServiceAreaList_D}.
		 * <p>${iServerJava6R_ServiceAreasResult_attribute_ServiceAreaList_remarks}</p> 
		 * @see ServiceArea
		 * @return 
		 * 
		 */		
		public function get serviceAreaList():Array
		{
			return _serviceAreaList;
		}
 
		sm_internal static function fromJson(json:Object):FindServiceAreasResult
		{
			if (!json)
				return null; 
			var result:FindServiceAreasResult = new FindServiceAreasResult();
 
			if (json.serviceAreaList && (json.serviceAreaList as Array).length > 0)
			{ 
				result._serviceAreaList = [];
				var serviceAreaListLength:int = (json.serviceAreaList as Array).length;
				for (var i:int = 0; i < serviceAreaListLength; i++)
				{
					result._serviceAreaList.push(ServiceArea.fromJson(json.serviceAreaList[i]));
				}
			}
			
			return result;
		}
	}
}