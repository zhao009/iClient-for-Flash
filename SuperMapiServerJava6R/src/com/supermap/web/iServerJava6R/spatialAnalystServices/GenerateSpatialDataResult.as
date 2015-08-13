package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.Recordset;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_GenerateSpatialDataResult_Title}.
	 * 
	 */	
	public class GenerateSpatialDataResult extends SpatialAnalystResult
	{
		private var _dataset:String;
		private var _recordset:Recordset;
		/**
		 * ${iServerJava6R_GenerateSpatialDataResult_constructor_D} 
		 * 
		 */	
		public function GenerateSpatialDataResult()
		{
			super();
		}
		/**
		 * ${iServerJava6R_GenerateSpatialDataResult_attribute_dataset_D} 
		 * @return 
		 * 
		 */	
		public function get dataset():String
		{
			return _dataset;
		}
		/**
		 * ${iServerJava6R_GenerateSpatialDataResult_attribute_recordset_D} 
		 * @return 
		 * 
		 */	
		public function get recordset():Recordset
		{
			return _recordset;
		}
		
		sm_internal static function fromJson(object:Object):GenerateSpatialDataResult
		{
			var result:GenerateSpatialDataResult;
			if(object)
			{
				result = new GenerateSpatialDataResult();
				result.setSucceedValue(object.succeed);
				if(object.succeed)
					result._recordset = Recordset.fromJson(object.recordset);
				else
					result.setErrorMsgValue(object.error.errorMsg);
				result._dataset = object.dataset;
			}
			return result;
		}
	}
}