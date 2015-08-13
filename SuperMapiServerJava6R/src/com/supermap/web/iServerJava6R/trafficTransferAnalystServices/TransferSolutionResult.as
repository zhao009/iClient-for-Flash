package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_TransferSolutionResult_Title}.
	 * 
	 */	
	public class TransferSolutionResult
	{
		private var _transferGuide:TransferGuide;
		private var _solutionItems:Array;
		/**
		 * ${iServerJava6R_TransferSolutionResult_constructor_D} 
		 * 
		 */		
		public function TransferSolutionResult()
		{
		}

		/**
		 * ${iServerJava6R_TransferSolutionResult_attribute_solutionItems_D} 
		 * @return 
		 * 
		 */	
		public function get solutionItems():Array
		{
			return _solutionItems;
		}

		/**
		 * ${iServerJava6R_TransferSolutionResult_attribute_transferGuide_D} 
		 * @return 
		 * 
		 */			
		public function get transferGuide():TransferGuide
		{
			return _transferGuide;
		}


//		/**
//		 * ${iServerJava6R_TrafficTransferResult_attribute_transferGuides_D} 
//		 * @return 
//		 * 
//		 */	
//		public function get transferGuides():Array
//		{
//			return _transferGuides;
//		}

		sm_internal static function fromJson(object:Object):TransferSolutionResult//解析json的标准方法
		{
			if (object == null)
				return null;
			
			var result:TransferSolutionResult = new TransferSolutionResult();
			result._transferGuide = TransferGuide.fromJson(object.defaultGuide);
			
			if (object.solutionItems && (object.solutionItems as Array).length)
			{ 
				var transferSolutionsArray:Array = object.solutionItems as Array;
				result._solutionItems = [];
				var transferSolutionsLength:int = transferSolutionsArray.length;
				for (var i:int = 0; i < transferSolutionsLength; i++)
				{
					result._solutionItems.push(TransferSolution.fromJson(transferSolutionsArray[i]));
				}
			}
			return result;
		}
	}
}