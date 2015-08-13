package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_LinkItem_Tile}.
	 * <p>${iServerJava6R_LinkItem_Description}</p> 
	 * @example ${iServerJava6R_LinkItem_Example}
	 * <listing> 
	 *     //定义数据库信息
	 *     var dataSrcConnecInfo:DatasourceConnectionInfo = new DatasourceConnectionInfo();
	 * 	    dataSrcConnecInfo.server = "192.168.177.11";
	 * 	    dataSrcConnecInfo.dataBase =  "RelQuery";
	 * 	    dataSrcConnecInfo.connect = true;
	 * 	    dataSrcConnecInfo.engineType = EngineType.SQL_PLUS;
	 * 	    dataSrcConnecInfo.user = "supermap";
	 * 	    dataSrcConnecInfo.password = "map";
	 * 	    dataSrcConnecInfo.alias = "RelQuery";//数据库别名
	 *     dataSrcConnecInfo.driver = "SQL Server";
	 *     dataSrcConnecInfo.readOnly = false;
	 *     dataSrcConnecInfo.exclusive = false;
	 *     //定义关联信息
	 *     var linkItem:LinkItem = new LinkItem();
	 *     linkItem.datasourceConnectionInfo = dataSrcConnecInfo;
	 *     linkItem.foreignKeys = new Array("ZIPL");//主表的外键
	 *     linkItem.foreignTable = "customerA";//外表
	 *     linkItem.linkFields = new Array( "SMID as customerAID","ZIP");//外表要保留的字段
	 *     linkItem.name = "关联";
	 *     linkItem.primaryKeys = new Array("ZIP");//外表的主键
	 * 
	 *     var filterParam:FilterParameter = new FilterParameter();
	 *     filterParam.name =  "streetL&#64;RelQuery";	//主表
	 *     filterParam.fields = new Array("SmID","ZIPL");//主表要保留的字段	
	 *     filterParam.linkItems =  new Array(linkItem);
	 * </listing>
	 * 
	 */	
	public class LinkItem
	{
		private var _datasourceConnectionInfo:DatasourceConnectionInfo;
		private var _primaryKeys:Array;
		private var _foreignKeys:Array;
		private var _linkFields:Array;
		private var _foreignTable:String;
		private var _linkFilter:String;
		private var _name:String;
		
		/**
		 * ${iServerJava6R_LinkItem_constructor_None_D} 
		 * 
		 */		
		public function LinkItem():void
		{
			
		}
		
		/**
		 * ${iServerJava6R_LinkItem_attribute_Name_D} 
		 * @return 
		 * 
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
		 * ${iServerJava6R_LinkItem_attribute_LinkFilter_D} 
		 * @return 
		 * 
		 */		
		public function get linkFilter():String
		{
			return _linkFilter;
		}

		public function set linkFilter(value:String):void
		{
			_linkFilter = value;
		}

		/**
		 * ${iServerJava6R_LinkItem_attribute_ForeignTable_D} 
		 * @return 
		 * 
		 */		
		public function get foreignTable():String
		{
			return _foreignTable;
		}

		public function set foreignTable(value:String):void
		{
			_foreignTable = value;
		}

		/**
		 * ${iServerJava6R_LinkItem_attribute_LinkFields_D} 
		 * @return 
		 * 
		 */		
		public function get linkFields():Array
		{
			return _linkFields;
		}

		public function set linkFields(value:Array):void
		{
			_linkFields = value;
		}

		/**
		 * ${iServerJava6R_LinkItem_attribute_ForeignKeys_D} 
		 * @return 
		 * 
		 */		
		public function get foreignKeys():Array
		{
			return _foreignKeys;
		}

		public function set foreignKeys(value:Array):void
		{
			_foreignKeys = value;
		}

		/**
		 * ${iServerJava6R_LinkItem_attribute_PrimaryKeys_D} 
		 * @return 
		 * 
		 */		
		public function get primaryKeys():Array
		{
			return _primaryKeys;
		}

		public function set primaryKeys(value:Array):void
		{
			_primaryKeys = value;
		}

		/**
		 * ${iServerJava6R_LinkItem_attribute_DatasourceConnectionInfo_D} 
		 * @return 
		 * 
		 */		
		public function get datasourceConnectionInfo():DatasourceConnectionInfo
		{
			return _datasourceConnectionInfo;
		}

		public function set datasourceConnectionInfo(value:DatasourceConnectionInfo):void
		{
			_datasourceConnectionInfo = value;
		}

		sm_internal static function toJson(item:LinkItem):String
		{
			var json:String = "";
			
			if (item.datasourceConnectionInfo)
				json += "\"datasourceConnectionInfo\":" + DatasourceConnectionInfo.toJson(item.datasourceConnectionInfo) + ",";
			
			if (item.primaryKeys && item.primaryKeys.length)
			{
				json += "\"primaryKeys\":" + JsonUtil.fromArray(item.primaryKeys) + ",";
			}		
			
			if (item.foreignKeys && item.foreignKeys.length)
			{
				json += "\"foreignKeys\":" + JsonUtil.fromArray(item.foreignKeys) + ",";
			}		
				
			if (item.linkFields && item.linkFields.length)
			{
				json += "\"linkFields\":" + JsonUtil.fromArray(item.linkFields) + ",";
			}
			
			if (item.foreignTable)
				json += "\"foreignTable\":" + "\"" + item.foreignTable + "\",";
			
			if (item.linkFilter)
				json += "\"linkFilter\":" + "\"" + item.linkFilter + "\",";
				
			if (item.name)
				json += "\"name\":" + "\"" + item.name + "\"";
				
			if(json.charAt(json.length - 1) == ",")
				json = json.substring(0, json.length - 1);
						
			if(json.length > 0)
			json ="{" + json + "}";
			
			return json;
		}

	}
}