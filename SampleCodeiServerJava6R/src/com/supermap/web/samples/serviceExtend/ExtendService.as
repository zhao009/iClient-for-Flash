package com.supermap.web.samples.serviceExtend
{
	import com.supermap.web.service.ServiceBase;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public class ExtendService extends ServiceBase
	{
		private var _lastResult:ExtendServiceResult = new ExtendServiceResult();
		override public function ExtendService(url:String)
		{
			super(url);
		}
		
		public function processAsync(parameters:ExtendServiceParameters, responder:IResponder=null):AsyncToken
		{
			if (parameters == null)
			{
				this.handleStringError("参数为空", null);
				return null;
			} 
			var extendURL:String = "getTemperatureResult.json?" + "arg0=" + parameters.arg + "&X-RequestEntity-ContentType=application/flex";
			
			if(this.url.charAt(this.url.length - 1) != "/")
			{
				extendURL = "/" + extendURL;
			}  
			return sendURL(extendURL, null, responder, this.handleDecodedObject); 
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult.result = object.toString();
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
		}

	}
}