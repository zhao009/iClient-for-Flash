package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_TransferStopInfo_Title}.
	 * <p>${iServerJava6R_TransferStopInfo_Description}</p> 
	 * 
	 */	
	public class TransferStopInfo
	{
		private var _alias:String;
		private var _id:int;
		private var _name:String;
		private var _position:Point2D;
		private var _stopID:Number;
		/**
		 * ${iServerJava6R_TransferStopInfo_contructor_D} 
		 * 
		 */	
		public function TransferStopInfo()
		{
		}
		/**
		 * ${iServerJava6R_TransferStopInfo_attribute_stopID_D} 
		 * @return   
		 * 
		 */	
		public function get stopID():Number
		{
			return _stopID;
		}
		/**
		 * ${iServerJava6R_TransferStopInfo_attribute_position_D} 
		 * @return   
		 * 
		 */
		public function get position():Point2D
		{
			return _position;
		}
		/**
		 * ${iServerJava6R_TransferStopInfo_attribute_name_D} 
		 * @return   
		 * 
		 */
		public function get name():String
		{
			return _name;
		}
		/**
		 * ${iServerJava6R_TransferStopInfo_attribute_id_D} 
		 * @return   
		 * 
		 */
		public function get id():int
		{
			return _id;
		}
		/**
		 * ${iServerJava6R_TransferStopInfo_attribute_alias_D} 
		 * @return   
		 * 
		 */
		public function get alias():String
		{
			return _alias;
		}

		sm_internal static function fromJson(object:Object):TransferStopInfo
		{
			var transferStopInfo:TransferStopInfo;
			if(object)
			{
				transferStopInfo = new TransferStopInfo();
				
				transferStopInfo._alias = object.alias;
				transferStopInfo._id = object.id;
				transferStopInfo._name = object.name;
				transferStopInfo._position = JsonUtil.toPoint2D(object.position);
				transferStopInfo._stopID = object.stopID;
			}
			
			return transferStopInfo;
		}
	}
}