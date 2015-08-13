package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;

	/**
	 * ${iServerJava6R_TransferLines_Title}. 
	 * 
	 */	
	public class TransferLines
	{
		private var _lineItems:Array;

		/**
		 * ${iServerJava6R_TransferLines_constructor_D} 
		 * 
		 */			
		public function TransferLines()
		{
		}

		/**
		 * ${iServerJava6R_TransferLines_attribute_linesItems_D} 
		 * @return 
		 * 
		 */		
		public function get lineItems():Array
		{
			return _lineItems;
		}

		sm_internal static function fromJson(object:Object):TransferLines//解析json的标准方法
		{
			if (object == null)
				return null;
			
			var transferLines:TransferLines = new TransferLines();
			if (object.lineItems && (object.lineItems as Array).length)
			{ 
				var transferlinesArray:Array = object.lineItems as Array;
				transferLines._lineItems = [];
				var transferLinesLength:int = transferlinesArray.length;
				for (var i:int = 0; i < transferLinesLength; i++)
				{
					transferLines._lineItems.push(TransferLine.fromJson(transferlinesArray[i]));
				}
			}
			return transferLines;
		}

	}
}