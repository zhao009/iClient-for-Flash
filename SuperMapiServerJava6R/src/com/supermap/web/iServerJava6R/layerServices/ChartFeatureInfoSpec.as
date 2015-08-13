package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ChartFeatureInfoSpec_Title}.
	 * <p>${iServerJava6R_ChartFeatureInfoSpec_Description}</p> 
	 * @see ChartFeatureInfoSpecsService
	 */	
	public class ChartFeatureInfoSpec
	{
		/**
		 * ${iServerJava6R_ChartFeatureInfoSpec_Constructor_D} 
		 * 
		 */	
		public function ChartFeatureInfoSpec()
		{
		}
		
		private var _acronym:String;
		
		private var _code:int;
		
		private var _localName:String;
		
		private var _name:String;
		
		private var _primitive:String;
		
		private var _attributeFields:Array;

		/**
		 * ${iServerJava6R_ChartFeatureInfoSpec_attribute_acronym_D} 
		 * 
		 */	
		public function get acronym():String
		{
			return _acronym;
		}

		/**
		 * ${iServerJava6R_ChartFeatureInfoSpec_attribute_code_D} 
		 * 
		 */	
		public function get code():int
		{
			return _code;
		}

		/**
		 * ${iServerJava6R_ChartFeatureInfoSpec_attribute_localName_D} 
		 * 
		 */	
		public function get localName():String
		{
			return _localName;
		}

		/**
		 * ${iServerJava6R_ChartFeatureInfoSpec_attribute_name_D} 
		 * 
		 */	
		public function get name():String
		{
			return _name;
		}


		/**
		 * ${iServerJava6R_ChartFeatureInfoSpec_attribute_primitive_D} 
		 * 
		 */	
		public function get primitive():String
		{
			return _primitive;
		}


		/**
		 * ${iServerJava6R_ChartFeatureInfoSpec_attribute_attributeFields_D} 
		 * @see ChartAttributeSpec
		 */	
		public function get attributeFields():Array
		{
			return _attributeFields;
		}


		sm_internal static function fromJson(json:Object):ChartFeatureInfoSpec
		{
			var chartInfo:ChartFeatureInfoSpec;
			if(json)
			{
				chartInfo = new ChartFeatureInfoSpec();
				
				if(json.acronym)
				{
					chartInfo._acronym = json.acronym;
				}
				if(json.code)
				{
					chartInfo._code = json.code;
				}
				if(json.localName)
				{
					chartInfo._localName = json.localName;
				}
				if(json.name)
				{
					chartInfo._name = json.name;
				}
				if(json.primitive)
				{
					chartInfo._primitive = json.primitive;
				}
				if(json.attributeFields)
				{
					var attriFields:Array = [];
					for each(var item:Object in json.attributeFields)
					{ 
						attriFields.push(ChartAttributeSpec.fromJson(item));
					}
					chartInfo._attributeFields = attriFields;
				}
			}
			return chartInfo;
		}
	}
}