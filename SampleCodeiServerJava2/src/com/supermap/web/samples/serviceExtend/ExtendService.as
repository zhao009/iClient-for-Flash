package com.supermap.web.samples.serviceExtend
{
	import com.supermap.web.service.ServiceBase;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	public class ExtendService extends ServiceBase
	{
		override public function ExtendService(url:String)
		{
			super(url);
		}
		
		public function execute(parameters:ExtendServiceParameters, responder:IResponder = null):AsyncToken
		{
			var reqVar:URLVariables = new URLVariables();
			reqVar.mapName = parameters.mapName;
			reqVar.method = parameters.method;
			if(parameters.params)
			{
				var queryVar:URLVariables = parameters.params;
				reqVar.params = "<uis>" + 
					"<command>" + 
					"<name>" + parameters.method + "</name>" +
					"<parameter>" + 
					"<mapName>" + parameters.mapName + "</mapName>" ;
				
				var key:String;
				for (key in queryVar)
				{	
					reqVar.params += "<" + key + ">" + queryVar[key] + "</" + key + ">";
				}
				reqVar.params += "</parameter>" + 
					"</command>" + 
					"</uis>";
			}
			return sendURL("/commonhandler", reqVar, responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			for each (responder in asyncToken.responders)
			{
				responder.result(object);
			}			
		}

	}
}