package com.supermap.web.utils.serverTypes
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.styles.TextStyle;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	
	import mx.utils.ObjectUtil;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ServerType_ServerFeature_Tile}.
	 * <p>${iServerJava6R_ServerType_ServerFeature_Description}</p> 
	 * 
	 */	
	public class ServerFeature
	{		
		private var _id:int;
		private var _fieldNames:Array;
		private var _fieldValues:Array;
		private var _geometry:ServerGeometry;	

		/**
		 * ${iServerJava6R_ServerType_ServerFeature_attribute_id_D} 
		 * @param value
		 * 
		 */		
		public function set id(value:int):void
		{
			_id = value;
		}

		public function get id():int
		{
			return _id;
		}

		/**
		 * ${iServerJava6R_ServerType_ServerFeature_constructor_D} 
		 * 
		 */		
		public function ServerFeature():void
		{
			
		}		
				
		/**
		 * ${iServerJava6R_ServerType_ServerFeature_attribute_FieldNames_D} 
		 * @return 
		 * 
		 */		
		public function get fieldNames():Array
		{
			return this._fieldNames;
		}
		
		/**
		 * ${iServerJava6R_ServerType_ServerFeature_attribute_FieldValues_D} 
		 * @return 
		 * 
		 */		
		public function get fieldValues():Array
		{
			return this._fieldValues;
		}
		
		/**
		 * ${iServerJava6R_ServerType_ServerFeature_attribute_Geometry_D} 
		 * @return 
		 * 
		 */		
		public function get geometry():ServerGeometry
		{
			return this._geometry;
		}
		
		sm_internal static function fromJson(object:Object):ServerFeature
		{
			var serverFeature:ServerFeature;
			if(object)
			{
				serverFeature = new ServerFeature();
				serverFeature._fieldNames = object.fieldNames;
				if(!serverFeature._fieldNames)
				{
					serverFeature._fieldNames = [];
				}
				
				serverFeature._fieldValues = object.fieldValues;
				serverFeature._geometry = ServerGeometry.fromJson(object.geometry); 
			}
			return serverFeature;
		}
		
		sm_internal static function toJson(serverFeature:ServerFeature):String
		{
			var json:String = "";
			
			if(serverFeature.id)
			{
				json += "\"ID\":" + serverFeature.id + ",";
			}
			if (serverFeature.fieldNames && serverFeature.fieldNames.length)
			{
				var tempFieldNames:Array = [];
				var fieldNamesLength:int = serverFeature.fieldNames.length;
				
				for(var i:int = 0; i < fieldNamesLength; i++)
					tempFieldNames.push("\"" + serverFeature.fieldNames[i] + "\"");
					
				json += "\"fieldNames\":" + "[" + tempFieldNames.join(",") + "],";
			}
			else
				json += "\"fieldNames\":" + "[],";
			
			if(serverFeature.geometry)
				json += "\"geometry\":" + ServerGeometry.toJson(serverFeature.geometry) + ",";
			
			if (serverFeature.fieldValues && serverFeature.fieldValues.length)
			{
				var tempFieldValues:Array = [];
				var fieldValuesLength:int = serverFeature.fieldValues.length;
				for(var j:int = 0; j < fieldValuesLength; j++)
					tempFieldValues.push("\"" + serverFeature.fieldValues[j] + "\"");
				json += "\"fieldValues\":" + "[" + tempFieldValues.join(",") + "]";
			}
			else
				json += "\"fieldValues\":" + "[]";
			
			json ="{" + json + "}";
			
			return json;
		}
		 
		/**
		 * @author lironghai
		 */
		sm_internal static function toFeature(feature:ServerFeature):Feature
		{
			if (feature != null)
			{
				var f:Feature = new Feature();
				if (feature.geometry)
				{ 
					f.geometry = ServerGeometry.toGeometry(feature.geometry);  
				}
				if (feature.fieldNames && feature.fieldNames.length > 0 && feature.fieldValues && feature.fieldValues.length > 0)
				{ 
					var object:Object = new Object();
			
					f.fields = new Array();
					var fieldLength:int = feature._fieldValues.length;
					for (var i:int = 0; i < fieldLength; i++)
					{ 
						if(feature.fieldNames[i])
						{
							var fieldObject:Object = new Object();
							var fieldName:String = feature.fieldNames[i].toString();
							var fieldValue:* = feature.fieldValues[i];
							object[fieldName] = fieldValue; 
							
							fieldObject.key = fieldName; 
							fieldObject.value = fieldValue;
							f.fields.push(fieldObject);
							
							if(fieldName.toUpperCase() == "SMID")
								f.id = fieldValue as String;
						}
					}
					f.attributes = object; 
				}
				return f;
			}
			return null;
		}
		
		sm_internal static function fromFeature(feature:Feature):ServerFeature
		{
			if (feature != null)
			{
				var serverFeature:ServerFeature = new ServerFeature();
				if (feature.geometry != null)
				{
					serverFeature._geometry = ServerGeometry.fromGeometry(feature.geometry);
				}
				if(feature.style is TextStyle)
				{
					serverFeature._geometry.text = [(feature.style as TextStyle).text];
					serverFeature._geometry.textStyle = ServerTextStyle.clientStyleToServerStyle((feature.style as TextStyle));
					serverFeature._geometry.type = "TEXT";
				}
				if(feature.attributes)
				{
					var propArray:Array = ObjectUtil.getClassInfo(feature.attributes).properties;
					var length:int = propArray.length;
					var fieldNames:Array = [];
					var fieldValues:Array = [];
					for(var i:int = 0; i < length; i++)
					{
						fieldNames[i] = propArray[i].localName;
						fieldValues[i] = feature.attributes[fieldNames[i]];
					}
					serverFeature._fieldNames = fieldNames;
					serverFeature._fieldValues = fieldValues;					
				}
				return serverFeature;
			}
			return null;
		}

	}
}