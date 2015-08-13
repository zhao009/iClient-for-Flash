package com.supermap.components.serviceExtend
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.styles.PredefinedMarkerStyle;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;

	public class ExtendRecordSet
	{
		private var _features:Array;
		public function get features():Array
		{
			return _features;
		}

		public function set features(value:Array):void
		{
			_features = value;
		}

		public static function toExtendRecordSet(object:Object):ExtendRecordSet
		{
			var recordset:ExtendRecordSet;
			if(object && object.length)
			{
				recordset = new ExtendRecordSet();
				var fs:Array = [];
				for(var k:int = 0; k < object.length; k++)
				{ 
					var recordObject:Object = object[k];
					
					var tempFields:Array = recordObject.fields;
					var tempFieldValues:Array = recordObject.fieldValues;
					
					var featureAttribute:Object = new Object();
					if(tempFields && tempFields.length)
					{
						var fieldsLength:int = tempFields.length;
						
						var feature:Feature = new Feature();
						var fieldName:String;
						var fieldValue:*;
						
						var x:Number;
						var y:Number;
						feature.fields = new Array();
						for (var i:int = 0; i < fieldsLength; i++)
						{ 
							fieldName = tempFields[i].toString().toUpperCase();
							fieldValue = tempFieldValues[i];
							featureAttribute[fieldName] = fieldValue; 
							
							var fieldObject:Object = new Object();
							fieldObject.key = fieldName; 
							fieldObject.value = fieldValue;
							feature.fields.push(fieldObject);
							
							if(fieldName == "SMID")
								feature.id = fieldValue as String;
							
							if(fieldName == "SMX")
								x = fieldValue;
							if(fieldName == "SMY")
								y = fieldValue;
							
						}
						feature.attributes = featureAttribute;
						feature.geometry = new GeoPoint(x, y);
						feature.style = new PredefinedMarkerStyle();
						fs.push(feature);
					}
				}
				recordset.features = fs;
				return recordset;
			}
			return null;
		}
		
	}
}