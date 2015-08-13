package com.supermap.web.mapping
{
	import com.supermap.web.core.*;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.events.ViewBoundsEvent;
	import com.supermap.web.events.ZoomEvent;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.utils.MathUtil;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	
	import mx.core.*;
	import mx.events.*;
	import mx.graphics.*;
	
	use namespace sm_internal;
	
	/**
	 * ${mapping_Layer_Event_isInResolutionRange_D}
	 * @eventType com.supermap.web.events.LayerEvent.IS_IN_RESOLUTION_RANGE_CHANGE
	 */	
	[Event(name="isInResolutionRangeChange", type="com.supermap.web.events.LayerEvent")]
	/**
	 * ${mapping_Layer_Event_load_D} 
	 * @eventType com.supermap.web.events.LayerEvent.LOAD
	 */	
	[Event(name="load", type="com.supermap.web.events.LayerEvent")]
	/**
	 * ${mapping_Layer_Event_loadError_D}
	 * @eventType com.supermap.web.events.LayerEvent.LOAD_ERROR 
	 */	
	[Event(name="loadError", type="com.supermap.web.events.LayerEvent")]
	/**
	 * ${mapping_Layer_Event_updateEnd_D}
	 * @eventType com.supermap.web.events.LayerEvent.UPDATE_END 
	 */	
	[Event(name="updateEnd", type="com.supermap.web.events.LayerEvent")]
	/**
	 * ${mapping_Layer_Event_updateStart_D}
	 * @eventType com.supermap.web.events.LayerEvent.UPDATE_START 
	 */	
	[Event(name="updateStart", type="com.supermap.web.events.LayerEvent")]
	
	/**
	 * ${mapping_Layer_Event_minVisibleResolutionChange_D} 
	 * @see #maxVisibleResolution
	 */	
	[Event(name="minVisibleResolutionChange", type="flash.events.Event")]
	/**
	 * ${mapping_Layer_Event_maxVisibleResolutionChange_D} 
	 * @see maxVisibleResolution
	 */	
	[Event(name="maxVisibleResolutionChange", type="flash.events.Event")]
	/**
	 * ${mapping_Layer_Event_visibleChange_D}
	 * @see #visible 
	 */	
	[Event(name="visibleChange", type="flash.events.Event")]
	
	/**
	 * ${mapping_Layer_Title}.
	 * <p>${mapping_Layer_Description}</p> 
	 * 
	 * 
	 */	
	public class Layer extends UIComponent
	{
		private var _lastIsInResolutionRange:Boolean = true;	
		//全局变量
//		sm_internal var _flag:Boolean;
		// 层本身属性
		private var _url:String;
		private var _metadata:Object;
		
		//Geo属性
		private var _bounds:Rectangle2D = null;
		
		private var _resolution:Number;
		private var _maxVisibleResolution:Number = 0;
		private var _minVisibleResolution:Number = 0;	
		private var _CRS:CoordinateReferenceSystem = null;
		private var _dpi:Number = 0.0;	
		
		
		// 层标志
		private var _isRefresh:Boolean;
		private var _loaded:Boolean;
		private var _visible:Boolean = true;
		
		// 私有属性
		private var _map:Map;
		private var _bitmapSize:Rectangle;
		private var _drawBitmap:Boolean;
		private var _bitmapData:BitmapData;
		private var _zoomFactor:Number;
		
		sm_internal var isIServer2Layer:Boolean = false;
		
		private const MINVISIBLERESOLUTION_CHANGE:String = "minVisibleResolutionChange";
		private const MAXVISIBLERESOLUTION_CHANGE:String = "maxVisibleResolutionChange";
		private const VISIBLE_CHANGE:String = "visibleChange";
		
		
		/**
		 * ${mapping_Layer_constructor_None_D} 
		 * 
		 */		
		public function Layer()
		{		
			this._bounds = new Rectangle2D();
//			this._CRS = new CoordinateReferenceSystem();
			addEventListener(Event.ADDED, this.addedHandler);
			addEventListener(Event.REMOVED, this.removedHandler);
			addEventListener(FlexEvent.SHOW, this.showHandler);
			addEventListener(FlexEvent.HIDE, this.hideHandler);	
		}

		/**
		 * ${mapping_Layer_attribute_dpi_D}.
		 * <p>${mapping_Layer_attribute_dpi_remarks}</p> 
		 * @see com.supermap.web.utils.ScaleUtil.getDpi()
		 * @return 
		 * 
		 */		
		protected function get dpi():Number
		{
			return _dpi;
		}

		protected function set dpi(value:Number):void
		{
			_dpi = value;
			
		}
		sm_internal function getDpi():Number
		{
			return this.dpi;
		}

		/**
		 * ${mapping_Layer_attribute_resolution_D} 
		 * @return 
		 * 
		 */		
		public function get resolution():Number
		{
			return this._map.resolution;
		}

		sm_internal function setResolution(value:Number):void
		{
			_resolution = value;
		}

		[Inspectable(category = "iClient")] 
		[Bindable]
		/**
		 * ${mapping_Layer_attribute_url_D} 
		 * @return 
		 * 
		 */		
		public function get url():String
		{
			return this._url;
		}
	    	
		public function set url(value:String):void
		{   
			this._url = value;
		}
 
		 //图层信息描述
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Layer_attribute_metadata_D} 
		 * @return 
		 * 
		 */		
		public function get metadata():Object
		{	
			return this._metadata;
		}
		
		public function set metadata(value:Object) : void
		{
			if (this._metadata is IEventDispatcher)
			{
				IEventDispatcher(this._metadata).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.metadata_changeHandler);
			}
			this._metadata = value;
			if (this._metadata is IEventDispatcher)
			{
				IEventDispatcher(this._metadata).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.metadata_changeHandler, false, 0, true);
			}
			this.dispatchChangeEvent();
			this.invalidateLayer();
			
		}
		
//		override public function set x(value:Number) : void
//		{
//		}
//		
//		override public function set y(value:Number) : void
//		{
//		}
		
		
		/**
		 * ${mapping_Layer_attribute_map_D} 
		 * @return 
		 * 
		 */		
		sm_internal function get map() : Map
		{
			return this._map;
		}
		
		///**
		// * 供map使用，该layer为map的第一个layer且map的viewBounds为null，
		// * 则使用该值为map的viewBounds值
		// * 
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Layer_attribute_bounds_D}.
		 * <p>${mapping_Layer_attribute_bounds_Remarks_D}</p>
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}
		
		public function set bounds(value:Rectangle2D):void
		{
			var old_value:Rectangle2D = this._bounds;
			if (!old_value.equals(value))
			{
				this._bounds = value;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bounds", old_value, value));
				}
			}
		}
		
		//当前map的Resolution是否在maxResolution和minResolution之间
		/**
		 * ${mapping_Layer_attribute_IsInResolutionRange_D} 
		 * 
		 */		
		public function get isInResolutionRange() : Boolean
		{ 
			var bInResolutionRange:Boolean = true;
			if (this.map)
			{	
				bInResolutionRange = MathUtil.isInResolutionRange(this.map.resolution, this._minVisibleResolution, this._maxVisibleResolution);
			}	
			return bInResolutionRange;
		}
		
		/**
		 * ${mapping_Layer_attribute_isScaleCentric_D} 
		 * @return 
		 * 
		 */		
		public function get isScaleCentric() : Boolean
		{
			return false;
		}
        
		/**
		 * ${mapping_Layer_attribute_loaded_D} 
		 * @return 
		 * 
		 */		
		public function get loaded() : Boolean
		{
			return this._loaded;
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Layer_attribute_maxVisibleResolution_D} 
		 * @return 
		 * 
		 */		
		public function get maxVisibleResolution() : Number
		{
			return this._maxVisibleResolution;
		}
		
		public function set maxVisibleResolution(value:Number) : void
		{
			if (this._maxVisibleResolution != value)
			{
				this._maxVisibleResolution = value;
				dispatchEvent(new Event(MAXVISIBLERESOLUTION_CHANGE));
			}
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Layer_attribute_minVisibleResolution_D} 
		 * @return 
		 * 
		 */		
		public function get minVisibleResolution() : Number
		{
			return this._minVisibleResolution;
		}
		
		public function set minVisibleResolution(value:Number) : void
		{
			if (this._minVisibleResolution != value)
			{
				this._minVisibleResolution = value;
				dispatchEvent(new Event(MINVISIBLERESOLUTION_CHANGE));
			}
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Layer_attribute_CRS_D}.
		 * <p>${mapping_Layer_attribute_CRS_remarks_D}</p> 
		 * @return 
		 * 
		 */		
		public function get CRS() : CoordinateReferenceSystem
		{
			return this._CRS;
		}
		public function set CRS(value:CoordinateReferenceSystem):void
		{
			var old_value:CoordinateReferenceSystem = this.CRS;
			if(old_value)
			{
				if (!old_value.equals(value))
				{
					this._CRS = value;
					if (this.hasEventListener("propertyChange"))
					{
						this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "CRS", old_value, value));
					}
				}
			}
			else
			{
				this._CRS = value;
			}
//			_flag =true;
		}
		
		
		private function dispatchChangeEvent() : void
		{
			dispatchEvent(new Event(Event.CHANGE));			
		}
		
		sm_internal function setMap(map:Map) : void
		{
			this.removeMapListeners();
			//如果Map已经有了底图，且待加入的图层的CRS不为null，且wkid大于0，且不等于 map.CRS，则删除该图层
			if(map.baseLayer != this)
			{
				if(map.CRS.wkid > 0)
				{
					if(this._CRS != null && this._CRS.wkid > 0 && !this._CRS.equals(map.CRS))
					{
						map.removeLayer(this);
						return;
					}			
				}
				else if(this._CRS != null)
				{
					map.setCRS(this._CRS);
				}
			}
			
//			var tempMap:Map = this._map;
//			this._map = map;
//			
//			if (this.visible)
//			{
//				if(tempMap && tempMap != map)
//					this.invalidateLayer();
//				this.addMapListeners();
//				
//			}
			
			// layer 被加载到map后，当调用此方法后，会调用相关的更新方法，即表示初始化完成  同时  imagelayer resultInfo 里面不用invalidateLayer
			 //yld 2011-6-8
			this._map = map;
			this.dispatchEvent(new LayerEvent(LayerEvent.LOADED, this));
			if (this.visible)
			{
				this.invalidateLayer();
				this.addMapListeners();
				
			}
			
			
		}
		
		/**
		 * ${mapping_Layer_method_refresh_D} 
		 * 
		 */		
		public function refresh():void
		{
			this.invalidateLayer();
		}
		
		
		/**
		 * ${mapping_Layer_attribute_visible_D}
		 * @return 
		 * 
		 */		
		override public function get visible() : Boolean
		{
			return this._visible;
		}
		
		override public function set visible(value:Boolean) : void
		{
			if (this._visible != value)
			{
				this._visible = value;
				if (super.visible != value)
				{
					super.visible = value;
				}
				else
				{
					dispatchEvent(new FlexEvent(value ? (FlexEvent.SHOW) : (FlexEvent.HIDE)));
				}
				dispatchEvent(new Event(VISIBLE_CHANGE));
			}
		}
		
		
		private function metadata_changeHandler(event:Event) : void
		{
			this.invalidateLayer();			
		}
		
		/**
		 * @private 
		 * @param unscaledWidth
		 * @param unscaledHeight
		 * 
		 */		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number) : void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			this.updateLayerIfInvalid();
			if (this._drawBitmap)
			{
				this.drawBitmap();
			}
		}
		
//		override protected function commitProperties() : void
//		{
//			super.commitProperties();
//			if (!this._maxScaleChanged)
//			{
//			}
//			if (this._minScaleChanged)
//			{
//				this._maxScaleChanged = false;
//				this._minScaleChanged = false;
//				this.checkIsInScaleRange();
//			}
//		}
		
		private function updateLayerIfInvalid() : void
		{
			var new_lastIsInResolutionRange:Boolean = false;
			var isInResolutionRangeChangeEvent:LayerEvent = null;
			if (this._isRefresh)
			{
				this._isRefresh = false;
				new_lastIsInResolutionRange = this.isInResolutionRange;
				if (this._lastIsInResolutionRange != new_lastIsInResolutionRange)
				{
					this._lastIsInResolutionRange = new_lastIsInResolutionRange;
					isInResolutionRangeChangeEvent = new LayerEvent(LayerEvent.IS_IN_RESOLUTION_RANGE_CHANGE, this, null, false, new_lastIsInResolutionRange);
					dispatchEvent(isInResolutionRangeChangeEvent);
				}
				if (!new_lastIsInResolutionRange)
				{
					if (super.visible)
					{
						super.setVisible(false, true);
					}
				}
				else
				{
					if ((this.visible) && (!super.visible))
					{
						super.setVisible(true, true);
					}
				}
				if ((super.visible) && (this.loaded) && (this.map) && (this.map.visible) && 
					 (this.map.width > 0) && (this.map.height > 0))
				{
					dispatchEvent(new LayerEvent(LayerEvent.UPDATE_START, this));
					this.draw();
				}
			}
		}
		
		/**
		 * ${mapping_Layer_method_draw_D} 
		 * 
		 */		
		protected function draw() : void
		{
		}
		
		private function drawBitmap() : void
		{
			var matrix:Matrix = null;
			graphics.clear();
			if (this._bitmapData)
			{
				matrix = new Matrix();
				matrix.scale(this._zoomFactor, this._zoomFactor);
				matrix.translate(this._bitmapSize.x, this._bitmapSize.y);
				graphics.beginBitmapFill(this._bitmapData, matrix, false, false);
				graphics.drawRect(this._bitmapSize.x, this._bitmapSize.y, this._bitmapSize.width, this._bitmapSize.height);
				graphics.endFill();
			}
		}
		
		private function updateBitmapSize(event:ZoomEvent) : void
		{
			if (this._bitmapSize)
			{
				this._zoomFactor = event.zoomFactor;
				this._bitmapSize.width = event.width;
				this._bitmapSize.height = event.height;
				this._bitmapSize.x = parent.scrollRect.x + event.x;
				this._bitmapSize.y = parent.scrollRect.y + event.y;
			}
		}
		

		/**
		 * ${mapping_Layer_method_setLoaded_D} 
		 * @param value
		 * @see com.supermap.web.events.LayerEvent
		 * 
		 */		
		protected function setLoaded(value:Boolean) : void
		{
			if (this._loaded != value)
			{
				this._loaded = value;
				if (this._loaded)
				{
					dispatchEvent(new LayerEvent(LayerEvent.LOAD, this));
				}
			}
			
		}
		
		/**
		 * ${mapping_Layer_method_removeAllChildren_D} 
		 * 
		 */		
		protected function removeAllChildren() : void
		{
			while (numChildren > 0)
			{			
				removeChildAt(0);			
			}
		}
			
		/**
		 * ${mapping_Layer_method_invalidateLayer_D} 
		 * 
		 */		
		protected function invalidateLayer():void
		{
			this._isRefresh = true;
			invalidateDisplayList();
		}
		
		
		
		/**
		 * ${mapping_Layer_method_addMapListeners_D} 
		 * 
		 */		
		protected function addMapListeners() : void
		{
			if (this.map)
			{
				this.map.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.viewBoundsChangedHandler);
				this.map.addEventListener(ZoomEvent.ZOOM_START, this.zoomStartHandler);
				this.map.addEventListener(ZoomEvent.ZOOM_UPDATE, this.zoomUpdateHandler);
				this.map.addEventListener(ZoomEvent.ZOOM_END, this.zoomEndHandler);
			}
		}
		
		/**
		 * ${mapping_Layer_method_removeMapListeners_D} 
		 * 
		 */		
		protected function removeMapListeners() : void
		{
			if (this.map)
			{
				this.map.removeEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.viewBoundsChangedHandler);
				this.map.removeEventListener(ZoomEvent.ZOOM_START, this.zoomStartHandler);
				this.map.removeEventListener(ZoomEvent.ZOOM_UPDATE, this.zoomUpdateHandler);
				this.map.removeEventListener(ZoomEvent.ZOOM_END, this.zoomEndHandler);
			}
		}
		
		/**
		 * ${mapping_Layer_method_addedHandler_D} 
		 * @param event ${mapping_Layer_method_param_event}
		 * 
		 */		
		protected function addedHandler(event:Event) : void
		{
			if (event.target === this)
			{
				if (this._drawBitmap)
				{
					graphics.clear();
					this._drawBitmap = false;
					this._bitmapSize = null;
					this._bitmapData = null;
				}
				this.addMapListeners();
			}
		}
		
		/**
		 * ${mapping_Layer_method_removedHandler_D} 
		 * @param event ${mapping_Layer_method_param_event}
		 * 
		 */		
		protected function removedHandler(event:Event) : void
		{
			if (event.target === this)
			{
				this.removeMapListeners();
			}
		}
		
		/**
		 * ${mapping_Layer_method_showHandler_D} 
		 * @param event ${mapping_Layer_method_param_event}
		 * 
		 */		
		protected function showHandler(event:FlexEvent) : void
		{
			if (this._drawBitmap)			
			{
				this.graphics.clear();
				this._drawBitmap = false;
				this._bitmapSize = null;
				this._bitmapData = null;
			}
			this.addMapListeners();
			this.invalidateLayer();
		}
		
		/**
		 * ${mapping_Layer_method_hideHandler_D} 
		 * @param event ${mapping_Layer_method_param_event}
		 * 
		 */		
		protected function hideHandler(event:FlexEvent) : void
		{
			this.removeMapListeners();
		}
		
		/**
		 * ${mapping_Layer_method_viewBoundsChangedHandler_D} 
		 * @param event ${mapping_Layer_method_param_viewBoundsEvent}
		 * @see ViewBoundsEvent ViewBoundsEvent Class
		 */		
		protected function viewBoundsChangedHandler(event:ViewBoundsEvent) : void
		{
			this.invalidateLayer();
			
		}
		
		/**
		 * ${mapping_Layer_method_zoomStartHandler_D} 
		 * @param event ${mapping_Layer_method_param_zoomEvent}
		 * @see ZoomEvent ZoomEvent Class
		 * 
		 */		
		protected function zoomStartHandler(event:ZoomEvent) : void
		{
			if (this.map && parent)
			{
				width = this.map.width;
				height = this.map.height;
				var matrix:Matrix = new Matrix();
				matrix.translate(-parent.scrollRect.x, -parent.scrollRect.y);
				try
				{
					this._bitmapData = ImageSnapshot.captureBitmapData(this, matrix);
				}
				catch (error:SecurityError)
				{
					_bitmapData = null;
					throw error;
				}
				catch (error:Error)
				{
					_bitmapData = null;
				}
				this._zoomFactor = event.zoomFactor;
				this._bitmapSize = new Rectangle(parent.scrollRect.x, parent.scrollRect.y, width, height);
				this._drawBitmap = true;
				invalidateDisplayList();
			}
		}
		
		/**
		 * ${mapping_Layer_method_zoomUpdateHandler_D} 
		 * @param event ${mapping_Layer_method_param_zoomEvent}
		 * @see ZoomEvent ZoomEvent Class
		 * 
		 */		
		protected function zoomUpdateHandler(event:ZoomEvent) : void
		{
			this.updateBitmapSize(event);
			invalidateDisplayList();
		}
		
		/**
		 * ${mapping_Layer_method_zoomEndHandler_D} 
		 * @param event ${mapping_Layer_method_param_zoomEvent}
		 * @see ZoomEvent ZoomEvent Class
		 * 
		 */		
		protected function zoomEndHandler(event:ZoomEvent) : void
		{
			this.updateBitmapSize(event);
			this.drawBitmap();
	 		this.clearBitMapData();
		}
		
		sm_internal function clearBitMapData():void
		{
			this._drawBitmap = false;
			this._bitmapSize = null;
			this._bitmapData = null;
		}
	}
}