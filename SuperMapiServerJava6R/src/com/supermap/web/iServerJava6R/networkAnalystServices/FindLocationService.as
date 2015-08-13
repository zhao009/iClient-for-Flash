package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.FindLocationEvent;
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
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.FindLocationEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_FindLocationService_Title}.
	 * <p>${iServerJava6R_FindLocationService_Description}</p> 
	 * @see FindLocationResult
	 * @see com.supermap.web.iServerJava6R.serviceEvents.FindLocationEvent
	 * 
	 */	
	public class FindLocationService extends ServiceBase
	{
		private var _lastResult:FindLocationResult;
		/**
		 * ${iServerJava6R_FindLocationService_constructor_D} 
		 * @param url ${iServerJava6R_FindLocationService_constructor_param_url}
		 * 
		 */		
		public function FindLocationService(url:String)
		{
			super(url);
		}
	 
		sm_internal function get lastResult():FindLocationResult
		{
			return _lastResult;
		}

		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = FindLocationResult.fromJson(object);//用fromJson进行转换
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new FindLocationEvent(FindLocationEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
		
 		private function getSupplyCenterString(supplyCenters:Array):String
		{ 
			if(supplyCenters && supplyCenters.length)
			{
				var temp:Array = [];
				var scLength:int = supplyCenters.length;
				for(var i:int = 0; i < scLength; i++)
				{
					temp.push(SupplyCenter.toJson(supplyCenters[i]));
				}
				var supplyString:String = "[" + temp.toString() + "]";
				return supplyString;
			}
			return null;
		}
		
		/**
		 * ${iServerJava6R_FindLocationService_method_ProcessAsync_D} 
		 * @param parameters ${iServerJava6R_FindLocationService_method_ProcessAsync_param_Parameters}
		 * @param responder ${iServerJava6R_FindLocationService_method_ProcessAsync_param_responder}
		 * @return ${iServerJava6R_FindLocationService_method_ProcessAsync_param_return}
		 * 
		 */		
		public function processAsync(parameters:FindLocationParameters, responder:IResponder = null):AsyncToken
		{
			if (parameters == null)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			} 
			   
			var extendURL:String = "location.json?_method=GET&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}  
			return sendURL(extendURL, this.getParametersString(parameters), responder, this.handleDecodedObject); 
		}
		private function getParametersString(parameters:FindLocationParameters):String
		{ 
			var json:String = "";
			
			json += "\"isFromCenter\":" + parameters.isFromCenter;
			json += ",\"expectedSupplyCenterCount\":" + parameters.expectedSupplyCenterCount;
			//json += ",\"nodeDemandField\":" + parameters.nodeDemandField;
			json += ",\"weightName\":" + parameters.weightName;
			json += ",\"turnWeightField\":" + parameters.turnWeightField;
			
			json += ",\"returnEdgeFeature\":" + parameters.returnEdgeFeature;
			json += ",\"returnEdgeGeometry\":" + parameters.returnEdgeGeometry;
			json += ",\"returnNodeFeature\":" + parameters.returnNodeFeature;
			json += ",\"supplyCenters\":" + this.getSupplyCenterString(parameters.supplyCenters);
			json ="{" + json + "}";
			
			return json;
		}
//		private function getParameters(parameters:FindLocationParameters):URLVariables
//		{ 
//			var reqVar:URLVariables = new URLVariables(); 
//			
//			reqVar.isFromCenter = parameters.isFromCenter;
//			reqVar.expectedSupplyCenterCount = parameters.expectedSupplyCenterCount;
//			reqVar.nodeDemandField = parameters.nodeDemandField;
//			reqVar.weightName = parameters.weightName;
//			reqVar.turnWeightField = parameters.turnWeightField;
//			
//			//组装return字段开头的参数
//			reqVar.returnEdgeFeatures = parameters.returnEdgeFeature;
//			reqVar.returnEdgeGeometry = parameters.returnEdgeGeometry;
//	 		reqVar.returnNodeFeatures = parameters.returnNodeFeature;
//			return reqVar;
//		}
	}
}