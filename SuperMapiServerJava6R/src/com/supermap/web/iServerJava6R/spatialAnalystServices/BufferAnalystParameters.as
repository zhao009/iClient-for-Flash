package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	/**
	 * ${iServerJava6R_BufferAnalystParameters_Title}.
	 * <p>${iServerJava6R_BufferAnalystParameters_Description}</p> 
	 * 
	 */	
	public class BufferAnalystParameters
	{
		private var _bufferSetting:BufferSetting;
		/**
		 * ${iServerJava6R_BufferAnalystParameters_constructor_D} 
		 * 
		 */		
		public function BufferAnalystParameters()
		{
		}
		
		/**
		 * ${iServerJava6R_BufferAnalystParameters_attribute_bufferSetting_D}.
		 * <p>${iServerJava6R_BufferAnalystParameters_attribute_bufferSetting_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get bufferSetting():BufferSetting
		{
			return _bufferSetting;
		}

		public function set bufferSetting(value:BufferSetting):void
		{
			_bufferSetting = value;
		}

	}
}