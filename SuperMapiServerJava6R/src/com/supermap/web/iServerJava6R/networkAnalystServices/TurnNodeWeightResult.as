package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_TurnNodeWeightResult_Title}.
	 * <p>${iServerJava6R_TurnNodeWeightResult_Description}</p> 
	 * 
	 */	
	public class TurnNodeWeightResult
	{ 
		private var _succeed:Boolean;
		private var _code:int;
		private var _errorMsg:String;
		
		/**
		 * ${iServerJava6R_TurnNodeWeightResult_constructor_D} 
		 * 
		 */		
		public function TurnNodeWeightResult()
		{
		}

		/**
		 * ${iServerJava6R_TurnNodeWeightResult_attribute_succeed_D} 
		 * @return 
		 * 
		 */		
		public function get succeed():Boolean
		{
			return _succeed;;
		}
		/**
		 * ${iServerJava6R_TurnNodeWeightResult_attribute_code_D} 
		 * @return 
		 * 
		 */		
    	public function get code():int
		{
			return _code;
		}
		/**
		 * ${iServerJava6R_TurnNodeWeightResult_attribute_details_D}  
		 * @return 
		 * 
		 */		
		public function get errorMsg():String
		{
			return _errorMsg;
		}
		sm_internal static function fromJson(json:Object):TurnNodeWeightResult
		{
			var result:TurnNodeWeightResult = new TurnNodeWeightResult()
			if(!json)
			{
				return null;
			}
			else
			{
				result._succeed=json["succeed"];
				if(json["error"])
				{
					result._code=json["error"].code;
					result._errorMsg=json["error"].errorMsg;
				}
				return result;
			}
		}
	}
}