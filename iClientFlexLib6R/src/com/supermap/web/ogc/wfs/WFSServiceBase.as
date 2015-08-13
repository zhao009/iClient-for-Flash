package com.supermap.web.ogc.wfs
{
	import com.supermap.web.core.Credential;
	
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.Fault;
	import mx.rpc.IResponder;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;

	/**
	 * ${ogc_wfs_WFSServiceBase_Title}.
	 * <p>${ogc_wfs_WFSServiceBase_Description}</p> 
	 * @see com.supermap.web.ogc.wfs.GetWFSCapabilities
	 * @see com.supermap.web.ogc.wfs.DescribeWFSFeatureType
	 * @see com.supermap.web.ogc.wfs.GetWFSFeature
	 * 
	 */	
	public class WFSServiceBase extends EventDispatcher
	{
		private var _url:String;
		private var _version:String = "1.0.0";
		
		/**
		 * ${ogc_wfs_WFSServiceBase_attribute_url_D} 
		 * @return 
		 * 
		 */		
		public function get url():String
		{
			return this._url;
		}	
		
		public function set url(value:String):void
		{
			if (value && this.url !== value)
			{
				this._url = value;
				if(this._url.lastIndexOf("/") == this._url.length - 1)
				{
					this._url = this._url.substr(0, this._url.length - 1);
				}
			}		
		}
		
		/**
		 * ${ogc_wfs_WFSServiceBase_attribute_version_D} 
		 * @return 
		 * 
		 */		
		public function get version():String 
		{
			return _version;
		}
		
		public function set version(version:String):void 
		{
			_version = version;
		}
		
		/**
		 * ${ogc_wfs_WFSServiceBase_method_ProcessAsync_D}.
		 * <p>${ogc_wfs_WFSServiceBase_method_ProcessAsync_remarks}</p> 
		 * 
		 */		
		public function processAsync(responder:IResponder = null):void
		{
			var asyncToken:AsyncToken;
			asyncToken = new AsyncToken(null);
			if (responder)
			{
				asyncToken.addResponder(responder);
			}
			
			var url:String = this.getFinalUrl();
			if(Credential.CREDENTIAL)
			{
				url += "&" + Credential.CREDENTIAL.getUrlParameters();
			}
			var httpService:HTTPService = new HTTPService();
			httpService.url = encodeURI(url);
			httpService.resultFormat="e4x";
			
			var httpServiceAsyncToken:AsyncToken = httpService.send();
			httpServiceAsyncToken.addResponder(new Responder(
				function (event:ResultEvent) : void
				{
					getResultHandler(event, asyncToken);
				}
				,
				function (event:FaultEvent) : void
				{
					getResultErrorHandler(event, asyncToken);
				}
				));
		}
		
		/**
		 * ${ogc_wfs_WFSServiceBase_method_getResultHandler_D} 
		 * 
		 */		
		protected function getResultHandler(event:ResultEvent, asyncToken:AsyncToken) : void
		{
		}
		
		/**
		 * ${ogc_wfs_WFSServiceBase_method_handleStringError_D} 
		 * 
		 */		
		protected function handleStringError(errorString:String, asyncToken:AsyncToken) : void
		{
			var responder:IResponder;
			var fault:Fault = new Fault(null, errorString);
			if(asyncToken)
			{
				for each (responder in asyncToken.responders)
				{
					responder.fault(fault);
				}
			}
			dispatchEvent(new FaultEvent(FaultEvent.FAULT, false, true, fault));
		}
		
		private function getResultErrorHandler(event:FaultEvent, asyncToken:AsyncToken) : void
		{
			var responder:IResponder = null;
			for each (responder in asyncToken.responders)
			{	
				responder.fault(event);
			}
			dispatchEvent(event);
		}
		
		/**
		 * ${ogc_wfs_WFSServiceBase_method_getFinalUrl_D} 
		 * @return 
		 * 
		 */		
		protected function getFinalUrl():String
		{
			return null;
		}
		
		/**
		 * ${ogc_wfs_WFSServiceBase_constructor_string_D} 
		 * 
		 */		
		public function WFSServiceBase()
		{
		}
	}
}