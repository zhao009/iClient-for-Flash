package com.supermap.query
{
	import com.supermap.events.ReadConfigEvent;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;

	public class ConfigReader
	{
		public static var categoryList:XML;
		
		private var app:Object;
		public function ConfigReader(application:Object)
		{
			var service:HTTPService = new HTTPService();   
			service.url = "com/supermap/query/config.xml";  
			service.resultFormat = "e4x";
			service.addEventListener(ResultEvent.RESULT, resultHandler);   
			service.send(); 
			this.app = application;
		}
		
		protected function resultHandler(event:ResultEvent):void
		{
			categoryList = event.result as XML;
			this.app.dispatchEvent(new ReadConfigEvent(ReadConfigEvent.READ_COMPLETE));
		}
	}
}