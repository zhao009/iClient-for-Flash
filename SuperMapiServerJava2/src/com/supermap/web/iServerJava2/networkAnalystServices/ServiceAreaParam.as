package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServer2_networkAnalystServices_ServiceAreaParam_Title}. 
	 * <p>${iServer2_networkAnalystServices_ServiceAreaParam_Description}</p>
	 * 
	 */	
	public class ServiceAreaParam
	{
		private var _weights:Array;		
		private var _networkAnalystParam:NetworkAnalystParam;		
		private var _isCenterMutuallyExclusive:Boolean;		
		private var _isFromCenter:Boolean = true;
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaParam_constructor_None_D}
		 * 
		 */		
		public function ServiceAreaParam()
		{
		}
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaParam_attribute_isFromCenter_D}.
		 * <p>${iServer2_networkAnalystServices_ServiceAreaParam_attribute_isFromCenter_remarks}</p>
		 * @default true
		 * @return 
		 * 
		 */		
		public function get isFromCenter():Boolean
		{
			return _isFromCenter;
		}

		public function set isFromCenter(value:Boolean):void
		{
			_isFromCenter = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaParam_attribute_isCenterMutuallyExclusive_D}.
		 * <p>${iServer2_networkAnalystServices_ServiceAreaParam_attribute_isCenterMutuallyExclusive_remarks}</p>
		 * @default false
		 * @return 
		 * 
		 */		
		public function get isCenterMutuallyExclusive():Boolean
		{
			return _isCenterMutuallyExclusive;
		}

		public function set isCenterMutuallyExclusive(value:Boolean):void
		{
			_isCenterMutuallyExclusive = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaParam_attribute_networkAnalystParam_D} 
		 * @return 
		 * 
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
		 * ${iServer2_networkAnalystServices_ServiceAreaParam_attribute_weights_D}.
		 * <p>${iServer2_networkAnalystServices_ServiceAreaParam_attribute_weights_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get weights():Array
		{
			return _weights;
		}

		public function set weights(value:Array):void
		{
			_weights = value;
		}

		sm_internal function toJson():String
		{
			var json:String = "";
			
			if (this.networkAnalystParam)
				json += "\"networkAnalystParam\":" + this.networkAnalystParam.toJson() + ",";
			
			json += "\"isCenterMutuallyExclusive\":" + this.isCenterMutuallyExclusive + ",";
			
			if (this.weights)
			{
				if(this.weights.length > 0)
					json += "\"weights\":" + "[" + this.weights.join(",") + "],";
			}
			
			json += "\"isFromCenter\":" + this.isFromCenter;
			
			if(json.length > 0)
				json ="{" + json + "}";
			
			return json;
		}
	}
}