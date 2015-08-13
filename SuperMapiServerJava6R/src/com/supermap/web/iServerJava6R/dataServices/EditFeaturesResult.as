package com.supermap.web.iServerJava6R.dataServices
{
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_EditFeaturesResult_Title}.
	 * <p>${iServerJava6R_EditFeaturesResult_Description}</p> 
	 * 
	 */	
	public class EditFeaturesResult
	{
		private var _succeed:Boolean;

		private var _newResourceLocation:String;
		
		private var _IDs:Array;
		
		/**
		 * ${iServerJava6R_EditFeaturesResult_constructor_D} 
		 * 
		 */		
		public function EditFeaturesResult()
		{
		}
		
		/**
		 * ${iServerJava6R_EditFeaturesResult_attribute_IDs_D} 
		 * @return 
		 * 
		 */		
		public function get IDs():Array
		{
			return _IDs;
		}

		/**
		 * ${iServerJava6R_EditFeaturesResult_attribute_newResourceLocation_D} 
		 * @return 
		 * 
		 */		
		public function get newResourceLocation():String
		{
			return _newResourceLocation;
		}

		/**
		 * ${iServerJava6R_EditFeaturesResult_attribute_succeed_D} 
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
		public static function fromJson(json:Object) : EditFeaturesResult
		{
			if (json == null)
				return null;
			
			var result:EditFeaturesResult = new EditFeaturesResult();
			
			if(json is Array)
			{
				result._succeed = true;
				result._IDs = json as Array;
			}
			else
			{
				result._succeed = json["succeed"];
				
				if (json.hasOwnProperty("newResourceLocation"))
				{
					result._newResourceLocation = json["newResourceLocation"];
				}
			
			}
			return result;
		}
	}
}