package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_InterpolationAnalystResult_Title}
	 * 
	 */	
	public class InterpolationAnalystResult extends SpatialAnalystResult
	{
		private var _dataset:String;	

		/**
		 * ${iServerJava6R_InterpolationAnalystResult_constructor_D} 
		 * 
		 */		
		public function InterpolationAnalystResult()
		{
			super();
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystResult_attribute_dataset_D}
		 * @return 
		 * 
		 */		
		public function get dataset():String
		{
			return _dataset;
		}

		sm_internal static function fromJson(object:Object):InterpolationAnalystResult
		{
			var interResult:InterpolationAnalystResult;
			if(object)
			{
				interResult = new InterpolationAnalystResult();
				
				if(object.succeed)
				{
					interResult._dataset = object.dataset;
				}
				else
					interResult.setErrorMsgValue(object.error.errorMsg);
				
				interResult.setSucceedValue(object.succeed);
				
			}
			return interResult;
		}
	}
}