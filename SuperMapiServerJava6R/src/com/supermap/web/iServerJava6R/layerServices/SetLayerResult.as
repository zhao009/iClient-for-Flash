package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServer6_SetLayerResult_Title}.
	 * <p>${iServer6_SetLayerResult_Description}</p> 
	 * 
	 */	
	public class SetLayerResult
	{
		private var _isSucceed:Boolean;
		private var _newResourceID:String;//属性不从fromJson组装，可以设置
		 
		/**
		 * ${iServer6_SetLayerResult_constructor_D} 
		 * 
		 */		
		public function SetLayerResult()
		{
		}
		
		/**
		 * ${iServer6_SetLayerResult_attribute_NewResourceID_D} 
		 * @return 
		 * 
		 */		
		public function get newResourceID():String
		{
			return _newResourceID;
		}

		public function set newResourceID(value:String):void
		{
			_newResourceID = value;
		}

		/**
		 * ${iServer6_SetLayerResult_attribute_IsSucceed_D} 
		 * @return 
		 * 
		 */		
		public function get isSucceed():Boolean
		{
			return _isSucceed;
		}
 
		sm_internal static function fromJson(jsonObject:Object):SetLayerResult
		{
			var result:SetLayerResult;
			if(jsonObject)
			{
				result = new SetLayerResult();
				result._isSucceed = jsonObject.succeed; 
			}
			return result;
		}
	}
}