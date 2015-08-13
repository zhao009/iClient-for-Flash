package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.Recordset;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_DatasetsOverlayAnalystResult_Title}.
	 * <p>${iServerJava6R_DatasetsOverlayAnalystResult_Description}</p> 
	 * 
	 */	
	public class DatasetOverlayAnalystResult extends SpatialAnalystResult
	{
		private var _dataset:String;
		private var _recordset:Recordset;
		
		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystResult_constructor_D} 
		 * 
		 */		
		public function DatasetOverlayAnalystResult()
		{
			
		}
		
		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystResult_attribute_recordset_D} 
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

		sm_internal static function fromJson(object:Object):DatasetOverlayAnalystResult
		{
			var datasetResult:DatasetOverlayAnalystResult;
			if(object)
			{
				datasetResult = new DatasetOverlayAnalystResult();
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