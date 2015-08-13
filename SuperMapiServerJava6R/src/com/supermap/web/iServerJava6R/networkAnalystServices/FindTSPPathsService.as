package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.FindTSPPathsEvent;
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
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.FindTSPPathsEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	/**
	 * ${iServerJava6R_FindTSPPathsService_Title}.
	 * <p>${iServerJava6R_FindTSPPathsService_Description}</p> 
	 * @see FindTSPPathsResult
	 * @see com.supermap.web.iServerJava6R.serviceEvents.FindTSPPathsEvent
	 * 
	 */	
	public class FindTSPPathsService extends ServiceBase
	{
		private var _lastResult:FindTSPPathsResult;
		/**
		 * ${iServerJava6R_FindPathService_constructor_D} 
		 * @param url ${iServerJava6R_FindPathService_constructor_param_url}
		 * 
		 */		
		override public function FindTSPPathsService(url:String)
		{
			super(url);
		}
	
		sm_internal function get lastResult():FindTSPPathsResult
		{
			return _lastResult;
		}

		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void//解析从服务端返回的对象
		{
			var responder:IResponder;
			this._lastResult = FindTSPPathsResult.fromJson(object);//用fromJson进行转换
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new FindTSPPathsEvent(FindTSPPathsEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
		 
		/**
		 * ${iServerJava6R_FindTSPPathsService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_FindTSPPathsService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_FindTSPPathsService_method_ProcessAsync_param_Parameters}
		 * @param responder ${iServerJava6R_FindTSPPathsService_method_ProcessAsync_param_responder}
		 * @return ${iServerJava6R_FindTSPPathsService_method_ProcessAsync_param_return}
		 * 
		 */
		public function processAsync(parameters:FindTSPPathsParameters, responder:IResponder = null):AsyncToken
		{
			if (parameters == null)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			} 
//			var reqVar:URLVariables = this.getParameters(parameters);  
			
			var nodeStr:String;
			if(!parameters.isAnalyzeById)
			{ 
				nodeStr = JsonUtil.fromPoint2Ds(parameters.nodes as Array);
			} 
			else if(parameters.isAnalyzeById)
			{
				nodeStr = "[" + parameters.nodes.join(",") + "]"; 
			}  
			var extendURL:String = "tsppath.json?_method=GET&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}  
			var json:String = "";
			json += "\"endNodeAssigned\":" + parameters.endNodeAssigned;
			json += ",\"parameter\":" + TransportationAnalystParameter.toJson(parameters.parameter);
			json += ",\"nodes\":" + nodeStr;
			json ="{" + json + "}";
			
			return sendURL(extendURL, json, responder, this.handleDecodedObject); 
		}
	 
//		private function getParameters(parameters:FindTSPPathsParameters):URLVariables
//		{ 
//			var reqVar:URLVariables = new URLVariables(); 
//			
//			reqVar.endNodeAssigned = parameters.endNodeAssigned;  
//			reqVar.parameter = TransportationAnalystParameter.toJson(parameters.parameter); 
//			return reqVar;
//		}  
		
	}
}