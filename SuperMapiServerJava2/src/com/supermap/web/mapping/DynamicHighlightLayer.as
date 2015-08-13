package com.supermap.web.mapping
{
	import com.supermap.web.sm_internal;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	use namespace sm_internal;

	/**
	 * ${iServerJava2_DynamicHighLightLayer_Title}.
	 * <p>${iServerJava2_DynamicHighLightLayer_Description}</p>
	 * 
	 * 
	 */	
	public class DynamicHighlightLayer extends DynamicLayer
	{
		private var _url:String;
		private var _time:Date;
		private var _urlRequest:URLRequest;
		private var _mapName:String;
		
		/**
		 * ${iServerJava2_DynamicHighLightLayer_constructor_None_D} 
		 * 
		 */		
		public function DynamicHighlightLayer()
		{
			super();
			this.setLoaded(true);
			this._urlRequest = new URLRequest();
			this._time = new Date();
			this.isIServer2Layer = true;
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */				
		public override function get url():String
		{
			return this._url;
		}
		
		public override function set url(value:String):void
		{
			if (this._url != value)
			{			
				if (value && value != "")
				{
					this._url = value;		
					if(this._url.lastIndexOf("/") != this._url.length - 1)
					{
						this._url += "/";
					}
					invalidateProperties();
				}
				
			}
		}
		
		/**
		 * ${iServerJava2_DynamicHighLightLayer_attribute_mapName_D} 
		 * @return 
		 * 
		 */		
		public function get mapName():String
		{
			return this._mapName;
		} 
		public function set mapName(value:String):void
		{
			if (this._mapName != value)
			{
				if (value && value != "")
				{
					this._mapName = value;		
					invalidateProperties();
				}
			}
		} 
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		public override function refresh():void
		{	
			this._time = new Date();
			super.refresh();
		}
		
		/**
		 * @private 
		 * 
		 */		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			invalidateLayer();
		}
		
		/**
		 * @inheritDoc 
		 * @param loader
		 * 
		 */		
		override protected function loadMapImage(loader:Loader) : void
		{
			if (this.resolution <= 0)
			{
				return;
			}	  	
			var width:Number = this.map.width;
			var height:Number = this.map.height;
			var minX:Number = this.map.viewBounds.left;
			var minY:Number = this.map.viewBounds.bottom;
			var maxX:Number = this.map.viewBounds.right;
			var maxY:Number = this.map.viewBounds.top; 
			var mapHandler:String="/maphandler";
			
			var serverURL:String = this.url + mapHandler + "?mapName=" + encodeURI(this._mapName) + "&imageFormat=" + this.imageFormat + "&width=" + 
				width + "&minx=" + minX + "&maxx="+maxX+"&miny="+minY+"&maxy=" + maxY + "&height=" + height + 
				"&mapScale=" + 1.0 + "&method=gettiledtrackinglayerimagebybounds&t=" + 
				this._time.getTime();
			
			this._urlRequest.url = serverURL;
			loader.load(this._urlRequest);
		}
		
		/**
		 * ${iServerJava2_DynamicHighLightLayer_method_clear_D} 
		 * 
		 */		
		public function clear():void
		{
			var urlloader:URLLoader = new URLLoader();
			urlloader.addEventListener(Event.COMPLETE, clearComplete);
//			urlloader.addEventListener(IOErrorEvent.IO_ERROR, clearError);
			var urlRequest:URLRequest = new URLRequest();
			var serverURL:String = this.url + "commonhandler?" + "mapName=" + encodeURI(this._mapName) + "&params=" + "<uis>" +  "<command>" + "<name>" + 
				"ClearHighlight" + "</name>" + "<parameter>" + "<mapName>" + encodeURI(this._mapName) + "</mapName>" + "<customParam>" + "</customParam>" + 
				"</parameter>" + "</command>" + "</uis>" + "&method=" + "ClearHighlight&t=" + this._time.getTime();
			
			urlRequest.url = encodeURI(serverURL);
			urlloader.load(urlRequest);
		}
		
		private function clearComplete(event:Event):void
		{
			this.refresh();
		}
	}
}