package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_StopQueryResult_Title}.
	 * 
	 */	
	public class StopQueryResult
	{
		private var _transferStopInfos:Array;
		/**
		 * ${iServerJava6R_StopQueryResult_constructor_D} 
		 * 
		 */	
		public function StopQueryResult()
		{
		}
		/**
		 * ${iServerJava6R_StopQueryResult_attribute_transferStopInfos_D} 
		 * @return 
		 * 
		 */	
		public function get transferStopInfos():Array
		{
			return _transferStopInfos;
		}
		
		sm_internal static function fromJson(object:Object):StopQueryResult//解析json的标准方法
		{
			if (object == null)
				return null;
			
			var result:StopQueryResult = new StopQueryResult();
			
			var tempTSInfos:Array = object as Array;
			if (tempTSInfos.length)
			{ 
				result._transferStopInfos = [];
				var tempTSInfosLength:int = tempTSInfos.length;
				for (var i:int = 0; i < tempTSInfosLength; i++)
				{
					result._transferStopInfos.push(TransferStopInfo.fromJson(tempTSInfos[i]));
				}
			}
			return result;
		}
		
	}
}