package com.supermap.web.mapping.supportClasses
{
    import com.supermap.web.core.*;
    import com.supermap.web.events.MapEvent;
    import com.supermap.web.mapping.*;
    import com.supermap.web.sm_internal;
    
    import flash.geom.*;
    
    import mx.core.*;
    import mx.events.*;
	
	use namespace sm_internal;
	
	/**
	 * @private
	 * ${mapping_LayerContainer_Title}.
	 * ${mapping_LayerContainer_Description} 
	 * 
	 * 
	 */	
	public class LayerContainer extends UIComponent
	{
		private var _map:Map;
			
		public function LayerContainer(map:Map)
		{
			this._map = map;
			this._map.addEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete, false, 1);
		}
		
		private function onCreationComplete(event:FlexEvent) : void
		{
			this._map.removeEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
			this._map.addEventListener(ResizeEvent.RESIZE, this.onMapResize);
			scrollRect = new Rectangle(0, 0, this._map.width, this._map.height);
			width = scrollRect.width;
			height = scrollRect.height;
		}
		
		private function onMapResize(event:ResizeEvent) : void
		{
			var rect:Rectangle = scrollRect;
			rect.width = this._map.width;
			rect.height = this._map.height;
			scrollRect = rect;
			width = rect.width;
			height = rect.height;
		}
		
		sm_internal function updateScrollRect(x:Number, y:Number) : void
		{
			var rect:Rectangle = scrollRect;
			rect.x = x;
			rect.y = y;
			scrollRect = rect;
			invalidateDisplayList();
		}
		
		sm_internal function updateScrollRectDelta(dx:Number, dy:Number) : void
		{
			var rect:Rectangle = scrollRect;
			rect.x = rect.x + dx;
			rect.y = rect.y + dy;
			scrollRect = rect;
			invalidateDisplayList();
		}
		
		sm_internal function get dpi():Number
		{
			var layer:Layer = null;		
			for(var i:int = 0; i < numChildren; i++)
			{
				layer = getChildAt(i) as Layer;
				if (layer.isScaleCentric)
				{
					var dpi:Number = layer.getDpi();
					if(dpi)
					{
						if(layer.isIServer2Layer)
							this.map.isIServer2DPI = true;
						else
							this.map.dpiCRS = layer.CRS;
						return dpi;
					}
				}
			}
			return 0;
		}
		
		sm_internal function get layerIds() : Array
		{
			var layer:Layer = null;
			var layerIds:Array = [];

			for(var i:int = 0; i < numChildren; i++)
			{
				layer = getChildAt(i) as Layer;
				layerIds[i] = layer.id;
			}
			return layerIds;
		}
		
		sm_internal function get layers() : Array
		{
			var layers:Array = [];

			for(var i:int = 0; i < numChildren; i++)
			{
				layers[i] = getChildAt(i) as Layer;
			}
			return layers;
		}
		
		sm_internal function setMapOnLoadedLayers() : void
		{
			var layer:Layer = null;
		
			for(var i:int = 0; i < numChildren; i++)
			{
				layer = getChildAt(i) as Layer;
				if (layer.loaded)
				{
					layer.setMap(this._map);
				}
			}
		}
		
		sm_internal function get map() : Map
		{
			return this._map;
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number) : void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			if (scrollRect)
			{
				graphics.clear();
				graphics.beginFill(16711680, 0);
				graphics.drawRect(scrollRect.x, scrollRect.y, scrollRect.width, scrollRect.height);
				graphics.endFill();
			}
		}
		
		sm_internal function removeLayer(layer:Layer) : void
		{
			if (contains(layer))
			{
				removeChild(layer);
				this._map.dispatchEvent(new MapEvent(MapEvent.LAYER_REMOVE, this._map, layer));
			}
		}
		
		sm_internal function removeAllLayers() : void
		{
			var layer:Layer = null;
			while (numChildren > 0)
			{			
				layer = removeChildAt(0) as Layer;
				this._map.dispatchEvent(new MapEvent(MapEvent.LAYER_REMOVE, this._map, layer));
			}
		}
		
	}
}