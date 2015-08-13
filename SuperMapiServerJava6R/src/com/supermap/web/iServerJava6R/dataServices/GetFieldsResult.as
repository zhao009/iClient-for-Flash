package com.supermap.web.iServerJava6R.dataServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_GetFieldsResult_Title}.
	 * <p>${iServerJava6R_GetFieldsResult_Description}</p> 
	 * 
	 */	
	public class GetFieldsResult
	{
		private var _succeed:Boolean;
		
		private var _fieldNames:Array;
		
		private var _childUriList:Array;
		
		/**
		 * ${iServerJava6R_GetFieldsResult_constructor_D} 
		 * 
		 */		
		public function GetFieldsResult()
		{
		}
		/**
		 * ${iServerJava6R_GetFieldsResult_attribute_fieldNames_D} 
		 * @return 
		 * 
		 */		
		public function get fieldNames():Array
		{
			return _fieldNames;
		}
		
		/**
		 * ${iServerJava6R_GetFieldsResult_attribute_childUriList_D} 
		 * @return 
		 * 
		 */		
		public function get childUriList():Array
		{
			return _childUriList;
		}
		
		/**
		 * ${iServerJava6R_GetFieldsResult_attribute_succeed_D} 
		 * @return 
		 * 
		 */		
		public function get succeed():Boolean
		{
			return _succeed;
		}
		
		/**
		 * @private 
		 * @param json
		 * @return 
		 * 
		 */		
		public static function fromJson(json:Object) : GetFieldsResult
		{
			if (json == null)
				return null;
			
			var result:GetFieldsResult = new GetFieldsResult();
			
			
			result._succeed = true;
			result._fieldNames = json.fieldNames as Array;
			result._childUriList = json.childUriList as Array;
			
			return result;
		}
	}
}