package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServer2_networkAnalystServices_ProximityParam_Title}.
	 * <p>${iServer2_networkAnalystServices_ProximityParam_Description}</p>
	 * 
	 * 
	 */
	public class ProximityParam
	{
		//要查找的最近设施点个数
		private var _facilityCount:int = 1;
		//最近设施分析查找的方向，即是否按照从事件点到设施点的方向进行查找
		private var _isFromEvent:Boolean = false;
		//查找范围的最大半径,单位同分析环境中阻力字段的单位，如果查找全网络，该值设为0
		private var _maxImpedance:int = 0;
		//网络参数对象
		private var _networkAnalystParam:NetworkAnalystParam;
		
		/**
		 * ${iServer2_networkAnalystServices_ProximityParam_constructor_None_D} 
		 * 
		 */		
		public function ProximityParam()
		{
		}
		
		/**
		 * ${iServer2_networkAnalystServices_ProximityParam_attribute_networkAnalystParam_D} 
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
		 * ${iServer2_networkAnalystServices_ProximityParam_attribute_maxImpedance_D}.
		 * <p>${iServer2_networkAnalystServices_ProximityParam_attribute_maxImpedance_remarks}</p> 
		 * @see 
		 */
		public function get maxImpedance():int
		{
			return _maxImpedance;
		}

		public function set maxImpedance(value:int):void
		{
			_maxImpedance = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_ProximityParam_attribute_isFromEvent_D}.
		 * <p>${iServer2_networkAnalystServices_ProximityParam_attribute_isFromEvent_remarks}</p> 
		 * @default false
		 */
		public function get isFromEvent():Boolean
		{
			return _isFromEvent;
		}

		public function set isFromEvent(value:Boolean):void
		{
			_isFromEvent = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_ProximityParam_attribute_facilityCount_D}
		 * @default 1
		 */
		public function get facilityCount():int
		{
			return _facilityCount;
		}

		public function set facilityCount(value:int):void
		{
			_facilityCount = value;
		}

		sm_internal function toJson():String
		{
			var json:String = "";
			
			json += "\"facilityCount\":" + this.facilityCount + ",";
			
			json += "\"isFromEvent\":" + this.isFromEvent + ",";
			
			if (this.networkAnalystParam)
				json += "\"networkAnalystParam\":" + this.networkAnalystParam.toJson() + ",";
			
			json += "\"maxImpedance\":" + this.maxImpedance;
			
			if(json.length > 0)
			json ="{" + json + "}";
			
            return json;
  		}
	}
}