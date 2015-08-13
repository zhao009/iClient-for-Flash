package 
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	import mx.utils.ObjectProxy;
	import mx.utils.URLUtil;
	
	import spark.components.Group;
	public class ViewConfig
	{
		[Bindable]public var webUrl:String;
		[Bindable]public var gisUrl:String;
		[Bindable]public var cacheUrl:String;
		[Bindable]public var extendServiceUrl:String;
		
		private var app:Object;
		public function ViewConfig(application:Object):void
		{
			var service:HTTPService = new HTTPService();   
			service.url = "mapUrlConfig.xml";   
			service.addEventListener(ResultEvent.RESULT, resultHandler);   
			service.send(); 
			this.app = application;
		}
		
		private function resultHandler(event:ResultEvent):void
		{ 
			var url:String = this.app.url;
			var subUrl:String = URLUtil.getProtocol(url);
			if(subUrl == "file")
			{ 
				webUrl = (event.result.node.url[0] as ObjectProxy).value; 
				gisUrl = (event.result.node.url[1] as ObjectProxy).value; 
				cacheUrl = (event.result.node.url[2] as ObjectProxy).value; 
				extendServiceUrl = (event.result.node.url[3] as ObjectProxy).value; 
			}
			//支持 tomcat 发布的服务
			else
			{ 
				gisUrl = URLUtil.getServerName(url);
				webUrl = subUrl + "://" + URLUtil.getServerNameWithPort(url) + "/demo";
				cacheUrl = subUrl + "://" + URLUtil.getServerNameWithPort(url) + "/output/cache";
				extendServiceUrl = subUrl + "://" + URLUtil.getServerNameWithPort(url) + "/samplecode";
			}
		} 
	}
}