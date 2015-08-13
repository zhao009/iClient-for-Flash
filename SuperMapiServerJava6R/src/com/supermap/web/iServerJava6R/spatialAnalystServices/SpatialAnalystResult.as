package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_SpatialAnalystResult_Title}.
	 * <p>${iServerJava6R_SpatialAnalystResult_Description}</p> 
	 * 
	 */	
	public class SpatialAnalystResult
	{
		private var _succeed:Boolean;
		private var _errorMsg:String;
		
		/**
		 * ${iServerJava6R_SpatialAnalystResult_constructor_D} 
		 * 
		 */		
		public function SpatialAnalystResult()
		{
			
		}

		/**
		 * ${iServerJava6R_SpatialAnalystResult_attribute_errorMsg_D}.
		 * <p>${iServerJava6R_SpatialAnalystResult_attribute_errorMsg_remarks}</p> 
		 * @see #succeed
		 * @return 
		 * 
		 */		
		public function get errorMsg():String
		{
			return _errorMsg;
		}

		sm_internal function setErrorMsgValue(value:String):void
		{
			_errorMsg = value;
		}
		
		/**
		 * ${iServerJava6R_SpatialAnalystResult_attribute_succeed_D} 
		 * @return 
		 * 
		 */	
		public function get succeed():Boolean
		{
			return _succeed;
		}
		
		sm_internal function setSucceedValue(value:Boolean):void
		{
			_succeed = value;
		}


	}
}