package com.supermap.web.resources
{
	import mx.resources.ResourceManager;
	import mx.utils.StringUtil;

	/**
	 * ${resources_SmServerResource_Title}.
	 * <p>${resources_SmServerResource_Description}</p>
	 * 
	 */	
	[ResourceBundle("SuperMapServerMessage")]
	public class SmServerResource
	{
		public static const SUPERMAP_MESSAGES:String = "SuperMapServerMessage";
		public static const BOUNDS_NULL:String	= "S0024S";
		/**
		 * @private 
		 * 
		 */		
		public function SmServerResource()
		{
			super();
		}
		public static function formatMessage(errorCode:String, ...args) : String
		{
			var str:String = ResourceManager.getInstance().getString(SmServerResource.SUPERMAP_MESSAGES, errorCode, args);
			return StringUtil.substitute("{0}: {1}", errorCode, str);
		}
	} 
}