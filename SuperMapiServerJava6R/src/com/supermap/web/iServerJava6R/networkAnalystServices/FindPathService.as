package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.FindPathEvent;
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
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.FindPathEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	/**
	 * ${iServerJava6R_FindPathService_Title}.
	 * <p>${iServerJava6R_FindPathService_Description}</p> 
	 * @see FindPathResult
	 * @see com.supermap.web.iServerJava6R.serviceEvents.FindPathEvent
	 * 
	 */	
	public class FindPathService extends ServiceBase
	{ 
		
		//--------------------------------------------------------------------------
		//
		//  最佳路径分析服务类，设置参数后，对 paths 资源执行 GET 请求，可以获取一个最佳路径分析的结果
		//
		//--------------------------------------------------------------------------
		 
		private var _lastResult:FindPathResult;
		/**
		 * ${iServerJava6R_FindPathService_constructor_D}.
		 * @param url ${iServerJava6R_FindPathService_constructor_param_url}
		 * 
		 */		
		public function FindPathService(url:String)
		{
			super(url);
		}

		sm_internal function get lastResult():FindPathResult
		{
			return _lastResult;
		}
 
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = FindPathResult.fromJson(object);//用fromJson进行转换
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new FindPathEvent(FindPathEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
		 
		/**
		 * ${iServerJava6R_FindPathService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_FindPathService_method_ProcessAsync_remarks}</p>
		 * @param parameters ${iServerJava6R_FindPathService_method_ProcessAsync_param_Parameters}
		 * @param responder ${iServerJava6R_FindPathService_method_ProcessAsync_param_responder}
		 * @return ${iServerJava6R_networkAnalystServices_FindPathService_method_ProcessAsync_return}
		 * 
		 */		
		public function processAsync(parameters:FindPathParameters, responder:IResponder = null):AsyncToken
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
			var extendURL:String = "path.json?_method=GET&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}  
			var json:String = "";
			json += "\"hasLeastEdgeCount\":" + parameters.hasLeastEdgeCount;
			json += ",\"parameter\":" + TransportationAnalystParameter.toJson(parameters.parameter);
			json += ",\"nodes\":" + nodeStr;
			json ="{" + json + "}";
			return sendURL(extendURL, json, responder, this.handleDecodedObject); 
		}
		
//		private function getParameters(parameters:FindPathParameters):URLVariables
//		{ 
//			var reqVar:URLVariables = new URLVariables();  
//			reqVar.hasLeastEdgeCount = parameters.hasLeastEdgeCount;  
//			reqVar.parameter = TransportationAnalystParameter.toJson(parameters.parameter);
//			return reqVar;
//		}  
	}
}