package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServer2_networkAnalystServices_TSPPathParam_Title}.
	 * <p>${iServer2_networkAnalystServices_TSPPathParam_Description}</p>
	 * 
	 * 
	 */
	public class TSPPathParam
	{
		//是否指定旅行终点
		private var _isEndNodeAssigned:Boolean;
		//网络参数对象
		private var _networkAnalystParam:NetworkAnalystParam;
		
		/**
		 * ${iServer2_networkAnalystServices_TSPPathParam_constructor_None_D}
		 * 
		 */
		public function TSPPathParam()
		{
		}
		
		/**
		 * ${iServer2_networkAnalystServices_TSPPathParam_attribute_networkAnalystParam_D}.
		 * <p>${iServer2_networkAnalystServices_TSPPathParam_attribute_networkAnalystParam_remarks}</p> 
		 */
		public function get networkAnalystParam():NetworkAnalystParam
		{
			return _networkAnalystParam;
		}

		public function set networkAnalystParam(value:NetworkAnalystParam):void
		{
			_networkAnalystParam = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_TSPPathParam_attribute_isNodeEndAssigned_D}.
		 * <p>${iServer2_networkAnalystServices_TSPPathParam_attribute_isNodeEndAssigned_remarks}</p> 
		 * @default false
		 */
		public function get isEndNodeAssigned():Boolean
		{
			return _isEndNodeAssigned;
		}

		public function set isEndNodeAssigned(value:Boolean):void
		{
			_isEndNodeAssigned = value;
		}

		sm_internal function toJson():String
		{
			var json:String = "";
						
			if (this.networkAnalystParam)
				json += "\"networkAnalystParam\":" + this.networkAnalystParam.toJson() + ",";
			
			json += "\"isEndNodeAssigned\":" + this.isEndNodeAssigned;
			
			if(json.length > 0)
			json ="{" + json + "}";
			
            return json;
  		}

	}
}