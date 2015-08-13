package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_TransferSolution_Title}. 
	 * 
	 */	
	public class TransferSolution
	{
		private var _transferCount:int;
		private var _linesItems:Array;
		
		/**
		 * ${iServerJava6R_TransferSolution_constructor_D} 
		 * 
		 */			
		public function TransferSolution()
		{
		}

		/**
		 * ${iServerJava6R_TransferSolution_attribute_linesItems_D} 
		 * @return 
		 * 
		 */	
		public function get linesItems():Array
		{
			return _linesItems;
		}

		/**
		 * ${iServerJava6R_TransferSolution_attribute_transferCount_D} 
		 * @return 
		 * 
		 */	
		public function get transferCount():int
		{
			return _transferCount;
		}
		
		sm_internal static function fromJson(object:Object):TransferSolution//解析json的标准方法
		{
			if (object == null)
				return null;
			
			var transferSolution:TransferSolution = new TransferSolution();
			transferSolution._transferCount = object.transferCount;
			
			if (object.linesItems && (object.linesItems as Array).length)
			{ 
				var transferlinesArray:Array = object.linesItems as Array;
				transferSolution._linesItems = [];
				var transferLinesLength:int = transferlinesArray.length;
				for (var i:int = 0; i < transferLinesLength; i++)
				{
					transferSolution._linesItems.push(TransferLines.fromJson(transferlinesArray[i]));
				}
			}
			return transferSolution;
		}

	}
}