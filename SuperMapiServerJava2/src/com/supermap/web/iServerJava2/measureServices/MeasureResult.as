package com.supermap.web.iServerJava2.measureServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServer2_measureServices_measureResult_Title}.
	 * <p>${iServer2_measureServices_measureResult_Description}</p> 
	 * 
	 * 
	 */	
	public class MeasureResult
	{
		private var _distance:Number;
		private var _area:Number;
		
		/**
		 * ${iServer2_measureServices_measureResult_constructor_None_D} 
		 * 
		 */		
		public function MeasureResult()
		{
		}
		
		/**
		 * ${iServer2_measureServices_measureResult_attribute_distance_D} 
		 * @return 
		 * 
		 */		
		public function get distance():Number
		{
			return this._distance;
		}
		
		/**
		 * ${iServer2_measureServices_measureResult_attribute_area_D} 
		 * @return 
		 * 
		 */		
		public function get area():Number
		{
			return this._area;
		}
		
		sm_internal static function toMeasureResult(object:Object):MeasureResult
		{
			var measureResult:MeasureResult;
			if(object)
			{
				measureResult = new MeasureResult();
				measureResult._area = (Number)(object.area);
				measureResult._distance = (Number)(object.distance);
			}
			return measureResult;
		}
		
	}
}