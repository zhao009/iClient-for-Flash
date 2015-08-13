package com.supermap.web.iServerJava2.editServices
{
	import com.supermap.web.iServerJava2.ServerGeometry;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServer2_editServices_Entity_Title}.
	 * <p>${iServer2_editServices_Entity_Description}</p>
	 * 
	 * 
	 */
	public class Entity
	{
		//字段列表 String 数组
		private var _fieldNames:Array = null;
		
		//属性字段值 String 数组
		private var _fieldValues:Array = null;
		
		//实体对象的标识符，也即数据集中 SmID 字段的值
		private var _id:int;
		
		//服务器端的几何形状
		private var _shape:ServerGeometry;
		
		/**
		 * ${iServer2_editServices_Entity_constructor_None_D} 
		 * 
		 */		
		public function Entity():void
		{
			
		}
		
		/**
		 * ${iServer2_editServices_Entity_attribute_shape_D} 
		 */
		public function get shape():ServerGeometry
		{
			return _shape;
		}

		public function set shape(value:ServerGeometry):void
		{
			_shape = value;
		}

		/**
		 * ${iServer2_editServices_Entity_attribute_ID_D}.
		 * <p>${iServer2_editServices_Entity_attribute_ID_remarks}</p>
		 */
		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		/**
		 * ${iServer2_editServices_Entity_attribute_fieldValues_D} 
		 * <p>${iServer2_editServices_Entity_attribute_fieldValues_remarks}</p>
		 * @see #fieldNames
		 */
		public function get fieldValues():Array
		{
			return _fieldValues;
		}

		public function set fieldValues(value:Array):void
		{
			_fieldValues = value;
		}

		/**
		 * ${iServer2_editServices_Entity_attribute_fieldNames_D}.
		 * <p>${iServer2_editServices_Entity_attribute_fieldNames_remarks}</p> 
		 */
		public function get fieldNames():Array
		{
			return _fieldNames;
		}

		public function set fieldNames(value:Array):void
		{
			_fieldNames = value;
		}

		sm_internal function toJson():String
		{
			var json:String = "";
			
			if (this.fieldNames)
			{
				if(this.fieldNames.length > 0)
				{
					var tempFieldNames:Array = new Array();
					for(var i:int = 0; i < this.fieldNames.length; i++)
						tempFieldNames.push("\"" + this.fieldNames[i] + "\"");
					
				}
				json += "\"fieldNames\":" + "[" + tempFieldNames.join(",") + "],";
			}
			else
				json += "\"fieldNames\":" + null + ",";
				
			if (this.fieldValues)
			{
				if(this.fieldValues.length > 0)
				{
					var tempFieldValues:Array = new Array();
					for(var j:int = 0; j < this.fieldValues.length; j++)
						tempFieldValues.push("\"" + this.fieldValues[j] + "\"");
				}
				json += "\"fieldValues\":" + "[" + tempFieldValues.join(",") + "],";
			}
			else
				json += "\"fieldValues\":" + null + ",";
				
			if(this.id > 0)
				json += "\"id\":" + this.id + ",";
			
			if(this.shape)
				json += "\"shape\":" + ServerGeometry.toJson(this.shape);
			
			if(json.charAt(json.length - 1) == ",")
				json = json.substring(0, json.length - 1);
			
			if(json.length > 0)
			json ="[{" + json + "}]";
			
            return json;
  		}
		
		sm_internal static function toEntity(object:Object):Entity
		{
			var entity:Entity;
			if(object)
			{
				entity = new Entity();
				entity._fieldNames = object.fieldNames;
				entity._fieldValues = object.fieldValues;
				entity._id = object.id;
				entity._shape = ServerGeometry.fromJson(object.shape);
			}
			return entity;
		}
	}
}