package com.supermap.web.core
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_PointWithMeasure_Title}.
	 * <P>${iServerJava6R_PointWithMeasure_Description}</P> 
	 * 
	 */	
	public class PointWithMeasure extends Point2D
	{
		//--------------------------------------------------------------------------
		//
		//  PointWithMeasure 参照silverlight
		//
		//--------------------------------------------------------------------------
		 
		private var _measure:Number = 0;
		/**
		 * ${iServerJava6R_PointWithMeasure_constructor_D} 
		 * 
		 */		
		public function PointWithMeasure(x:Number = 0, y:Number = 0, measuer:Number = 0)
		{
			super(x, y);
			if(!isNaN(measuer))
			{
				this._measure=measuer;
			}
		}
		
		/**
		 * ${iServerJava6R_Route_attribute_measure_D}
		 */
		public function get measure():Number
		{
			return _measure;
		}
 
		sm_internal static function fromJson(json:Object):PointWithMeasure
		{ 
			if(json)
			{
				var pointWidthMeasure:PointWithMeasure = new PointWithMeasure(json.x, json.y, json.measure);
				return pointWidthMeasure;
			}
			return null; 
		}
		
		sm_internal function toString():String
		{
			return "[ x: " + this.x +", y: "+ this.y +", measure:"+ this._measure + "]";
		}
	}
}