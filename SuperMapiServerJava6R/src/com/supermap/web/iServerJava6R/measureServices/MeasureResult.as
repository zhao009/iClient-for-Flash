package com.supermap.web.iServerJava6R.measureServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_MeasureResult_Tile}. 
	 * <p>${iServerJava6R_MeasureResult_Description}</p>
	 * 
	 */
	public class MeasureResult
	{
		private var _distance:Number;
		private var _area:Number;
		private var _unit:String;
		
		
		/**
		 * ${iServerJava6R_MeasureResult_constructor_D_as} 
		 * 
		 */
		public function MeasureResult()
		{
		}
		
		/**
		 * ${iServerJava6R_MeasureResult_attribute_Distance_D} 
		 * 
		 */
		public function get distance():Number
		{
			return this._distance;
		}
		
		/**
		 * ${iServerJava6R_MeasureResult_attribute_Area_D} 
		 * 
		 */
		public function get area():Number
		{
			return this._area;
		}
		
		/**
		 * ${iServerJava6R_MeasureResult_attribute_Unit_D} 
		 * 
		 */
		public function get unit():String
		{
			return this._unit;
		}
		
		sm_internal static function toMeasureResult(object:Object):MeasureResult
		{
			var measureResult:MeasureResult;
			if(object)
			{
				measureResult = new MeasureResult();
				measureResult._area = (Number)(object.area);
				measureResult._distance = (Number)(object.distance);
				measureResult._unit = object.unit;
			}
			return measureResult;
		}
		
	}
}