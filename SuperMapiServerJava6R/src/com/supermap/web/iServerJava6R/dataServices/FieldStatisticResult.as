package com.supermap.web.iServerJava6R.dataServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_FieldStatisticResult_Title}.
	 * <p>${iServerJava6R_FieldStatisticResult_Description}</p> 
	 * 
	 */	
	public class FieldStatisticResult
	{
		private var _succeed:Boolean;
		
		private var _mode:String;
		
		private var _result:Number;
		
		/**
		 * ${iServerJava6R_FieldStatisticResult_constructor_D} 
		 * 
		 */		
		public function FieldStatisticResult()
		{
		}
		
		/**
		 * ${iServerJava6R_FieldStatisticResult_attribute_mode_D} 
		 * @return 
		 * 
		 */		
		public function get mode():String
		{
			return _mode;
		}
		
		/**
		 * ${iServerJava6R_FieldStatisticResult_attribute_result_D} 
		 * @return 
		 * 
		 */		
		public function get result():Number
		{
			return _result;
		}
		
		/**
		 * ${iServerJava6R_FieldStatisticResult_attribute_succeed_D} 
		 * @return 
		 * 
		 */		
		public function get succeed():Boolean
		{
			return _succeed;
		}
		
		/**
		 * @private 
		 * @param json
		 * @return 
		 * 
		 */		
		public static function fromJson(json:Object) : FieldStatisticResult
		{
			if (json == null)
				return null;
			
			var result:FieldStatisticResult = new FieldStatisticResult();			
			
			result._succeed = true;
			result._mode = json.mode;
			result._result = json.result;
			
			return result;
		}
	}
}