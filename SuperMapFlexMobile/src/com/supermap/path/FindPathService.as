package com.supermap.path
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.service.ServiceBase;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	public class FindPathService extends ServiceBase
	{
		override public function FindPathService()
		{
			super("http://services.supermapcloud.com/iserver");
		}
		
		public function pathExecu(starPoint:Point2D, endPoint:Point2D,responder:IResponder = null):AsyncToken
		{		
			var reqVar:URLVariables = new URLVariables();
			reqVar.servicename = "TransportationAnalyst";
			reqVar.methodname = "findPath";
			if(starPoint&&endPoint)
			{
				var commonStr:String = "{\"startPoint\":{\"x\":"+starPoint.x+", \"y\":"+starPoint.y+"}, \"endPoint\":{\"x\":"+endPoint.x+", \"y\":"+endPoint.y+"}, \"nSearchMode\":0, \"pPntWay\":[]}";
				
				reqVar.parameter = commonStr;
			}
			return sendURL("/cloudhandler", reqVar, responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			var lastResult:FindPathRecordSet;
			if(object&&object.result[0])
			{
				lastResult = FindPathRecordSet.toExtendRecordSetPath(object.result[0]);
			}
			for each (responder in asyncToken.responders)
			{
				responder.result(lastResult);
			}			
		}
	}
}