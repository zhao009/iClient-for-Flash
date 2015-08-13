package com.supermap.web.iServerJava6R.mapServices
{
	import com.supermap.web.sm_internal;

	use namespace sm_internal;

	/**
	 * ${iServerJava6R_ClearCacheResult_Title} 
	 * 
	 */	
	public class ClearCacheResult
	{
		private var _message:String;

		/**
		 * ${iServerJava6R_ClearCacheResult_constructor_String_D} 
		 * @param message ${iServerJava6R_ClearCacheResult_constructor_String_param_url}
		 * 
		 */		
		public function ClearCacheResult(message:String = null)
		{
			this._message = message;
		}

		/**
		 * ${iServerJava6R_ClearCacheResult_attribute_message} 
		 * @return 
		 * 
		 */		
		public function get message():String
		{
			return _message;
		}

	}
}
