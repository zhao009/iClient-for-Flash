package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;

	use namespace sm_internal;
		/**
		 * ${iServerJava6R_TransferGuideItem_Title}.
		 * <p>${iServerJava6R_TransferGuideItem_Description}</p> 
		 * 
		 */	
	public class TransferGuideItem
	{
		private var _distance:Number;
		private var _endIndex:int;
		private var _endStopName:String;
		private var _endPosition:Point2D;
		private var _lineName:String;
		private var _lineType:int;
		private var _passStopCount:int;
		private var _route:GeoLine;
		private var _startIndex:int;
		private var _startPosition:Point2D;
		private var _startStopName:String;
		private var _isWalking:Boolean;
		
		/**
		 * ${iServerJava6R_TransferGuideItem_contructor_D} 
		 * 
		 */
		public function TransferGuideItem()
		{
		}

		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_lineType_D} 
		 * @return 
		 * 
		 */	
		public function get lineType():int
		{
			return _lineType;
		}

		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_endPosition_D} 
		 * @return 
		 * 
		 */	
		public function get endPosition():Point2D
		{
			return _endPosition;
		}

		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_lineName_D} 
		 * @return 
		 * 
		 */	
		public function get lineName():String
		{
			return _lineName;
		}

		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_startPosition_D} 
		 * @return 
		 * 
		 */	
		public function get startPosition():Point2D
		{
			return _startPosition;
		}

		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_startStopName_D} 
		 * @return 
		 * 
		 */	
		public function get startStopName():String
		{
			return _startStopName;
		}

		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_endStopName_D} 
		 * @return 
		 * 
		 */	
		public function get endStopName():String
		{
			return _endStopName;
		}

		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_route_D} 
		 * @return 
		 * 
		 */	
		public function get route():GeoLine
		{
			return _route;
		}


		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_isWalking_D} 
		 * @return 
		 * 
		 */	
		public function get isWalking():Boolean
		{
			return _isWalking;
		}
//		/**
//		 * ${iServerJava6R_TransferGuideItem_attribute_weight_D} 
//		 * @return 
//		 * 
//		 */	
//		public function get weight():Number
//		{
//			return _weight;
//		}
//		/**
//		 * ${iServerJava6R_TransferGuideItem_attribute_lineInfo_D} 
//		 * @return 
//		 * 
//		 */	
//		public function get lineInfo():TransferLineInfo
//		{
//			return _lineInfo;
//		}
		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_passStopCount_D} 
		 * @return 
		 * 
		 */	
		public function get passStopCount():int
		{
			return _passStopCount;
		}
//		/**
//		 * ${iServerJava6R_TransferGuideItem_attribute_endStopInfo_D} 
//		 * @return 
//		 * 
//		 */	
//		public function get endStopInfo():TransferStopInfo
//		{
//			return _endStopInfo;
//		}
//		/**
//		 * ${iServerJava6R_TransferGuideItem_attribute_startStopInfo_D} 
//		 * @return 
//		 * 
//		 */
//		public function get startStopInfo():TransferStopInfo
//		{
//			return _startStopInfo;
//		}
		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_startIndex_D} 
		 * @return 
		 * 
		 */
		public function get startIndex():int
		{
			return _startIndex;
		}
		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_endIndex_D} 
		 * @return 
		 * 
		 */
		public function get endIndex():int
		{
			return _endIndex;
		}
		/**
		 * ${iServerJava6R_TransferGuideItem_attribute_distance_D} 
		 * @return 
		 * 
		 */
		public function get distance():Number
		{
			return _distance;
		}

		sm_internal static function fromJson(object:Object):TransferGuideItem
		{
			var transferGuideItem:TransferGuideItem;
			if(object)
			{
				transferGuideItem = new TransferGuideItem();
				
				transferGuideItem._distance = object.distance;
				transferGuideItem._endIndex = object.endIndex;
				transferGuideItem._startIndex = object.startIndex;
				transferGuideItem._isWalking = object.isWalking;
				transferGuideItem._passStopCount = object.passStopCount;
				transferGuideItem._endStopName = object.endStopName;
				transferGuideItem._endPosition = JsonUtil.toPoint2D(object.endPosition);
				transferGuideItem._lineName = object.lineName;
				transferGuideItem._lineType = object.lineType;
				transferGuideItem._startStopName = object.startStopName;
				transferGuideItem._startPosition = JsonUtil.toPoint2D(object.startPosition);
				transferGuideItem._route = ServerGeometry.fromJson(object.route).toGeoLine();
			}
			return transferGuideItem;
		}
	}
}