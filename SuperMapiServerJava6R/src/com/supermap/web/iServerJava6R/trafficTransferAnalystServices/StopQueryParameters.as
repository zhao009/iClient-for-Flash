package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	/**
	 * ${iServerJava6R_StopQueryParameters_Title}.
	 * 
	 */	
	public class StopQueryParameters
	{
		private var _returnPosition:Boolean = false;
		
		private var _keyword:String;
		/**
		 * ${iServerJava6R_StopQueryParameters_constructor_D} 
		 * 
		 */	
		public function StopQueryParameters()
		{
		}
		/**
		 * ${iServerJava6R_StopQueryParameters_attribute_keyword_D} 
		 * @return 
		 * 
		 */	
		public function get keyword():String
		{
			return _keyword;
		}

		public function set keyword(value:String):void
		{
			_keyword = value;
		}
		/**
		 * ${iServerJava6R_StopQueryParameters_attribute_returnPosition_D} 
		 * @return 
		 * 
		 */	
		public function get returnPosition():Boolean
		{
			return _returnPosition;
		}

		public function set returnPosition(value:Boolean):void
		{
			_returnPosition = value;
		}

	}
}