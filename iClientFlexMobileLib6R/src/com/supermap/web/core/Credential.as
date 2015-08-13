package com.supermap.web.core
{
	/**
	 * ${core_Credential_Title}.
	 * <p>${core_Credential_Description}</p>
	 * 
	 */	
	public class Credential
	{
		/**
		 * ${core_Credential_field_CREDENTIAL_D} 
		 */	
		public static var CREDENTIAL:Credential = null;
		//iserver所支持的验证权限的属性名称
		private var _value:String;
		//虽然现在iserver只支持token=的格式，但是第三方的服务也许支持key=的格式，所以此属性用于向后兼容
		private var _name:String = "token";
		
		/**
		 * ${core_Credential_constructor_D} 
		 * @param value ${core_Credential_constructor_param_value}
		 * 
		 * @example ${core_Credential_Example}
		 * <listing>
		 * //RbVQsi6UJCF3NXL_25WEJBciN6oa24X_khzfCm7T3jTTyMFJBTywIc14wkQ7iT41YjV0yerPGwUJ-aCbRSYM_Q..为用户申请的安全锁
		 * //必须设置了Credential.CREDENTIAL才能访问受安全限制的服务，并且必须在所有向服务器发送请求之前设置
		 * Credential.CREDENTIAL = new Credential("RbVQsi6UJCF3NXL_25WEJBciN6oa24X_khzfCm7T3jTTyMFJBTywIc14wkQ7iT41YjV0yerPGwUJ-aCbRSYM_Q..");
		 * </listing>
		 * 
		 */	
		public function Credential(value:String = null)
		{
			if(value)
			{
				this.value = value;
			}
		}
		/**
		 * ${core_Credential_attribute_value_D} 
		 * @return 
		 */	
		public function get value():String
		{
			return _value;
		}
		public function set value(value:String):void
		{
			_value = value;
		}
		
		/**
		 * ${core_Credential_attribute_name_D} 
		 * @return 
		 */	
		public function get name():String
		{
			return _name;
		}
		public function set name(value:String):void
		{
			_name = value;
		}
		
		/**
		 * @private
		 * 此方法主要用于在ServiceBase和TiledLayer的url组合的地方使用，用于将安全锁信息添加进url里面
		 */	
		public function getUrlParameters():String
		{
			return this.name + "=" + this.value;
		}
	}
}