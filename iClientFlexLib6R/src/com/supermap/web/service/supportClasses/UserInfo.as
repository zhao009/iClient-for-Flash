package com.supermap.web.service.supportClasses
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */
	public class UserInfo
	{
		private var _userID:String;
		
		public function UserInfo()
		{
		}
					
		sm_internal function get userID():String
		{
			return _userID;
		}

		sm_internal function set userID(value:String):void
		{
			_userID = value;
		}


		sm_internal static function fromJson(json:Object):UserInfo
		{
			if (json == null)
			{
				return null;
			}
			var userInfo:UserInfo = new UserInfo();
			userInfo.userID = json.userID;
			return userInfo;
		}
	}
}