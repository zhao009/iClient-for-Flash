package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_RouteCalculateMeasureResult_Title}.
	 * 
	 */	
	public class RouteCalculateMeasureResult extends SpatialAnalystResult
	{
		private var _measure:Number;
		private var _message:String;
		
		/**
		 * ${iServerJava6R_RouteCalculateMeasureResult_constructor_D} 
		 * 
		 */	
		public function RouteCalculateMeasureResult()
		{
			super();
		}
		
		/**
 		 * ${iServerJava6R_RouteCalculateMeasureResult_attribute_measure_D} 
 		 * @return 
 		 * 
 		 */	
		public function get measure():Number
		{
			return _measure;
		}

		public function set measure(value:Number):void
		{
			_measure = value;
		}

		/**
		 * ${iServerJava6R_RouteCalculateMeasureResult_attribute_message_D} 
		 * @return 
		 * 
		 */	
		public function get message():String
		{
			return _message;
		}

		public function set message(value:String):void
		{
			_message = value;
		}

		sm_internal static function fromJson(object:Object):RouteCalculateMeasureResult
		{
			var result:RouteCalculateMeasureResult;
			if(object)
			{
				result = new RouteCalculateMeasureResult();
				result.setSucceedValue(object.succeed);
				result.measure = object.measure;
				result.message = object.message;
			}
			return result;
		}
	}
}