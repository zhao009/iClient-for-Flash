package com.supermap.web.mapping
{
	import com.supermap.web.core.*;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	import flash.net.*;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.rpc.Fault;
	
	use namespace sm_internal; 
	
	[IconFile("/designIcon/TiledWMSLayer.png")]
	/**
	 * ${mapping_TiledWMSLayer_Title}.
	 * <p>${mapping_TiledWMSLayer_Description}</p> 
	 * 
	 * 
	 */	
	public class TiledWMSLayer extends TiledDynamicLayer
	{
		private var _wmsParams:WMSParams;
		private var _loader:URLLoader;
		private var _enableGetCapabilities:Boolean = true;
		private var _getCapabilitiesDone:Boolean = false;
		private var _urlChanged:Boolean = false;
		private var _layersChanged:Boolean = false;
		private var _url:String;
		private var _layers:ArrayCollection;
		
		
		/**
		 * ${mapping_TiledWMSLayer_constructor_D} 
		 * @param url ${mapping_TiledWMSLayer_constructor_String_param_url}
		 * @param layers ${mapping_TiledWMSLayer_constructor_WMSParams_param_Layers}
		 * 
		 */		
		public function TiledWMSLayer(url:String = null, layers:Object = null)
		{		
			this._loader = new URLLoader();
			this._wmsParams = new WMSParams();
			if(url && url != "")
			{
				this.url = url;
			}
			if(layers)
			{
				this.layers = layers;
			}		
			//addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
		}
		
		[Bindable]
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_TiledWMSLayer_attribute_bgcolor_D} 
		 * @return 
		 * 
		 */		
		public function get bgcolor():String 
		{
			return this._wmsParams.bgcolor;
		}	
		public function set bgcolor(bgcolor:String):void 
		{
			this._wmsParams.bgcolor = bgcolor;
		}
		
		[Bindable]
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_DynamicWMSLayer_attribute_layers_D} 
		 * @return 
		 * 
		 */		
		public function get layers():Object 
		{
			return this._layers;
		}
		public function set layers(value:Object):void 
		{
			if (this._layers)
			{
				this._layers.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.layers_collectionChangeHandler);
			}
			var layerArray:Array = null;
			if (value is Array)
			{
				this._layers = new ArrayCollection(value as Array);
			}
			else if (value is ArrayCollection)
			{
				this._layers = value as ArrayCollection;
			}
			else
			{
				layerArray = [];
				if (value != null)
				{
					layerArray.push(value);
				}
				this._layers = new ArrayCollection(layerArray);
			}
			
			if (this._layers)
			{
				this._layers.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.layers_collectionChangeHandler);
				this._wmsParams.layers = this._layers.source.join(",");
			}
			this._layersChanged = true;
			
			invalidateProperties();
			dispatchEvent(new Event("layersChanged"));
		}
		
		[Inspectable(category = "iClient", defaultValue = "true", enumeration = "true,false")] 
		/**
		 * ${mapping_TiledWMSLayer_attribute_enableGetCapabilities_D} 
		 * @default true
		 * @return 
		 * 
		 */		
		public function get enableGetCapabilities():Boolean 
		{
			return this._enableGetCapabilities;
		}
		public function set enableGetCapabilities(value:Boolean):void {
			this._enableGetCapabilities = value;
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_DynamicWMSLayer_attribute_exceptions_D} 
		 * @return 
		 * 
		 */		
		public function get exception():String 
		{
			return this._wmsParams.exceptions;
		}
		public function set exception(value:String):void {
			_wmsParams.exceptions = value;
		}
		
		[Bindable]
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		public override  function get url():String
		{
			return this._url;
		}	
		public override  function set url(value:String):void
		{
			if (this.url !== value && value)
			{
				this._url = value;
				this._urlChanged = true;
				invalidateProperties();
				setLoaded(false);
				dispatchEvent(new Event("urlChanged"));
			}		
		}
		
		[Bindable]
		/**
		 * @copy Layer#urls 
		 * @return 
		 * 
		 */			
		public function get urls():Array
		{
			return this._urls;
		}
		public function set urls(value:Array):void
		{
			if(value == null)
			{
				this._urls= null;
				return;
			}
			
			this._urls = [];
			var length:int = value.length;
			var tempUrl:String = null;
			
			for (var i:int = 0; i < value.length; i++)
			{		
				if (value[i] && value[i] != "")
				{ 
					tempUrl = value[i];
					
					this._urls.push(tempUrl);
					if(i==0)
					{
						this._url = tempUrl;
					}
				}
			}
			
			this._urlChanged = true;
			invalidateProperties();
			setLoaded(false);
			dispatchEvent(new Event("urlChanged"));
		}
		
		[Bindable]
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_TiledWMSLayer_attribute_version_D} 
		 * @return 
		 * 
		 */		
		public function get version():String 
		{
			return this._wmsParams.version;
		}
		public function set version(value:String):void 
		{
			if (this._wmsParams.version !== value && WMSParams.SUPPORTED_VERSIONS.indexOf(value) != -1)
			{
				this._wmsParams.version = value;
				dispatchEvent(new Event("versionChanged"));
			}
		}
		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			if (this._urlChanged)
			{
				this._urlChanged = false;
				removeAllChildren();			
				setLayerLoaded(); 
			}
			if (this._layersChanged)
			{
				this._layersChanged = false;
				removeAllChildren();			
				invalidateLayer();	
			}
		}
		
		override public function get isScaleCentric() : Boolean
		{
			return true;
		}
		
		/**
		 * @copy TiledDynamicLayer#getTileURL() 
		 * @param row
		 * @param col
		 * @param resolution
		 * @return 
		 * 
		 */		
		override protected function getTileURL(row:int, col:int, resolution:Number) : URLRequest
		{
			var bbox:Rectangle2D = getBBox(resolution, row, col);
			if(this.version == "1.3.0")
			{
				this._wmsParams.bbox = WMSParams.rectToYXBBox(bbox, this._wmsParams.crs);
			}
			else
			{
				this._wmsParams.bbox = bbox.bbox;
			}
			
			var tempUrl:String; 
			tempUrl = this.url;
			if(this._urls && this._urls.length>0)
			{
				tempUrl = selectUrls(row,col);
			}
			
			var tileURL:String = tempUrl + "?" + this._wmsParams.toGETString();
			return new URLRequest(tileURL);
		}
		
		private function getCapabilities() : void
		{
			var str:String = this.url + "?" + "SERVICE=WMS" + "&"
				+ "REQUEST=" + "GetCapabilities" + "&"
				+ "VERSION=" + this._wmsParams.version;
			var urlRequest:URLRequest = new URLRequest(str);
			
			this._loader.dataFormat = URLLoaderDataFormat.TEXT;
			this._loader.addEventListener(Event.COMPLETE, this.getCapabilitiesHandler, false, 0, true);
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, getCapabilities_ioErrorHandler, false, 0, true);
			this._loader.load(urlRequest);
		}
		
		private function getCapabilitiesHandler(event:Event) : void
		{
			this._loader.removeEventListener(Event.COMPLETE, this.getCapabilitiesHandler);
			try 
			{
				var wmsInfo:XML = new XML(event.target.data);
				if(CRS && CRS.wkid && CRS.wkid > 0)
					this._wmsParams.crs = "EPSG:" + CRS.wkid;
				this._wmsParams.fromXML(wmsInfo);
			} 
			catch ( e:TypeError ) 
			{
				throw new SmError(SmResource.TO_XML_ERROR);//0920byzyn
			}
			this._getCapabilitiesDone = true;
			this.setLayerLoaded();
		}
		
		private function getCapabilities_ioErrorHandler(event:IOErrorEvent) : void
		{
			var fault:Fault = new Fault(null, event.text);
			fault.rootCause = event;
			dispatchEvent(new LayerEvent(LayerEvent.UPDATE_END, this, fault, false));
		}
		
		private function setLayerLoaded() : void
		{
			if(this._enableGetCapabilities && !this._getCapabilitiesDone)
			{
				this.getCapabilities();
				return;
			}
			
			if(this.CRS == null || this.CRS.wkid == 0)
			{
				this.CRS = this._wmsParams.srsToCRS();
			}	
			else
			{
				this._wmsParams.crs = "EPSG:" + this.CRS.wkid;
			}
			
			if(this.bounds == null )
			{
				this.bounds = new Rectangle2D();
			}
			if(this.bounds.isEmpty())
			{
				this.bounds.bbox = this._wmsParams.bbox;
			}
			else
			{
				this._wmsParams.bbox = this.bounds.bbox;
			}
			
			if(isNaN(this.tileSize) || this.tileSize <= 0)
			{
				this.tileSize = 256;
			}
			
			if(!this.origin)
			{
				this.origin = new Point2D(this.bounds.left, this.bounds.top);
			}
			
			this._wmsParams.width = this.tileSize;
			this._wmsParams.height = this.tileSize;
			this._wmsParams.tiled = true;
			this._wmsParams.transparent = this.transparent;
			this._getCapabilitiesDone = false;	
			
			setLoaded(true);	
			invalidateLayer();
		}
		
		private function getBBox(resolution:Number, row:Number, col:Number):Rectangle2D
		{
			var bounds:Rectangle2D = this.bounds;
			var left:Number = bounds.left + this.tileSize * col * resolution;	
			var right:Number = bounds.left + this.tileSize * (col+1) * resolution;	
			var bottom:Number = bounds.top - this.tileSize * (row+1) * resolution;	
			var top:Number = bounds.top - this.tileSize * row * resolution;	
			try
			{
				var rect:Rectangle2D = new Rectangle2D(left, bottom, right, top);
			}
			catch(e:ArgumentError)
			{
				return new Rectangle2D();
			}
			
			return rect;
		}
		
		private function layers_collectionChangeHandler(event:CollectionEvent) : void
		{
			this._wmsParams.layers = this._layers.source.join(",");
			if(!this._wmsParams.layers || this._wmsParams.layers == "")
			{
				this.removeAllChildren();
			}
			this.forceToRefresh();
		}
		/**
		 * 通过手动修改WmsParas来获取对应的字串�?
		 * */
		sm_internal function getWmsParasString(bbox:Rectangle2D):String
		{
			var wmsParams:WMSParams = _wmsParams.clone();
			if(this.version == "1.3.0")
			{
				wmsParams.bbox = WMSParams.rectToYXBBox(bbox);
			}
			else
			{
				wmsParams.bbox = bbox.bbox;
			}
			var result:String =  wmsParams.toGETString();
			wmsParams = null;
			return result;
		}
		
	}
}