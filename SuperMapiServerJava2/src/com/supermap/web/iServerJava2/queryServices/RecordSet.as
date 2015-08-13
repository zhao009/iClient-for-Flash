package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.iServerJava2.ServerFeatureType;
	import com.supermap.web.iServerJava2.ServerGeometry;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	
	/**
	 * ${iServer2_Query_Recordset_Title}. 
	 * <br/> ${iServer2_Query_Recordset_Description}
	 * 
	 * 
	 */	
	public class RecordSet
	{
		private var _layerName:String;
        private var _records:Array;
        private var _returnFieldCaptions:Array;
        private var _returnFields:Array;
        private var _returnFieldTypes:Array;
        
		/**
		 * ${iServer2_Query_Recordset_constructor_D} 
		 * 
		 */        
		public function RecordSet()
		{
		}
		
		/**
		 * ${iServer2_Query_Recordset_attribute_layerName_D_as}  
		 * 
		 */		
		public function get layerName():String
		{
			return this._layerName;
		}
		
		/**
		 * ${iServer2_Query_Recordset_attribute_records_D_as} 
		 * 
		 */		
		public function get records():Array
		{
			return this._records;
		}
		
		/**
		 * ${iServer2_Query_Recordset_attribute_returnFieldCaptions_D} 
		 * 
		 */		
		public function get returnFieldCaptions():Array
		{
			return this._returnFieldCaptions;
		}
		
		/**
		 * ${iServer2_Query_Recordset_attribute_returnFields_D} 
		 * 
		 */		
		public function get returnFields():Array
		{
			return this._returnFields;
		}
		
		/**
		 * ${iServer2_Query_Recordset_attribute_returnFieldTypes_D} 
		 * 
		 */		
		public function get returnFieldTypes():Array
		{
			return this._returnFieldTypes;
		}
		
		/**
		 * @private 
		 * @param object
		 * @return 
		 * 
		 */		
		sm_internal static function toRecordSet(object:Object):RecordSet
		{
			var recordSet:RecordSet;
			if(object)
			{
				recordSet = new RecordSet();
				recordSet._layerName = object.layerName;
				recordSet._returnFieldCaptions = object.returnFieldCaptions;
				recordSet._returnFields = object.returnFields;
				recordSet._returnFieldTypes = object.returnFieldTypes;
				
				var tempRecords:Array = object.records;
				if(tempRecords)
				{
					if(tempRecords.length > 0)
					{
						recordSet._records = new Array();
						for(var i:int = 0; i < tempRecords.length; i++)
							recordSet._records.push(Record.toRecord(tempRecords[i]));	
					}
				}
				
			}
			return recordSet;
		}
		
		/**
		 * ${iServer2_Query_Recordset_method_toFeatureSet_D_as} 
		 * @return ${iServer2_Query_Recordset_method_toFeatureSet_return}
		 * 
		 */
		public function toFeatureSet():Array
		{
			if(!records)
				return null;
			
			var featureSet:Array = new Array();
			for(var i:int = 0; i < records.length; i++)
			{
				var record:Record = records[i];
				var serverGeometry:ServerGeometry = record.shape;
				var feature:Feature = new Feature();
				
				if(record.fieldValues != null)
				{										
					var object:Object = new Object();	 
					var fieldsArray:Array = [];
					for(var j:int = 0; j < this._returnFields.length; j++)
					{
						var fieldName:String = this._returnFields[j].toString().toUpperCase();
						var fieldValue:Object = record.fieldValues[j];
						object[fieldName] = fieldValue;
						
						var fieldObject:Object = new Object();
						fieldObject.key = fieldName;
						fieldObject.value = fieldValue;
						fieldsArray.push(fieldObject);
						if(fieldName == "SMID")
							feature.id = fieldName;
					}
					feature.fields = fieldsArray;
					feature.attributes = object;											
				}
				
				if(serverGeometry)
					if(serverGeometry.feature)
					{
						if(serverGeometry.feature == ServerFeatureType.POINT)
						{
							feature.geometry = serverGeometry.toGeoPoint();
						}
						else if(serverGeometry.feature == ServerFeatureType.LINE)
						{
							feature.geometry = serverGeometry.toGeoLine();
						}
							
						else if(serverGeometry.feature == ServerFeatureType.POLYGON)
						{
							feature.geometry = serverGeometry.toGeoRegion();
						}
						
						featureSet.push(feature);
					}
			}
			return featureSet;
		}
	
	}
}