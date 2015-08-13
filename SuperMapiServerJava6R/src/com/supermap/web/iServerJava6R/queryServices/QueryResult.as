package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.iServerJava6R.Recordset;
	import com.supermap.web.sm_internal;
		
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_Query_QueryResult_Title}.
	 * <p>${iServerJava6R_Query_QueryResult_Description}</p> 
	 * 
	 */	
	public class QueryResult
	{
		private var _totalCount:int;
		private var _currentCount:int;
		private var _customResponse:String;
		private var _recordsets:Array;
		private var _resourceInfo:ResourceInfo;
		
		/**
		 * ${iServerJava6R_Query_QueryResult_constructor_D} 
		 * 
		 */		
		public function QueryResult():void
		{
			
		}
		
		/**
		 * ${iServerJava6R_Query_ResultSet_attribute_totalCount_D} 
		 * @return 
		 * 
		 */		
		public function get totalCount():int
		{
			return this._totalCount;
		}
		
		/**
		 * ${iServerJava6R_Query_ResultSet_attribute_currentCount_D}.
		 * <p>${iServerJava6R_Query_ResultSet_attribute_currentCount_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get currentCount():int
		{
			return this._currentCount;
		}
		
		/**
		 * ${iServerJava6R_Query_ResultSet_attribute_customResponse_D} 
		 * @return 
		 * 
		 */		
		public function get customResponse():String
		{
			return this._customResponse;
		}
		
		/**
		 * ${iServerJava6R_Query_ResultSet_attribute_recordSets_D}.
		 * <p>${iServerJava6R_Query_ResultSet_attribute_recordSets_remarks}</p> 
		 * @see Recordset
		 * @return 
		 * 
		 */		
		public function get recordsets():Array
		{
			return this._recordsets;
		}
		
		/**
		 * ${iServerJava6R_Query_ResultSet_attribute_ResourceInfo_D} 
		 * @example ${iServerJava6R_Query_QueryResult_attribute_ResourceInfo__Example}
		 * <listing> 
		 *      //使用高亮图层 HighlightLayer 显示查询结果
		 * 	   var highlayer:HighlightLayer = new HighlightLayer(mapUrl)
		 *     
		 *      //SQL查询
		 *  	   private function onExcuteQueryClick(event:MouseEvent):void 
		 *	   {
		 *		    //定义 SQL 查询参数
		 *			var queryBySQLParam:QueryBySQLParameters = new QueryBySQLParameters();
		 *			var filter:FilterParameter = new FilterParameter();
		 *			filter.name = "Countries&#64;World";
		 *			filter.attributeFilter = "smid=247";
		 *			queryBySQLParam.filterParameters = [filter];
		 *			 //当 returnContent = false 时，表示返回查询结果资源，这时查询结果存储在 QueryResult.resourceInfo 中，而 QueryResult.recordsets 为空。
		 *			queryBySQLParam.returnContent = false;
		 *		
		 *			// 执行 SQL 查询
		 *			var queryByDistanceService:QueryBySQLService = new QueryBySQLService(mapUrl);
		 *			queryByDistanceService.processAsync(queryBySQLParam, new AsyncResponder(this.displayQueryResourceInfo, 
		 *			function (object:Object, mark:Object = null):void
		 *			{
		 *				Alert.show("与服务端交互失败", "抱歉", 4, this);
		 *			}, null));
		 *	   }
		 * 
         *      //使用高亮图层显示查询结果
		 *	   private function displayQueryResourceInfo(queryResult:QueryResult, mark:Object = null):void
		 *	   {
		 * 			if (queryResult.resourceInfo!= null)
		 *			{
		 *				highlayer.visible = true;
		 *				 //设置查询结果资源 ID.
		 *				highlayer.queryResultID = queryResult.resourceInfo.newResourceID;	
		 *				var serverstyle:ServerStyle = new ServerStyle();
		 *				serverstyle.lineWidth = 0.5;
		 *				serverstyle.fillOpaqueRate = 80;
		 *				highlayer.style = serverstyle;
		 *				this.map.addLayer(highlayer);
		 *			} 
		 *     }	     
		 * </listing>
		 * @return 
		 * 
		 */		
		public function get resourceInfo():ResourceInfo
		{
			return this._resourceInfo;
		}
		
		sm_internal static function fromJson(object:Object):QueryResult
		{
			var queryResult:QueryResult;
			if(object)
			{
				queryResult = new QueryResult();
				
				if(!object.newResourceID)
				{
					queryResult._currentCount = object.currentCount;
					queryResult._customResponse = object.customResponse;
					queryResult._totalCount = object.totalCount;
					
					var tempRecordsets:Array = object.recordsets;
					if(tempRecordsets && tempRecordsets.length)
					{
						queryResult._recordsets = [];
						var recordsLength:int = tempRecordsets.length;
						for(var i:int = 0; i < recordsLength; i++)
							queryResult._recordsets.push(Recordset.fromJson(tempRecordsets[i]));
					}
				}
				else
				{
					queryResult._resourceInfo = ResourceInfo.fromJson(object);
				}
				
			}
			return queryResult;
		}
		
	}
}
