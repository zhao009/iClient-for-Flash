package com.supermap.web.iServerJava6R.serviceEvents
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.InterpolationAnalystResult;

	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	public class InterpolationAnalystEvent extends ServiceEvent
	{
		public static const PROCESS_COMPLETE:String = "processComplete";
		
		private var _result:InterpolationAnalystResult;
		
		public function InterpolationAnalystEvent(type:String, result:InterpolationAnalystResult, originResult:Object)
		{
			super(type, originResult);
			this._result = result;
		}
		
		public function get result():InterpolationAnalystResult
		{
			return _result;
		}
	}
}