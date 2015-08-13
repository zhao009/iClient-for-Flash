package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_DatasourceConnectionInfo_Title}.
	 * <p>${iServerJava6R_DatasourceConnectionInfo_Description}</p> 
	 * 
	 */	
	public class DatasourceConnectionInfo
	{
		private var _alias:String;
		private var _dataBase:String;
		private var _driver:String;
		private var _server:String;
		private var _user:String;
		private var _password:String;
		private var _engineType:String;
		private var _connect:Boolean;
		private var _exclusive:Boolean;
		private var _openLinkTable:Boolean;
		private var _readOnly:Boolean;
		
		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_constructor_None_D} 
		 * 
		 */		
		public function DatasourceConnectionInfo():void
		{
			
		}
		
		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_attribute_ReadOnly_D} 
		 * @return 
		 * 
		 */		
		public function get readOnly():Boolean
		{
			return _readOnly;
		}

		public function set readOnly(value:Boolean):void
		{
			_readOnly = value;
		}

		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_attribute_OpenLinkTable_D} 
		 * @return 
		 * 
		 */		
		public function get openLinkTable():Boolean
		{
			return _openLinkTable;
		}

		public function set openLinkTable(value:Boolean):void
		{
			_openLinkTable = value;
		}

		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_attribute_Exclusive_D} 
		 * @return 
		 * 
		 */		
		public function get exclusive():Boolean
		{
			return _exclusive;
		}

		public function set exclusive(value:Boolean):void
		{
			_exclusive = value;
		}

		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_attribute_Connect_D} 
		 * @return 
		 * 
		 */		
		public function get connect():Boolean
		{
			return _connect;
		}

		public function set connect(value:Boolean):void
		{
			_connect = value;
		}

		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_attribute_EngineType_D} 
		 * @return 
		 * 
		 */		
		public function get engineType():String
		{
			return _engineType;
		}

		public function set engineType(value:String):void
		{
			_engineType = value;
		}

		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_attribute_Password_D} 
		 * @return 
		 * 
		 */		
		public function get password():String
		{
			return _password;
		}

		public function set password(value:String):void
		{
			_password = value;
		}

		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_attribute_User_D} 
		 * @return 
		 * 
		 */		
		public function get user():String
		{
			return _user;
		}

		public function set user(value:String):void
		{
			_user = value;
		}

		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_attribute_Server_D} 
		 * <p>${iServerJava6R_DatasourceConnectionInfo_attribute_Server_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get server():String
		{
			return _server;
		}

		public function set server(value:String):void
		{
			_server = value;
		}

		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_attribute_Driver_D} 
		 * @return 
		 * 
		 */		
		public function get driver():String
		{
			return _driver;
		}

		public function set driver(value:String):void
		{
			_driver = value;
		}

		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_attribute_DataBase_D} 
		 * @return 
		 * 
		 */		
		public function get dataBase():String
		{
			return _dataBase;
		}

		public function set dataBase(value:String):void
		{
			_dataBase = value;
		}

		/**
		 * ${iServerJava6R_DatasourceConnectionInfo_attribute_Alias_D} 
		 * @return 
		 * 
		 */		
		public function get alias():String
		{
			return _alias;
		}

		public function set alias(value:String):void
		{
			_alias = value;
		}

		sm_internal static function toJson(connectionInfon:DatasourceConnectionInfo):String
		{
			var json:String = "";
			
			if (connectionInfon.alias)
				json += "\"alias\":" + "\"" + connectionInfon.alias + "\",";
			
			if (connectionInfon.dataBase)
				json += "\"dataBase\":" + "\"" + connectionInfon.dataBase + "\",";
				
			if (connectionInfon.driver)
				json += "\"driver\":" + "\"" + connectionInfon.driver + "\",";
				
			if (connectionInfon.server)
				json += "\"server\":" + "\"" + connectionInfon.server + "\",";
			
			if (connectionInfon.user)
				json += "\"user\":" + "\"" + connectionInfon.user + "\",";
				
			if (connectionInfon.password)
				json += "\"password\":" + "\"" + connectionInfon.password + "\",";
				
				
			if (connectionInfon.engineType)
				json += "\"engineType\":" + "\"" + connectionInfon.engineType + "\",";
			
			
			json += "\"connect\":" + connectionInfon.connect + ",";
							
			json += "\"exclusive\":" + connectionInfon.exclusive + ",";
			
			json += "\"openLinkTable\":" + connectionInfon.openLinkTable + ",";
							
			json += "\"readOnly\":" + connectionInfon.readOnly;
										
			if(json.length > 0)
			json ="{" + json + "}";
				
			return json;
		}

	}
}