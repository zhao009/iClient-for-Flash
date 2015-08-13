package com.supermap.web.resources
{
	/**
	 * ${resources_SmError_Title}.
	 * <p>${resources_SmError_Description}</p>
	 * 
	 */	
	public class SmError extends Error
	{
		/**
		 * ${resources_SmError_constructor_D} 
		 * @param errorCode ${resources_SmError_constructor_param_errorCode}
		 * @param args ${resources_SmError_constructor_param_args}
		 * 
		 */		
		public function SmError(errorCode:String, ... args):void
		{
			super(SmResource.formatMessage(errorCode, args));
		}
	}
}