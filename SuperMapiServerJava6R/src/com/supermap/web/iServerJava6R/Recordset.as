package com.supermap.web.iServerJava6R
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.styles.TextStyle;
	import com.supermap.web.utils.serverTypes.ServerFeature;
	import com.supermap.web.utils.serverTypes.ServerGeometryType;
	import com.supermap.web.utils.serverTypes.ServerTextStyle;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_Query_Recordset_Title}.
	 * <p>${iServerJava6R_Query_Recordset_Description}</p> 
	 * 
	 */	
	public class Recordset
	{
		private var _datasetName:String;
		private var _fieldCaptions:Array;
		private var _fields:Array;
		private var _fieldTypes:Array;
		private var _features:Array;
		
		/**
		 * ${iServerJava6R_Query_Recordset_Title}.
		 * <p>${iServerJava6R_Query_Recordset_Description}</p> 
		 * 
		 */		
		public function Recordset():void
		{
			
		}
		
		/**
		 * ${iServerJava6R_Query_Recordset_attribute_DatasetName_D} 
		 * @return 
		 * 
		 */		
		public function get datasetName():String
		{
			return this._datasetName;
		}
		
		/**
		 * ${iServerJava6R_Query_Recordset_attribute_FieldCaptions_D}.
		 * <p>${iServerJava6R_Query_Recordset_attribute_FieldCaptions_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get fieldCaptions():Array
		{
			return this._fieldCaptions;
		}
		
		/**
		 * ${iServerJava6R_Query_Recordset_attribute_Fields_D}.
		 * <p>${iServerJava6R_Query_Recordset_attribute_Fields_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get fields():Array
		{
			return this._fields;
		}
		
		/**
		 * ${iServerJava6R_Query_Recordset_attribute_FieldTypes_D}.
		 * <p>${iServerJava6R_Query_Recordset_attribute_FieldTypes_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get fieldTypes():Array
		{
			return this._fieldTypes;
		}
		
		/**
		 * ${iServerJava6R_Query_Recordset_attribute_Features_D}.
		 * @see com.supermap.web.core.Feature
		 * @return 
		 * 
		 */		
		public function get features():Array
		{
			return this._features;
		}
		
		sm_internal static function fromJson(object:Object):Recordset
		{
			var recordset:Recordset;
			if(object)
			{
				recordset = new Recordset();
				
				recordset._datasetName = object.datasetName;
				recordset._fieldCaptions = object.fieldCaptions;
				recordset._fields = object.fields;
				recordset._fieldTypes = object.fieldTypes;
				
				var tempFeatures:Array = object.features;
				if(tempFeatures)
				{
					if(tempFeatures.length > 0)
					{
						recordset._features = [];
						var tempFeaturesLength:int = tempFeatures.length;
						for(var i:int = 0; i < tempFeaturesLength; i++)
						{
							var serverFeature:ServerFeature = ServerFeature.fromJson(tempFeatures[i]);
							if(recordset._fields && recordset._fields.length)
							{
								var fieldsLength:int = recordset._fields.length;
								for (var j:int = 0; j < fieldsLength; j++)
								{
									serverFeature.fieldNames.push(recordset._fields[j]);
								}
							}
							var feature:Feature = ServerFeature.toFeature(serverFeature);
							//支持文本对象 byzyn
							if(feature.geometry is GeoPoint)
							{
								if(feature.geometry.type == ServerGeometryType.TEXT)
								{
									var geoPoint:GeoPoint = feature.geometry as GeoPoint;
									var textStyle:TextStyle = ServerTextStyle.serverStyleToClientStyle(serverFeature.geometry.textStyle);
									var tempStr:String = "";
									for(var n:int=0; n<serverFeature.geometry.text.length; n++)
									{
										tempStr+=serverFeature.geometry.text[n];
									}
									textStyle.text = tempStr;//(serverFeature.geometry.text.toString()). .replace(",","");
									feature.style = textStyle;
								}
//								else
//									feature.style = new PredefinedMarkerStyle();
							}
//							else if(feature.geometry is GeoLine)
//								feature.style = new PredefinedLineStyle();
//							else if(feature.geometry is GeoRegion)
//								feature.style = new PredefinedFillStyle();
							recordset._features.push(feature);	
						}
					}
				}
				
			}
			return recordset;
		}
	}
}