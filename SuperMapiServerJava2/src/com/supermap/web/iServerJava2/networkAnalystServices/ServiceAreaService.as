package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.iServerJava2.networkAnalystServices.NetworkModelSetting;
	import com.supermap.web.sm_internal;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	use namespace sm_internal;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	/**
	 * ${iServer2_networkAnalystServices_ServiceAreaService_Title}.
	 * <p>${iServer2_networkAnalystServices_ServiceAreaService_Description}</p> 
	 * @see ServiceAreaResult
	 * @author zyn
	 * 
	 */	
	public class ServiceAreaService extends ServiceBase
	{
		private var _lastResult:ServiceAreaResult;
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaService_constructor_String_D} 
		 * @param url ${iServer2_networkAnalystServices_ServiceAreaService_constructor_String_param_url}
		 * 
		 */		
		public function ServiceAreaService(url:String=null)
		{
			super(url);
		}
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaService_attribute_lastResult_D} 
		 * @return 
		 * 
		 */		
		public function get lastResult():ServiceAreaResult
		{
			return this._lastResult;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaService_method_execute_D} 
		 * @param responder ${iServer2_networkAnalystServices_ServiceAreaService_method_execute_param_responder}
		 * @param parameters ${iServer2_networkAnalystServices_ServiceAreaService_method_execute_param_parameters}
		 * @return ${iServer2_networkAnalystServices_ServiceAreaService_method_ProcessAsync_return}
		 * 
		 */		
		public function execute(responder:IResponder, parameters:ServiceAreaParameters):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			var reqVar:URLVariables = new URLVariables();
			reqVar.mapName = parameters.mapName;
			reqVar.method = "ServiceArea";
			reqVar.params = "<uis>" + 
				"<command>" + 
				"<name>ServiceArea</name>" +
				"<parameter>" +
				"<mapName>" + parameters.mapName + "</mapName>" + 
				"<networkSetting>" + parameters.networkSetting.toJson() + "</networkSetting>" +
				"<serviceAreaParam>" + parameters.serviceAreaParam.toJson() + "</serviceAreaParam>" +  
				"<needHighlight>false</needHighlight>" + 
				"<customParam></customParam>" +
				"</parameter>" + 
				"</command>" + 
				"</uis>";
			return sendURL("/commonhandler", reqVar, responder, this.handleDecodedObject); 
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			if(object)
				this._lastResult = ServiceAreaResult.toServiceAreaResult(object);
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
		}
		
	}
}