package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_JoinItem_Tile}.
	 * <p>${iServerJava6R_JoinItem_Description}</p> 
	 * @example ${iServerJava6R_JoinItem_Example}
	  * <listing> 
	  * 	var joinItem:JoinItem = new JoinItem();
	  *     joinItem.foreignTableName =  "customer";
	  * 	joinItem.joinFilter = "Street.ZIP = customer.ZIP";
	  * 	joinItem.joinType = JoinType.INNER_JOIN;
	  * 
	  * 	var filterParam:FilterParameter = new FilterParameter();
	  *     filterParam.name =  "Street&#64;RelQuery";//主表
	  *     filterParam.fields = new Array("Street.ZIP", "Street.CITY", "customer.NAME", "customer.TYPE_USER");	//主表或外表需要保留的字段
	  *     filterParam.joinItems = new Array(joinItem);
	  * </listing>
	 */	
	public class JoinItem
	{
		private var _foreignTableName:String;
		private var _joinFilter:String;
		private var _joinType:String;
		
		/**
		 * ${iServerJava6R_JoinItem_constructor_None_D} 
		 * 
		 */		
		public function JoinItem():void
		{
			
		}
	
		/**
		 * ${iServerJava6R_JoinItem_attribute_JoinType_D}.
		 * <p>${iServerJava6R_JoinItem_attribute_JoinType_remarks}</p> 
		 * @see JoinType
		 * @return 
		 * 
		 */		
		public function get joinType():String
		{
			return _joinType;
		}

		public function set joinType(value:String):void
		{
			_joinType = value;
		}

		
		/**
		 * ${iServerJava6R_JoinItem_attribute_JoinFilter_D}.
		 * <p>${iServerJava6R_JoinItem_attribute_JoinFilter_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get joinFilter():String
		{
			return _joinFilter;
		}

		public function set joinFilter(value:String):void
		{
			_joinFilter = value;
		}

		/**
		 * ${iServerJava6R_JoinItem_attribute_ForeignTableName_D}.
		 * <p>${iServerJava6R_JoinItem_attribute_ForeignTableName_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get foreignTableName():String
		{
			return _foreignTableName;
		}

		public function set foreignTableName(value:String):void
		{
			_foreignTableName = value;
		}

		sm_internal static function toJson(item:JoinItem):String
		{
			var json:String = "";
			
			if (item.foreignTableName)
				json += "\"foreignTableName\":" + "\"" + item.foreignTableName + "\",";
			
			if (item.joinFilter)
				json += "\"joinFilter\":" + "\"" + item.joinFilter + "\",";
				
			if (item.joinType)
				json += "\"joinType\":" + "\"" + item.joinType + "\"";
				
			if(json.charAt(json.length - 1) == ",")
				json = json.substring(0, json.length - 1);
						
			if(json.length > 0)
			json ="{" + json + "}";
				
			return json;
			
		}
		
		
		
		sm_internal static function fromJson(json:Object):JoinItem//添加fromJson方法
		{
			var result:JoinItem;
			if(json)
			{
				result._foreignTableName = json.foreignTableName;
				result._joinFilter = json.joinFilter;
				result._joinType = json.joinType; 
			}
			return result;
		}
	}
}