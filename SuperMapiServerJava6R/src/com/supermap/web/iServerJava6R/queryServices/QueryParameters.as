package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.iServerJava6R.FilterParameter;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.utils.serverTypes.ServerGeometryType;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_Query_queryParamerters_Title}.
	 * <p>${iServerJava6R_Query_queryParamerters_Description}</p> 
	 * 
	 */	
	public class QueryParameters
	{
		private var _customParams:String;
		
		private var _expectCount:int = 1000000;
		
		private var _networkType:String = ServerGeometryType.LINE;
		
		private var _queryOption:String = QueryOption.ATTRIBUTE_AND_GEOMETRY;
		
		private var _filterParameters:Array;
		
		private var _startRecord:int = 0;
		
		private var _returnContent:Boolean = true;
		
		private var _holdTime:int = 10;
		
		/**
		 * ${iServerJava6R_Query_QueryParamerters_constructor_None_D} 
		 * 
		 */		
		public function QueryParameters()
		{
		}
		
		/**
		 * ${iServerJava6R_Query_attribute_holdTime_D}.
		 * <p>${iServerJava6R_Query_attribute_holdTime_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get holdTime():int
		{
			return _holdTime;
		}

		public function set holdTime(value:int):void
		{
			_holdTime = value;
		}

		/**
		 * ${iServerJava6R_Query_attribute_ReturnContent_D}.
		 * <p>${iServerJava6R_Query_attribute_ReturnContent_remarks}</p> 
		 * @see QueryResult
		 * @return 
		 * 
		 */		
		public function get returnContent():Boolean
		{
			return _returnContent;
		}

		public function set returnContent(value:Boolean):void
		{
			_returnContent = value;
		}

		/**
		 * ${iServerJava6R_Query_attribute_StartRecord_D}.
		 * <p>${iServerJava6R_Query_attribute_StartRecord_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get startRecord():int
		{
			return _startRecord;
		}

		public function set startRecord(value:int):void
		{
			_startRecord = value;
		}

		/**
		 * ${iServerJava6R_Query_attribute_FilterParameters_D} 
		 * @see com.supermap.web.iServerJava6R.FilterParameter
		 * @return 
		 * 
		 */		
		public function get filterParameters():Array
		{
			return _filterParameters;
		}

		public function set filterParameters(value:Array):void
		{
			_filterParameters = value;
		}

		/**
		 * ${iServerJava6R_Query_attribute_QueryOption_D} 
		 * @see QueryOption
		 * @return 
		 * 
		 */		
		public function get queryOption():String
		{
			return _queryOption;
		}

		public function set queryOption(value:String):void
		{
			_queryOption = value;
		}

		/**
		 * ${iServerJava6R_Query_attribute_NetworkType_D} 
		 * @return 
		 * @see com.supermap.web.iServerJava6R.serverTypes.ServerGeometryType
		 * 
		 */		
		public function get networkType():String
		{
			return _networkType;
		}

		public function set networkType(value:String):void
		{
			_networkType = value;
		}

		/**
		 * ${iServerJava6R_Query_attribute_ExpectCount_D}.
		 * <p>${iServerJava6R_Query_attribute_ExpectCount_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get expectCount():int
		{
			return _expectCount;
		}

		public function set expectCount(value:int):void
		{
			_expectCount = value;
		}

		/**
		 * ${iServerJava6R_Query_attribute_CustomParams_D} 
		 * @return 
		 * 
		 */		
		public function get customParams():String
		{
			return _customParams;
		}

		public function set customParams(value:String):void
		{
			_customParams = value;
		}

		sm_internal function toJson():String
		{
			var json:String = "";
			
			if (this.customParams)
				json += "\"customParams\":" + "\"" + this.customParams + "\",";
			else
				json += "\"customParams\":" + null + ",";
			
			if (this.networkType)
				json += "\"networkType\":" + "\"" + this.networkType + "\",";
			else
				json += "\"networkType\":" + null + ",";
			
			
			json += "\"expectCount\":" + this.expectCount + ",";
			
			json += "\"queryOption\":" + "\"" + queryOption + "\",";
			
			
			if (this.filterParameters && this.filterParameters.length)
			{
				var filterParamArray:Array = [];
				var filterLength:int = this.filterParameters.length;
				for(var i:int = 0; i < filterLength; i++)
				{
					filterParamArray.push((this.filterParameters[i] as FilterParameter).toJson());
				}
				
				var queryParams:String = "[" + filterParamArray.join(",") + "]";
				json += "\"queryParams\":" + queryParams + ",";
			}
			
			json += "\"startRecord\":" + startRecord + ",";
			
			json += "\"holdTime\":" + holdTime;
						
			json ="{" + json + "}";
			
            return json;
		}

	}
}