package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.ComputeWeightMatrixEvent;
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
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.ComputeWeightMatrixEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_ComputeWeightMatrixService_Title}. 
	 * <p>${iServerJava6R_ComputeWeightMatrixService_Description}</p>
	 * @see TransportationAnalystParameter
	 * @see ComputeWeightMatrixResult
	 * @see com.supermap.web.iServerJava6R.serviceEvents.ComputeWeightMatrixEvent
	 */	
	public class ComputeWeightMatrixService extends ServiceBase
	{
		//--------------------------------------------------------------------------
		//
		//  耗费矩阵分析服务类
		//
		//--------------------------------------------------------------------------
		
		private var _lastResult:ComputeWeightMatrixResult;
		
		/**
		 * ${iServerJava6R_ComputeWeightMatrixService_constructor_D} 
		 * @param url ${iServerJava6R_ComputeWeightMatrixService_constructor_param_url}
		 * 
		 */		
		public function ComputeWeightMatrixService(url:String)
		{
			super(url);
		}
		//用于处理返回结果
	
		sm_internal function get lastResult():ComputeWeightMatrixResult
		{
			return _lastResult;
		}

		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = ComputeWeightMatrixResult.fromJson(object);//用fromJson进行转换
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new ComputeWeightMatrixEvent(ComputeWeightMatrixEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
		 
		//对服务端发送请求
		/**
		 * ${iServerJava6R_ComputeWeightMatrixService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_ComputeWeightMatrixService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_ComputeWeightMatrixService_method_ProcessAsync_param_Parameters}
		 * @param responder ${iServerJava6R_ComputeWeightMatrixService_method_ProcessAsync_param_responder}
		 * @return ${iServerJava6R_ComputeWeightMatrixService_method_ProcessAsync_param_return}
		 * 
		 */		
		public function processAsync(parameters:ComputeWeightMatrixParameters, responder:IResponder = null):AsyncToken
		{
			if (parameters == null)
			{  
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			} 
//			var reqVar:URLVariables = new URLVariables();
//			reqVar.parameter = TransportationAnalystParameter.toJson(parameters.parameter);
//			
			var nodeStr:String;
			if(!parameters.isAnalyzeById)
			{ 
				nodeStr = JsonUtil.fromPoint2Ds(parameters.nodes as Array);
			} 
			else if(parameters.isAnalyzeById)
			{
				nodeStr = "[" + parameters.nodes.join(",") + "]"; 
			}  
			var extendURL:String = "weightmatrix.json?_method=GET&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}  
			var json:String = "";
			json += "\"parameter\":" + TransportationAnalystParameter.toJson(parameters.parameter);
			json += ",\"nodes\":" + nodeStr;
			json ="{" + json + "}";
			return sendURL(extendURL, json, responder, this.handleDecodedObject); 
		}

//		private function getParameters(parameters:ComputeWeightMatrixParameters):URLVariables
//		{ 
//			var reqVar:URLVariables = new URLVariables();  
//	        //耗费矩阵服务分析类仅一个有效参数
//			reqVar.parameter = TransportationAnalystParameter.toJson(parameters.parameter);
//			return reqVar;
//		}  
	}
}