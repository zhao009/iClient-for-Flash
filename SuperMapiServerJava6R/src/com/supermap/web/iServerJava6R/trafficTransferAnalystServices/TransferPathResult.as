package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;

	/**
	 * ${iServerJava6R_TransferPathResult_Title}. 
	 * 
	 */		
	public class TransferPathResult
	{
		private var _transferGuide:TransferGuide;

		/**
		 * ${iServerJava6R_TransferPathResult_constructor_D} 
		 * 
		 */			
		public function TransferPathResult()
		{
		}
		/**
		 * ${iServerJava6R_TransferPathResult_attribute_transferGuide_D} 
		 * @return 
		 * 
		 */			
		public function get transferGuide():TransferGuide
		{
			return _transferGuide;
		}

		sm_internal static function fromJson(object:Object):TransferPathResult//解析json的标准方法
		{
			if (object == null)
				return null;
			
			var result:TransferPathResult = new TransferPathResult();
			result._transferGuide = TransferGuide.fromJson(object);
			return result;
		}
	}
}