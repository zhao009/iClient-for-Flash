package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ChartQueryParameter_Tile}.
	 * <p>${iServerJava6R_ChartQueryParameter_Description}</p> 
	 * 
	 */	
	public class ChartQueryParameters
	{
		private var _queryMode:String;
		private var _bounds:Rectangle2D;
		private var _chartLayerNames:Array;
		private var _chartQueryFilterParameters:Array;
		private var _returnContent:Boolean = true;
		private var _startRecord:int = 0;
		private var _expectCount:int;
		
		/**
		 * ${iServerJava6R_ChartQueryParameter_constructor_None_D} 
		 * 
		 */	
		public function ChartQueryParameters()
		{
		}
		/**
		 * ${iServerJava6R_ChartQueryParameter_attribute_queryMode_D}
		 * @see ChartQueryMode
		 * 
		 */
		public function get queryMode():String
		{
			return _queryMode;
		}

		public function set queryMode(value:String):void
		{
			_queryMode = value;
		}
		/**
		 * ${iServerJava6R_ChartQueryParameter_attribute_bounds_D}
		 * 
		 */
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}

		public function set bounds(value:Rectangle2D):void
		{
			_bounds = value;
		}
		/**
		 * ${iServerJava6R_ChartQueryParameter_attribute_chartLayerNames_D}
		 * 
		 */
		public function get chartLayerNames():Array
		{
			return _chartLayerNames;
		}

		public function set chartLayerNames(value:Array):void
		{
			_chartLayerNames = value;
		}
		/**
		 * ${iServerJava6R_ChartQueryParameter_attribute_chartQueryParameters_D}
		 * @see ChartQueryFilterParameter
		 * 
		 */
		public function get chartQueryFilterParameters():Array
		{
			return _chartQueryFilterParameters;
		}

		public function set chartQueryFilterParameters(value:Array):void
		{
			_chartQueryFilterParameters = value;
		}
		/**
		 * ${iServerJava6R_ChartQueryParameter_attribute_returnContent_D}
		 * <p>${iServerJava6R_ChartQueryParameter_attribute_returnContent_remarks}</p> 
		 * @return 
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
		 * ${iServerJava6R_ChartQueryParameter_attribute_startRecord_D}
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
		 * ${iServerJava6R_ChartQueryParameter_attribute_expectCount_D}
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

		sm_internal function getVariablesJson():String
		{
			var json:String = "";
			
			json += "\"queryMode\": \""+this._queryMode+"\",";
			
			if (this.chartLayerNames && this.chartLayerNames.length)
			{
				var chartLayersArray:Array = [];
				var layerLength:int = this.chartLayerNames.length;
				for(var i:int = 0;i<layerLength;i++)
				{
					chartLayersArray.push(this.chartLayerNames[i]);
				}
				var layerNames:String = "[" + chartLayersArray.join(",") + "]";
				json += "\"chartLayerNames\":" + layerNames + ",";
			}
			
			if(this._queryMode == "ChartBoundsQuery"&&this.bounds)
			{
				json += "\"bounds\":" + "{" + "\"leftBottom\":" + "{" + "\"x\":"+ this._bounds.left + "," +
					"\"y\":"+ this._bounds.bottom + "}" + "," + "\"rightTop\":" + "{" + "\"x\":"+ this._bounds.right + "," +
					"\"y\":"+ this._bounds.top + "}" + "},";
			}	
			
			if (this._chartQueryFilterParameters && this._chartQueryFilterParameters.length)
			{
				var chartParamArray:Array = [];
				var chartLength:int = this._chartQueryFilterParameters.length;
				for(var j:int = 0;j<chartLength;j++)
				{
					chartParamArray.push((this._chartQueryFilterParameters[j] as ChartQueryFilterParameter).toJson());
				}
				var chartParamsJson:String = "[" + chartParamArray.join(",") + "]";
				chartParamsJson = "\"chartQueryParams\":" + chartParamsJson + ",";
				chartParamsJson += "\"startRecord\":" + this._startRecord + ",";
				chartParamsJson += "\"expectCount\":" + this._expectCount;
				chartParamsJson ="{" + chartParamsJson + "}";
				json += "\"chartQueryParameters\":" + chartParamsJson;
			}
			
			json ="{" + json + "}";
			
			return json;
		}


	}
}