package com.supermap.web.iServerJava6R.themeServices
{
	/**
	 * ${iServerJava6R_ThemeMemoryData_Title}.
	 * <p>${iServerJava6R_ThemeMemoryData_Description}</p> 
	 * 
	 */	
	public class ThemeMemoryData
	{
		private var _srcData:Array;
		private var _targetData:Array;
		/**
		 * ${iServerJava6R_ThemeMemoryData_constructor_D} 
		 * 
		 */		
		public function ThemeMemoryData()
		{
		}

		/**
		 * ${iServerJava6R_ThemeMemoryData_attribute_targetData_D}
		 * @see #srcData
		 * @return 
		 * 
		 */		
		public function get targetData():Array
		{
			return _targetData;
		}

		public function set targetData(value:Array):void
		{
			_targetData = value;
		}

		/**
		 * ${iServerJava6R_ThemeMemoryData_attribute_srcData_D}
		 * @see #targetData
		 * @return 
		 * 
		 */		
		public function get srcData():Array
		{
			return _srcData;
		}

		public function set srcData(value:Array):void
		{
			_srcData = value;
		}
		public function toJSON():String{
			if(_srcData&&_targetData){
				var memoryStr:String = "";
				for(var k:int = 0; k<Math.min(_targetData.length,_srcData.length); k++){
					memoryStr += "\"" + _srcData[k] + "\":\"" + _targetData[k] + "\",";
				}
				return "{" + memoryStr +"}";
			}else{
				return "null";
			}
		}
	}
}