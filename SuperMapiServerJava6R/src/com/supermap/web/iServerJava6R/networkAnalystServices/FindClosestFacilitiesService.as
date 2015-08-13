package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.iServerJava6R.serviceEvents.FindClosestFacilitiesEvent;
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
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.FindClosestFacilitiesEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	/**
	 * ${iServerJava6R_ClosestFacilitiesService_Title}.
	 * <p>${iServerJava6R_ClosestFacilitiesService_Description}</p> 
	 * 
	 */	
	public class FindClosestFacilitiesService extends ServiceBase
	{
	
		private var _lastResult:FindClosestFacilitiesResult;
		
		/**
		 * ${iServerJava6R_ClosestFacilitiesService_constructor_D} 
		 * @param url ${iServerJava6R_ClosestFacilitiesService_constructor_param_url}
		 * 
		 */		
		public function FindClosestFacilitiesService(url:String)
		{
			super(url);
		}
		
	
		sm_internal function get lastResult():FindClosestFacilitiesResult
		{
			return _lastResult;
		}

		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = FindClosestFacilitiesResult.fromJson(object);//用fromJson进行转换
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new FindClosestFacilitiesEvent(FindClosestFacilitiesEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
 
		private function eventToString(event:Object, isAnalyzeById:Boolean):String
		{
			if(event){
				if(!isAnalyzeById) 
				{
					return JsonUtil.fromPoint2D(event as Point2D);
				} 
				else if(isAnalyzeById) 
				{
					return event.toString(); 
				} 
			}
			return null;
		}
		
		private function facilityToString(facilities:Array, isAnalyzeById:Boolean):String
		{
			if(facilities){
				if(!isAnalyzeById) 
				{
					return JsonUtil.fromPoint2Ds(facilities as Array);
				} 
				else if(isAnalyzeById) 
				{
					return "[" + facilities.toString() + "]"; 
				} 
			}
			return null;
		}
		
		/**
		 * ${iServerJava6R_ClosestFacilitiesService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_ClosestFacilitiesService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_ClosestFacilitiesService_method_ProcessAsync_param_Parameters}
		 * @param responder ${iServerJava6R_ClosestFacilitiesService_method_ProcessAsync_param_responder}
		 * @return ${iServerJava6R_FindMTSPPathsService_method_ProcessAsync_param_return}
		 * 
		 */		
		public function processAsync(parameters:FindClosestFacilitiesParameters, responder:IResponder = null):AsyncToken
		{
			if (parameters == null)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			} 
//			var reqVar:URLVariables = this.getParameters(parameters);  
		 
			var eventString:String = this.eventToString(parameters.event, parameters.isAnalyzeById);
 			var facilityString:String = this.facilityToString(parameters.facilities, parameters.isAnalyzeById);
		   	var extendURL:String = "closestfacility.json?_method=GET&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			} 
			var json:String = "";
			json += "\"expectFacilityCount\":" + parameters.expectFacilityCount;
			json += ",\"fromEvent\":" + parameters.fromEvent;
			json += ",\"maxWeight\":" + parameters.maxWeight;
			json += ",\"parameter\":" + TransportationAnalystParameter.toJson(parameters.parameter);
			json += ",\"event\":"  + eventString;
			json += ",\"facilities\":" + facilityString;
			json = "{" + json + "}";
			return sendURL(extendURL, json, responder, this.handleDecodedObject); 
		}
		 
//		private function getParameters(parameters:FindClosestFacilitiesParameters):URLVariables
//		{ 
//			var reqVar:URLVariables = new URLVariables(); 
//			reqVar.expectFacilityCount = parameters.expectFacilityCount;
//			reqVar.fromEvent = parameters.fromEvent;
//			reqVar.maxWeight = parameters.maxWeight; 
//			reqVar.parameter = TransportationAnalystParameter.toJson(parameters.parameter); 
//			return reqVar;
//		} 
	}
}