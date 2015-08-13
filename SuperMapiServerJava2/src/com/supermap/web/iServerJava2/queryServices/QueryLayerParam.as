package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_QueryLayerParam_Title}. 
	 * ${iServer2_QueryLayerParam_Description}
	 * 
	 * 
	 */	
	public class QueryLayerParam
	{
		private var _name:String;
     	private var _sqlParam:SqlParam;
     	
		/**
		 * ${iServer2_QueryLayerParam_constructor_D} 
		 * @param name ${iServer2_QueryLayerParam_constructor_param_name_D}
		 * @param sqlParam ${iServer2_QueryLayerParam_constructor_param_sqlParam_D}
		 * 
		 */     	
		public function QueryLayerParam(name:String = null, sqlParam:SqlParam = null)
		{
			this.name = name;
			this.sqlParam = sqlParam;
		}
		
		/**
		 * ${iServer2_QueryLayerParam_attribute_sqlParam_D} 
		 */
		public function get sqlParam():SqlParam
		{
			return _sqlParam;
		}
		
		public function set sqlParam(value:SqlParam):void
		{
			_sqlParam = value;
		}

		/**
		 * ${iServer2_QueryLayerParam_attribute_name_D} 
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
		 * @param queryLayer
		 * @return 
		 * 
		 */		
		sm_internal static function toQueryLayerParam(queryLayer:QueryLayerParam):String
		{
			var QueryLayerParam:String = "{";
			
			if (queryLayer.sqlParam)
			{
				if(queryLayer.sqlParam.toSqlParam().length > 0)
					QueryLayerParam += "\"sqlParam\":" + queryLayer.sqlParam.toSqlParam() + ",";
			}
			
			if (queryLayer.name)
			{
				QueryLayerParam += "\"name\":" + "\"" + queryLayer.name + "\"";
			}
			
			QueryLayerParam += "}";
			
			return QueryLayerParam;
		}
		
		

	}
}