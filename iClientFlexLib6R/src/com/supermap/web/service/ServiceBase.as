package com.supermap.web.service
{
	import com.supermap.web.core.Credential;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.serialization.json.*;
	import com.supermap.web.utils.URL;
	
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import mx.core.IMXMLObject;
	import mx.resources.ResourceManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;
		
	/**
	 * @private 
	 * 
	 */
	public class ServiceBase extends EventDispatcher implements IMXMLObject
	{
		protected var id:String = "";	
		
		// 设置请求方法，默认为GET方法
		private var _method:String = URLRequestMethod.GET;
		
		private var _httpService:HTTPService;
		
		// 如果为 true，在执行服务时会显示忙碌光标。
		private var _showBusyCursor:Boolean = false;
		
		// 指示如何处理对同一服务的多个调用的值。
		private var _concurrency:String = "multiple";
		
		// 提供对已发送消息的请求超时（以秒为单位）的访问。如果值小于 0 或等于 0，则可阻止请求超时的发生。
		private var _requestTimeout:Number = -1;
		
		// 无效对客户端请求的缓存
		private var _disableClientCaching:Boolean;
		
		private var _forceRequest:Boolean = false;
		
		private var _proxyURLObj:URL;
		private var _token:String;
		private var _urlObj:URL;
		private var _contentType:String = "application/x-www-form-urlencoded";
		private var _resultType:String = "text";
		
		
		public function ServiceBase(url:String)
		{
			var traceHandler:Function;
			this._httpService = new HTTPService();
			this._proxyURLObj = new URL();
			this._urlObj = new URL();
			traceHandler = function (event:Event) : void
			{
				return;
			};
			this.url = url;
			this._httpService.resultFormat = "text";
			this._httpService.addEventListener(ResultEvent.RESULT, traceHandler);
			this._httpService.addEventListener(FaultEvent.FAULT, traceHandler);
		}
		
		
		[Bindable]
		public function get concurrency():String
		{
			return this._concurrency;
		}	
		public function set concurrency(value:String):void
		{
			if (this._concurrency !== value)
			{
				this._concurrency = value;
				dispatchEvent(new Event("concurrencyChanged"));
			}
		}
		
		
		[Bindable]
		public function get disableClientCaching():Boolean
		{
			return this._disableClientCaching;
		}	
		public function set disableClientCaching(value:Boolean):void
		{
			if (this._disableClientCaching !== value)
			{
				this._disableClientCaching = value;
				dispatchEvent(new Event("disableClientCachingChanged"));
			}
		}
		
		
		[Bindable]
		public function get forceRequest():Boolean
		{
			return this._forceRequest;
		}	
		public function set forceRequest(value:Boolean):void
		{
			if (this._forceRequest !== value)
			{
				this._forceRequest = value;
				dispatchEvent(new Event("forceRequestChanged"));
			}
		}
		
		public function get method():String
		{
			return this._method;
		}
		
		public function set method(value:String):void
		{
			if (this._method !== value)
			{
				if (value == URLRequestMethod.GET || value == URLRequestMethod.POST)
				{
					this._method = value;
					dispatchEvent(new Event("methodChanged"));
				}
			}	
		}
		
		// 服务代理地址
		[Bindable]
		public function get proxyURL():String
		{
			return _proxyURLObj.sourceURL;
		}
		public function set proxyURL(value:String):void
		{
			if (this.proxyURL !== value)
			{
				this._proxyURLObj.update(value);
				dispatchEvent(new Event("proxyURLChanged"));
			}
		}
		
		
		[Bindable]
		public function get requestTimeout():Number
		{
			return this._requestTimeout;
		}	
		public function set requestTimeout(value:Number):void
		{
			if (this._requestTimeout !== value)
			{
				this._requestTimeout = value;
				dispatchEvent(new Event("requestTimeoutChanged"));
			}
		}
		
		
		[Bindable]
		public function get showBusyCursor():Boolean
		{
			return this._showBusyCursor;
		}	
		public function set showBusyCursor(value:Boolean):void
		{
			if (this._showBusyCursor !== value)
			{
				this._showBusyCursor = value;
				dispatchEvent(new Event("showBusyCursorChanged"));
			}
		}
		
		[Bindable]
		public function get token():String
		{
			return _token;
		}
		public function set token(value:String):void
		{
			if (this._token !== value)
			{
				this._token = value;
				dispatchEvent(new Event("tokenChanged"));
			}
		}
		
		[Bindable]
		public function get url():String
		{
			return this._urlObj.sourceURL;
		}	
		public function set url(value:String):void
		{
			if (this.url !== value)
			{
				this._urlObj.update(value);
				dispatchEvent(new Event("urlChanged"));
			}
		}
		
		
		protected function handleResult(event:ResultEvent, asyncToken:AsyncToken, operation:Function) : void
		{
			if (event.result == "")
			{
				this.handleStringError(ResourceManager.getInstance().getString(SmResource.SUPERMAP_MESSAGES,SmResource.RESULT_NULL), asyncToken);
			}
			else
			{
				var resultStr:String = event.result as String;
				var returnObj:Object;
				if(this._resultType =="text")
				{
					var jsonDecoder:JSONDecoder = new JSONDecoder(resultStr, true);  
					returnObj = jsonDecoder.getValue();
				}
				else if(this._resultType =="xml")
				{
					returnObj = new XML(resultStr);
				}
				else
				{
					returnObj = event.result;
				}
				operation.call(this, returnObj, asyncToken);
			}
		}
		
		protected function handleFault(event:FaultEvent, asyncToken:AsyncToken) : void
		{
			var responder:IResponder = null;
			for each (responder in asyncToken.responders)
			{	
				responder.fault(event);
			}
			dispatchEvent(event);
		}
		
		protected function handleError(jsonObject:Object, asyncToken:AsyncToken) : void
		{
			var responder:IResponder;
			var details:String = (jsonObject.details as Array) ? ((jsonObject.details as Array).join("\n")) : ("");
			var fault:Fault = new Fault(jsonObject.code, jsonObject.message, details);
			fault.rootCause = jsonObject;
			for each (responder in asyncToken.responders)
			{
				responder.fault(new FaultEvent(FaultEvent.FAULT, false, true, fault, asyncToken));
			}
			dispatchEvent(new FaultEvent(FaultEvent.FAULT, false, true, fault));
		}
		
		protected function handleStringError(errorString:String, asyncToken:AsyncToken) : void
		{
			var responder:IResponder;
			var fault:Fault = new Fault(null, errorString);
			
			for each (responder in asyncToken.responders)
			{
				responder.fault(fault);
			}
			
			dispatchEvent(new FaultEvent(FaultEvent.FAULT, false, true, fault));
		}
		
		
		public function initialized(document:Object, id:String):void
		{
			this.id = id;
		}
		
		protected function initHttpService():void
		{
			this._httpService.request = {};
			this._httpService.method = this.method;
			this._httpService.requestTimeout = this.requestTimeout;
			this._httpService.showBusyCursor = this.showBusyCursor;
			this._httpService.concurrency = this.concurrency;
		}
		
		private function loaderCompleteHandler(event:Event) : void
		{
			var data:ByteArray;
			var obj:Object;
			var result:String;
			var resultEvent:ResultEvent;
			var loader:MyURLLoader = event.target as MyURLLoader;
			this.removeEventListeners(loader);
			data = loader.data;
			try
			{
				obj = data.readObject();
			}
			catch (error:Error)
			{
				data.position = 0;
				result = data.readUTFBytes(data.length);
				resultEvent = new ResultEvent(ResultEvent.RESULT, false, false, result);
				handleResult(resultEvent, loader.token, loader.operation);
				return;
			}
			loader.operation.call(this, obj, loader.token);
		}
		
		private function loaderIOErrorHandler(event:IOErrorEvent) : void
		{
			var loader:MyURLLoader = event.target as MyURLLoader;
			this.removeEventListeners(loader);
			this.handleStringError(event.text, loader.token);
		}
		
		private function loaderSecurityErrorHandler(event:SecurityErrorEvent) : void
		{
			var loader:MyURLLoader = event.target as MyURLLoader;
			this.removeEventListeners(loader);
			this.handleStringError(event.text, loader.token);
			throw new SecurityError(event.text);
		}
		
		private function removeEventListeners(loader:URLLoader) : void
		{
			loader.removeEventListener(Event.COMPLETE, this.loaderCompleteHandler);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, this.loaderIOErrorHandler);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loaderSecurityErrorHandler);
		}
		
//		private function getJsonStringFromVariables(queryVar:Object):String
//		{
//			if(queryVar is String)
//			{
//				return queryVar as String;
//			}
//			var json:String = "";
//			if (queryVar)
//			{
//				var key:String;
//				var jsonArray:Array = [];
//				for (key in queryVar) 
//				{
//					jsonArray.push("\"" + key + "\":" + queryVar[key]);
//				} 
//				json = "{" + jsonArray.join(",") + "}";
//			}
//			return json;
//		}
		
		protected function sendURL(extendUrlPath:String, 
								   queryVar:Object, 
								   responder:IResponder, 
								   operation:Function):AsyncToken
		{
			var asyncToken:AsyncToken;
			var hasQueryVars:Boolean;
			
			this.initHttpService();    	
			this._httpService.url = this._urlObj.path ? (this._urlObj.path) : ("");
			var n:int = this._httpService.url.lastIndexOf("/");		 	
			if (extendUrlPath != "")
			{				
				if(Credential.CREDENTIAL)
				{
					if(extendUrlPath.split("?").length>1)
						extendUrlPath += "&" +  Credential.CREDENTIAL.getUrlParameters();
					else
						extendUrlPath += "?" + Credential.CREDENTIAL.getUrlParameters();
				}
				var str:String = this._httpService.url.slice(n);
				if (str != "/" && str.toLowerCase() == extendUrlPath)
				{
					this._httpService.url = this._httpService.url.slice(0, n);
				}
				this._httpService.url = this._httpService.url + extendUrlPath;
			}
			
			var postMarkIndex:int = extendUrlPath.indexOf("flexAgent");
			var postMarkIndex2:int = extendUrlPath.indexOf("debug");
			if((postMarkIndex > -1) || (postMarkIndex2 > -1))
				this._httpService.method = URLRequestMethod.POST;
			
			var linkMarkIndex:int = extendUrlPath.indexOf("?");
			if(linkMarkIndex > -1)
				hasQueryVars = true;
			
			var reqVars:URLVariables = new URLVariables();
			
			//如果传过来的是字符串就直接构建请求吧
			if(queryVar && queryVar is String)
			{
				if (this._httpService.method != URLRequestMethod.POST)
				{
					//此方法第三方服务Get请求也适用
					this._httpService.url = this._httpService.url + (hasQueryVars ? ("&") : ("?")) + queryVar;
				}
				else
				{
					if((postMarkIndex > -1) || (postMarkIndex2 > -1))
					{
						var postVars:URLVariables = new URLVariables();
						postVars.requestEntity = queryVar;
						this._httpService.request = postVars;
					}
					else
					{
						this._httpService.contentType = this.contentType;
						this._httpService.request = queryVar;
					}
				}
				this._httpService.url = encodeURI(this._httpService.url);
			}
			
			else
			{
				var reqObj:Object;
				var key:String;
				for (key in queryVar)
				{	
					reqVars[key] = queryVar[key];
				}
				
				var queryVars:URLVariables = new URLVariables();
				var queryVar2:URLVariables = this._urlObj.query;
				for (key in queryVar2)
				{			
					if (!reqVars[key])
					{
						queryVars[key] = this._urlObj.query[key];
					}
				}
				
//				if (this.token)
//				{
//					if (queryVars.token)
//					{
//						queryVars.token = this.token;
//					}
//					else
//					{
//						reqVars.token = this.token;
//					}
//				}
				
				if (this.disableClientCaching && !queryVars._t && !reqVars._t)
				{
					reqVars._t = new Date().time;
				}
				
				if (this.proxyURL)
				{
					this._httpService.url = this._proxyURLObj.path + "?" + this._httpService.url;
					if (this._proxyURLObj.query)
					{
						var proxyQuery:* = this._proxyURLObj.query;
						for (key in proxyQuery)
						{		
							reqObj = proxyQuery[key];
							if (!queryVars[reqObj] && !reqVars[reqObj])
							{
								queryVars[reqObj] = this._proxyURLObj.query[reqObj];
							}
						}
					}
				}
				this._httpService.url = encodeURI(this._httpService.url);
				var query:String = queryVars.toString();
				if (query && query.length > 0)
				{
					hasQueryVars = true;   //??
					this._httpService.url = this._httpService.url + ("?" + query);
				}
				if (this._httpService.method != URLRequestMethod.POST)
				{
					var length:Number = this._httpService.url.length + reqVars.toString().length;
					if (length > 2000)
					{
						this._httpService.method = URLRequestMethod.POST;
					}
					else
					{
						if (!queryVars.token && reqVars.token)   //???
						{
							this._httpService.method = URLRequestMethod.POST;
						}
					}
				}
				
				var layerDefs:String;
				if (reqVars.layerDefs && this._httpService.method != URLRequestMethod.POST)
				{
					layerDefs = reqVars.layerDefs;
					delete reqVars.layerDefs;
				}
				var reqParams:String = reqVars.toString();
				if (this._httpService.method != URLRequestMethod.POST)
				{
					if (reqParams && reqParams.length > 0)
					{
						this._httpService.url = this._httpService.url + ((hasQueryVars ? ("&") : ("?")) + reqParams);
						if (layerDefs)
						{
							this._httpService.url = this._httpService.url + ("&layerDefs=" + encodeURIComponent(layerDefs));
						}
					}
				}
				else
				{
					if (reqParams && reqParams.length == 0)
					{
						reqVars.forceFlashPOST = true;
					}
					this._httpService.request = reqVars;
				}
			}
					
			asyncToken = new AsyncToken(null);
			if (responder)
			{
				asyncToken.addResponder(responder);
			}
			if (reqVars.f == "amf")
			{
				var loader:MyURLLoader = new MyURLLoader();
				loader.operation = operation;
				loader.token = asyncToken;
				loader.addEventListener(Event.COMPLETE, this.loaderCompleteHandler);
				loader.addEventListener(IOErrorEvent.IO_ERROR, this.loaderIOErrorHandler);
				loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.loaderSecurityErrorHandler);
				var request:URLRequest = new URLRequest(this._httpService.url);
				request.data = this._httpService.request is URLVariables ? (this._httpService.request) : (null);
				request.method = this._httpService.method;
				loader.load(request);
			}
			else
			{
				var httpServiceAsyncToken:AsyncToken = this._httpService.send();
				httpServiceAsyncToken.addResponder(new Responder(
					function (event:ResultEvent) : void
					{
						handleResult(event, asyncToken, operation);
					},
					function (event:FaultEvent) : void
					{
						var securityError:SecurityErrorEvent;
						handleFault(event, asyncToken);
						if (event.fault && event.fault.rootCause)
						{
							securityError = event.fault.rootCause as SecurityErrorEvent;
							if (securityError)
								throw new SecurityError(securityError.text);
						}
					}));
			}
			return asyncToken;
		}

		public function get contentType():String
		{
			return _contentType;
		}

		public function set contentType(value:String):void
		{
			_contentType = value;
		}

		public function get resultType():String
		{
			return _resultType;
		}

		public function set resultType(value:String):void
		{
			_resultType = value;
		}


	}
}


//////////////////////////////////////////////////////////////////////////////
///////////////////////////myloader类，先放着，以后用不到再删掉/////////////////
import flash.net.URLLoader;

import mx.rpc.AsyncToken;

class MyURLLoader extends URLLoader
{
	private var _token:AsyncToken;
	private var _operation:Function;
	
	public function MyURLLoader()
	{
	}
	
	public function get operation():Function
	{
		return _operation;
	}
	
	public function set operation(value:Function):void
	{
		_operation = value;
	}
	
	public function get token():AsyncToken
	{
		return _token;
	}
	
	public function set token(value:AsyncToken):void
	{
		_token = value;
	}
	
}