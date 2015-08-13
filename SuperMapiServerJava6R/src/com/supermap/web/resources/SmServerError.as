package com.supermap.web.resources
{
	/**
	 * ${resources_SmError_Title}.
	 * <p>${resources_SmError_Description}</p>
	 * 
	 */	
	public class SmServerError extends Error
	{
		/**
		 * ${resources_SmError_constructor_D} 
		 * @param errorCode ${resources_SmError_constructor_param_errorCode}
		 * @param args ${resources_SmError_constructor_param_args}
		 * 
		 */		
		public function SmServerError(errorCode:String, ... args):void
		{
			super(SmServerResource.formatMessage(errorCode, args));
		}
	}
}