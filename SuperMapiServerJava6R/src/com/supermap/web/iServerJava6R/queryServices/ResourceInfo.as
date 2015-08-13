package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_Query_ResourceInfo_Title}.
	 * <p>${iServerJava6R_Query_ResourceInfo_Description}</p> 
	 * 
	 */	
	public class ResourceInfo
	{
		private var _succeed:Boolean;
		private var _newResourceLocation:String;
		private var _newResourceID:String;
		
		/**
		 * ${iServerJava6R_Query_ResourceInfo_contructor_D} 
		 * 
		 */		
		public function ResourceInfo()
		{
		}

	 
		/**
		 * ${iServerJava6R_Query_ResourceInfo_attribute_NewResourceID_D} 
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
		 * ${iServerJava6R_Query_ResourceInfo_attribute_NewResourceLocation_D} 
		 * @return 
		 * 
		 */		
		public function get newResourceLocation():String
		{
			return _newResourceLocation;
		}

		public function set newResourceLocation(value:String):void
		{
			_newResourceLocation = value;
		}

		/**
		 * ${iServerJava6R_Query_ResourceInfo_attribute_Succeed_D} 
		 * @return 
		 * 
		 */		
		public function get succeed():Boolean
		{
			return _succeed;
		}

		public function set succeed(value:Boolean):void
		{
			_succeed = value;
		}

		sm_internal static function fromJson(object:Object):ResourceInfo
		{
			var resourceInfo:ResourceInfo;
			if(object)
			{
				resourceInfo = new ResourceInfo();
				resourceInfo._newResourceID = object.newResourceID;
				resourceInfo._succeed = object.succeed;
				resourceInfo._newResourceLocation = object.newResourceLocation;
				
			}
			return resourceInfo;
		}

	}
}