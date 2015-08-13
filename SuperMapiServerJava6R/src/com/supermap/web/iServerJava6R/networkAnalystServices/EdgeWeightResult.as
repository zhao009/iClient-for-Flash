package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.sm_internal;
    use namespace sm_internal;
	/**
	 * ${iServerJava6R_EdgeWeightResult_Title}.
	 * <p>${iServerJava6R_EdgeWeightResult_Description}</p> 
	 * @see UpdateEdgeWeightService
	 * 
	 */	
	public class EdgeWeightResult
	{
		
		private var _succeed:Boolean;
		
		private var _code:int;
		
		private var _errorMsg:String;
		
		/**
		 * ${iServerJava6R_EdgeWeightResult_constructor_D} 
		 * 
		 */		
		public function EdgeWeightResult()
		{
		}
		
		/**
		 * ${iServerJava6R_EdgeWeightResult_attribute_succeed_D} 
		 * @return 
		 * 
		 */		
		public function get succeed():Boolean
		{
			return _succeed;
		}
		/**
		 * ${iServerJava6R_EdgeWeightResult_attribute_code_D} 
		 * @return 
		 * 
		 */ 		
		public function get code():int
		{
			return _code;
		}
		/**
		 * ${iServerJava6R_EdgeWeightResult_attribute_details_D}  
		 * @return 
		 * 
		 */		
		public function get errorMsg():String
		{
			return _errorMsg;
		}
		
		/**
		 * @private 
		 * @param json
		 * @return 
		 * 
		 */		
		public static function fromJson(json:Object) : EdgeWeightResult
		{
			var result:EdgeWeightResult = new EdgeWeightResult();
			if (json == null)
			{
				return null;
			}
			else
			{
				result._succeed = json["succeed"];
				if(json["error"])
				{
					result._errorMsg = json["error"].errorMsg;
					result._code = json["error"].code;
				}
			}
			return result;
		}
	}
}