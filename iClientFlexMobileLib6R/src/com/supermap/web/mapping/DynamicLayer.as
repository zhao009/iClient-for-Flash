package com.supermap.web.mapping
{
	import com.supermap.web.core.*;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.events.ZoomEvent;
	import com.supermap.web.sm_internal;
	
	import flash.display.*;
	import flash.events.*;
	
	import mx.events.*;
	import mx.logging.*;
	import mx.rpc.*;
	
	use namespace sm_internal;

	/**
	 * ${mapping_DynamicLayer_Title}.
	 * <p>${mapping_DynamicLayer_Description}</p>
	 * 
	 * 
	 */	
	public class DynamicLayer extends ImageLayer
	{
		private var _imageBounds:Rectangle2D;
		private var _image:ImageLoader;    //显示图片	
		
		private var _log:ILogger;
		private var _imageLoader:ImageLoader;   //请求图片		
		private var _hiddenViewBounds:Rectangle2D;
		private var _useDefaultZoomHandlers:Boolean = true;
		
		/**
		 * ${mapping_DynamicLayer_constructor_None_D}
		 * 
		 */		
		public function DynamicLayer()
		{
			super();
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function draw() : void
		{
			if (this._imageLoader)
			{
				this.cancelLoadingImage();
			}

			this._imageLoader = new ImageLoader();
			this._imageLoader.addEventListener(Event.COMPLETE, this.imageLoader_completeHandler, false, 0, true);
			this._imageLoader.addEventListener(IOErrorEvent.IO_ERROR, this.imageLoader_ioErrorHandler, false, 0, true);
			this.loadMapImage(this._imageLoader);
			
		}
		
		/**
		 * @inheritDoc  
		 * @param event
		 * 
		 */		
		override protected function removedHandler(event:Event) : void
		{
			if (event.target === this)
			{
				this.removeMapListeners();
				this.removeAllChildren();
				if(this._imageLoader)
				{
					this.cancelLoadingImage();
				}
			}
		}
		
		/**
		 * @inheritDoc  
		 * @param event
		 * 
		 */		
		override protected function showHandler(event:FlexEvent) : void
		{
			super.showHandler(event);
			if (map && this._hiddenViewBounds && !map.viewBounds.equals(this._hiddenViewBounds))
			{
				removeAllChildren();
			}
		}
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */		
		override protected function hideHandler(event:FlexEvent) : void
		{
			super.hideHandler(event);
			if (map && map.viewBounds)
			{
				this._hiddenViewBounds = map.viewBounds.clone();
			}
			else
			{
				this._hiddenViewBounds = null;
			}
		}
		
		/**
		 * @inheritDoc  
		 * @param event
		 * 
		 */		
		override protected function zoomStartHandler(event:ZoomEvent) : void
		{
			if (this._useDefaultZoomHandlers)
			{
				try
				{
					super.zoomStartHandler(event);
					removeAllChildren();
				}
				catch (error:SecurityError)
				{
					_useDefaultZoomHandlers = false;
				}
			}
		}
		
		/**
		 * @inheritDoc  
		 * @param event
		 * 
		 */		
		override protected function zoomUpdateHandler(event:ZoomEvent) : void
		{
			if (this._useDefaultZoomHandlers)
			{
				super.zoomUpdateHandler(event);
			}
			else if (this._image && this._imageBounds && !this._imageBounds.isEmpty() && parent && map)
			{
				var left:Number = map.mapToScreenX(this._imageBounds.left) + parent.scrollRect.x;
				var right:Number = map.mapToScreenX(this._imageBounds.right) + parent.scrollRect.x;
				var bottom:Number = map.mapToScreenY(this._imageBounds.bottom) + parent.scrollRect.y;
				var top:Number = map.mapToScreenY(this._imageBounds.top) + parent.scrollRect.y;
				this._image.x = left;
				this._image.y = top;
				this._image.width = right - left;
				this._image.height = bottom - top;
			}

		}
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */		
		override protected function zoomEndHandler(event:ZoomEvent) : void
		{
			super.zoomEndHandler(event);
			this._useDefaultZoomHandlers = true;
		}
		
		/**
		 * ${mapping_DynamicLayer_method_protected_loadMapImage_D} 
		 * @param loader ${mapping_DynamicLayer_method_protected_loadMapImage_param_loader}
		 * 
		 */		
		protected function loadMapImage(loader:Loader) : void
		{
			return;
		}
		
		/**
		 * ${mapping_TiledWMSLayer_method_protected_calcImageBounds_D} 
		 * @return 
		 * 
		 */		
		protected function calcImageBounds() : Rectangle2D
		{
			var imgBounds:Rectangle2D = null;
			if (this.map && map.viewBounds && this._image)
			{
				if (this._image.x == 0 && this._image.y == 0 )
				{
					imgBounds = map.viewBounds.clone();
				}
				else
				{
					var left:Number = map.screenToMapX(this._image.x);
					var bottom:Number = map.screenToMapY(this._image.y + this._image.height);
					var right:Number = map.screenToMapX(this._image.x + this._image.width);
					var top:Number = map.screenToMapY(this._image.y);
					imgBounds = new Rectangle2D(left, bottom, right, top);
				}
			}
			return imgBounds;
		}
		
		private function cancelLoadingImage() : void
		{
			this._imageLoader.removeEventListener(Event.COMPLETE, this.imageLoader_completeHandler);
			this._imageLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.imageLoader_ioErrorHandler);
			this._imageLoader.cancel = true;
			this._imageLoader = null;
		}
		
		private function imageLoader_completeHandler(event:Event) : void
		{
			var img:ImageLoader = event.target as ImageLoader;
			if(map && map.isTweening)
			{
				img.cancel = true;
			}
			else
			{
				removeAllChildren();
				graphics.clear();
				this._image = img;
				this._imageBounds = calcImageBounds();
				this._image.x = this._image.x + parent.scrollRect.x;
				this._image.y = this._image.y + parent.scrollRect.y;
				this.addChild(this._image);
			}
			this._imageLoader = null;
			dispatchEvent(new LayerEvent(LayerEvent.UPDATE_END, this, null, true));
		}
		
		private function imageLoader_ioErrorHandler(event:IOErrorEvent) : void
		{
			removeAllChildren();
			graphics.clear();
			this._imageLoader = null;
			if (Log.isError())
			{
				this._log.error("{0}::{1}", id, event.text);
			}
			var fault:Fault = new Fault(null, event.text);
			fault.rootCause = event;
			dispatchEvent(new LayerEvent(LayerEvent.UPDATE_END, this, fault, false));
		}
	}
}