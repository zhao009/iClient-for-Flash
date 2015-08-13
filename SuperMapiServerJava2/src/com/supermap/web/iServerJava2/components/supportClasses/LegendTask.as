package com.supermap.web.iServerJava2.components.supportClasses
{ 
	import com.supermap.web.iServerJava2.mapServices.GetMapStatusParameters;
	import com.supermap.web.iServerJava2.mapServices.GetMapStatusResult;
	import com.supermap.web.iServerJava2.mapServices.GetMapStatusService;
	import com.supermap.web.mapping.Layer;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.Responder;
	import com.supermap.web.iServerJava2.components.LegendEvent;

	/**
	 * @private 
	 * @author lirh
	 * 
	 */	
	public class LegendTask extends GetMapStatusService
	{   
		private var _layerID:String; 
		private var _mapName:String; 
		private var _mapServicesAddress:String;
		private var _mapServicesPort:String;
		  
		public static function toLegendTask(layer:Layer):LegendTask
		{ 
			var legendTask:LegendTask;
			if(layer)
			{
				var mapName:String = (layer as Object).mapName;
				var address:String = (layer as Object).mapServiceAddress;
				var port:String = (layer as Object).mapServicePort;
				var layerID:String = layer.id;
				legendTask = new LegendTask(layer.url, mapName, address, port, layerID);
			}
			return legendTask;
		}
		
		public function LegendTask(url:String, mapName:String, mapServicesAddress:String, mapServicesPort:String, layerID:String)
		{
			super(url);     
			this.mapName = mapName;
			this.mapServicesAddress = mapServicesAddress;
			this.mapServicesPort = mapServicesPort;
			this.layerID = layerID;
		}
 
		public function get mapServicesPort():String
		{
			return _mapServicesPort;
		}

		public function set mapServicesPort(value:String):void
		{
			_mapServicesPort = value;
		}

		public function get mapServicesAddress():String
		{
			return _mapServicesAddress;
		}

		public function set mapServicesAddress(value:String):void
		{
			_mapServicesAddress = value;
		}

		public function get mapName():String
		{
			return _mapName;
		}

		public function set mapName(value:String):void
		{
			_mapName = value;
		}

		public function get layerID():String
		{
			return _layerID;
		}

		public function set layerID(value:String):void
		{
			_layerID = value; 
		}
        
		public function excute():void
		{   
			var parameters:GetMapStatusParameters;
			if(url != null)
			{
				parameters = new GetMapStatusParameters(this.mapName, this.mapServicesAddress, this.mapServicesPort);
				this.execute(new AsyncResponder(this.processCompleted, null, null), parameters);
			}
		}
	 	/**
		 * 派发服务端请求完成事件
		 */
		public function processCompleted(result:GetMapStatusResult, mark:Object):void
		{
			this.dispatchEvent(new LegendEvent(LegendEvent.PROCESS_COMPLETE, result));
		}
	}
}