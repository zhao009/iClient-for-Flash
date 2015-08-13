package com.supermap.web.iServerJava2
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_JoinItem_Tile}.
	 * <p>${iServer2_JoinItem_Description}</p> 
	 * 
	 */	
	public class JoinItem
	{
		private var _foreignTableName:String;
		private var _joinFilter:String;
		private var _joinType:int = -1;
		
		/**
		 * ${iServer2_JoinItem_constructor_None_D} 
		 * 
		 */		
		public function JoinItem():void
		{
			
		}
	
		/**
		 * ${iServer2_JoinItem_attribute_JoinType_D}.
		 * <p>${iServer2_JoinItem_attribute_JoinType_remarks}</p> 
		 * @see JoinType
		 * @return 
		 * 
		 */		
		public function get joinType():int
		{
			return _joinType;
		}

		public function set joinType(value:int):void
		{
			_joinType = value;
		}

		
		/**
		 * ${iServer2_JoinItem_attribute_JoinFilter_D}.
		 * <p>${iServer2_JoinItem_attribute_JoinFilter_remarks}</p> 
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
		 * ${iServer2_JoinItem_attribute_ForeignTableName_D}.
		 * <p>${iServer2_JoinItem_attribute_ForeignTableName_remarks}</p> 
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
				
			if (item.joinType != -1)
				json += "\"joinType\":" +  item.joinType.toString();
				
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