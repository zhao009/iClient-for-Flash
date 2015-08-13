package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.FindMTSPPathsEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.FindMTSPPathsEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_FindMTSPPathsService_Title}.
	 * <p>${iServerJava6R_FindMTSPPathsService_Description}</p> 
	 * 
	 */	
	public class FindMTSPPathsService extends ServiceBase
	{
		//--------------------------------------------------------------------------
		//
		//  多旅行商分析服务类
		//
		//--------------------------------------------------------------------------
		
		private var _lastResult:FindMTSPPathsResult;
		
		/**
		 * ${iServerJava6R_FindMTSPPathsService_constructor_D} 
		 * @param url ${iServerJava6R_FindMTSPPathsService_constructor_param_url}
		 * 
		 */		
		public function FindMTSPPathsService(url:String)
		{
			super(url);
		}
	
		sm_internal function get lastResult():FindMTSPPathsResult
		{
			return _lastResult;
		}

		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void//解析从服务端返回的对象
		{
			var responder:IResponder;
			this._lastResult = FindMTSPPathsResult.fromJson(object);//用fromJson进行转换
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new FindMTSPPathsEvent(FindMTSPPathsEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
		
		/**
		 * ${iServerJava6R_FindMTSPPathsService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_FindMTSPPathsService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_FindMTSPPathsService_method_ProcessAsync_param_Parameters}
		 * @param responder ${iServerJava6R_FindMTSPPathsService_method_ProcessAsync_param_responder}
		 * @return ${iServerJava6R_FindMTSPPathsService_method_ProcessAsync_param_return}
		 * 
		 */		
		public function processAsync(parameters:FindMTSPPathsParameters, responder:IResponder = null):AsyncToken
		{
			if (parameters == null)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			} 
//			var reqVar:URLVariables = this.getParameters(parameters);  
			 
			var centerStr:String;
			if(!parameters.isAnalyzeById)
			{ 
				centerStr = JsonUtil.fromPoint2Ds(parameters.centers as Array);
			} 
			else if(parameters.isAnalyzeById)
			{
				centerStr = "[" + parameters.centers.join(",") + "]"; 
			}
			 
			var nodeStr:String;
			if(!parameters.isAnalyzeById)
			{ 
				nodeStr = JsonUtil.fromPoint2Ds(parameters.nodes as Array);
			} 
			else if(parameters.isAnalyzeById)
			{
				nodeStr = "[" + parameters.nodes.join(",") + "]"; 
			}  
			var extendURL:String = "mtsppath.json?_method=GET&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}  
			
			var json:String = "";
			json += "\"hasLeastTotalCost\":" + parameters.hasLeastTotalCost;
			json += ",\"parameter\":" + TransportationAnalystParameter.toJson(parameters.parameter);
			json += ",\"centers\":" + centerStr;
			json += ",\"nodes\":" + nodeStr;
			json ="{" + json + "}";
			return sendURL(extendURL, json, responder, this.handleDecodedObject); 
		} 
	 
//		private function getParameters(parameters:FindMTSPPathsParameters):URLVariables
//		{ 
//			var reqVar:URLVariables = new URLVariables();  
//			reqVar.hasLeastTotalCost = parameters.hasLeastTotalCost;  
//			reqVar.parameter = TransportationAnalystParameter.toJson(parameters.parameter); 
//			return reqVar;
//		} 
		
	}
}