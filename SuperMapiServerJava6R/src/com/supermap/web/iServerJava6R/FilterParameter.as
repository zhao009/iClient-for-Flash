package com.supermap.web.iServerJava6R
{
	import com.supermap.web.iServerJava6R.queryServices.JoinItem;
	import com.supermap.web.iServerJava6R.queryServices.LinkItem;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_FilterParameter_Tile}.
	 * <p>${iServerJava6R_FilterParameter_Description}</p> 
	 * 
	 */	
	public class FilterParameter
	{
		private var _name:String;
		private var _joinItems:Array;
		private var _linkItems:Array;
		private var _ids:Array;
		private var _attributeFilter:String;
		private var _orderBy:String;
		private var _groupBy:String;
		private var _fields:Array;
		
		/**
		 * ${iServerJava6R_FilterParameter_constructor_None_D} 
		 * 
		 */		
		public function FilterParameter()
		{
		}
		
		/**
		 * ${iServerJava6R_FilterParameter_attribute_Fields_D} 
		 * @return 
		 * 
		 */		
		public function get fields():Array
		{
			return _fields;
		}

		public function set fields(value:Array):void
		{
			_fields = value;
		}

		/**
		 * ${iServerJava6R_FilterParameter_attribute_GroupBy_D}.
		 * <p>${iServerJava6R_FilterParameter_attribute_GroupBy_remarks}</p> 
		 * @return 
		 * 
		 */			
		public function get groupBy():String
		{
			return _groupBy;
		}

		public function set groupBy(value:String):void
		{
			_groupBy = value;
		}

		/**
		 * ${iServerJava6R_FilterParameter_attribute_OrderBy_D}.
		 * <p>${iServerJava6R_FilterParameter_attribute_OrderBy_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get orderBy():String
		{
			return _orderBy;
		}

		public function set orderBy(value:String):void
		{
			_orderBy = value;
		}

		/**
		 * ${iServerJava6R_FilterParameter_attribute_AttributeFilter_D}.
		 * <p>${iServerJava6R_FilterParameter_attribute_AttributeFilter_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get attributeFilter():String
		{
			return _attributeFilter;
		}

		public function set attributeFilter(value:String):void
		{
			_attributeFilter = value;
		}

		/**
		 * ${iServerJava6R_FilterParameter_attribute_IDs_D} 
		 * @return 
		 * 
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
		 * ${iServerJava6R_FilterParameter_attribute_LinkItems_D} 
		 * @return 
		 * 
		 */		
		public function get linkItems():Array
		{
			return _linkItems;
		}

		public function set linkItems(value:Array):void
		{
			_linkItems = value;
		}

		/**
		 * ${iServerJava6R_FilterParameter_attribute_JoinItems_D} 
		 * @return 
		 * 
		 */		
		public function get joinItems():Array
		{
			return _joinItems;
		}

		public function set joinItems(value:Array):void
		{
			_joinItems = value;
		}

		/**
		 * ${iServerJava6R_FilterParameter_attribute_Name_D}.
		 * <p>${iServerJava6R_FilterParameter_attribute_Name_remarks}</p> 
		 * @return 
		 * @see com.supermap.web.iServerJava6R.dataServices.GetFeaturesBySQLService
		 * @see com.supermap.web.iServerJava6R.dataServices.GetFeaturesBySQLParameters#datasetNames
		 */		
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		sm_internal function toJson():String
		{
			var json:String = "";
			
			if (this.name)
				json += "\"name\":" + "\"" + this.name + "\",";
			else
				json += "\"name\":" + null + ",";
			
			if (this.orderBy)
				json += "\"orderBy\":" + "\"" + this.orderBy + "\",";
			else
				json += "\"orderBy\":" + null + ",";
				
			if (this.attributeFilter)
				json += "\"attributeFilter\":" + "\"" + this.attributeFilter + "\",";
			else
				json += "\"attributeFilter\":" + null + ",";
				
			if (this.groupBy)
				json += "\"groupBy\":" + "\"" + this.groupBy + "\",";
			else
				json += "\"groupBy\":" + null + ",";
				
			if (this.joinItems && this.joinItems.length)
			{
				var joinArray:Array = [];
				var itemLength:int = this.joinItems.length;
				for(var i:int = 0; i < itemLength; i++)
				{
					joinArray.push(JoinItem.toJson(this.joinItems[i]));
				}
				
				var tempJoinItems:String = "[" + joinArray.join(",") + "]";
				json += "\"joinItems\":" + tempJoinItems + ",";
			}	
			else
				json += "\"joinItems\":" + null + ",";
			
			if (this.ids && this.ids.length)
			{
				json += "\"ids\":" +  JsonUtil.fromArray(this.ids) + ",";
			}		
			else
				json += "\"ids\":" + null + ",";			
			
			if (this.linkItems && this.linkItems.length)
			{
				var linkArray:Array = [];
				var linkItemLength:int = this.linkItems.length;
				for(var j:int = 0; j < linkItemLength; j++)
				{
					linkArray.push(LinkItem.toJson(this.linkItems[j]));
				}
				
				var tempLinkItems:String = "[" + linkArray.join(",") + "]";
				json += "\"linkItems\":" + tempLinkItems + ",";
				
			}
			else
				json += "\"linkItems\":" + null + ",";		
			
			if (this.fields && this.fields.length)
			{
				json += "\"fields\":" + JsonUtil.fromArray(this.fields);
			}
			else
				json += "\"fields\":" + null;			
			
			
			json ="{" + json + "}";
			
            return json;
		}
		

	}
}