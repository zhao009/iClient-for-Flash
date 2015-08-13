package com.supermap.web.mapping
{
	import com.supermap.web.core.*;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.rpc.Fault;
	
	use namespace sm_internal;
	
	[IconFile("/designIcon/DynamicWMSLayer.png")]
	/**
	 * ${mapping_DynamicWMSLayer_Title}.
	 * <p>${mapping_DynamicWMSLayer_Description}</p> 
	 * 
	 * 
	 */	
	public class DynamicWMSLayer extends DynamicLayer
	{
		private var _wmsParams:WMSParams;
		private var _urlRequest:URLRequest;
		private var _loader:URLLoader;
		private var _enableGetCapabilities:Boolean = true;
		private var _getCapabilitiesDone:Boolean = false;
		private var _urlChanged:Boolean = false;
		private var _layersChanged:Boolean = false;
		private var _url:String;
		private var _layers:ArrayCollection;
		
		/**
		 * ${mapping_DynamicWMSLayer_constructor_D}. 
		 * @param url ${mapping_DynamicWMSLayer_constructor_String_param_url}
		 * @param wmsParams ${mapping_DynamicWMSLayer_constructor_WMSParams_param_wmsParams}
		 * 
		 */		
		public function DynamicWMSLayer(url:String = null, layers:Object = null)
		{		
			this._wmsParams = new WMSParams();
			this._urlRequest = new URLRequest();
			this._loader = new URLLoader();
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
		 * ${mapping_DynamicWMSLayer_attribute_bgcolor_D}
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
		
		/**
		 * @copy TiledWMSLayer#enableGetCapabilities 
		 * @default true
		 * @return 
		 * 
		 */		
		public function get enableGetCapabilities():Boolean 
		{
			return this._enableGetCapabilities;
		}
		public function set enableGetCapabilities(value:Boolean):void 
		{
			this._enableGetCapabilities = value;
		}
		
		
		/**
		 * ${mapping_DynamicWMSLayer_attribute_exceptions_D} 
		 * @return 
		 * 
		 */		
		public function get exception():String 
		{
			return this._wmsParams.exceptions;
		}
		public function set exception(value:String):void 
		{
			_wmsParams.exceptions = value;
		}
		
		[Bindable]
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override public function get url():String
		{
			return this._url;
		}	
		override public function set url(value:String):void
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
		[Inspectable(category = "iClient")] 
		/**
		 * @copy TiledWMSLayer#version 
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
		
		/**
		 * @private 
		 * 
		 */		
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
		
//		/**
//		 * @copy TiledWMSLayer#creationCompleteHandler() 
//		 * @param event
//		 * 
//		 */		
//		protected function creationCompleteHandler(event:FlexEvent) : void
//		{
//			removeEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
//			this.setLayerLoaded();
//		}
			
		/**
		 * @copy DynamicLayer#loadMapImage() 
		 * @param loader
		 * 
		 */		
		override protected function loadMapImage(loader:Loader) : void
		{
			if(this.version == "1.3.0")
			{
				this._wmsParams.bbox = WMSParams.rectToYXBBox(this.map.viewBounds);
			}
			else
			{
				this._wmsParams.bbox = this.map.viewBounds.bbox;
			}
			this._wmsParams.width = this.map.width;
			this._wmsParams.height = this.map.height;
			this._wmsParams.transparent = this.transparent;
			var url:String = this.url + "?" + this._wmsParams.toGETString();
			if(Credential.CREDENTIAL)
			{
				url += "&" + Credential.CREDENTIAL.getUrlParameters();
			}
			this._urlRequest.url = url;
			loader.load(this._urlRequest);
		}
		
		private function getCapabilities() : void
		{
			var str:String = this.url + "?" + "SERVICE=WMS" + "&"
				+ "REQUEST=" + "GetCapabilities" + "&"
				+ "VERSION=" + this._wmsParams.version;
			if(Credential.CREDENTIAL)
			{
				str += "&" + Credential.CREDENTIAL.getUrlParameters();
			}
			var urlRequest:URLRequest = new URLRequest(str);
						
			this._loader.dataFormat = URLLoaderDataFormat.TEXT;
			this._loader.addEventListener(Event.COMPLETE, this.getCapabilitiesHandler, false, 0, true);
			this._loader.addEventListener(IOErrorEvent.IO_ERROR, getCapabilities_ioErrorHandler, false, 0, true);
			this._loader.load(urlRequest);
		}
		
		private function getCapabilitiesHandler(event:Event) : void
		{
			this._loader .removeEventListener(Event.COMPLETE, this.getCapabilitiesHandler);
			try 
			{
				var wmsInfo:XML = new XML(event.target.data);
				this._wmsParams.fromXML(wmsInfo);			
			} 
			catch ( e:TypeError ) 
			{
				throw new SmError(SmResource.TO_XML_ERROR);//0920byzyn
//				trace( "Could not parse text into XML" );
//				trace( e.message );
			}
			this._getCapabilitiesDone = true;
			this.setLayerLoaded();			
		}
		
		private function getCapabilities_ioErrorHandler(event:IOErrorEvent) : void
		{
			var fault:Fault = new Fault(null, event.text);
			fault.rootCause = event;
			dispatchEvent(new LayerEvent(LayerEvent.UPDATE_END, this, fault, false));
			
			if (fault && fault.rootCause)
			{
				var se:SecurityErrorEvent = fault.rootCause as SecurityErrorEvent;
				if (se)
				{
					throw new SecurityError(se.text);
				}
				else
				{
					
					throw new Error(String(fault));
				}
			}
		}
		
		private function setLayerLoaded() : void
		{
			//if(this._wmsParams.bbox == null || this._wmsParams.crs == null || (this._enableGetCapabilities && !this._getCapabilitiesDone))
			if(this._enableGetCapabilities && !this._getCapabilitiesDone)
			{
				this.getCapabilities();		
				return;
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
					
			if(this.CRS == null || this.CRS.wkid == 0)
			{
				this.CRS =this._wmsParams.srsToCRS();
			}
			else
			{
				this._wmsParams.crs = "EPSG:" + this.CRS.wkid;
			}
			setLoaded(true);
			invalidateLayer();
			this._getCapabilitiesDone = false;		
		}
		
		private function layers_collectionChangeHandler(event:CollectionEvent) : void
		{
			this._wmsParams.layers = this._layers.source.join(",");
			if(!this._wmsParams.layers || this._wmsParams.layers == "")
			{
				this.removeAllChildren();
			}
			invalidateLayer();
		}
		
		/**
		 * 通过手动修改WmsParas来获取对应的字串值
		 * */
		sm_internal function getWmsParasString(bbox:Rectangle2D, mapWidth:Number, mapHeight:Number):String
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
			wmsParams.width = mapWidth;
			wmsParams.height = mapHeight;
			wmsParams.transparent = this.transparent;
			var result:String =  wmsParams.toGETString();
			wmsParams = null;
			return result;
		}
	}
}