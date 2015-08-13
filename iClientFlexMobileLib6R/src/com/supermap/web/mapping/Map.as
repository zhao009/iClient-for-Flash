package com.supermap.web.mapping
{
	//	import com.supermap.web.actions.*;
	import com.supermap.web.actions.MapAction;
	import com.supermap.web.actions.Pan;
	import com.supermap.web.actions.TouchAction;
	import com.supermap.web.components.*;
	import com.supermap.web.core.*;
	import com.supermap.web.events.*;
	import com.supermap.web.mapping.supportClasses.LayerContainer;
	import com.supermap.web.mapping.supportClasses.ResizeHandler;
	import com.supermap.web.mapping.supportClasses.ScreenContainer;
	import com.supermap.web.mapping.supportClasses.ZoomEffect;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	import com.supermap.web.themes.RawTheme;
	import com.supermap.web.themes.Theme;
	import com.supermap.web.utils.*;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.*;
	import flash.geom.*;
	import flash.net.*;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.ui.*;
	import flash.utils.*;
	
	import mx.collections.*;
	import mx.controls.Alert;
	import mx.core.*;
	import mx.effects.Parallel;
	import mx.events.*;
	import mx.logging.*;
	import mx.utils.*;
	
	import spark.effects.*;
	
	use namespace sm_internal;	
	
	//在这里声明事件，可以在标签中直接注册事件的回调函数
	//例如 <iClient:Map load="onLoad(event)">
	/**
	 * ${mapping_Map_Event_CRS_Change_D} 
	 */	
	[Event(name="CRSChange", type="flash.events.event")]
	/**
	 * ${mapping_Map_Event_load_D} 
	 * @eventType com.supermap.web.events.MapEvent.LOAD
	 */	
	[Event(name="load", type="com.supermap.web.events.MapEvent")]
	/**
	 * ${mapping_Map_Event_layerAdd_D} 
	 * @eventType com.supermap.web.events.MapEvent.LAYER_ADD
	 */	
	[Event(name="layerAdd", type="com.supermap.web.events.MapEvent")]
	/**
	 * ${mapping_Map_Event_layerRemove_D}
	 * @eventType com.supermap.web.events.MapEvent.LAYER_REMOVE 
	 */	
	[Event(name="layerRemove", type="com.supermap.web.events.MapEvent")]
	/**
	 * ${mapping_Map_Event_layerRemoveAll_D}
	 * @eventType com.supermap.web.events.MapEvent.LAYER_REMOVE_ALL 
	 */	
	[Event(name="layerRemoveAll", type="com.supermap.web.events.MapEvent")]
	/**
	 * ${mapping_Map_Event_layerReorder_D}
	 * @eventType com.supermap.web.events.MapEvent.LAYER_REORDER  
	 */	
	[Event(name="layerMove", type="com.supermap.web.events.MapEvent")]
	
	/**
	 * ${mapping_Map_Event_mapClick_D}
	 * @eventType com.supermap.web.events.MapMouseEvent.MAP_CLICK 
	 */	
	[Event(name="mapClick", type="com.supermap.web.events.MapMouseEvent")]
	
	/**
	 * 
	 * 
	 * ${mapping_Map_Event_panStart_D}
	 * @eventType com.supermap.web.events.PanEvent.PAN_START
	 */	
	[Event(name="panStart", type="com.supermap.web.events.PanEvent")]
	/**
	 * ${mapping_Map_Event_panUpdate_D}
	 * @eventType com.supermap.web.events.PanEvent.PAN_UPDATE 
	 */	
	[Event(name="panUpdate", type="com.supermap.web.events.PanEvent")]
	/**
	 * ${mapping_Map_Event_panEnd_D}
	 * @eventType com.supermap.web.events.PanEvent.PAN_END  
	 */	
	[Event(name="panEnd", type="com.supermap.web.events.PanEvent")]
	
	/**
	 * ${mapping_Map_Event_resolutionsChange_D} 
	 */	
	[Event(name="resolutionsChange", type="flash.events.Event")]
	
	/**
	 * ${mapping_Map_Event_zoomStart_D}
	 * @eventType com.supermap.web.events.ZoomEvent.ZOOM_START  
	 */	
	[Event(name="zoomStart", type="com.supermap.web.events.ZoomEvent")]
	/**
	 * ${mapping_Map_Event_zoomUpdate_D}
	 * @eventType com.supermap.web.events.ZoomEvent.ZOOM_UPDATE  
	 */	
	[Event(name="zoomUpdate", type="com.supermap.web.events.ZoomEvent")]
	/**
	 * ${mapping_Map_Event_zoomEnd_D}
	 * @eventType com.supermap.web.events.ZoomEvent.ZOOM_END  
	 */	
	[Event(name="zoomEnd", type="com.supermap.web.events.ZoomEvent")]
	
	/**
	 * ${mapping_Map_Event_viewBoundsChange_D}
	 * @eventType com.supermap.web.events.ViewBoundsEvent.VIEWBOUNDS_CHANGE  
	 */	
	[Event(name="viewBoundsChange", type="com.supermap.web.events.ViewBoundsEvent")]
	
	/**
	 * ${mapping_Map_Event_viewBoundsUpdate_D}
	 * @eventType com.supermap.web.events.ViewBoundsEvent.VIEWBOUNDS_UPDATE  
	 */	
	[Event(name="viewBoundsUpdate", type="com.supermap.web.events.ViewBoundsEvent")]
	
	/**
	 * ${mapping_Map_Event_maxResolutionChange_D}
	 */	
	[Event(name="maxResolutionChange", type="flash.events.Event")]
	
	/**
	 * ${mapping_Map_Event_minResolutionChange_D} 
	 */	
	[Event(name="minResolutionChange", type="flash.events.Event")]
	
	/**
	 * ${mapping_Map_Event_maxScaleChange_D} 
	 */	
	[Event(name="maxScaleChange", type="flash.events.Event")]
	
	/**
	 * ${mapping_Map_Event_mixScaleChange_D} 
	 */	
	[Event(name="minScaleChange", type="flash.events.Event")]
	
	/**
	 *  ${mapping_Map_attribute_backgroundImage_D} 
	 * */
	[Style(name="backgroundImage", type="Object", inherit="no")]
	
	/**
	 *  ${mapping_Map_attribute_backgroundImageRepeat_D} 
	 * */
	[Style(name="backgroundImageRepeat", type="Boolean", inherit="no")]
	
	/**
	 *  ${mapping_Map_attribute_backgroundColor_D} 
	 * */
	[Style(name="backgroundColor", type="uint", inherit="no")]
	
	/**
	 *  ${mapping_Map_attribute_backgroundAlpha_D} 
	 * */
	[Style(name="backgroundAlpha", type="Number", inherit="no")]
	
	//map
	[IconFile("/designIcon/Map.png")]
	[DefaultProperty("layers")]
	/**
	 * ${mapping_Map_Title}. 
	 * <p>${mapping_Map_Description}</p>
	 * 
	 * 
	 */	
	public class Map extends UIComponent
	{
		sm_internal var _resizeHandler:ResizeHandler;
		
		private var _layerHolder:UIComponent;
		sm_internal var _layerContainer:LayerContainer;
		
		sm_internal var baseLayer:Layer;
		private var _markersLayer:Layer;
		
		
		sm_internal var isPanning:Boolean = false;
		sm_internal var isResizing:Boolean = false;
		sm_internal var isTweening:Boolean = false;
		sm_internal var animateViewBounds:Boolean = false;
		sm_internal var endViewBounds:Rectangle2D;
		sm_internal var oldViewBounds:Rectangle2D;
		sm_internal var isIServer2DPI:Boolean = false;
		
		sm_internal var preBounds:Rectangle2D;
		
		private var _creationComplete:Boolean = false;		
		private var _baseLayerLoaded:Boolean;
		
		private var _infoWindow:InfoWindow;
		
		private var _level:Number = -1;
		private var _levelChange:Boolean;
		
		private var _resolution:Number = 0;
		private var _maxResolution:Number = NaN;
		private var _minResolution:Number = NaN;	
		private var _isMaxResolutionSet:Boolean;
		private var _isMinResolutionSet:Boolean;
		private var _resolutions:Array = null;		
		
		private var _scale:Number = 0;
		private var _maxScale:Number = NaN;
		private var _minScale:Number = NaN;	
		private var _isMaxScaleSet:Boolean;
		private var _isMinScaleSet:Boolean;
		private var _scales:Array = null;
		private var _scalesConvertDone:Boolean;
		private var _minScaleConvertDone:Boolean;
		private var _maxScaleConvertDone:Boolean;
		
		private var _mapAnimation:Parallel;
		private var _mapResize:Resize;
		private var _mapMove:Move;
		
		//与Action有关的变量
		private var _panHandCursorVisible:Boolean = false;		
		private var _mapAction:MapAction;
		private var _zoomEffect:ZoomEffect;
		
		private var _mouseWheelChangePending:Boolean = false;
		private var _doubleClickZoomEnabled:Boolean = true;
		private var _scrollWheelZoomEnabled:Boolean = true;
		private var _keyboardNavigationEnabled:Boolean = true;
				
		private var _multiTouchEnabled:Boolean;		
		private var _touchAction:TouchAction;
		
		//缩放系数
		private var _zoomFactor:Number = 2;
		private var _panFactor:Number = 0.2;
		private var _panEasingFactor:Number = 0.2;
		private var _zoomDuration:Number = 250;
		private var _panDuration:Number = 300;
		
		private var _viewBounds:Rectangle2D;
		private var _viewBoundsChanged:Boolean = false;
		private var _commitViewBoundsCalled:Boolean;
		
		private var _ratioH:Number = 1;
		private var _ratioW:Number = 1;
		
		private var _bounds:Rectangle2D;
		private var _CRS:CoordinateReferenceSystem;
		private var _layerIds:Array;
		private var _layers:ArrayCollection;
		private var _loaded:Boolean = false;  //map创建完毕并且第一个图层的baselayer加载后，值为true
		
		private var _dummyContainer:UIComponent;
		private var _screenContainer:ScreenContainer;
		
		private var _mapLoadEventWasDispatched:Boolean = false;
		
		private var _zoomEffectEnabled:Boolean = true;
		
		private static var _theme:Theme;
		//private var _oldClickTime:int;
		
		private static const LEVEL_CHANGE_FACTOR:Number = 1000000;
		private static const CRS_CHANGE:String = "CRSChange";
		private static const MAXRESOLUTION_CHANGE:String = "maxResolutionChange";
		private static const MINRESOLUTION_CHANGE:String = "minResolutionChange";
		private static const MAXSCALE_CHANGE:String = "maxScaleChange";
		private static const MINSCALE_CHANGE:String = "minScaleChange";
		private static const PANEASINGFACTOR_CHANGE:String = "panEasingFactorChange";
		private static const RESOLUTIONS_CHANGE:String = "resolutionsChange";
		
		/////////////////////////*****构造函数****////////////////////////////////
		/**
		 * ${mapping_Map_constructor_None_D}
		 * 
		 */		
		public function Map()
		{
			percentWidth = 100;
			percentHeight = 100;
			this._layerHolder = new UIComponent();
			this._layerContainer = new LayerContainer(this);			
			this._dummyContainer = new UIComponent();
			
			this._screenContainer = new ScreenContainer(this);
			this._infoWindow = new InfoWindow(this);
			this._touchAction = new TouchAction(this);
			
			addEventListener(ResizeEvent.RESIZE, this.resizeHandler);
			addEventListener(FlexEvent.CREATION_COMPLETE, this.onCreationComplete);
			addEventListener(FlexEvent.SHOW, this.showHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);

			this._resizeHandler = new ResizeHandler(this);
			this.doubleClickEnabled = true;
			this.scrollWheelZoomEnabled = true;
			this._mapAction = new Pan(this);
			this._mapAction.addMapListeners();	
			
			_zoomEffect = new ZoomEffect(this);
		}
		
		private function resizeHandler(event:ResizeEvent):void
		{
			if (width > 0 && height > 0)
			{
				removeEventListener(ResizeEvent.RESIZE, this.resizeHandler);
//				this.m_widthAndHeightNotZero = true;
				this.checkIfCompleteAndBaseLayerLoaded();
			}
		}
		
		private var _zoomScale:Number;

		sm_internal function set layerContainer(value:LayerContainer):void
		{
			sm_internal::_layerContainer = value;
		}
		
		
		
		private function zoomHandler(ptx:Number, pty:Number, scale:Number):void
		{
			if(scale > 1)
			{
				zoomOut();					
			}
			else if(scale == 1)
			{
				
			}
			else
			{
				zoomIn();				
			}
			//			this._mapAction.removeMapListeners();
		}
		
		
		
		//////////////////////****end构造函数*****////////////////////////////////
		
		
		//////////////////////******属性******/////////////////////////////////
		
		/**
		 * ${mapping_Map_attribute_multiTouchEnabled_D}.
		 * <p>${mapping_Map_attribute_multiTouchEnabled_remsrks}</p> 
		 * @return 
		 * 
		 */
		 
		public function get multiTouchEnabled():Boolean
		{
			return _multiTouchEnabled;
		}
		
		public function set multiTouchEnabled(value:Boolean):void
		{
			var old_value:Boolean = this._multiTouchEnabled;
			if (old_value !== value)
			{
				this._multiTouchEnabled = value;
				
				if(value)
					this._touchAction.enable();
				else
					this._touchAction.disable();
				
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "multiTouchEnabled", arguments, value));
				}
			}
			
		}
		
		/**
		 * ${mapping_Map_attribute_zoomEffectEnabled_D}.
		 * <p>${mapping_Map_attribute_zoomEffectEnabled_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get zoomEffectEnabled():Boolean
		{
			return _zoomEffectEnabled;
		}
		
		public function set zoomEffectEnabled(value:Boolean):void
		{
						_zoomEffectEnabled = value;
						if((this.screenContainer.contains(_zoomEffect)) && !_zoomEffectEnabled)
							this.screenContainer.removeElement(_zoomEffect);
		}
		
		/**
		 * ${mapping_Map_attribute_theme_D} 
		 * @return 
		 * 
		 */		
		public static function get theme():Theme
		{
			return _theme;
		}
		
		public static function set theme(value:Theme):void
		{
//			if(value)
				_theme = value;
		}
		
		//临时加入
		sm_internal function get markersLayer():Layer
		{
			if(!this._markersLayer)
			{
				var layer:Layer;
				for each (layer in layers)
				{
					if (layer.hasOwnProperty("markers"))
					{
						this._markersLayer = layer;
						break;
					}
				}
			}
			return _markersLayer;
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Map_attribute_action_D} 
		 * @return 
		 * 
		 */		
		public function get action():MapAction
		{
			return this._mapAction;
		}	
		public function set action(value:MapAction):void
		{		
			if (this._mapAction == value)
				return;
			
			this.dispatchEvent(new ActionEvent(ActionEvent.ACTION_CHANGED, this._mapAction, value));
			
			if (this._mapAction)
				this._mapAction.removeMapListeners();
			
			this._mapAction = value;
			
			if (this._mapAction)
				this._mapAction.addMapListeners();
		}
		
		//所有layer的bounds的并集		
		/**
		 * ${mapping_Map_attribute_bounds_D} 
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			this._bounds = new Rectangle2D();
			if(this.layers.length > 0)
			{
				var layer:Layer;
				for each(layer in this.layers)
				{
					if(layer.loaded)
					{		
						this._bounds = this._bounds.union(layer.bounds);
					}
				}
			}
			return this._bounds;
		}
		
		/**
		 * @private 
		 * @param value
		 * 
		 */		
		sm_internal function setBounds(value:Rectangle2D):void
		{
			_bounds = value;
		}
		
		/**
		 * ${mapping_Map_attribute_center_D} 
		 * @return 
		 * 
		 */		
		public function get center():Point2D
		{
			if (this._viewBounds)
			{
				return this._viewBounds.center.clone();
			}
			return null;
		}
		
		/**
		 * ${mapping_Map_attribute_CRS_D}.
		 * <p>${mapping_Map_attribute_CRS_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get CRS() : CoordinateReferenceSystem
		{
			return this._CRS;
		}
		/**
		 * @private 
		 * @param value
		 * 
		 */		
		sm_internal function setCRS(value:CoordinateReferenceSystem) : void
		{
			this._CRS = value;
		}
		
		public function get dpi() : Number
		{
			return this.layerContainer.dpi;
		}
		
		//是否支持双击缩放
		[Inspectable(defaultValue="true", category = "iClient", enumeration = "true,false")] 
		/**
		 * ${mapping_Map_attribute_doubleClickZoomEnabled_D} 
		 * @return 
		 * 
		 */		
		public function get doubleClickZoomEnabled() : Boolean
		{
			return this._doubleClickZoomEnabled;
		}	
		public function set doubleClickZoomEnabled(value:Boolean) : void
		{
			var old_value:Boolean = this.doubleClickZoomEnabled;
			if (old_value !== value)
			{
				this._doubleClickZoomEnabled = value;				
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "doubleClickZoomEnabled", old_value, value));
				}
			}
		}
		
		/**
		 * ${mapping_Map_attribute_infoWindow_D} 
		 * @return 
		 * 
		 */		
		public function get infoWindow() : InfoWindow
		{
			return this._infoWindow;
		}	
		
		//是否支持键盘操作地图
		[Inspectable(defaultValue="true", category = "iClient", enumeration = "true,false")] 
		/**
		 * ${mapping_Map_attribute_keyboardNavigationEnabled_D}.
		 * <p>${mapping_Map_attribute_keyboardNavigationEnabled_remarks}</p>
		 * @default true
		 * @return 
		 * 
		 */		
		public function get keyboardNavigationEnabled() : Boolean
		{
			return this._keyboardNavigationEnabled;
		}	
		public function set keyboardNavigationEnabled(value:Boolean) : void
		{
			var old_value:Boolean = this.keyboardNavigationEnabled;
			if (old_value !== value)
			{
				this._keyboardNavigationEnabled = value;
				
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "keyboardNavigationEnabled", old_value, value));
				}
			}
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		sm_internal function get layerContainer() : LayerContainer
		{
			return this._layerContainer;
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		sm_internal function get layerHolder() : UIComponent
		{
			return this._layerHolder;
		}
		
		/**
		 * ${mapping_Map_attribute_layerIds_D}.
		 * <p>${mapping_Map_attribute_layerIds_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get layerIds():Array
		{
			return this._layerContainer.layerIds;
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Map_attribute_Layers_D}.
		 * ${mapping_Map_attribute_Layers_Remarks_D} 
		 * @return 
		 * 
		 */		
		public function get layers() : Object
		{
			if (this._layers == null)			
			{
				this._layers = new ArrayCollection();
				this._layers.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			}
			return this._layers;
		}
		public function set layers(value:Object) : void
		{
			//value的类型可以是layer、array或者是arrayCollection
			var layerArray:Array = null;
			if (this._layers)
			{
				this._layers.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			}
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
			this._layers.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			var layersEvent:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
			layersEvent.kind = CollectionEventKind.RESET;
			this.collectionChangeHandler(layersEvent);
			dispatchEvent(layersEvent);
		}
		
		//当map的resolutions不为空时，设置才有效
		/**
		 * ${mapping_Map_attribute_level_D}.
		 * ${mapping_Map_attribute_level_Remarks_D} 
		 * @return 
		 * 
		 */		
		public function get level() : Number
		{
			if (!this.loaded)
			{
				return this._level;
			}
			return this._resolutions ? MathUtil.getNearestIndex(this.resolution, this._resolutions, this._minResolution, this._maxResolution) : -1;
		}	
		
		
		/**
		 * ${mapping_Map_attribute_loaded_D} 
		 * @return 
		 * 
		 */		
		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Map_attribute_maxResolution_D}.
		 * ${mapping_Map_attribute_maxResolution_remarks_D} 
		 * @return 
		 * 
		 */		
		public function get maxResolution() : Number
		{
			return this._maxResolution;
		}	
		public function set maxResolution(value:Number) : void
		{
			if (this._maxResolution != value)
			{
				this._maxResolution = value;
				this._isMaxResolutionSet = true;
				dispatchEvent(new Event(MAXRESOLUTION_CHANGE));
			}
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Map_attribute_minResolution_D}.
		 * ${mapping_Map_attribute_minResolution_remarks_D} 
		 * @return 
		 * 
		 */			
		public function get minResolution() : Number
		{
			return this._minResolution;
		}	
		public function set minResolution(value:Number) : void
		{
			if (this._minResolution != value)
			{
				this._minResolution = value;
				this._isMinResolutionSet = true;
				dispatchEvent(new Event(MINRESOLUTION_CHANGE));
			}
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Map_attribute_maxScale_D}.
		 * ${mapping_Map_attribute_maxScale_remarks_D} 
		 * @return 
		 * 
		 */		
		public function get maxScale() : Number
		{
			var _dpi:Number = this.dpi;
			if(!isNaN(this.dpi) && _dpi != 0 && this._minResolution > 0)
			{
				if(this.isIServer2DPI)
					return ScaleUtil.resolutionToScale(this._minResolution, _dpi, null);
				else if(this.CRS)
					return ScaleUtil.resolutionToScale(this._minResolution, _dpi, this.CRS.unit, this.CRS.datumAxis);
				else
					return ScaleUtil.resolutionToScale(this._minResolution, _dpi);
			}
			return NaN;
		}	
		public function set maxScale(value:Number) : void
		{
			var _dpi:Number = this.dpi;
			if (this._maxScale != value)
			{
				this._maxScale = value;
				this._isMaxScaleSet = true;
				if(!isNaN(_dpi) && _dpi != 0)
				{
					if(this.isIServer2DPI)
						this._minResolution = ScaleUtil.scaleToResolution(this._maxScale, _dpi, null);
					else if(this.CRS)
						this._minResolution = ScaleUtil.scaleToResolution(this._maxScale, _dpi, this.CRS.unit, this.CRS.datumAxis);
					else
						this._minResolution = ScaleUtil.scaleToResolution(this._maxScale, _dpi);
				}			
				dispatchEvent(new Event(MAXSCALE_CHANGE));
			}
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Map_attribute_minScale_D}.
		 * ${mapping_Map_attribute_minScale_remarks_D} 
		 * @return 
		 * 
		 */		
		public function get minScale() : Number
		{
			var _dpi:Number = this.dpi;
			if(!isNaN(_dpi) && _dpi != 0 && this._maxResolution > 0)
			{
				if(this.isIServer2DPI)
					return ScaleUtil.resolutionToScale(this._maxResolution, _dpi, null);
				else if(this.CRS)
					return ScaleUtil.resolutionToScale(this._maxResolution, _dpi, this.CRS.unit, this.CRS.datumAxis);
				else
					return ScaleUtil.resolutionToScale(this._maxResolution, _dpi);
			}
			return NaN;
			
		}
		
		public function set minScale(value:Number) : void
		{
			var _dpi:Number = this.dpi;
			if (this._minScale != value)
			{
				this._minScale = value;
				this._isMinScaleSet = true;
				if(!isNaN(_dpi) && _dpi != 0)
				{
					if(this.isIServer2DPI)
						this._maxResolution =  ScaleUtil.scaleToResolution(this._minScale, _dpi, null);
					else if(this.CRS)
						this._maxResolution =  ScaleUtil.scaleToResolution(this._minScale, _dpi, this.CRS.unit, this.CRS.datumAxis);
					else
						this._maxResolution =  ScaleUtil.scaleToResolution(this._minScale, _dpi);
				}		
				dispatchEvent(new Event(MINSCALE_CHANGE));
			}
		}
		
		//控制地图漫游的动画时间，及从一点移动到另一点所需的时间，单位为ms，最小值为1
		[Inspectable(category = "iClient", defaultValue = "1")] 
		/**
		 * ${mapping_Map_attribute_panDuration_D}.
		 * <p>${mapping_Map_attribute_panDuration_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get panDuration() : Number
		{
			return this._panDuration;
		}	
		public function set panDuration(value:Number) : void
		{
			var old_panDuration:Number = this.panDuration;
			if (old_panDuration !== value)
			{
				if (this._panDuration != value)
				{
					this._panDuration = isNaN(value) ? (1) : (Math.max(1, value));
				}
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "panDuration", old_panDuration, value));
				}
			}
		}
		
		//控制鼠标漫游地图时的动画效果，默认值为0.2,值越小，动画越缓慢
		[Inspectable(category = "iClient", defaultValue = "0.2")] 
		/**
		 * ${mapping_Map_attribute_panEasingFactor_D} 
		 * @return 
		 * 
		 */		
		public function get panEasingFactor() : Number
		{
			return this._panEasingFactor;
		}	
		public function set panEasingFactor(value:Number) : void
		{
			value = Math.min(1, value);
			if (value <= 0)
			{
				value = 0.2;
			}
			if (this._panEasingFactor != value)
			{
				this._panEasingFactor = value;
				dispatchEvent(new Event("panEasingFactorChange"));
			}
		}
		
		//键盘平移地图时距离系数，默认为0.25,如沿X轴平移距离为:map.width * 0.25
		[Inspectable(category = "iClient", defaultValue = "0.25")] 
		/**
		 * ${mapping_Map_attribute_panFactor_D} 
		 * @default 0.2
		 * @return 
		 * 
		 */		
		public function get panFactor():Number
		{
			return _panFactor;
		}	
		public function set panFactor(value:Number):void
		{
			var old_value:Number = this.panFactor;
			if (old_value !== value)
			{
				this._panFactor = value;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "panFactor", old_value, value));
				}
			}
		}
		
		//平移图标是否可见
		[Inspectable(category = "iClient", defaultValue = "false", enumeration = "true,false")] 
		/**
		 * ${mapping_Map_attribute_panHandCursorVisible_D} 
		 * @default false
		 * @return 
		 * 
		 */		
		public function get panHandCursorVisible() : Boolean
		{
			return this._panHandCursorVisible;
		}	
		public function set panHandCursorVisible(value:Boolean) : void
		{
			var old_value:Boolean = this.panHandCursorVisible;
			if (old_value !== value)
			{
				this._panHandCursorVisible = value;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "panHandCursorVisible", old_value, value));
				}
			}
		}
		
		/**
		 * ${mapping_Map_attribute_Resolution_D} 
		 * @return 
		 * 
		 */		
		public function get resolution() : Number
		{
			if (!this.loaded && this._resolution)
			{
				return this._resolution;
			}
			return this.getResolution();
		}		
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Map_attribute_Resolutions_D}.
		 * ${mapping_Map_attribute_Resolutions_Remarks_D} 
		 * @return 
		 * 
		 */		
		public function get resolutions() : Array
		{
			return this._resolutions;
		}	
		public function set resolutions(value:Array) : void
		{		
			if (value && value.length > 0)
			{
				var length:int = value.length;
				var tempArr:Array = [];
				for (var j:int = 0; j < length; j++)
				{
					if(isNaN(value[j]) || value[j] <= 0)
					{
						continue;
					}
					tempArr.push(value[j]);
				}
				
				this._resolutions = MathUtil.getUniqueArray(tempArr.sort(Array.NUMERIC | Array.DESCENDING));
				if (!this._isMinResolutionSet)
				{
					this._minResolution = this.resolutions[this._resolutions.length - 1];
					//this._isMinResolutionSet = false;
				}
				if (!this._isMaxResolutionSet)
				{
					this._maxResolution = this._resolutions[0];
					//this._isMaxResolutionSet = false;
				}
			}
			else
			{
				this._resolutions = null;
			}
			//先注释掉吧
			if (this.loaded)
			{
				this.viewBounds = this.getAdjustedBounds(this._viewBounds);
			}
			dispatchEvent(new Event(RESOLUTIONS_CHANGE));
		}	
		
		
		
		/**
		 * ${mapping_Map_attribute_scale_D} 
		 * @return 
		 * 
		 */			
		public function get scale() : Number
		{
			if (!this.loaded)
			{
				return this._scale;
			}
			var _dpi:Number = this.dpi;
			if(!isNaN(_dpi) && _dpi != 0)
			{
				if(this.isIServer2DPI)
					return ScaleUtil.resolutionToScale(this.getResolution(), _dpi, null);
				else if(this.CRS)
					return ScaleUtil.resolutionToScale(this.getResolution(), _dpi, this.CRS.unit, this.CRS.datumAxis);
				else
					return ScaleUtil.resolutionToScale(this.getResolution(), _dpi);
			}
			return NaN;
			
		}		
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Map_attribute_scales_D}.
		 * ${mapping_Map_attribute_scales_remarks_D} 
		 * @return 
		 * 
		 */		
		public function get scales():Array
		{
			return _scales;
		}
		public function set scales(value:Array) : void
		{		
			if(value == null)
			{
				this._scales = null;
				return;
			}
			var length:int = value.length;
			var tempArr:Array = [];
			if (value[0] > 1)
			{
				for (var j:int = 0; j < value.length; j++)
				{
					if(isNaN(value[j]) || value[j] <= 0)
					{
						continue;
					}
					tempArr.push(1.0 / value[j]);
				}
			}
			else
			{
				for (j = 0; j < value.length; j++)
				{
					if(isNaN(value[j]) || value[j] <= 0)
					{
						continue;
					}
					tempArr.push(value[j]);
				}
			}	
			this._scales = tempArr.slice().sort(Array.NUMERIC);	
			
			if (this.loaded)
			{
				var _dpi:Number = this.dpi;
				if(!isNaN(_dpi) && _dpi != 0)
				{
					if(this.isIServer2DPI)
						this.resolutions = ScaleUtil.scalesToResolutions(this._scales, _dpi, null);
					else if(this.CRS)
						this.resolutions = ScaleUtil.scalesToResolutions(this._scales, _dpi, this.CRS.unit, this.CRS.datumAxis);
					else
						this.resolutions = ScaleUtil.scalesToResolutions(this._scales, _dpi);
				}	
			}
			
		}
		
		
		/**
		 * ${mapping_Map_attribute_scrollRectX_D} 
		 * @return 
		 * 
		 */		
		public function get scrollRectX() : Number
		{
			return this._layerContainer.scrollRect.x;
		}
		
		/**
		 * ${mapping_Map_attribute_scrollRectY_D} 
		 * @return 
		 * 
		 */		
		public function get scrollRectY() : Number
		{
			return this._layerContainer.scrollRect.y;
		}
		
		//是否支持滚轮缩放
		[Inspectable(category = "iClient", defaultValue = "true", enumeration = "true,false")] 
		/**
		 * ${mapping_Map_attribute_scrollWheelZoomEnabled_D} 
		 * @return 
		 * 
		 */		
		public function get scrollWheelZoomEnabled() : Boolean
		{
			return this._scrollWheelZoomEnabled;
		}	
		public function set scrollWheelZoomEnabled(value:Boolean) : void
		{
			var old_value:Boolean = this.scrollWheelZoomEnabled;
			if (old_value !== value)
			{
				this._scrollWheelZoomEnabled = value;
				
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "scrollWheelZoomEnabled", old_value, value));
				}
			}
		}
		
		/**
		 * ${mapping_Map_attribute_staticLayer_D} 
		 * @return 
		 * 
		 */		
		public function get screenContainer() :ScreenContainer
		{
			return this._screenContainer;
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_Map_attribute_viewBounds_D} 
		 * @return 
		 * 
		 */		
		public function get viewBounds() : Rectangle2D
		{
			return this._viewBounds;
		}
		public function set viewBounds(value:Rectangle2D) : void
		{
			if (this.isPanning)
			{
				if(this._mapAction is Pan)					
				{
					var pan:Pan = this._mapAction as Pan;
					pan.stopPanning();
				}
				else
				{
					this.dispatchPanEnd(this.mouseX, this.mouseY);
				}						
			}
			else if (this.isTweening)
			{
				return;
			}
			if (value != null)
			{
				this._viewBounds = value.clone();
				this._viewBoundsChanged = true;
				invalidateProperties();				
				
				if (this.loaded)
				{
					this._viewBounds = this.getAdjustedBounds(this._viewBounds);
					//trace("set::viewBounds");
				}
			}
		}
		
		sm_internal function get viewBoundsChanged() : Boolean
		{
			return this._viewBoundsChanged;
		}
		
		//默认的zoomin以及zoomout、双击放大的缩放倍数,必须大于0
		[Inspectable(category = "iClient", defaultValue = "2")] 
		/**
		 * ${mapping_Map_attribute_zoomFactor_D} 
		 * 
		 */		
		public function get zoomFactor():Number
		{
			return _zoomFactor;
		}	
		public function set zoomFactor(value:Number):void
		{
			var old_value:Number = this.zoomFactor;
			if (old_value !== value)
			{
				if(value <= 0)
				{
					return;
				}
				this._zoomFactor = value;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zoomFactor", old_value, value));
				}
			}
		}
		
		//缩放动画时间
		[Inspectable(defaultValue = "250", category = "iClient")] 
		/**
		 * ${mapping_Map_attribute_zoomDuration_D} 
		 * @return 
		 * 
		 */		
		public function get zoomDuration() : Number
		{
			return this._zoomDuration;
		}	
		public function set zoomDuration(value:Number) : void
		{		
			var old_zoomDuration:Number = this.zoomDuration;
			if (old_zoomDuration !== value)
			{
				if (this._zoomDuration != value)
				{
					this._zoomDuration = isNaN(value) ? (1) : (Math.max(1, value));
				}
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "zoomDuration", old_zoomDuration, value));
				}
			}
		}
		
		
		////////////////////////*****end 属性******////////////////////////////		
		
		////////////////////////*****方法******///////////////////////////////
		
		/**
		 * ${mapping_Map_method_addChild_D}.
		 * <p>${mapping_Map_method_addChild_remarks}</p>
		 * @param child ${mapping_Map_method_addChild_param_child}
		 * @return ${mapping_Map_method_addChild_return}
		 * 
		 */		
		override public function addChild(child:DisplayObject):DisplayObject 
		{		
			if (! this._loaded) 
			{
				if (!(child is Layer)) 
				{
					return super.addChild(child);
				}			
			}		
			// Only layers lay be added
			if (child is Layer) 
			{
				// Add the layer/baselayer
				addLayer(child as Layer);
			}		
			return child;
		}
		
		/**
		 * ${mapping_Map_method_addChildAt_D}.
		 * <p>${mapping_Map_method_addChildAt_remarks}</p> 
		 * @param child ${mapping_Map_method_addChildAt_param_child}
		 * @param index ${mapping_Map_method_addChildAt_param_index}
		 * @return ${mapping_Map_method_addChildAt_return}
		 * 
		 */		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject 
		{
			if(child is Layer) 
			{
				addLayer(child as Layer, index);
			}
			else
			{
				if(!this._loaded)
				{
					return super.addChildAt(child, index);
				}
			}
			return child;
		}
		
		/**
		 * ${mapping_Map_method_addLayer_D}.
		 * <p>${mapping_Map_method_addLayer_remarks}</p> 
		 * @param layer ${mapping_Map_method_addLayer_param_layer}
		 * @param index ${mapping_Map_method_addLayer_param_index}
		 * @return ${mapping_Map_method_addLayer_return}
		 * 
		 */		
		public function addLayer(layer:Layer, index:int = -1) : String
		{
			//临时加入
			if(layer.hasOwnProperty("markers"))
			{
				if(this._markersLayer)
					return this._markersLayer.id;
				else
					this._markersLayer = layer;
			}
			if (layer.id == null)
			{
				layer.id = NameUtil.createUniqueName(layer);
			}
			if (index < 0)
			{
				index = this._layerContainer.numChildren;
			}
			else
			{
				index = Math.min(index, this._layerContainer.numChildren);
			}
			var layers:ArrayCollection = this.layers as ArrayCollection;
			var layerIndex:int = layers.getItemIndex(layer);
			if (layerIndex != -1)
			{
				layers.removeItemAt(layerIndex);
				if (index > layers.length)
				{
					index = index - 1;
				}
			}
			
			layers.addItemAt(layer, index);
			return layer.id;
		}
		
		/**
		 * ${mapping_Map_method_getLayer_D} 
		 * @param layerId ${mapping_Map_method_getLayer_param_layerId}
		 * @return ${mapping_Map_method_getLayer_return}
		 * 
		 */		
		public function getLayer(layerId:String) : Layer
		{
			var rtnLayer:Layer = null;
			var layer:Layer = null;
			var layers:Array = this._layerContainer.layers;
			for each (layer in layers)
			{
				
				if (layerId == layer.id)
				{
					rtnLayer = layer;
					break;
				}
			}
			return rtnLayer;
		}
		
		/**
		 * ${mapping_Map_method_mapToScreen_D} 
		 * @param mapPoint ${mapping_Map_method_mapToScreen_param_mapPoint}
		 * @return ${mapping_Map_method_mapToScreen_return}
		 * 
		 */		
		public function mapToScreen(mapPoint:Point2D) : Point
		{
			var screenPoint:Point = new Point();
			screenPoint.x = this.mapToScreenX(mapPoint.x);
			screenPoint.y = this.mapToScreenY(mapPoint.y);
			return screenPoint;
		}
		
		/**
		 * ${mapping_Map_method_mapToStage_D} 
		 * @param mapPoint ${mapping_Map_method_mapToStage_param_mapPoint}
		 * @return ${mapping_Map_method_mapToStage_return}
		 * 
		 */		
		public function mapToStage(mapPoint:Point2D) : Point
		{
			var local:Point = new Point();
			local.x = this.mapToScreenX(mapPoint.x);
			local.y = this.mapToScreenY(mapPoint.y);
			return localToGlobal(local);
		}
		
		/**
		 * ${mapping_Map_method_pan_D} 
		 * @param offsetX ${mapping_Map_method_pan_Param_offsetX}
		 * @param offsetY ${mapping_Map_method_pan_Param_offsetY}
		 * 
		 */		
		public function pan(offsetX:Number, offsetY:Number) : void
		{		
			if(isNaN(offsetX) || isNaN(offsetY))
			{
				return;	
			}		
			if(this.viewBounds != null)
			{
				this.viewBounds = this.viewBounds.offset(offsetX, offsetY);
			}
		}
		
		/**
		 * ${mapping_Map_method_panByPixel_D} 
		 * @param dx ${mapping_Map_method_panByPixel_Param_dx}
		 * @param dy ${mapping_Map_method_panByPixel_Param_dy}
		 * 
		 */		
		public function panByPixel(offsetX:Number, offsetY:Number) : void
		{		
			if(this.viewBounds != null)
			{
				var mapX:Number = this.screenToMapX(width / 2 + offsetX);
				var mapY:Number = this.screenToMapY(height / 2 + offsetY);
				this.panTo(new Point2D(mapX, mapY));	
			}
			
		}
		
		/**
		 * ${mapping_Map_method_panTo_D} 
		 * @param pnt2D ${mapping_Map_method_panTo_Param_pnt2D}
		 * 
		 */		
		public function panTo(pnt2D:Point2D) : void
		{		
			if(this.viewBounds && pnt2D && !isNaN(pnt2D.x) && !isNaN(pnt2D.y))
			{
				this.viewBounds = this.viewBounds.centerAt(pnt2D.x, pnt2D.y); 
			}
			
		}
		
		/**
		 * ${mapping_Map_method_refresh_D} 
		 * 
		 */		
		public function refresh() : void
		{
			var layer:Layer = null;
			var layers:Array = this._layerContainer.layers;
			for each (layer in layers)
			{			
				layer.refresh();
			}
		}
		
		/**
		 * ${mapping_Map_method_removeAllLayers_D}
		 * 
		 */				
		public function removeAllLayers() : void
		{
			ArrayCollection(this.layers).removeAll();
		}
		
		/**
		 * ${mapping_Map_method_removeLayer_D} 
		 * @param layer ${mapping_Map_method_removeLayer_Param_layer}
		 * 
		 */		
		public function removeLayer(layer:Layer) : void
		{
			var layers:ArrayCollection = this.layers as ArrayCollection;
			var index:int = layers.getItemIndex(layer);
			if (index != -1)
			{
				layers.removeItemAt(index);
			}
		}
		
		/**
		 * ${mapping_Map_method_reorderLayer_D} 
		 * @param layerId ${mapping_Map_method_reorderLayer_Param_layerId}
		 * @param index ${mapping_Map_method_reorderLayer_Param_index}
		 * 
		 */		
		public function moveLayer(layerId:String, index:int) : void
		{
			if (index < 0)
			{
				index = 0;
			}
			else if (index > this._layerContainer.numChildren)
			{
				index = this._layerContainer.numChildren;
			}
			var layer:Layer = this.getLayer(layerId);
			if (layer)
			{
				var layers:ArrayCollection = this.layers as ArrayCollection;
				var layerIndex:int = layers.getItemIndex(layer);
				if (layerIndex != -1)
				{
					layers.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
					layers.removeItemAt(layerIndex);
					if (index > layers.length)
					{
						index = index - 1;
					}
					layers.addItemAt(layer, index);
					this._layerContainer.setChildIndex(layer, index);
					layers.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
				}
				dispatchEvent(new MapEvent(MapEvent.LAYER_MOVE, this, layer, index));
			}
		}
		
		/**
		 * ${mapping_Map_method_screenToMap_D}.
		 * <p>${mapping_Map_method_screenToMap_remarks}</p> 
		 * @param screenPoint ${mapping_Map_method_screenToMap_screenPoint_Param}
		 * @return ${mapping_Map_method_screenToMap_return}
		 * @see #stageToMap()
		 * 
		 */		
		public function screenToMap(screenPoint:Point) : Point2D
		{
			var mapPoint:Point2D = new Point2D();
			mapPoint.x = this.screenToMapX(screenPoint.x);
			mapPoint.y = this.screenToMapY(screenPoint.y);	
			return mapPoint;
		}
		
		/**
		 * ${mapping_Map_method_stageToMap_D}.
		 * <p>${mapping_Map_method_stageToMap_remarks}</p> 
		 * @param stage ${mapping_Map_method_stageToMap_stage_Param}
		 * @return ${mapping_Map_method_stageToMap_return}
		 * @see #screenToMap()
		 * 
		 */		
		public function stageToMap(stage:Point) : Point2D
		{
			var local:Point = globalToLocal(stage);
			var mapPoint:Point2D = new Point2D();
			mapPoint.x = this.screenToMapX(local.x);
			mapPoint.y = this.screenToMapY(local.y);
			return mapPoint;
		}
		
		/**
		 * ${mapping_Map_method_viewEntire_D} 
		 * 
		 */		
		public function viewEntire() : void
		{
			if(this.bounds != null && !this.viewBounds.equals(this.preBounds))
			{				
				this.viewBounds = this.bounds.clone();
			}
		}
		
		//factor必须大于0
		/**
		 * ${mapping_Map_method_zoomIn_D} 
		 * @param factor ${mapping_Map_method_zoomIn_param_factor_D}
		 * 
		 */		
		public function zoomIn(factor:Number = 1) : void
		{
			if(isNaN(factor) || factor <= 0)
			{
				return;
			}
			if (this.level == -1)
			{
				if(this.viewBounds != null)
				{
					this.viewBounds = this.viewBounds.expand(0.5 / factor);
				}			
			}
			else
			{
				this.zoomToLevel(this.level + int(factor));
			}
		}
		
		//factor必须大于0
		/**
		 * ${mapping_Map_method_zoomOut_D}.
		 * <p>${mapping_Map_method_zoomOut_param_factor_D}</p> 
		 * 
		 */		
		public function zoomOut(factor:Number = 1) : void
		{
			if(isNaN(factor) || factor <= 0)
			{
				return;
			}
			if (this.level >= 1)
			{
				this.zoomToLevel(this.level - int(factor));
			}
			else if (this.level == -1)
			{
				if(this.viewBounds != null)
				{
					this.viewBounds = this.viewBounds.expand(2 * factor);
				}		
			}
		}
		
		
		//1.只有map的resolutions或者scales不为空时才可以用
		//2.point如果不设置的话就默认为当前map的中心点
		
		/**
		 * ${mapping_Map_method_zoomToLevel_D}.
		 * ${mapping_Map_method_zoomToLevel_remarks_D} 
		 * @param level ${mapping_Map_method_zoomToLevel_param_level}
		 * @param point ${mapping_Map_method_zoomToLevel_param_point}
		 * @see #level
		 * 
		 */		
		public function zoomToLevel(level:int, point:Point2D = null) : void
		{
			if (isNaN(level))
			{
				return;	
			}
			if (this.resolutions)
			{
				var validlevel:int = level < 0 ? 0 : level;
				var maxLevel:int = this.resolutions.length - 1;
				validlevel = validlevel > maxLevel ? maxLevel : validlevel;
				var res:Number = this.resolutions[validlevel];
				if(isNaN(res))
				{
					return;
				}
				this.zoomToResolution(res, point);
			}
			
		}
		
		/**
		 * ${mapping_Map_method_zoomToResolution_D}
		 * @param resolution ${mapping_Map_method_zoomToResolution_param_resolution}
		 * @param point ${mapping_Map_method_zoomToResolution_param_point}
		 * 
		 */
		public function zoomToResolution(resolution:Number, point:Point2D = null) : void
		{
			if(point == null)
			{
				point = this.center;
			}
			if(this.viewBounds != null && point != null && !isNaN(resolution) && resolution > 0)
			{
				var left:Number = point.x - (resolution * this.width) * 0.5;
				var right:Number = point.x + (resolution * this.width) * 0.5;
				var bottom:Number = point.y - (resolution * this.height) * 0.5;
				var top:Number = point.y + (resolution * this.height) * 0.5;
				try
				{
					this.viewBounds = new Rectangle2D(left, bottom, right, top);
				}
				catch(error:ArgumentError)
				{
					throw new SmError(SmResource.CREAT_RECTANGLE2D_ERROR);
				}
				
			}		
		}
		
		
		/**
		 * ${mapping_Map_method_zoomToScale_D} 
		 * @param scale ${mapping_Map_method_zoomToScale_param_scale}
		 * @param point ${mapping_Map_method_zoomToScale_param_point}
		 * @see Layer.dpi
		 * 
		 */		
		public function zoomToScale(scale:Number, point:Point2D = null) : void
		{
			var _dpi:Number = this.dpi;
			if(!isNaN(_dpi) && _dpi != 0 && !isNaN(scale) && scale > 0)
			{
				if(scale > 1)
				{
					scale = 1 / scale;
				}
				if(this.isIServer2DPI)
					this.zoomToResolution(ScaleUtil.scaleToResolution(scale, _dpi, null), point);
				else if(this.CRS)
					this.zoomToResolution(ScaleUtil.scaleToResolution(scale, _dpi, this.CRS.unit, this.CRS.datumAxis), point);
				else
					this.zoomToResolution(ScaleUtil.scaleToResolution(scale, _dpi, this.CRS.unit),point);
			}
			
		}	
		//end public
		
		
		//override--继承自UIComponent的接口
		/**
		 * @private 
		 * 
		 */		
		override protected function createChildren() : void
		{
			super.createChildren();
			
			if (!UIComponentGlobals.designMode)
			{
				this._layerHolder.addChild(this._layerContainer);
				addChild(this._layerHolder);			
				this._screenContainer.addElement(this._infoWindow);
			}
			addChild(this._screenContainer);
		}
		
		
		/**
		 * @private 
		 * @param unscaledWidth
		 * @param unscaledHeight
		 * 
		 */		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number) : void
		{
			this._screenContainer.setActualSize(unscaledWidth, unscaledHeight);
			//Container内部处理流程对于我们来说过于冗余，简单的绘制代码描述如下
			drawBackground();
		}
		
		/**
		 * @private 
		 * 获取相关样式属性，绘制背景
		 * */
		protected function drawBackground():void
		{
			//背景image优先级高于颜色,alpha属性公用，backgroundImageRepeat设置backgrounImage填充方式
			var newStyle:Object = getStyle("backgroundImage"); 
			if(newStyle)
			{
				if (newStyle as Class)
				{
					// Load background image given a class pointer
					var cls:Class = Class(newStyle);
					initBackgroundImage(new cls());
				}
				else if (newStyle is String)
				{
					// Load background image from external URL.
					var loader:Loader = new FlexLoader();
					loader.contentLoaderInfo.addEventListener(
						Event.COMPLETE, completeEventHandler);
					loader.contentLoaderInfo.addEventListener(
						IOErrorEvent.IO_ERROR, errorEventHandler);
					loader.contentLoaderInfo.addEventListener(
						ErrorEvent.ERROR, errorEventHandler);
					var loaderContext:LoaderContext = new LoaderContext();
					loaderContext.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
					loader.load(new URLRequest(String(newStyle)), loaderContext);       
				}
				
			}
			else if(!isNaN(getStyle("backgroundColor")))
			{
				var bgColor:uint = getStyle("backgroundColor");
				var bgAlpha:Number  = 1;
				if(!isNaN(getStyle("backgroundAlpha")))
				{
					bgAlpha = getStyle("backgroundAlpha");
				}
				
				this.graphics.clear();
				this.graphics.beginFill(bgColor, bgAlpha);
				this.graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
				this.graphics.endFill();
			}
		}
		
		private function completeEventHandler(event:Event):void 
		{
			var target:DisplayObject = DisplayObject(LoaderInfo(event.target).loader);
			initBackgroundImage(target);
		}
		
		private function errorEventHandler(event:Event):void 
		{
			// Ignore errors that occure during background image loading.   
		}
		
		private function initBackgroundImage(image:DisplayObject):void
		{
			var bgImageData:BitmapData;
			if (image && image.hasOwnProperty("bitmapData"))
			{
				bgImageData = image["bitmapData"];
			}
			else if (image is Loader)
			{
				var imageLoader:Loader = image as Loader;
				if(imageLoader.content is Bitmap)
				{
					bgImageData = (imageLoader.content as Bitmap).bitmapData;
				}
				else
				{
					bgImageData = new BitmapData(imageLoader.contentLoaderInfo.width,
						imageLoader.contentLoaderInfo.width);
					bgImageData.draw(imageLoader.content);
				}
				
			}
			if(bgImageData)
			{
				var repeat:Boolean = true;
				var matrix:Matrix = new Matrix;
				if(false == getStyle("backgroundImageRepeat"))
				{
					repeat = false;
					matrix.scale(unscaledWidth / bgImageData.width, unscaledHeight / bgImageData.height);
				}
				
				this.graphics.clear();
				this.graphics.beginBitmapFill(bgImageData, matrix, repeat);
				this.graphics.drawRect(0, 0, unscaledWidth, unscaledHeight);
				this.graphics.endFill();
			}
		}
		
		/**
		 * @private 
		 * 
		 */		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			if (this.loaded)
			{
				if (this._viewBoundsChanged)
				{
					this._viewBoundsChanged = false;
					this.commitViewBounds();
				}
			}
		}
		
		//sm_internal
		sm_internal function screenToMapX(screenX:Number) : Number
		{
			if (this._viewBounds)
			{
				return this._viewBounds.left + screenX * this._viewBounds.width / width;
			}
			return screenX;
		}
		
		sm_internal function screenToMapX2(screenX:Number) : Number
		{	
			if (this.oldViewBounds)
			{
				return this.oldViewBounds.left + screenX * this.oldViewBounds.width / width;
			}
			return screenX;		
		}
		
		sm_internal function screenToMapY(screenY:Number) : Number
		{
			if (this._viewBounds)
			{
				return this._viewBounds.top - screenY * this._viewBounds.height / height;
			}
			return screenY
		}
		
		sm_internal function screenToMapY2(screenY:Number) : Number
		{
			if (this.oldViewBounds)
			{
				return this.oldViewBounds.top - screenY * this.oldViewBounds.height / height;
			}
			return screenY
		}
		
		sm_internal function mapToScreenX(mapX:Number) : Number
		{
			if (this._viewBounds)
			{
				return (mapX - this._viewBounds.left) * width / this._viewBounds.width;
			}
			return mapX;
		}
		
		sm_internal function mapToScreenX2(mapX:Number) : Number
		{
			if (this.oldViewBounds)
			{
				return (mapX - this.oldViewBounds.left) * width / this.oldViewBounds.width;
			}
			return mapX;
		}
		
		sm_internal function mapToScreenY(mapY:Number) : Number
		{		
			if (this._viewBounds)
			{
				return (this._viewBounds.top - mapY) * height / this._viewBounds.height;
			}
			return mapY;
		}
		
		sm_internal function mapToScreenY2(mapY:Number) : Number
		{
			if (this.oldViewBounds)
			{
				return (this.oldViewBounds.top - mapY) * height / this.oldViewBounds.height;
			}
			return mapY;
		}
		
		sm_internal function mapToContainerX(mapX:Number) : Number
		{
			if (this._viewBounds)
			{
				return (mapX - this._viewBounds.left) * width / this._viewBounds.width + this.layerContainer.scrollRect.x;
			}
			return mapX;
		}
		
		sm_internal function mapToContainerY(mapY:Number) : Number
		{
			if (this._viewBounds)
			{
				return (this._viewBounds.top - mapY) * height / this._viewBounds.height + this.layerContainer.scrollRect.y;
			}
			return mapY;
		}
		
		sm_internal function containerToMapX(containerX:Number) : Number
		{
			if (this._viewBounds)
			{
				return (containerX -  this.layerContainer.scrollRect.x)*this._viewBounds.width/width + this._viewBounds.left
			}
			return containerX;
		}
		
		sm_internal function containerToMapY(containerY:Number) : Number
		{
			if (this._viewBounds)
			{
				return this._viewBounds.top-(containerY - this.layerContainer.scrollRect.y) * this._viewBounds.height/height
			}
			return containerY;
		}
		
		private function onCreationComplete(event:FlexEvent) : void
		{
			this.multiTouchEnabled = true;
			this._creationComplete = true;
			var i:int = 0;
			var child:DisplayObject = null;
			for(i = 0; i < this.numChildren; i++) 
			{
				child = this.getChildAt(i);
				if (child is Layer) 
				{
					this.addLayer(child as Layer);
				}
			}			
			this.checkIfCompleteAndBaseLayerLoaded();
			this.width;
			this.height;
		}
		
		private function mouseDownHandler(event:MouseEvent) : void
		{				
			if (event.shiftKey)
			{
				return;
			}
			if (hasEventListener(MapMouseEvent.MAP_CLICK))
			{
				addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
				addEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);			
			}
		}
		
		private function mouseMoveHandler(event:MouseEvent) : void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
			removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
		}
		
		private function mouseUpHandler(event:MouseEvent) : void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
			removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);	
			//			if(this.doubleClickEnabled)
			//			{
			//				var time:int = getTimer();
			//				var duration:int = time - this._oldClickTime;		
			//				if(duration < 1000)
			//				{
			//					return;
			//				}			
			//			}
			//			this._oldClickTime = time;		
			var mapPoint:Point2D = this.stageToMap(new Point(event.stageX, event.stageY));
			var mapClickEvent:MapMouseEvent = new MapMouseEvent(MapMouseEvent.MAP_CLICK, this, mapPoint);
			mapClickEvent.setMouseEventProperties(event);
			dispatchEvent(mapClickEvent);
		}
		
		private function dbClickHandler(event:MouseEvent) : void
		{
			if(this._doubleClickZoomEnabled)
			{
				var pnt:Point2D = null;
				var zoomFactor:Number = NaN;
				if(this.isPanning)
				{
					if(this._mapAction is Pan)
					{
						var pan:Pan = this._mapAction as Pan;
						pan.stopPanning();
					} 
					else
					{
						this.dispatchPanEnd(this.mouseX, this.mouseY);
					}		
				}
				if (!MapAction.targetHasEventListener(event))
				{					
					this.setFocus();
					pnt = this.stageToMap(new Point(event.stageX, event.stageY));
					zoomFactor = 1 / this._zoomFactor;
					if (event.shiftKey)
					{
						zoomFactor = this._zoomFactor;
					}
					var bounds:Rectangle2D  = this.viewBounds;
					bounds = bounds.centerAtPoint(pnt);
					bounds = bounds.expand(zoomFactor);
					this.viewBounds = bounds;
					//trace("doubleClick" + this.viewBounds);
					
										if(this._zoomEffectEnabled)
											_zoomEffect.addToMap(true);
					
				}
			}
		}
		
		private function mouseWheelHandler(event:MouseEvent) : void
		{
			if(this.scrollWheelZoomEnabled)
			{
				event.stopPropagation();
				if (this._mouseWheelChangePending)
				{
					return;
				}
				if(this.isPanning)
				{
					if(this._mapAction is Pan)
					{
						var pan:Pan = this._mapAction as Pan;
						pan.stopPanning();
					}
					else
					{
						this.dispatchPanEnd(this.mouseX, this.mouseY);
					}
				}
				
				var point:Point = this.globalToLocal(new Point(event.stageX, event.stageY));
				if (event.delta < 0)
				{
					if (this.resolutions != null && this.level <= 0)
					{
						return;
					}
					this.zoom(point.x, point.y, this._zoomFactor * 0.5, false);
				}
				else
				{
					if (this.resolutions != null && this.level >= (this.resolutions.length - 1))
					{
						return;
					}
					this.zoom(point.x, point.y, this._zoomFactor * 0.5, true);
				}
			}	
		}
		
		sm_internal function zoom(px:Number, py:Number, fac:Number, isZoomIn:Boolean) : void
		{
			
			this._mouseWheelChangePending = true;
			if (isZoomIn)
			{
				this.zoomIn(fac);
			}
			else
			{
				this.zoomOut(fac);
			}
			
						if(this._zoomEffectEnabled)
							_zoomEffect.addToMap(isZoomIn);
			
			var viewBounds:Rectangle2D = this.viewBounds;
			var left:Number = this.mapToScreenX2(viewBounds.left);
			var bottom:Number = this.mapToScreenY2(viewBounds.bottom);
			var right:Number = this.mapToScreenX2(viewBounds.right);
			var top:Number = this.mapToScreenY2(viewBounds.top);
			fac = viewBounds.width / this.oldViewBounds.width;
			var x:Number = left + px * fac;
			var y:Number = top + py * fac;
			var offsetwidth:Number = x - px;
			var offsetheight:Number = y - py;
			left = this.screenToMapX2(left - offsetwidth);
			right = this.screenToMapX2(right - offsetwidth);
			bottom = this.screenToMapY2(bottom - offsetheight);
			top = this.screenToMapY2(top - offsetheight);
			try
			{
				this.viewBounds = new Rectangle2D(left, bottom, right, top);
			}
			catch(error:ArgumentError)
			{
				throw new SmError(SmResource.CREAT_RECTANGLE2D_ERROR);
			}
		}
		
		/**
		 * @private 
		 * @param event
		 * 
		 */		
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			if(this._keyboardNavigationEnabled)
			{
				var deltaX:Number = this._panFactor * width;
				var deltaY:Number = this._panFactor * height;
				
				switch(event.keyCode)
				{
					case Keyboard.NUMPAD_ADD:
					case 187:   //“+”
					{
						this.zoomIn(this._zoomFactor * 0.5);
						break;
					}
					case Keyboard.NUMPAD_SUBTRACT:
					case 189:  //“-”
					{
						this.zoomOut(this._zoomFactor * 0.5);
						break;
					}
					case Keyboard.LEFT:
					case Keyboard.NUMPAD_4:
					{
						this.panByPixel(-deltaX, 0);
						break;
					}
					case Keyboard.RIGHT:
					case Keyboard.NUMPAD_6:
					{
						this.panByPixel(deltaX, 0);
						break;
					}
					case Keyboard.UP:
					case Keyboard.NUMPAD_8:
					{
						this.panByPixel(0, -deltaY);
						break;
					}
					case Keyboard.DOWN:
					case Keyboard.NUMPAD_2:
					{
						this.panByPixel(0, deltaY);
						break;
					}
					case Keyboard.PAGE_UP:
					case Keyboard.NUMPAD_9:
					{
						this.panByPixel(deltaX, -deltaY);
						break;
					}
					case Keyboard.PAGE_DOWN:
					case Keyboard.NUMPAD_3:
					{
						this.panByPixel(deltaX, deltaY);
						break;
					}
					case Keyboard.END:
					case Keyboard.NUMPAD_1:
					{
						this.panByPixel(-deltaX, deltaY);
						break;
					}
					case Keyboard.HOME:
					case Keyboard.NUMPAD_7:
					{
						this.panByPixel(-deltaX, -deltaY);
						break;
					}
					case 70:   //"f"
					{
						this.viewEntire();
						break;
					}
					default:
					{
						break;
					}
				}
				
			}
		}
		
		
		private function calcViewBoundsFromComponent() : Rectangle2D
		{	
			var widthRatio:Number = this.oldViewBounds.width / this._dummyContainer.width;
			var new_left:Number = this.oldViewBounds.left + -this._dummyContainer.x * widthRatio;
			var new_right:Number = this.oldViewBounds.left + (width - this._dummyContainer.x) * widthRatio;
			var heightRatio:Number = this.oldViewBounds.height / this._dummyContainer.height;
			var new_bottom:Number = this.oldViewBounds.bottom + (this._dummyContainer.height - (height - this._dummyContainer.y)) * heightRatio;
			var new_top:Number = this.oldViewBounds.bottom + (this._dummyContainer.height - -this._dummyContainer.y) * heightRatio;
			try
			{
				var rect:Rectangle2D = new Rectangle2D(new_left, new_bottom, new_right, new_top);
			}
			catch(error:SmError)
			{
				throw new SmError(SmResource.CREAT_RECTANGLE2D_ERROR);//110920byzyn
				return null;
			}
			return rect;
		}
		
		private function checkIfCompleteAndBaseLayerLoaded() : void
		{
			if (this._creationComplete && this._baseLayerLoaded && this.width && this.height)
			{
				this._mapAction.addMapListeners();
				addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE,this.viewBoundsChangedHandler, false);
				addEventListener(MouseEvent.DOUBLE_CLICK,this.dbClickHandler, true);
				addEventListener(MouseEvent.MOUSE_WHEEL,this.mouseWheelHandler, false);
				addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
				
				var loc_vb:Rectangle2D = this.getAdjustedBounds(this._viewBounds);
				
				this.oldViewBounds = loc_vb;
				this.viewBounds = loc_vb;
				this.preBounds = loc_vb;
				this._loaded = true;
				this._layerContainer.setMapOnLoadedLayers();
				if (!this._mapLoadEventWasDispatched)
				{
					this._mapLoadEventWasDispatched = true;
					dispatchEvent(new MapEvent(MapEvent.LOAD, this));
				}
			}
		}
		
		private function getAdjustedBounds(viewBounds:Rectangle2D) : Rectangle2D
		{
			var geoWidth:Number = viewBounds.width;
			var geoHeight:Number = viewBounds.height;
			var geoAspect:Number = geoWidth / geoHeight;
			var aspect:Number = width / height;//480 695 这里的值有时能取出来 有时取不出来 后者会报出图错误 即 宽度小于0的错误信息
//			trace(aspect);
			
			var offsetWidth:Number = 0;
			var offsetHeight:Number = 0;
			if (width > height)
			{
				if (geoWidth > geoHeight)
				{
					if (aspect > geoAspect)
					{
						offsetWidth = geoHeight * aspect - geoWidth;
					}
					else
					{
						offsetHeight = geoWidth / aspect - geoHeight;
					}
				}
				else
				{
					offsetWidth = geoHeight * aspect - geoWidth;
				}
			}
			else if (width < height)
			{
				if (geoWidth < geoHeight)
				{
					if (aspect > geoAspect)
					{
						offsetWidth = geoHeight * aspect - geoWidth;
					}
					else
					{
						
						offsetHeight = geoWidth / aspect - geoHeight;
						
					}
				}
				else
				{
					offsetHeight = geoWidth / aspect - geoHeight;
				}
			}
			else if (geoWidth < geoHeight)
			{
				offsetWidth = geoHeight - geoWidth;
			}
			else if (geoWidth > geoHeight)
			{
				offsetHeight = geoWidth / aspect - geoHeight;
			}
			if (offsetWidth)
			{
				viewBounds.update(viewBounds.left - offsetWidth * 0.5, viewBounds.bottom, 
					viewBounds.right + offsetWidth * 0.5, viewBounds.top);
			}
			if (offsetHeight)
			{
				viewBounds.update(viewBounds.left, viewBounds.bottom - offsetHeight / 2, 
					viewBounds.right, viewBounds.top + offsetHeight / 2);
			}
			return this.getAdjustedBounds2(viewBounds);
		}
		
		private function getAdjustedBounds2(bounds:Rectangle2D) : Rectangle2D
		{
			var center:Point2D = bounds.center;			
			var res:Number;	
			if (this._resolutions && this._resolutions.length > 0)
			{
				var closestObj:Object = TileUtil.getClosestResolutionAndLevel(this.width, this.height, bounds.width, bounds.height, this._resolutions);
				if(!isNaN(closestObj.resolution) ||　closestObj.resolution < 0)
				{
					res = this.clipResolutionWithReslutions(closestObj.resolution, closestObj.level);
					
				}
			}
			else
			{
				res = this.clipResolution( Math.max(bounds.width / this.width, bounds.height / this.height));
			}
			if(!isNaN(res) && res > 0)
			{
				var halfMapGeoWidth:Number = this.width *0.5 * res;
				var halfMapGeoHeight:Number = this.height * 0.5 * res;
				bounds.update(center.x - halfMapGeoWidth, center.y - halfMapGeoHeight, center.x + halfMapGeoWidth, center.y + halfMapGeoHeight);
			}						
			return bounds;
		}
		
		private function moveAndResize() : void
		{		
			this._dummyContainer.x = 0;
			this._dummyContainer.y = 0;
			this._dummyContainer.width = this.width;
			this._dummyContainer.height = this.height;
			
			if(this._mapAnimation == null)
			{
				this._mapAnimation = new Parallel(this._dummyContainer);
				this._mapResize = new Resize();
				this._mapMove = new Move();
				this._mapAnimation.addChild(this._mapResize);
				this._mapAnimation.addChild(this._mapMove);
				this._mapAnimation.addEventListener(EffectEvent.EFFECT_START, this.mapAnimationStartHandler);
				this._mapResize.addEventListener(EffectEvent.EFFECT_UPDATE, this.mapAnimationUpdateHandler);
				this._mapMove.addEventListener(EffectEvent.EFFECT_UPDATE, this.mapAnimationUpdateHandler);
				this._mapAnimation.addEventListener(EffectEvent.EFFECT_END, this.mapAnimationEndHandler);
				
			}
			else
			{
				this._mapAnimation.end();
			}
			
			var left:Number = this.mapToScreenX2(this.endViewBounds.left);
			var right:Number = this.mapToScreenX2(this.endViewBounds.right);
			var bottom:Number = this.mapToScreenY2(this.endViewBounds.bottom);
			var top:Number = this.mapToScreenY2(this.endViewBounds.top);
			var halfWidth:Number = (right + left) * 0.5;
			var halfHeight:Number = (bottom + top) * 0.5;
			
			this._mapResize.widthFrom = this.width;
			this._mapResize.heightFrom = this.height;
			this._mapResize.widthTo = this.width * this.width / (right - left);
			this._mapResize.heightTo = this.height * this.height / (bottom - top);
			
			var widthRatio:Number = this._mapResize.widthTo / this._mapResize.widthFrom;		
			var offsetWidth:Number = (halfWidth - this.width * 0.5) * widthRatio;
			var offsetHeight:Number = (halfHeight - this.height * 0.5) * widthRatio;
			
			this._mapMove.xFrom = 0;
			this._mapMove.yFrom = 0;
			this._mapMove.xTo = (this._mapResize.widthFrom - this._mapResize.widthTo) * 0.5 - offsetWidth;
			this._mapMove.yTo = (this._mapResize.heightFrom - this._mapResize.heightTo) * 0.5 - offsetHeight;
			
			this._mapAnimation.duration = this.zoomDuration;
			this._mapAnimation.play();
		}
		
		
		
		private function panMap() : void
		{
			var rect:Rectangle = this._layerContainer.scrollRect;
			var center:Point2D = this._viewBounds.center;
			var xPixel:Number = this.mapToScreenX2(center.x);
			var yPixel:Number = this.mapToScreenY2(center.y);
			var xFrom:Number = rect.x;
			var yFrom:Number = rect.y;
			var xBy:Number = xPixel - width * 0.5;
			var yBy:Number = yPixel - height * 0.5;
			var xTo:Number = xFrom + xBy;
			var yTo:Number = yFrom + yBy;
			var time:int = getTimer();
			var enterFrameHandler:Function;
			
			enterFrameHandler = function (event:Event) : void
			{
				var duration:int = getTimer() - time;
				if (duration >= panDuration)
				{
					removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
					layerContainer.updateScrollRect(xTo, yTo);
					dispatchPanEnd(-xBy, -yBy);
				}
				else
				{
					var durationRatio:Number = duration / panDuration;
					var newX:Number = xFrom + xBy * durationRatio;
					var newY:Number = yFrom + yBy * durationRatio;
					layerContainer.updateScrollRect(newX, newY);
					dispatchPanUpdate(newX, newY, xFrom, yFrom);
				}
			}
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			this.dispatchPanStart(0, 0);
			this.isPanning = false;
		}
		
		/**
		 * ${mapping_Map_method_collectionChangeHandler_D} 
		 * @param event ${mapping_Map_method_collectionChangeHandler_param_event}
		 * 
		 */		
		protected function collectionChangeHandler(event:CollectionEvent) : void
		{
			switch(event.kind)
			{
				case CollectionEventKind.ADD:
				{
					this.collectionAddHandler(event);
					break;
				}
				case CollectionEventKind.MOVE:
				{
					this.collectionMoveHandler(event);
					break;
				}
				case CollectionEventKind.REFRESH:
				case CollectionEventKind.RESET:
				{
					this.collectionRefreshAndResetHandler();
					break;
				}
				case CollectionEventKind.REMOVE:
				{
					this.collectionRemoveHandler(event);
					break;
				}
				case CollectionEventKind.REPLACE:
				{
					this.collectionReplaceHandler(event);
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		private function addLayer2(layer:Layer, index:int) : void
		{
			//临时加入
			if(layer.hasOwnProperty("markers"))
			{
				if(!this._markersLayer)
					this._markersLayer = layer;
			}
			
			if (layer.id == null)
			{
				layer.id = NameUtil.createUniqueName(layer);
			}
			index = Math.min(index, this._layerContainer.numChildren);
			if (!this._layerContainer.contains(layer))
			{
				this._layerContainer.addChildAt(layer, index);
				
			}
			//todo:暂时先注释，还没有想清楚
			//			if (index && index == this._layerContainer.numChildren)
			//			{
			//				index = index - 1;
			//			}
			
			if (this.baseLayer == null)
			{
				this.baseLayer = layer;
				if (this.baseLayer.loaded)
				{
					this.baseLayerLoadHandler(new LayerEvent(LayerEvent.LOAD, this.baseLayer));
				}
				else
				{
					layer.addEventListener(LayerEvent.LOAD, this.baseLayerLoadHandler, false, 999);
				}
			}
			else if (layer.loaded)
			{
				this.layerLoadHandler(new LayerEvent(LayerEvent.LOAD, layer));
			}
			else
			{
				layer.addEventListener(LayerEvent.LOAD, this.layerLoadHandler, false, 999);
			}
			dispatchEvent(new MapEvent(MapEvent.LAYER_ADD, this, layer, index));
		}
		
		private function baseLayerLoadHandler(event:LayerEvent) : void
		{
			var layer:Layer = event.layer;
			layer.removeEventListener(LayerEvent.LOAD, this.baseLayerLoadHandler);
			//如果加入的第一个图层的投影信息为空，则创建一个wkid为0的CRS，其实就是没有投影信息
			if(event.layer.CRS == null)
			{
				this._CRS = new CoordinateReferenceSystem();
			}
			else
			{
				this._CRS = layer.CRS;
			}		
			dispatchEvent(new Event(CRS_CHANGE));
			if (this._bounds == null)
			{
				this.setBounds(layer.bounds.clone());
			}
			if (this._viewBounds == null)
			{
				this._viewBounds = this._bounds.clone();
			}
			
			if(layer.isScaleCentric)
			{
				this.scaleConvertion();
			}
			
			if (layer is TiledCachedLayer)
			{
				var tempResolutions:Array = TiledCachedLayer(layer).resolutions;
				var tempScales:Array = TiledCachedLayer(layer).scales;
				
				if(tempScales && tempScales.length)
				{
					if(this.scales == null)
					{
						this.scales = tempScales;
					}
					else
					{
						this.scales = this.scales.concat(tempScales);
					}
				}
				if(this.resolutions == null)
				{
					this.resolutions = tempResolutions;
				}	
				else
				{
					this.resolutions = this.resolutions.concat(tempResolutions);
				}
			}	
			this._baseLayerLoaded = true;			
			this.checkIfCompleteAndBaseLayerLoaded();
		}
		
		private function layerLoadHandler(event:LayerEvent) : void
		{
			var layer:Layer = event.layer;
			layer.removeEventListener(LayerEvent.LOAD, this.layerLoadHandler);
			if (this._loaded)
			{
				layer.setMap(this);				
			}
			if(layer.isScaleCentric)
			{
				this.scaleConvertion();
			}
		}
		
		private function collectionAddHandler(event:CollectionEvent) : void
		{
			var layer:Layer = null;
			for each (layer in event.items)
			{			
				this.addLayer2(layer, event.location);
			}
		}
		
		private function collectionMoveHandler(event:CollectionEvent) : void
		{
			var layer:Layer = null;
			for each (layer in event.items)
			{
				
				this.reorderLayer2(layer, event.location);
			}
		}
		
		private function collectionRefreshAndResetHandler() : void
		{
			var layer:Layer = null;
			if(this.layerContainer.numChildren)
				this.removeAllLayers2();
			for each (layer in this._layers)
			{			
				this.addLayer2(layer, this._layerContainer.numChildren);
			}
		}
		
		private function collectionRemoveHandler(event:CollectionEvent) : void
		{
			var layer:Layer = null;
			for each (layer in event.items)
			{		
				this.removeLayer2(layer);
			}
		}
		
		private function collectionReplaceHandler(event:CollectionEvent) : void
		{
			var new_layer:Layer = Layer(PropertyChangeEvent(event.items[0]).newValue);
			this.addLayer2(new_layer, event.location);
			var old_layer:Layer = Layer(PropertyChangeEvent(event.items[0]).oldValue);
			if (old_layer)
			{
				this.removeLayer2(old_layer);
			}
		}
		
		
		//触摸完毕
		sm_internal function pinchEndHandler() : void
		{
			var oldVB:* = this.oldViewBounds;
			this.endViewBounds = this.getAdjustedBounds(this._viewBounds);
			this.mapAnimationEndHandler(null);
			this.oldViewBounds = oldVB;
			this.animateViewBounds = false;
			this.viewBounds = this.endViewBounds;
		}
		
		//触摸开始
		sm_internal function pinchStartHandler() : void
		{
//			this.endViewBounds = this.viewBounds;
//			if (this.isPanning)
//			{
				if(this._mapAction is Pan)
				{
					var pan:Pan = this._mapAction as Pan;
					pan.stopPanning();
				}
				else
				{
					this.dispatchPanEnd(this.mouseX, this.mouseY);
				}
//			}
			
			this.isTweening = true;
			
			this._dummyContainer.x = 0;
			this._dummyContainer.y = 0;
			this._dummyContainer.width = this.width;
			this._dummyContainer.height = this.height;
			
			if(this._mapAnimation == null)
			{
				this._mapAnimation = new Parallel(this._dummyContainer);
				this._mapResize = new Resize();
				this._mapMove = new Move();
				this._mapAnimation.addChild(this._mapResize);
				this._mapAnimation.addChild(this._mapMove);
				this._mapAnimation.addEventListener(EffectEvent.EFFECT_START, this.mapAnimationStartHandler);
				this._mapResize.addEventListener(EffectEvent.EFFECT_UPDATE, this.mapAnimationUpdateHandler);
				this._mapMove.addEventListener(EffectEvent.EFFECT_UPDATE, this.mapAnimationUpdateHandler);
				this._mapAnimation.addEventListener(EffectEvent.EFFECT_END, this.mapAnimationEndHandler);
				
			}
			else
			{
				this._mapAnimation.end();
			}
			this.mapAnimationStartHandler(null);
			
		}
		
		sm_internal function pinchUpdateHandler(scale:Number, px:Number, py:Number) : void
		{
			var factor1:Number = (px - this._dummyContainer.x) / this._dummyContainer.width;
			var factor2:Number = (py - this._dummyContainer.y) / this._dummyContainer.height;
			
			this._dummyContainer.width = this._dummyContainer.width * scale;
			this._dummyContainer.height = this._dummyContainer.height * scale;
			this._dummyContainer.x = px - this._dummyContainer.width * factor1;
			this._dummyContainer.y = py - this._dummyContainer.height * factor2;
			
			this.mapAnimationUpdateHandler(null);
		}
		
		sm_internal function dispatchPanEnd(x:Number, y:Number, dispatchViewBoundsChange:Boolean = true) : void
		{
			this.isTweening = false;
			this.isPanning = false;
			this._viewBounds = this.endViewBounds;
			this.oldViewBounds = this.endViewBounds;
			dispatchEvent(new PanEvent(PanEvent.PAN_END, this._viewBounds, new Point(x, y)));
			if (dispatchViewBoundsChange)
			{
				dispatchEvent(new ViewBoundsEvent(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this._viewBounds, false, this.resolution));
			}
		}
		
		sm_internal function dispatchPanStart(x:Number, y:Number) : void
		{
			this.isTweening = true;
			this.isPanning = true;
			this._viewBounds = this.oldViewBounds;
			dispatchEvent(new PanEvent(PanEvent.PAN_START, this.oldViewBounds, new Point(x, y)));
			dispatchEvent(new ViewBoundsEvent(ViewBoundsEvent.VIEW_BOUNDS_UPDATE, this._viewBounds));
		}
		
		sm_internal function dispatchPanUpdate(xFrom:Number, yFrom:Number, xTo:Number, yTo:Number) : void
		{
			var offset:Point = new Point(xTo - xFrom, yTo - yFrom);
			this._viewBounds = new Rectangle2D(this.oldViewBounds.left - offset.x / this._ratioW, 
				this.oldViewBounds.bottom + offset.y / this._ratioH, 
				this.oldViewBounds.left + this.oldViewBounds.width - offset.x / this._ratioW,
				this.oldViewBounds.bottom + this.oldViewBounds.height + offset.y / this._ratioH);
			dispatchEvent(new ViewBoundsEvent(ViewBoundsEvent.VIEW_BOUNDS_UPDATE, this._viewBounds));
			dispatchEvent(new PanEvent(PanEvent.PAN_UPDATE, this._viewBounds, offset));
		}
		
		private function mapAnimationStartHandler(event:EffectEvent) : void
		{			
			var zoomEvent:ZoomEvent = new ZoomEvent(ZoomEvent.ZOOM_START);
			zoomEvent.x = this._dummyContainer.x;
			zoomEvent.y = this._dummyContainer.y;
			zoomEvent.width = this._dummyContainer.width;
			zoomEvent.height = this._dummyContainer.height;
			zoomEvent.viewBounds = this.oldViewBounds;
			zoomEvent.zoomFactor = 1;
			zoomEvent.level = this.level;
			this._viewBounds = this.oldViewBounds;
			dispatchEvent(new ViewBoundsEvent(ViewBoundsEvent.VIEW_BOUNDS_UPDATE, this._viewBounds));
			dispatchEvent(zoomEvent);
		}
		
		private function mapAnimationUpdateHandler(event:EffectEvent) : void
		{
			var zoomEvent:ZoomEvent = new ZoomEvent(ZoomEvent.ZOOM_UPDATE);
			zoomEvent.x = this._dummyContainer.x;
			zoomEvent.y = this._dummyContainer.y;
			zoomEvent.width = this._dummyContainer.width;
			zoomEvent.height = this._dummyContainer.height;
			zoomEvent.viewBounds = this.calcViewBoundsFromComponent();
			zoomEvent.zoomFactor = this._dummyContainer.width / this.width;
			this._viewBounds = zoomEvent.viewBounds;
			dispatchEvent(new ViewBoundsEvent(ViewBoundsEvent.VIEW_BOUNDS_UPDATE, this._viewBounds));
			dispatchEvent(zoomEvent);
		}
		
		private function mapAnimationEndHandler(event:EffectEvent) : void
		{
			this.isTweening = false;
			this._viewBounds = this.endViewBounds;//多点触摸的时候 这里endViewBounds的值有问题 这个值
			this.oldViewBounds = this.endViewBounds;
			var zoomEvent:ZoomEvent = new ZoomEvent(ZoomEvent.ZOOM_END);
			zoomEvent.x = this._dummyContainer.x;
			zoomEvent.y = this._dummyContainer.y;
			zoomEvent.width = this._dummyContainer.width;
			zoomEvent.height = this._dummyContainer.height;
			zoomEvent.viewBounds = this._viewBounds;
			zoomEvent.zoomFactor = this._dummyContainer.width / this.width;
			zoomEvent.level = this.level;
			dispatchEvent(zoomEvent);
			dispatchEvent(new ViewBoundsEvent(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this._viewBounds, this._levelChange, this.resolution));
			//trace("--------------------mapAnimationEndHandler-----------------" + this._viewBounds + "this.level:" + this.level)
			//trace("layerContainerEndHandler:" + this.layerContainer.x + " " + this.layerContainer.y + " " + this.layerContainer.width + " " + this.layerContainer.height);
		}
		
		
		private function removeAllLayers2() : void
		{
			this._layerContainer.removeAllLayers();
			this.resetMapStatus();
			dispatchEvent(new MapEvent(MapEvent.LAYER_REMOVE_ALL, this));
		}
		
		private function removeLayer2(layer:Layer) : void
		{
			this._layerContainer.removeLayer(layer);
			if(!this._layerContainer.numChildren)
			{
				this.resetMapStatus();
			}
				
			else if(layer is TiledCachedLayer)
			{
				var removedLayerResolutions:Array = (layer as TiledCachedLayer).resolutions;
				for(var i:int = 0; i < removedLayerResolutions.length; i++)
				{
					var res:Number = removedLayerResolutions[i];
					if(this.resolutions)
					{
						var index:int = this.resolutions.indexOf(res);
						if(index > -1)
							this.resolutions.splice(index,1);
					}
				}
				var layersLength:int = this._layers.length;
				for(var j:int = 0; j < layersLength; j++)
				{
					var comparedLayer:Layer = this._layers.getItemAt(j) as Layer;
					if(comparedLayer is TiledCachedLayer && comparedLayer != layer)
					{
						if(this._resolutions)
						{
							var combinedResolutions:Array = this._resolutions.concat((comparedLayer as TiledCachedLayer).resolutions);
							this.resolutions = combinedResolutions;
						}
					}
				}
			}
		}
		
		private function reorderLayer2(layer:Layer, index:int) : void
		{
			if (index >= this._layerContainer.numChildren)
			{
				index = this._layerContainer.numChildren - 1;
			}
			this._layerContainer.setChildIndex(layer, index);
			dispatchEvent(new MapEvent(MapEvent.LAYER_MOVE, this, layer, index));
		}
		
		private function showHandler(event:FlexEvent) : void
		{
			this.refresh();
		}
		
		private function viewBoundsChangedHandler(event:ViewBoundsEvent) : void
		{
			this._mouseWheelChangePending = false;	
		}
		private function commitViewBounds() : void
		{
			this._ratioW = width / this._viewBounds.width;
			this._ratioH = height / this._viewBounds.height;
			this.endViewBounds = this._viewBounds.clone();
			if (this._commitViewBoundsCalled == false)
			{
				this._commitViewBoundsCalled = true;
				this.oldViewBounds = this.endViewBounds;
			}
			var oldWidth:Number = this.oldViewBounds.width;
			var newWidth:Number = this._viewBounds.width;
			var oldHeight:Number = this.oldViewBounds.height;
			var newHeight:Number = this._viewBounds.height;
			if (MathUtil.numsAreClose(oldWidth, newWidth) && MathUtil.numsAreClose(oldHeight, newHeight))
			{
				if(this._commitViewBoundsCalled)
				{
					this._levelChange = false;
				}
				else
				{
					this._levelChange = true;
				}		
			}
			else 
			{
				this._levelChange = true;
			}
			
			if (this._levelChange)
			{
				if (this.animateViewBounds)
				{
					this.isTweening = true;
					this.moveAndResize();
				}
				else
				{
					this.oldViewBounds = this.endViewBounds;
					dispatchEvent(new ViewBoundsEvent(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this._viewBounds, this._levelChange, this.resolution));
					
				}
			}
			else
			{
				if (this.animateViewBounds)
				{
					if (!this.oldViewBounds.intersects(this._viewBounds))
					{
						this.animateViewBounds = false;
					}
				}
				if (this.animateViewBounds)
				{
					this.isTweening = true;
					this.panMap();
				}
				else
				{
					var left:Number = this.mapToScreenX2(this._viewBounds.left);
					var top:Number = this.mapToScreenY2(this._viewBounds.top);
					this._layerContainer.updateScrollRectDelta(left, top);
					this.oldViewBounds = this.endViewBounds;
					//viewbounds除了平移，缩放可以修改，直接赋值也可以修改，此派发需要打开
					dispatchEvent(new ViewBoundsEvent(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this._viewBounds, this._levelChange, this.resolution));
				}
			}
			this.animateViewBounds = true;
		}
		
		private function getResolution() : Number
		{
			if (this.viewBounds != null)
			{
				return this.viewBounds.width / width;
			}
			return 0;
		}
		
		private function resetMapStatus() : void
		{
			this.baseLayer = null;
			this._baseLayerLoaded = false;
			this._loaded = false;
			this._bounds = null;
			this._viewBounds = null;
			this.oldViewBounds = null;
			this.endViewBounds = null;
			this.resolutions = null;
			this.scales = null;				
			this._level = -1;
			this._commitViewBoundsCalled = false;
			this._mapLoadEventWasDispatched = false;
			this.animateViewBounds = false;		
			this. _levelChange = false;
			
			this._resolution = 0;
			this._maxResolution = NaN;
			this._minResolution = NaN;	
			this._isMaxResolutionSet = false;
			this._isMinResolutionSet = false;
			
			this._scale = 0;
			this._maxScale = NaN;
			this._minScale = NaN;	
			this._isMaxScaleSet = false;
			this._isMinScaleSet = false;
			this._scalesConvertDone = false;
			this._minScaleConvertDone = false;
			this._maxScaleConvertDone = false;
			
			//this.action = null;
		}
		
		private function clipResolution(resolution:Number) : Number
		{
			var res:Number = resolution;
			if (!isNaN(this._minResolution) && this._minResolution > 0)
			{
				res = Math.max(resolution, this._minResolution);
			}
			if (!isNaN(this._maxResolution) && this._maxResolution > 0)
			{
				res = Math.min(res, this._maxResolution);
			}
			if (res < MathUtil.DBL_EPSILON)
			{
				res = MathUtil.DBL_EPSILON;
			}
			return res;
		}
		
		private function clipResolutionWithReslutions(resolution:Number, level:int) : Number
		{
			var res:Number = resolution;
			if (!isNaN(this._minResolution) && this._minResolution > 0)
			{
				while(res < this._minResolution)
				{
					if(level == 0)
					{
						return this.resolutions[0];
					}
					res = this.resolutions[--level];
				}
			}
			if (!isNaN(this._maxResolution) && this._maxResolution > 0)
			{
				while(res > this._maxResolution)
				{
					res = this.resolutions[++level];
				}
			}
			return res;
		}
		
		private function scaleConvertion() : void
		{
			var _dpi:Number = this.dpi;
			if(!isNaN(_dpi) && _dpi != 0)
			{
				if (!this._maxScaleConvertDone && this._isMaxScaleSet && !this._isMinResolutionSet)
				{
					if(this.isIServer2DPI)
						this.minResolution = ScaleUtil.scaleToResolution(this._maxScale, _dpi, null);
					else if(this.CRS)
						this.minResolution = ScaleUtil.scaleToResolution(this._maxScale, _dpi, this.CRS.unit, this.CRS.datumAxis);
					else
						this.minResolution = ScaleUtil.scaleToResolution(this._maxScale, _dpi);
					this._maxScaleConvertDone = true;
				}
				
				if (!this._minScaleConvertDone && this._isMinScaleSet && !this._isMaxResolutionSet)
				{
					if(this.isIServer2DPI)
						this.maxResolution = ScaleUtil.scaleToResolution(this._minScale, _dpi, null);
					else if(this.CRS)
						this.maxResolution = ScaleUtil.scaleToResolution(this._minScale, _dpi, this.CRS.unit, this.CRS.datumAxis);
					else
						this.maxResolution = ScaleUtil.scaleToResolution(this._minScale, _dpi);
					this._minScaleConvertDone = true;
					
				}
				
				if(!this._scalesConvertDone && this._scales && this._scales.length >0)
				{
					if(this.isIServer2DPI)
						this.resolutions = ScaleUtil.scalesToResolutions(this._scales, _dpi, null);
					else if(this.CRS)
						this.resolutions = ScaleUtil.scalesToResolutions(this._scales, _dpi, this.CRS.unit, this.CRS.datumAxis);
					else
						this.resolutions = ScaleUtil.scalesToResolutions(this._scales, _dpi);
					this._scalesConvertDone = true;
				}
			}
			else
			{
				if (!this._maxScaleConvertDone && this._isMaxScaleSet && !this._isMinResolutionSet)
				{
					this.minResolution = ScaleUtil.scaleToResolutionWithoutDPI(this._maxScale, this);
					this._maxScaleConvertDone = true;
				}
				
				if (!this._minScaleConvertDone && this._isMinScaleSet && !this._isMaxResolutionSet)
				{
					this.maxResolution = ScaleUtil.scaleToResolutionWithoutDPI(this._minScale, this);
					this._minScaleConvertDone = true;
				}
				
				if(!this._scalesConvertDone && this._scales && this._scales.length >0)
				{
					this.resolutions = ScaleUtil.scalesToResolutionsWithoutDPI(this._scales, this);
					this._scalesConvertDone = true;
				}
			}
			
		}
	}
}