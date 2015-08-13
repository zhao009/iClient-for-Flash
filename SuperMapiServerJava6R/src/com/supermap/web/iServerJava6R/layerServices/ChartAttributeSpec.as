package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ChartAttributeSpec_Title}.
	 * <p>${iServerJava6R_ChartAttributeSpec_Description}</p> 
	 */	
	public class ChartAttributeSpec
	{
		/**
		 * ${iServerJava6R_ChartAttributeSpec_Constructor_D} 
		 * 
		 */	
		public function ChartAttributeSpec()
		{
		}
		
		private var _code:int;
		
		private var _required:int;

		/**
		 * ${iServerJava6R_ChartAttributeSpec_attribute_code_D} 
		 * 
		 */	
		public function get code():int
		{
			return _code;
		}

		/**
		 * ${iServerJava6R_ChartAttributeSpec_attribute_requried_D} 
		 * 
		 */	
		public function get required():int
		{
			return _required;
		}

		sm_internal static function fromJson(json:Object):ChartAttributeSpec
		{
			var chartAttri:ChartAttributeSpec;
			if(json)
			{
				chartAttri = new ChartAttributeSpec();
				
				if(json.code)
				{
					chartAttri._code = json.code;
				}
				if(json.required)
				{
					chartAttri._required = json.required;
				}
				
			}
			return chartAttri;
		}
	}
}