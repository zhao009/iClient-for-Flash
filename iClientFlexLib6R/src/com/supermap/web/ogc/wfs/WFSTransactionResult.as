package com.supermap.web.ogc.wfs
{

	/**
	 * ${ogc_wfs_WFSTransactionResult_Title}. 
	 * <p>${ogc_wfs_WFSTransactionResult_Description}</p>
	 * 
	 */	
	public class WFSTransactionResult
	{
		private var _status:String;
		
		private var _message:String;

		private var _featureIDs:Array;
		
		/**
		 * ${ogc_wfs_WFSTransactionResult_constructor_string_D} 
		 * 
		 */		
		public function WFSTransactionResult()
		{
		}

		/**
		 * ${ogc_wfs_WFSTransactionResult_attribute_featureIds_D}
		 * @return 
		 * 
		 */		
		public function get featureIDs():Array
		{
			return _featureIDs;
		}

		public function set featureIDs(value:Array):void
		{
			_featureIDs = value;
		}

		/**
		 * ${ogc_wfs_WFSTransactionResult_attribute_message_D} 
		 * @return 
		 * 
		 */		
		public function get message():String
		{
			return _message;
		}

		public function set message(value:String):void
		{
			_message = value;
		}

		/**
		 * ${ogc_wfs_WFSTransactionResult_attribute_status_D} 
		 * @return 
		 * 
		 */		
		public function get status():String
		{
			return _status;
		}

		public function set status(value:String):void
		{
			_status = value;
		}

	}
}
