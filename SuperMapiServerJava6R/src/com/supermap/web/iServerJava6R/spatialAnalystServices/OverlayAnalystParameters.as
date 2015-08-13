package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.OverlayOperationType;
	/**
	 * ${iServerJava6R_OverlayAnalystParameters_Title}.
	 * <p>${iServerJava6R_OverlayAnalystParameters_Description}</p> 
	 * 
	 */	
	public class OverlayAnalystParameters
	{
		private var _operation:String = OverlayOperationType.UNION;
		
		/**
		 * ${iServerJava6R_OverlayAnalystParameters_constructor_D} 
		 * 
		 */		
		public function OverlayAnalystParameters()
		{
		}

		/**
		 * ${iServerJava6R_OverlayAnalystParameters_attribute_operation_D}.
		 * <p>${iServerJava6R_OverlayAnalystParameters_attribute_operation_remarks}</p> 
		 * @see OverlayOperationType
		 * @return 
		 * 
		 */		
		public function get operation():String
		{
			return _operation;
		}

		public function set operation(value:String):void
		{
			_operation = value;
		}

	}
}