package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.sm_internal;
	import com.supermap.web.iServerJava2.ServerFeatureType;
	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_queryParam_Title}.
	 * <p>${iServer2_queryParam_Description_as}</p> 
	 * 
	 * 
	 */	
	public class QueryParam
	{
		private var _startCount:Number = 0;
		private var _expectCount:Number = -1;
		private var _returnResultSetInfo:String = ReturnResultSetInfo.RETURN_RESULT_ATTRIBUTE;
		private var _networkType:int = ServerFeatureType.LINE;
		private var _queryLayerParams:Array;
		
		/**
		 * ${iServer2_queryParam_constructor_None_D_as} 
		 * 
		 */		
		public function QueryParam()
		{
		}
		
		/**
		 * ${iServer2_queryParam_attribute_queryLayerParams_D_as}
		 */
		public function get queryLayerParams():Array
		{
			return _queryLayerParams;
		}

		public function set queryLayerParams(value:Array):void
		{
			_queryLayerParams = value;
		}

		/**
		 * ${iServer2_queryParam_attribute_networkType_D_as} 
		 * @default ServerFeatureType.LINE
		 * @see ServerFeatureType
		 */
		public function get networkType():int
		{
			return _networkType;
		}

		public function set networkType(value:int):void
		{
			_networkType = value;
		}

		/**
		 * ${iServer2_queryParam_attribute_returnResultSetInfo_D_as} 
		 * @default ReturnResultSetInfo.RETURN_RESULT_ATTRIBUTE
		 * @see ReturnResultSetInfo
		 */
		public function get returnResultSetInfo():String
		{
			return _returnResultSetInfo;
		}

		public function set returnResultSetInfo(value:String):void
		{
			_returnResultSetInfo = value;
		}

		/**
		 * ${iServer2_queryParam_attribute_expectCount_D_as}
		 * @default -1 
		 */
		public function get expectCount():Number
		{
			return _expectCount;
		}

		public function set expectCount(value:Number):void
		{
			_expectCount = value;
		}

		/**
		 * ${iServer2_queryParam_attribute_startCount_D_as}
		 * @default 0
		 */
		public function get startCount():Number
		{
			return _startCount;
		}

		public function set startCount(value:Number):void
		{
			_startCount = value;
		}

		sm_internal function toQueryParam(sqlJson:String = null):String
		{
			var param:String = "";
			
			if (this.startCount >= 0)
			{
				param += "\"startRecord\":" + startCount.toString() + ",";
			}
			
			if (this.expectCount)
			{
				param += "\"expectCount\":" + expectCount.toString() + ",";
			}
			
			if (this.returnResultSetInfo)
			{
				param += "\"returnResultSetInfo\":" + returnResultSetInfo + ",";
			}
			
			param += "\"networkType\":" + networkType + ",";
					
			if (this.queryLayerParams)
			{
				if(this.queryLayerParams.length > 0)
				{
					var LayerParams:Array = new Array();
					for(var i:int = 0; i < this.queryLayerParams.length; i++)
					{
						LayerParams.push(QueryLayerParam.toQueryLayerParam(this.queryLayerParams[i]));
					}
					
					var tempLayerParams:String = "[" + LayerParams.join(",") + "]";
					param += "\"queryLayerParams\":" + tempLayerParams;
				}
			}
			
			if(param.charAt(param.length - 1) == ",")
				param = param.substring(0, param.length - 1);
			
			if(param.length > 0)
			param ="{" + param + "}";
			
            return param;
		}

	}
}