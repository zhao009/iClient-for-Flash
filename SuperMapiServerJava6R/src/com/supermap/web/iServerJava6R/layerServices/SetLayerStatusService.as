package com.supermap.web.iServerJava6R.layerServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.SetLayerEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.SetLayerEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	/**
	 * ${iServer6_SetLayerStatusService_Title}.
	 * <p>${iServer6_SetLayerStatusService_Description}</p> 
	 * 
	 */	
	public class SetLayerStatusService extends ServiceBase
	{ 
		private var _lastResult:SetLayerResult;
		private var _newResourceID:String;
		private var _parameters:SetLayerStatusParameters;
		private var _responder:IResponder;
		
		/**
		 * ${iServer6_SetLayerStatusService_constructor_String_D}
		 * 
		 * @param url ${iServer6_SetLayerStatusService_constructor_String_param_url}
		 * 
		 */		
		public function SetLayerStatusService(url:String)
		{
			super(url);
		}

		sm_internal function get lastResult():SetLayerResult//获取最后结果
		{
			return _lastResult;
		}
		
		private function getMapName(url:String):String//返回地图名
		{ 
			var mapUrl:String = url; 
			if(mapUrl.charAt(mapUrl.length - 1) == "/")
			{
				mapUrl = mapUrl.substr(0, mapUrl.length - 1);
			}
			var index:int = mapUrl.lastIndexOf("/");
			var mapName:String = mapUrl.substring(index + 1, mapUrl.length);  
			return mapName;
		} 
		  
		private function handleDecodedObject(jsonObject:Object, asyncToken:AsyncToken):void//返回结果参数
		{
			var responder:IResponder;
			this._lastResult = SetLayerResult.fromJson(jsonObject);//用fromJson进行转换
			this._lastResult.newResourceID = this._newResourceID;
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new SetLayerEvent(SetLayerEvent.PROCESS_COMPLETE, this._lastResult, jsonObject));//派发事件
	 	}
		  
		private function getPutRequestUrl(parameters:SetLayerStatusParameters):String
		{ 
		 	var secondUrl:String = "tempLayersSet/" + parameters.resourceID + ".json?X-RequestEntity-ContentType=application/flex&flexAgent=true&_method=PUT&reference=" + parameters.resourceID + "&elementRemain=true";
			return secondUrl;
		}
		
		private function getParameters(parameters:SetLayerStatusParameters):String
		{ 
			var parameterString:String = "[{" +"type:" + "\""+"UGC"+"\"" + "," +  "subLayers:" + SetLayerStatusParameters.toJson(parameters) + "," + "name:" + "\""+this.getMapName(this.url)+"\"" + "}]";
			return parameterString;
		}
		
		private function processAsyncToSetTempLayer():AsyncToken
		{
			
			var extendURL:String = "tempLayersSet.json?X-RequestEntity-ContentType=application/flex&flexAgent=true&_method=POST&holdTime=" + _parameters.holdTime.toString();
			if(_parameters.resourceID!=null)
			{
				extendURL +="&newResourceID="+_parameters.resourceID;
			}
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}
			return sendURL(extendURL, null, null, this.tempLayerHandleDecodedObject); 
		}
		  
		private function tempLayerHandleDecodedObject(jsonObject:Object, asyncToken:AsyncToken):void
		{  
			if(asyncToken)
			{
				asyncToken = null;
			}
			this._parameters.resourceID = jsonObject.newResourceID;  
			this._newResourceID = this._parameters.resourceID;
			this.process(this._parameters, this._responder);//如果没有设置id， 那么在这里可以通过发送请求再次得到id,并且再次发送请求
		}
	  
		private function process(parameters:SetLayerStatusParameters, responder:IResponder):AsyncToken//最后处理
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			var extendURL:String = this.getPutRequestUrl(parameters);  
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}
			var reqVar:String = this.getParameters(parameters);
			return sendURL(extendURL, reqVar, responder, this.handleDecodedObject);	
		}
		
		/**
		 * ${iServerJava6R_SetLayerStatusService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_SetLayerStatusService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_SetLayerStatusService_method_ProcessAsync_param_parameters}
		 * @param responder ${iServerJava6R_SetLayerStatusService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_SetLayerStatusService_method_ProcessAsync_return}
		 * 
		 */		
		public function processAsync(parameters:SetLayerStatusParameters, responder:IResponder = null):AsyncToken
		{	 
			if (parameters == null)
			{
				throw new SmError(SmResource.NONE_PARAMETERS); 
				return null;
			} 
			
			this._parameters = parameters
			this._responder = responder;
			if(this._newResourceID == null)//设置临时图层
			{
				this._newResourceID = parameters.resourceID;
				this.processAsyncToSetTempLayer(); 
				return null; 
			} 
//			if(this._newResourceID == null)//初始化一次
//			{
//				this._newResourceID = parameters.resourceID;
//			}
//			if(this._newResourceID == null)//设置临时图层
//			{
//				this.processAsyncToSetTempLayer(); 
//				return null; 
//			} 
			return this.process(parameters, responder); 
		}  
	}
}

 