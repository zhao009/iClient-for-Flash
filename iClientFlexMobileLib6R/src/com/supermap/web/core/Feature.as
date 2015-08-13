package com.supermap.web.core
{
//	import com.supermap.web.clustering.SparkElementStyle;
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.core.styles.*;
	import com.supermap.web.mapping.FeaturesLayer;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.MathUtil;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.core.IDataRenderer;
	import mx.core.IFactory;
	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	import mx.utils.NameUtil;

	
	use namespace sm_internal;
	
	/**
	 * ${core_Feature_Title}.
	 * <p>${core_Feature_Description}</p> 
	 * 
	 * 
	 */	
	public class Feature extends UIComponent
	{
		//用来标记是否因为视口裁剪而把visible设为false
		sm_internal var bDisvisibleFromNotContained:Boolean = false;
		private var _geometry:Geometry;
		private var _style:Style;
		private var _attributes:Object;
		
		private var _fields:Array;
		
		private var _lastStyle:Style;
		private var _source:Object;
		private var _autoMoveToTop:Boolean = true;
		sm_internal var _invalidateGraphicFlag:Boolean = false;
		private var _factory:IFactory;
		private var _infoWindowRendererInstance:Object;
		private var _maxVisibleResolution:Number = 0;
		private var _minVisibleResolution:Number = 0;	
		private var _checkForMouseListenersEnabled:Boolean = true;
		private var _isRealtimeRefresh:Boolean = false;
//		private var _sparkElementStyle:SparkElementStyle = null;
		private var _isAddToLayer:Boolean;
		
		private var _visible:Boolean = true;
		/**
		 * ${core_Feature_constructor_D} 
		 * @param geometry ${core_Feature_constructor_param_geometry}
		 * @param style ${core_Feature_constructor_param_style}
		 * @param attributes ${core_Feature_constructor_param_attributes}
		 * 
		 */		
		public function Feature(geometry:Geometry = null, style:Style = null, attributes:Object = null)
		{
			this._lastStyle = NoopStyle.instance;
			if(geometry)
				this.geometry = geometry; 
			else
				this._geometry = geometry;
			
			if(style)
				this.style = style; 
			else
				this._style = style;
			
			if(attributes)
				this.attributes = attributes; 
			else
				this._attributes = attributes;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
			//featureslayer里面设置visible属性都用setVisible，这样就不会派发事件，故而  showHandler不会执行
			// yld 2011-7-1
			this.addEventListener(FlexEvent.SHOW, this.showHandler);
			this.addEventListener(Event.ADDED, this.addedHandler);
			this.addEventListener(Event.REMOVED, this.removedHandler);	
			this.id = NameUtil.createUniqueName(this);
		}
		
		sm_internal function getFeatureSuperVisible():Boolean
		{
			return super.visible;
		}
		
		public override function get visible():Boolean
		{
			return this._visible;
		}
		
		public override function set visible(value:Boolean):void
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
			}
		}
		
		sm_internal function removeStyleChangeListener():void
		{
			if (this._style)
			{
				this._style.removeEventListener(Event.CHANGE, this.style_changeHandler);
			}
		}
		
		sm_internal function get fields():Array
		{
			return _fields;
		}
		
		sm_internal function set fields(value:Array):void
		{
			_fields = value;
		}
		
		/**
		 * ${core_Feature_attribute_clusterElementStyle_D}.
		 * <p>${core_Feature_attribute_clusterElementStyle_remarks}</p> 
		 * @return 
		 * @see com.supermap.web.clustering.Clusterer
		 * @see com.supermap.web.clustering.SparkClusterStyle
		 * 
		 */		
//		public function get sparkElementStyle():SparkElementStyle
//		{
//			return _sparkElementStyle;
//		}
//		
//		public function set sparkElementStyle(value:SparkElementStyle):void
//		{
//			_sparkElementStyle = value;
//		}
		
		/**
		 * ${core_Feature_attribute_isRealtimeRefresh_D} 
		 * @return 
		 * 
		 */		
		public function get isRealtimeRefresh():Boolean
		{
			return _isRealtimeRefresh;
		}
		
		public function set isRealtimeRefresh(value:Boolean):void
		{
			_isRealtimeRefresh = value;
		}
		
		/**
		 * 获取当前Feature的显示分辨率，用于Style，byzyn 
		 * @return 
		 * 
		 */		
		sm_internal function getcurrentResoltuion():Number
		{
			return this.featuresLayer.map.resolution;
		}
		
		sm_internal function get source():Object
		{
			return _source;
		}
		
		sm_internal function set source(value:Object):void
		{
			_source = value;
		}
		
		/**
		 * ${core_Feature_attribute_autoMoveToTop_D} 
		 * 
		 */		
		public function get autoMoveToTop():Boolean
		{
			return _autoMoveToTop;
		}
		public function set autoMoveToTop(value:Boolean):void
		{
			var oldValue:Boolean=this._autoMoveToTop;
			if(this._autoMoveToTop!=value)
			{
				this._autoMoveToTop = value;
				if (this._autoMoveToTop)
				{
					addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
				}
				else
				{
					removeEventListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
				}
				if(this.hasEventListener("propertyChange"))
				{					
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"autoMoveToTop",oldValue,value));
				}
			}
		}
		
		/**
		 * ${core_Feature_attribute_attributes_D} 
		 * @return 
		 * 
		 */		
		public function get attributes():Object
		{
			return _attributes;
		}
		public function set attributes(value:Object):void
		{
			if (this._attributes is IEventDispatcher)
			{
				IEventDispatcher(this._attributes).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.attributes_changeHandler);
			}
			this._attributes = value;
			if (this._attributes is IEventDispatcher)
			{
				IEventDispatcher(this._attributes).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, this.attributes_changeHandler, false, 0, true);
			}
			this.dispatchChangeEvent();
			if(_isAddToLayer)
				this.refresh();
		}
		
		
		/**
		 * ${core_Feature_attribute_checkForMouseListenersEnabled_D}.
		 * <p>${core_Feature_attribute_checkForMouseListenersEnabled_remarks}</p> 
		 * @default true
		 * @return 
		 * 
		 */		
		public function get checkForMouseListenersEnabled() : Boolean
		{
			return this._checkForMouseListenersEnabled;
		}
		
		public function set checkForMouseListenersEnabled(value:Boolean) : void
		{
			if (this.checkForMouseListenersEnabled != value)
			{
				var old_value:Boolean = this.checkForMouseListenersEnabled;
				this._checkForMouseListenersEnabled = value;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "checkForMouseListenersEnabled", old_value, value));
				}
			}
		}
		
		/**
		 * ${core_Feature_attribute_featuresLayer_D} 
		 * 
		 */		
		public function get featuresLayer():FeaturesLayer	
		{
			if(parent is FeaturesLayer)
			{
				return parent as FeaturesLayer;
			}
			return null;
			
		}
		
		/**
		 * ${core_Feature_attribute_infoWindowRenderer_D} 
		 * @return 
		 * 
		 */		
		public function get infoWindowRenderer():IFactory
		{
			return this._factory;
		}
		public function set infoWindowRenderer(value:IFactory) : void
		{
			var arguments:IFactory = this.infoWindowRenderer;
			if (arguments !== value)
			{
				if (this._factory)
				{
					removeEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
				}
				this._factory = value;
				this._infoWindowRendererInstance = null;
				if (this._factory)
				{
					addEventListener(MouseEvent.MOUSE_DOWN, this.mouseDownHandler);
				}
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "infoWindowRenderer", arguments, value));
				}
			}			
		}
		
		/**
		 * ${core_Feature_method_isInResolutionRange_D} 
		 * @return 
		 * 
		 */		
		public function get isInResolutionRange() : Boolean
		{ 
			var bInResolutionRange:Boolean = true;
			var fl:FeaturesLayer = this.featuresLayer;
			if (fl)
			{	
				bInResolutionRange = MathUtil.isInResolutionRange(fl.map.resolution, this._minVisibleResolution, this._maxVisibleResolution);
			}	
			return bInResolutionRange;
		}
		
		/**
		 * ${core_Feature_attribute_maxVisibleResolution_D} 
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
				this.dispatchChangeEvent();
				if(_isAddToLayer)
					this.refresh();
			}
		}
		
		/**
		 * ${core_Feature_attribute_minVisibleResolution_D} 
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
				this.dispatchChangeEvent();
				this.refresh();
			}
		}
		
		private function attributes_changeHandler(event:PropertyChangeEvent):void
		{
			this.refresh();
		}
		
		private function geometryChangeHandler(event:Event):void
		{					
			this.refresh();
		}
		
		private function mouseOverHandler(event:MouseEvent):void
		{
			if(parent is FeaturesLayer && this.autoMoveToTop && FeaturesLayer(parent).isFeatureMouseOver)
			{
				FeaturesLayer(parent).moveToTop(this);
			}
		}
		
		private function mouseDownHandler(event:MouseEvent):void
		{
			this.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
		}
		
		private function mouseMoveHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
			this.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
		}
		
		private function mouseUpHandler(event:MouseEvent):void
		{
//			var map:Map = null;
//			this.removeEventListener(MouseEvent.MOUSE_MOVE, this.mouseMoveHandler);
//			this.removeEventListener(MouseEvent.MOUSE_UP, this.mouseUpHandler);
//			var featuresLayer:FeaturesLayer = parent as FeaturesLayer;
//			if (featuresLayer && featuresLayer.map)
//			{
//				if (this._infoWindowRendererInstance == null)
//				{
//					this._infoWindowRendererInstance = this._factory.newInstance();
//				}
//				if (this._infoWindowRendererInstance is IDataRenderer)
//				{
//					IDataRenderer(this._infoWindowRendererInstance).data = this._attributes;
//				}
//				if (this._infoWindowRendererInstance.hasOwnProperty("dataProvider"))
//				{
//					this._infoWindowRendererInstance["dataProvider"] = this._attributes;
//				}
//				if (this._infoWindowRendererInstance is IFeatureRenderer)
//				{
//					IFeatureRenderer(this._infoWindowRendererInstance).feature = this;
//				}
//				if (this._infoWindowRendererInstance is UIComponent)
//				{
//					map = featuresLayer.map;
//					map.infoWindow.data = this._attributes;
//					map.infoWindow.content = UIComponent(this._infoWindowRendererInstance);
//					if (this.geometry is GeoPoint)
//					{					
//						map.infoWindow.show(this.geometry.bounds.center);
//					}
//					else
//					{
//						map.infoWindow.show(map.stageToMap(new Point(event.stageX, event.stageY)));
//					}
//				}
//			}
		}
		
		//矢量要素添加到featureslayer后，缩放地图，showHandler和featureslayer的draw都会刷新feature，
		//绘制两次要素，draw里面有剪裁判断，所有把showHandler方法暂时注释
		private  function showHandler(event:FlexEvent):void
		{
			this.refresh();
		}
		
		//增加feature并渲染时，首先判断featuresLayer有没有初始化完成  yld 2011-6-8
		private function addedHandler(event:Event):void
		{
			if (event.target === this)
			{
				if(parent is FeaturesLayer)
				{
					var fl:FeaturesLayer = parent as FeaturesLayer;
					if(fl.map)
					{
						this.refresh();	
					}
				}
				
				_isAddToLayer = true;
			}
		}
		sm_internal function invalidateGraphic() : void
		{
			this._invalidateGraphicFlag = true;	
			invalidateProperties();
		}
		
		sm_internal function realtimeValidateGraphic() : void
		{
			//如果feature的isRealtimeRefresh为true，则在这里强制实时刷新
			if(parent is FeaturesLayer)
			{
				var featuresLayer:FeaturesLayer = parent as FeaturesLayer;
				if (this.visible && featuresLayer.visible)
				{
					this._invalidateGraphicFlag = false;	
					var map:Map = featuresLayer.map;			
					if(map)
					{
						this.drawWithStyle(this.getActiveStyle(featuresLayer),featuresLayer.map);	
					}				
				}				
			}			
		}
		
		private function removedHandler(event:Event):void
		{
			var fl:FeaturesLayer = null;
			if (event.target === this)
			{
				fl = parent as FeaturesLayer;
				if (fl)
				{
					this.getActiveStyle(fl).destroy(this);
				}
			}
		}
		
		private function dispatchChangeEvent() : void
		{
			dispatchEvent(new Event(Event.CHANGE));			
		}
		
		/**
		 * ${core_Feature_attribute_style_D} 
		 * @return 
		 * 
		 */		
		public function get style():Style
		{
			return _style;
		}
		
		public function set style(value:Style):void
		{
			if (this._style)
			{
				this._style.removeEventListener(Event.CHANGE, this.style_changeHandler);
			}
			this._style = value;
			if (this._style)
			{
				this._style.addEventListener(Event.CHANGE, this.style_changeHandler, false, 0, true);
			}
			this.dispatchChangeEvent();
			if(_isAddToLayer)
				this.refresh();
			
		}
		
		private function style_changeHandler(event:Event):void
		{
			this.refresh();
		}
		
		/**
		 * ${core_Feature_attribute_geometry_D} 
		 * @return 
		 * 
		 */		
		public function get geometry():Geometry
		{
			return _geometry;
		}
		
		public function set geometry(value:Geometry):void
		{
			if (this._geometry is IEventDispatcher)
			{
				IEventDispatcher(this._geometry).removeEventListener(Event.CHANGE, this.geometry_changeHandler);
			}
			this._geometry = value;
			if (this._geometry is IEventDispatcher)
			{
				IEventDispatcher(this._geometry).addEventListener(Event.CHANGE, this.geometry_changeHandler, false, 0, true);
			}
			if(this._geometry)
				this._geometry.addEventListener(Geometry.GEOMETRY_CHANGE, geometryChangeHandler);
			this.dispatchChangeEvent();
			if(_isAddToLayer)
				this.refresh();
		}
		
		private function geometry_changeHandler(event:Event) : void
		{
			this.refresh();
		}
		
		/**
		 * @private 
		 * 
		 */		
		protected override function commitProperties():void
		{								
			super.commitProperties();	
			if (this.visible && this._invalidateGraphicFlag && parent && parent.visible)
			{
				this._invalidateGraphicFlag = false;
				if(parent is FeaturesLayer)
				{
					var featuresLayer:FeaturesLayer = parent as FeaturesLayer;
					var map:Map = featuresLayer.map;
					if(map && !map.isTweening && !map.isResizing)
					{
						this.drawWithStyle(this.getActiveStyle(featuresLayer),featuresLayer.map);	
					}
				}
			}		
		}
		
		sm_internal function getActiveStyle(layer:FeaturesLayer):Style
		{
			var style:Style = null;
			if (!this._geometry)
			{
				style = NoopStyle.instance;
			}
			else if (this._style)
			{
				style = this._style;
			}
//			else if (layer.renderer)
//			{
//				style = layer.renderer.getStyle(this);				
//				if (!style)
//				{
//					style = NoopStyle.instance;
//				}
//			}
			else if (layer.style)
			{
				style = layer.style;
			}
			else if (this._geometry)
			{
				style = this._geometry.defaultStyle;
			}
			else
			{
				
				style = NoopStyle.instance;
			}
			return style;
		}
		
		private function drawWithStyle(style:Style, map:Map) : void
		{					
			if(this._lastStyle !== style)
			{
				this._lastStyle.destroy(this);
				this._lastStyle = style;
				this._lastStyle.initialize(this, this.geometry, this.attributes, map);
			}
			style.clear(this);
			if(!this.minVisibleResolution && !this.maxVisibleResolution)
			{
				style.draw(this,this._geometry, this.attributes, map);
			}
			else if(this.isInResolutionRange)
			{
				style.draw(this,this._geometry, this.attributes, map);
			}
		}
		
		/**
		 * ${core_Feature_method_refresh_D} 
		 * 
		 */		
		public function refresh():void
		{
			if(this._isRealtimeRefresh)
			{
				this.realtimeValidateGraphic();
			}
			else
			{
				this.invalidateGraphic();
			}
		}		
		
	}
}