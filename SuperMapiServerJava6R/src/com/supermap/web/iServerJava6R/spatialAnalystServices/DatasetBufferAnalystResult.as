package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.Recordset;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;

	/**
	 * ${iServerJava6R_DatasetBufferAnalystResult_Title}.
	 * <p>${iServerJava6R_DatasetBufferAnalystResult_Description}</p> 
	 * 
	 */	
	public class DatasetBufferAnalystResult extends SpatialAnalystResult
	{
		private var _recordset:Recordset;
		private var _dataset:String;
		/**
		 * ${iServerJava6R_DatasetBufferAnalystResult_constructor_D} 
		 * 
		 */		
		public function DatasetBufferAnalystResult()
		{
			super();
		}	

		/**
		 * ${iServerJava6R_DatasetBufferAnalystResult_attribute_recordset_D} 
		 * @return 
		 * 
		 */		
		public function get recordset():Recordset
		{
			return _recordset;
		}
		
		public function get dataset():String
		{
			return _dataset;
		}
		
		sm_internal static function toDatasetBufferAnalystResult(object:Object):DatasetBufferAnalystResult
		{
			var datasetResult:DatasetBufferAnalystResult;
			if(object)
			{
				datasetResult = new DatasetBufferAnalystResult();
				datasetResult._dataset = object.dataset;
				if(object.succeed)
					datasetResult._recordset = Recordset.fromJson(object.recordset);
				else
					datasetResult.setErrorMsgValue(object.error.errorMsg);
				
				datasetResult.setSucceedValue(object.succeed);
			}
			return datasetResult;
		}

	}
}