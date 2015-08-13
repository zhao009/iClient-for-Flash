package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.Recordset;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;

	/**
	 * ${iServerJava6R_SurfaceAnalystResult_Title}.
	 * <p>${iServerJava6R_SurfaceAnalystResult_Description}</p> 
	 * 
	 */	
	public class SurfaceAnalystResult extends SpatialAnalystResult
	{
		private var _recordset:Recordset;
		private var _dataset:String;
		
		/**
		 * ${iServerJava6R_SurfaceAnalystResult_constructor_D} 
		 * 
		 */		
		public function SurfaceAnalystResult()
		{
			
		}

		/**
		 * ${iServerJava6R_SurfaceAnalystResult_attribute_recordset_D} 
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
		
		sm_internal static function fromJson(object:Object):SurfaceAnalystResult
		{
			var extractResult:SurfaceAnalystResult;
			if(object)
			{
				extractResult = new SurfaceAnalystResult();
				extractResult._dataset = object.dataset;
				if(object.succeed)
				{
					extractResult._recordset = Recordset.fromJson(object.recordset);
				}
				else
					extractResult.setErrorMsgValue(object.error.errorMsg);
				
				extractResult.setSucceedValue(object.succeed);
			}
			return extractResult;
		}

	}
}