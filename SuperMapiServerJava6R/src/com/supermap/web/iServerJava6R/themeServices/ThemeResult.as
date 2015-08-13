package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.iServerJava6R.queryServices.ResourceInfo;
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServer6R_themeServices_ThemeResult_Title}. 
	 * <p>${iServer6R_themeServices_ThemeResult_Description}</p>
	 * @see com.supermap.web.iServerJava6R.queryServices.ResourceInfo
	 */	
	public class ThemeResult
	{
		private var _resourceInfo:ResourceInfo = new ResourceInfo();
		
		/**
		 * ${iServer6R_themeServices_ThemeResult_constructor_None_D} 
		 * 
		 */		
		public function ThemeResult():void
		{
			
		}

		/**
		* ${iServer6R_themeServices_ThemeResult_attribute_resourceInfo_D} 
		* 
		*/	
		public function get resourceInfo():ResourceInfo
		{
			return _resourceInfo;
		}
		
		sm_internal static function fromJson(object:Object):ThemeResult
		{
			var themeResult:ThemeResult;
			if(object)
			{
				themeResult = new ThemeResult();
				
				if(object.newResourceID)
				{
					themeResult._resourceInfo = ResourceInfo.fromJson(object);
				}
			}
			return themeResult;
		}

	}
}