package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.utils.JsonUtil;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_sqlParam_Title}.
	 * <br/> ${iServer2_sqlParam_Description} 
	 * 
	 * 
	 */	
	public class SqlParam
	{
		private var _ids:Array;
		private var _returnFields:Array;
		private var _groupClause:String;
		private var _whereClause:String;
		private var _sortClause:String;
		
		/**
		 * ${iServer2_sqlParam_constructor_None_D_as} 
		 * 
		 */		
		public function SqlParam()
		{
		}
		
		/**
		 * ${iServer2_sqlParam_attribute_sortClause_D} 
		 */
		public function get sortClause():String
		{
			return _sortClause;
		}

		public function set sortClause(value:String):void
		{
			_sortClause = value;
		}

		/**
		 * ${iServer2_sqlParam_attribute_whereClause_D} 
		 */
		public function get whereClause():String
		{
			return _whereClause;
		}

		public function set whereClause(value:String):void
		{
			_whereClause = value;
		}

		/**
		 * ${iServer2_sqlParam_attribute_groupClause_D} 
		 */
		public function get groupClause():String
		{
			return _groupClause;
		}

		public function set groupClause(value:String):void
		{
			_groupClause = value;
		}

		/**
		 * ${iServer2_sqlParam_attribute_returnFields_D} 
		 */
		public function get returnFields():Array
		{
			return _returnFields;
		}

		public function set returnFields(value:Array):void
		{
			_returnFields = value;
		}

		/**
		 * ${iServer2_sqlParam_attribute_ids_D} 
		 */
		public function get ids():Array
		{
			return _ids;
		}
		
		public function set ids(value:Array):void
		{
			_ids = value;
		}

		/**
		 * @private 
		 * @return 
		 * 
		 */		
		sm_internal function toSqlParam():String
		{
			var parameters:String = "";
			
			if (ids)
			{
				parameters += "\"ids\":" + JsonUtil.fromArray(ids) + ",";
			}
			
			if (returnFields)
			{
				parameters += "\"returnFields\":" + "[" + returnFields.join(",") + "],";
			}
			
			if (groupClause)
			{
				parameters += "\"groupClause\":" + "\"" +groupClause + "\",";
			}
			
			if (sortClause)
			{
				parameters += "\"sortClause\":" + "\"" +sortClause + "\",";
			}
			
			if (whereClause)
			{
				parameters += "\"whereClause\":" + "\"" + whereClause + "\"";
			}
			
			if(parameters.charAt(parameters.length - 1) == ",")
				parameters = parameters.substring(0, parameters.length - 1);
				
			if(parameters.length > 0)
				parameters = "{" + parameters + "}";	
			
			parameters = parameters.replace("<", "&lt;");
			parameters = parameters.replace(">", "&gt;");
			
			return parameters;
		}
	}
}