package com.supermap.web.service.supportClasses
{
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */
	public class SmMapService extends ServiceBase
	{
		
		private var _smMapServiceInfo:SmMapServiceInfo;
		
		
		
		public function SmMapService(url:String)
		{
			super(url);
		}
		
		[Bindable]
		public function get lastResult():SmMapServiceInfo
		{
			return this._smMapServiceInfo;
		}
		
		public function set lastResult(value:SmMapServiceInfo):void
		{
			this._smMapServiceInfo = value;
		}
		
		public function execute(responder:IResponder = null, dynamicPrjWkid:int=-1000):AsyncToken
		{
			var extendUrl:String = ".json";
			
			
			if(dynamicPrjWkid>0)
				extendUrl += "?" + "prjCoordSys={\"epsgCode\":" + dynamicPrjWkid.toString() + "}";
			
			return sendURL(extendUrl, null, responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this.lastResult = SmMapServiceInfo.fromJson(object);
			for each (responder in asyncToken.responders)
			{
				responder.result(this.lastResult);
			}
		}
	}
}