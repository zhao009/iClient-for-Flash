package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	import mx.collections.ArrayCollection;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_DatasetInfo_Title}.
	 * <p>${iServerJava6R_DatasetInfo_Description}</p> 
	 * 
	 */	
	public class DatasetInfo
	{
		private var _bounds:Rectangle2D; 
		private var _name:String; 
		private var _dataSourceName:String;
		private var _type:String;
		
		/**
		 * ${iServerJava6R_DatasetInfo_Constructor_D} 
		 * 
		 */		
		public function DatasetInfo()
		{
			
		}
 
		/**
		 * ${iServerJava6R_DatasetInfo_attribute_Type_D} 
		 * @see DatasetType
		 * @return 
		 * 
		 */		
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		/**
		 * ${iServerJava6R_DatasetInfo_attribute_DatasourceName_D} 
		 * @return 
		 * 
		 */		
		public function get dataSourceName():String
		{
			return _dataSourceName;
		}

		public function set dataSourceName(value:String):void
		{
			_dataSourceName = value;
		}

		/**
		 * ${iServerJava6R_DatasetInfo_attribute_Name_D} 
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
		 * ${iServerJava6R_DatasetInfo_attribute_bounds_D}.
		 * <p>${iServerJava6R_DatasetInfo_attribute_bounds_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}

		public function set bounds(value:Rectangle2D):void
		{
			_bounds = value;
		}

		sm_internal static function fromJson(json:Object):DatasetInfo//将dataSetInfo的json对象转换为自身对象
		{
			var dataSetInfo:DatasetInfo;
			if(json)
			{
				dataSetInfo = new DatasetInfo();
				
				dataSetInfo.bounds = JsonUtil.toRectangle2D(json.bounds); 
				dataSetInfo.name = json.name; 
				dataSetInfo.dataSourceName = json.dataSourceName;
				dataSetInfo.type = json.type;
			}
			return dataSetInfo;
		}
		
		sm_internal static function toJson(param:DatasetInfo):String
		{
			if(param)
			{
				var json:String = "{";
				var list:Vector.<String> = new Vector.<String>;
				if(param.bounds)
				{
					var boudnsString:String = JsonUtil.fromRectangle2D(param.bounds);
					list.push("\"bounds\":\"" + boudnsString + "\"");
				} 
				if(param.name)
				{
					list.push("\"name\":\"" + param.name + "\"");
				} 
				if(param.dataSourceName)
				{
					list.push("\"dataSourceName\":\"" + param.dataSourceName + "\"");
				}
				if(param.type)
				{
					list.push("\"type\":\"" + param.type + "\"");
				} 
				json += list.toString();
				json += "}";
				return json;
			}
			return null;
		} 
	}
}