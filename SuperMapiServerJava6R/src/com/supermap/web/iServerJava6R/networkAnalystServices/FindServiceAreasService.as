package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.FindServiceAreasEvent;
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
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.FindServiceAreasEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_ServiceAreasService_Title}.
	 * <p>${iServerJava6R_ServiceAreasService_Description}</p> 
	 * @see FindServiceAreasResult
	 * @see com.supermap.web.iServerJava6R.serviceEvents.FindServiceAreasEvent
	 * 
	 */	
	public class FindServiceAreasService extends ServiceBase
	{  
		
		//--------------------------------------------------------------------------
		//
		//   服务区分析服务类
		//
		//--------------------------------------------------------------------------
		 
		private var _lastResult:FindServiceAreasResult;
		/**
		 * ${iServerJava6R_ServiceAreasService_constructor_D} 
		 * @param url ${iServerJava6R_ServiceAreasService_constructor_param_url}
		 * 
		 */		
		public function FindServiceAreasService(url:String)
		{
			super(url);
		}

		sm_internal function get lastResult():FindServiceAreasResult
		{
			return _lastResult;
		}

		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = FindServiceAreasResult.fromJson(object);//用fromJson进行转换
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new FindServiceAreasEvent(FindServiceAreasEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
	  
		private function centersToString(centers:Array, isAnalyzeById:Boolean):String
		{
			if(centers && centers.length)
			{
				if(!isAnalyzeById)
				{
					return JsonUtil.fromPoint2Ds(centers);
				}
				else if(isAnalyzeById)
				{
					return "[" + centers.join(",") + "]";
				}
			}
			return null;
		}
		
		private function weightsToString(weights:Array):String
		{
			if(weights && weights.length)
			{
				return "[" + weights.join(",") + "]";
			}
			return null
		}
		
		/**
		 * ${iServerJava6R_ServiceAreasService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_ServiceAreasService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_ServiceAreasService_method_ProcessAsync_param_Parameters}
		 * @param responder ${iServerJava6R_ServiceAreasService_method_ProcessAsync_param_responder}
		 * @return ${iServerJava6R_ServiceAreasService_method_ProcessAsync_param_return}
		 * 
		 */		
		public function processAsync(parameters:FindServiceAreasParameters, responder:IResponder = null):AsyncToken
		{
			if (parameters == null)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			} 
//			var reqVar:URLVariables = this.getParameters(parameters);  
		  	var centerString:String = this.centersToString(parameters.centers, parameters.isAnalyzeById);
			var weightsString:String = this.weightsToString(parameters.weights);
			var extendURL:String = "servicearea.json?&_method=GET&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}  
			var json:String = "";
			json += "\"isFromCenter\":" + parameters.isFromCenter;
			json += ",\"isCenterMutuallyExclusive\":" + parameters.isCenterMutuallyExclusive;
			json += ",\"parameter\":" + TransportationAnalystParameter.toJson(parameters.parameter); 
			json += ",\"centers\":" + centerString;
			json += ",\"weights\":" + weightsString;
			json ="{" + json + "}";
			return sendURL(extendURL, json, responder, this.handleDecodedObject); 
		}
		 
//		private function getParameters(parameters:FindServiceAreasParameters):URLVariables
//		{ 
//			var reqVar:URLVariables = new URLVariables(); 
//			 
//			reqVar.isFromCenter = parameters.isFromCenter;
//			reqVar.isCenterMutuallyExclusive = parameters.isCenterMutuallyExclusive;
//			reqVar.parameter =  TransportationAnalystParameter.toJson(parameters.parameter); 
//		 
//			return reqVar;
//		} 
	}
}