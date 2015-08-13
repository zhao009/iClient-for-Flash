package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.QueryEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.QueryEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	/**
	 * ${iServerJava6R_ChartQueryService_Tile}.
	 * <p>${iServerJava6R_ChartQueryService_Description}</p> 
	 * @example ${iServerJava6R_ChartQueryService_Example}	  
	 * <listing> 
	 * private var chartMarkCode:int;//物标代码
	 * protected function queryBtn_clickHandler(event:MouseEvent):void
	 * {
	 * 	var filterParam:ChartQueryFilterParameter = new ChartQueryFilterParameter();
	 * 	filterParam.isQueryLine = true;
	 * 	filterParam.isQueryPoint = true;
	 * 	filterParam.isQueryRegion = true;
	 * 	filterParam.attributeFilter = "SMID &lt; 10";
	 * 	filterParam.chartFeatureInfoSpecCode = chartMarkCode;//查询的物标代号,可通过海图物标信息服务类（ChartFeatureInfoSpecsService）获得
	 * 
	 * 	var queryPram:ChartQueryParameters = new ChartQueryParameters();
	 * 	queryPram.queryMode = ChartQueryMode.ChartAttributeQuery;
	 * 	queryPram.chartLayerNames = ["GB4X0000_52000"];
	 * 	queryPram.returnContent = true;
	 * 	queryPram.chartQueryFilterParameters = [filterParam];
	 * 	var chartQueryService:ChartQueryService = new ChartQueryService(mapUrl);
	 * 	chartQueryService.processAsync(queryPram,new AsyncResponder(successHandler,
	 * 		function (object:Object, mark:Object = null):void
	 * 		{		Alert.show("与服务端交互失败", "抱歉", 4, this);
	 *      },null));
	 * }
	 * 
	 * private function successHandler(result:QueryResult,object:Object = null):void
	 * {
	 * 	    //TODO
	 * }
	 * 
	 * &lt;s:Button top="3" id="queryBtn" label="查询" click="queryBtn_clickHandler(event)"/>
	 * </listing>
	 * @see ChartQueryParameters
	 */	
	public class ChartQueryService extends ServiceBase
	{
		private var _lastResult:QueryResult;
		/**
		 * ${iServerJava6R_ChartQueryService_constructor_None_D} 
		 * @param url ${iServerJava6R_ChartQueryService_string_constructor_param_url}
		 */	
		public function ChartQueryService(url:String=null)
		{
			super(url);
		}
		
		public function processAsync(parameters:ChartQueryParameters, responder:IResponder = null):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			var extendURL:String = "queryResults.json?returnContent=" + parameters.returnContent + "&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}
			
			return sendURL(extendURL,parameters.getVariablesJson() , responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			this._lastResult = QueryResult.fromJson(object);
			var responder:IResponder;
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			
			this.dispatchEvent(new QueryEvent(QueryEvent.PROCESS_COMPLETE, this._lastResult, object));
		}

		sm_internal function get lastResult():QueryResult
		{
			return _lastResult;
		}
		
		
	}
}