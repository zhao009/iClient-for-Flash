package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ClosestFacilityPath_Title}.
	 * <p>${iServerJava6R_ClosestFacilityPath_Description}</p> 
	 * 
	 */	
	public class ClosestFacilityPath extends Path
	{ 
		//--------------------------------------------------------------------------
		//
		//  最近设施
		//
		//--------------------------------------------------------------------------
		
		private var _facility:Object;
		private var _facilityIndex:int;
		/**
		 * ${iServerJava6R_ClosestFacilityPath_constructor_D} 
		 * 
		 */		
		public function ClosestFacilityPath()
		{
			super();
		}
		/**
		 * ${iServerJava6R_ClosestFacilityPath_attribute_FacilityIndex_D} 
		 * @see FindClosestFacilitiesParameters#facilities
		 * @return 
		 * 
		 */		 
		public function get facilityIndex():int
		{
			return _facilityIndex;
		}

		public function set facilityIndex(value:int):void
		{
			_facilityIndex = value;
		}

		/**
		 * ${iServerJava6R_ClosestFacilityPath_attribute_Facility_D}.
		 * <p>${iServerJava6R_ClosestFacilityPath_attribute_Facility_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get facility():Object
		{
			return _facility;
		}

		public function set facility(value:Object):void
		{
			_facility = value;
		}
		
		/**
		 * ${iServerJava6R_ClosestFacilityPath_method_fromJson_D} 
		 * @param json ${iServerJava6R_ClosestFacilityPath_method_fromJson_param_jsonObject}
		 * @return ${iServerJava6R_ClosestFacilityPath_method_fromJson_return}
		 * 
		 */		
		sm_internal static function fromJson(json:Object):ClosestFacilityPath
		{
			if (json)
			{
				var result:ClosestFacilityPath  = new ClosestFacilityPath();
				
				if (json.facility is int)
				{
					result.facility = int(json.facility);
				}
				else if(json.facility is Object)
				{
					result.facility =  JsonUtil.toPoint2D(json.facility);
				}
				result.facilityIndex = json.facilityIndex;
				
				//对应父类中的属性； 
				var path:Path = Path.fromJson(json); 
				result.edgeFeatures = path.edgeFeatures;
				result.edgeIDs = path.edgeIDs;
				result.nodeFeatures = path.nodeFeatures;
				result.nodeIDs = path.nodeIDs;
				result.pathGuideItems = path.pathGuideItems;
				result.route = path.route;
				result.stopWeights = path.stopWeights;
				result.weight = path.weight;
				
				return result;
			}
			return null;
		}   
	}
}


