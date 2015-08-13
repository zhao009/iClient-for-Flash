package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_TransferGuide_Title}.
	 * <p>${iServerJava6R_TransferGuide_Description}</p> 
	 * 
	 */	
	public class TransferGuide
	{
		private var _items:Array;
		private var _count:int;
		private var _totalDistance:Number;
//		private var _totalWeight:Number;
		private var _transferCount:int;
		/**
		 * ${iServerJava6R_TransferGuide_constructor_D} 
		 * 
		 */	
		public function TransferGuide()
		{
		}
		/**
		 * ${iServerJava6R_TransferGuide_attribute_transferCount_D} 
		 * @return 
		 * 
		 */	
		public function get transferCount():int
		{
			return _transferCount;
		}
//		/**
//		 * ${iServerJava6R_TransferGuide_attribute_totalWeight_D} 
//		 * @return 
//		 * 
//		 */	
//		public function get totalWeight():Number
//		{
//			return _totalWeight;
//		}
		/**
		 * ${iServerJava6R_TransferGuide_attribute_totalDistance_D} 
		 * @return 
		 * 
		 */	
		public function get totalDistance():Number
		{
			return _totalDistance;
		}
		/**
		 * ${iServerJava6R_TransferGuide_attribute_count_D} 
		 * @return 
		 * 
		 */	
		public function get count():int
		{
			return _count;
		}
		/**
		 * ${iServerJava6R_TransferGuide_attribute_items_D} 
		 * @return 
		 * 
		 */	
		public function get items():Array
		{
			return _items;
		}

		sm_internal static function fromJson(object:Object):TransferGuide
		{
			var transferGuide:TransferGuide;
			if(object)
			{
				transferGuide = new TransferGuide();
				transferGuide._count = object.count;
				transferGuide._totalDistance = object.totalDistance;
//				transferGuide._totalWeight = object.totalWeight;
				transferGuide._transferCount = object.transferCount;
				
				var tempItems:Array = object.items;
				if(tempItems && tempItems.length)
				{
					transferGuide._items = [];
					var tempItemsLength:int = tempItems.length;
					for(var i:int = 0; i < tempItemsLength; i++)
					{
						var transferGuideItem:TransferGuideItem = TransferGuideItem.fromJson(tempItems[i]);
						transferGuide._items.push(transferGuideItem);
					}
				}
			}
			return transferGuide;
		}
		
	}
}