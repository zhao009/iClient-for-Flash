package com.supermap.web.mapping
{   
	import com.supermap.web.core.Element;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.events.ElementsLayerEvent;
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.events.MapEvent;
	import com.supermap.web.events.PanEvent;
	import com.supermap.web.events.ViewBoundsEvent;
	import com.supermap.web.events.ZoomEvent;
	import com.supermap.web.mapping.supportClasses.LayerContainer;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	
	use namespace sm_internal; 
	
	/**
	 * ${mapping_FeatureLayer_Event_featureAdd_D} 
	 */	
	[Event(name="elementAdd", type="com.supermap.web.events.ElementsLayerEvent")]
	/**
	 * ${mapping_FeatureLayer_Event_featureRemove_D} 
	 */	
	[Event(name="elementRemove", type="com.supermap.web.events.ElementsLayerEvent")]
	/**
	 * ${mapping_FeatureLayer_Event_updateEnd_D} 
	 */	
	[Event(name="featureRemoveAll", type="com.supermap.web.events.ElementsLayerEvent")]
	/**
	 * ${mapping_FeatureLayer_Event_updateEnd_D} 
	 */	
	[Event(name="elementsChange", type="com.supermap.web.events.ElementsLayerEvent")]
	
	//	[Event(name="elementBoundChange", type="com.supermap.web.events.ElementsLayerEvent")]
	//	[Event(name="elementComponentChange", type="com.supermap.web.events.ElementsLayerEvent")]
	
	[IconFile("/designIcon/ElementsLayer.png")]
	[DefaultProperty("elements")]
	/**
	 * ${mapping_ElementsLayer_Title}.
	 * <p>${mapping_ElementsLayer_Description}</p> 
	 * @see com.supermap.web.core.Element
	 * 
	 */	
	public class ElementsLayer extends Layer
	{
		private var _elements:ArrayCollection;  
		private var _map:Map;   
		private var _screenBox:Rectangle = new Rectangle();
		private var _isViewportClip:Boolean = true;
		private var _isElementsZoomWithMap:Boolean = false;
		private var _elementsCache:Array;
		
		private var _graduatedElements:Array = [];
		private var _graduatedCount:int = 1;
		sm_internal var hashTableIDs:Hashtable;
		
		private var _isDrawedElements:Boolean;
		private var _isPanEnableOnElement:Boolean = false; 
		
		private var _isAutoAvoidance:Boolean = false;
		private var _referenceWidth:Number = 0;
		private var _referenceHeight:Number = 0;
		private var _referenceR:Number = 0;
		
		private var _isAvoidByPixel:Boolean = false;
		
		private var isIntersect:Boolean;
		private var isGetNewBounds:Boolean;
		private var boundsCollection:Array;
		
		/**
		 * ${mapping_ElementsLayer_constructor_None_D} 
		 * 
		 */		
		public function ElementsLayer()
		{
			super();
			this._elements = new ArrayCollection(); 
			hashTableIDs = new Hashtable();
			this._elements.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler); 
			this.addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			this.addEventListener(ElementsLayerEvent.ELEMENT_CHANGE, elementUpdateHandler);
			//			this.addEventListener(ElementsLayerEvent.ELEMENT_COMPONENT_CHANGE, elementComponentChangeHandler);
			
		}
		
		/**
		 * ${mapping_ElementsLayer_attribute_isAutoAvoidance_D} 
		 * @return 
		 * 
		 */		
		public function get isAutoAvoidance():Boolean
		{
			return _isAutoAvoidance;
		}
		
		public function set isAutoAvoidance(value:Boolean):void
		{
			_isAutoAvoidance = value;
		}
		
		/**
		 * ${mapping_ElementsLayer_attribute_isPanEnableOnElement_D} 
		 * @return 
		 * 
		 */		
		public function get isPanEnableOnElement():Boolean
		{
			return _isPanEnableOnElement;
		}
		
		public function set isPanEnableOnElement(value:Boolean):void
		{
			_isPanEnableOnElement = value;
		}
		
		/**
		 * ${mapping_ElementsLayer_attribute_graduatedCount_D}.
		 * <p>${mapping_ElementsLayer_attribute_graduatedCount_remarks}</p> 
		 * @see #elements
		 * @return 
		 * 
		 */		
		public function get graduatedCount():int
		{
			return _graduatedCount;
		}
		
		public function set graduatedCount(value:int):void
		{
			_graduatedCount = value;
		}
		
		/**
		 * ${mapping_ElementsLayer_attribute_isViewportClip_D}.
		 * <p>${mapping_ElementsLayer_attribute_isViewportClip_remarks}</p> 
		 * @default true
		 * @return 
		 * 
		 */
		public function get isViewportClip():Boolean
		{
			return _isViewportClip;
		}
		
		public function set isViewportClip(value:Boolean):void
		{
			_isViewportClip = value;
		}
		
		/**
		 * ${mapping_ElementsLayer_attribute_isElementsZoomWithMap_D}
		 * @default false
		 * @return 
		 * 
		 */
		public function get isElementsZoomWithMap():Boolean
		{
			return _isElementsZoomWithMap;
		}
		
		public function set isElementsZoomWithMap(value:Boolean):void
		{
			_isElementsZoomWithMap = value;
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function addMapListeners() : void
		{ 
			super.addMapListeners();
			if(this.map)
			{
				this.map.addEventListener(PanEvent.PAN_START, panStartHandler);
				this.map.addEventListener(PanEvent.PAN_END, panEndHandler); 
				this.map.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, viewBoundsChangeHandler); 
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function removeMapListeners():void
		{
			super.removeMapListeners();
			if(this.map)
			{
				this.map.removeEventListener(PanEvent.PAN_START, panStartHandler);
				this.map.removeEventListener(PanEvent.PAN_END, panEndHandler);
				this.map.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, viewBoundsChangeHandler); 
			}
		}
		
		private function panStartHandler(event:PanEvent):void
		{
			if(this._isViewportClip)
			{
				super.zoomStartHandler(new ZoomEvent(ZoomEvent.ZOOM_END));
				this._elementsCache = [];
				var count:int = numChildren;
				var child:DisplayObject;
				for (var index:int = 0; index < count; index++)
				{
					child = getChildAt(index) as DisplayObject;			 
					if (child && child.visible)
					{ 
						this._elementsCache[index] = child;
						child.visible = false;
					}
				}
			}
		}
		
		private function viewBoundsChangeHandler(event:ViewBoundsEvent):void
		{ 
			if(this._isViewportClip)
			{
				this.clearBitMapData();
			}
			this.restoreElements();
		}
		
		private function panEndHandler(event:PanEvent):void
		{ 
			if(this._isViewportClip)
			{
				this.clearBitMapData();
			}
			this.restoreElements();
		}
		
		private function elementUpdateHandler(event:ElementsLayerEvent):void
		{
			//			if(event.isBoundsChange && !event.isComponentChange)
			//			{
			//				this.setLayerMap();
			//				this.drawComponent(event.element); 
			//			}
			//			else
			//			{
			//				var index:int = event.elementIndex;
			//				var element:Element = event.element;
			//				this.elements.setItemAt(element, index);
			//				this.drawComponent(element); 	
			//			}
			this.setLayerMap();
			this.drawComponent(event.element); 
		}
		
		private function loadHandler(event:LayerEvent):void
		{
			var collectionEvent:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, false, CollectionEventKind.REFRESH);
			this._elements.dispatchEvent(collectionEvent);
		}
		
		private function creationCompleteHandler(event:FlexEvent):void
		{
			removeEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			setLoaded(true);
			
			this.addEventListener(ElementsLayerEvent.ELEMENT_SIZE_CHANGE, reDrawHandler);
		}
		
		private function reDrawHandler(event:ElementsLayerEvent):void
		{
			var el:Element = event.element;
			this.drawComponent(el);
		}
		
		private function collectionChangeHandler(event:CollectionEvent):void
		{
			dispatchEvent(event); 
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
		
		private function setLayerMap():void
		{
			if(this.map == null)
			{
				if(this.parent)
				{
					_map = (this.parent as LayerContainer).map; 
					this._map.addEventListener(MapEvent.LOAD, mapLoadHander);
				} 
				else
				{  
					this.addEventListener(LayerEvent.LOAD , loadHandler);
				}
			}
			else
			{
				_map = this.map; 
				this._map.addEventListener(MapEvent.LOAD, mapLoadHander);
			}  
			
		}
		
		private function mapLoadHander(event:MapEvent):void
		{  
			var collectionEvent:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE, false, false, CollectionEventKind.REFRESH);
			this._elements.dispatchEvent(collectionEvent);
		}
		
		private function collectionAddHandler(event:CollectionEvent):void
		{  
			var wrapper:Element; 
			var items:Array = event.items as Array;
			var index:int = event.location;
			this.setLayerMap();
			for each(wrapper in items)
			{ 
				var child:DisplayObject = (wrapper as Element).component; 
				if(child.height == 0){
					child.height = 20;
				}
				if(child.width == 0){
					child.width = 20;
				}
				super.addChildAt(child, index);
				addHashTableIDs(wrapper);
				this.drawComponent(wrapper); 
			}
		}
		
		//增加id键值对到哈希表
		private function addHashTableIDs(element:Element):void
		{
			var elementID:String = element.id;
			if(elementID && !this.hashTableIDs.containsKey(elementID))
			{
				this.hashTableIDs.add(elementID, element);
			}
		}
		
		//移除id键值对从哈希表
		private function removeHashTableIDs(element:Element):void
		{
			var elementID:String = element.id;
			if(elementID && !this.hashTableIDs.containsKey(elementID))
			{
				this.hashTableIDs.remove(elementID);
			}
		}		
		
		private function drawComponent(element:Element):void
		{    
			var rect2D:Rectangle2D = element.bounds;
			var offset:Point = element.offset;
			
			if(_map)
			{  
				_screenBox.left = _map.mapToContainerX(rect2D.left);
				_screenBox.right = _map.mapToContainerX(rect2D.right);
				_screenBox.top = _map.mapToContainerY(rect2D.top);
				_screenBox.bottom = _map.mapToContainerY(rect2D.bottom); 
			} 
			var component:DisplayObject = element.component;
			if(_screenBox.width != 0 && _screenBox.height != 0)
			{ 
				if(!this.isElementsZoomWithMap)
				{
					component.x = (_screenBox.left + _screenBox.right) * 0.5 - component.width * 0.5 + offset.x;
					component.y = (_screenBox.top + _screenBox.bottom) * 0.5 - component.height * 0.5 + offset.y;  
				} 
				else
				{
					var width:Number = _screenBox.right - _screenBox.left;
					var height:Number = _screenBox.bottom - _screenBox.top; 
					component.x = _screenBox.left + offset.x;
					component.y = _screenBox.top + offset.y;
					component.width = width; 
					component.height = height;   
				} 
			}
			else if(_screenBox.width == 0 || _screenBox.height == 0)
			{ 
				//有修改
				component.x = (_screenBox.left + _screenBox.right) * 0.5 - component.width * 0.5 + offset.x;
				component.y = (_screenBox.top + _screenBox.bottom) * 0.5 - component.height * 0.5 + offset.y;  
			}
			
			addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
		}
		
		/**
		 * ${mapping_ElementsLayer_method_enterFrameHandler_D} 
		 * @param event
		 * 
		 */		
		protected function enterFrameHandler(event:Event) : void
		{
			removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
			dispatchEvent(new LayerEvent(LayerEvent.UPDATE_END, this, null, true));		
		}
		
		private function collectionMoveHandler(event:CollectionEvent):void
		{
			var wrapper:DisplayObject;
			for each (wrapper in event.items)
			{
				setChildIndex(wrapper, event.location);
			}
		}
		
		private function collectionRefreshAndResetHandler():void
		{   
			var wrapper:Element;
			removeAllChildren();
			this.setLayerMap();
			
			var addElements:Array = this._elements.source;
			
			if(addElements.length == 0 && this.hashTableIDs.size)
			{
				this.hashTableIDs.clear();
			}
			
			if(this._graduatedCount != 1)
			{
				var internalNum:int = this._elements.length / this._graduatedCount;
				
				for(var i:int = 0; i < this._graduatedCount; i++)
				{
					var partElements:Array = addElements.slice((i * internalNum), (internalNum * ( i + 1)));
					this._graduatedElements.push(partElements);
				}
				
				addElements = this._graduatedElements.shift();
				this.addEventListener(Event.ENTER_FRAME, this.addElementsFrameHandler);
			}
			
			
			for each (wrapper in addElements)
			{	
				var component:DisplayObject = wrapper.component; 
				super.addChild(component);
				this.addHashTableIDs(wrapper);
				this.drawComponent(wrapper); 
			}
		}
		
		private function addElementsFrameHandler(event:Event):void
		{
			if(this._graduatedElements && this._graduatedElements.length)
			{
				var addElements:Array = this._graduatedElements.shift();
				var wrapper:Element;
				for each (wrapper in addElements)
				{	
					var component:DisplayObject = wrapper.component; 
					super.addChild(component);
					this.addHashTableIDs(wrapper);
					this.drawComponent(wrapper); 
				}
			}
			else
			{
				this.removeEventListener(Event.ENTER_FRAME, this.addElementsFrameHandler);
			}
		}
		
		private function collectionRemoveHandler(event:CollectionEvent):void
		{
			var wrapper:Element;
			for each (wrapper in event.items)
			{
				super.removeChild(wrapper.component);
				this.removeHashTableIDs(wrapper);
			} 
		}
		
		private function collectionReplaceHandler(event:CollectionEvent):void
		{
			var propertyEvent:PropertyChangeEvent = PropertyChangeEvent(event.items[0]);
			var newWrapper:Element = propertyEvent.newValue as Element;//这里有问题？
			if(newWrapper && newWrapper.component)
			{
				super.addChildAt(newWrapper.component, event.location);			
			}
			this.addHashTableIDs(newWrapper);			
			var oldWrapper:Element = propertyEvent.oldValue as Element;
			if (oldWrapper && oldWrapper.component)
			{
				super.removeChild(oldWrapper.component);				
				this.removeHashTableIDs(oldWrapper);
			} 
		}
		
		/**
		 * ${mapping_ElementsLayer_method_moveElement_D} 
		 * @param element ${mapping_ElementsLayer_method_moveElement_param_element}
		 * @param index ${mapping_ElementsLayer_method_moveElement_param_index}
		 * @see #elements
		 * 
		 */		
		public function moveElement(element:Element, index:int):void
		{			
			try
			{
				this._elements.removeItemAt(this.getElementIndex(element));
				this._elements.addItemAt(element, index);
			}
			catch(error:SmError)			
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}			
		}
		
		/**
		 * ${mapping_ElementsLayer_method_moveFeatureAt_D} 
		 * @param fromIndex ${mapping_ElementsLayer_method_moveFeatureAt_param_fromIndex}
		 * @param toIndex ${mapping_ElementsLayer_method_moveFeatureAt_param_toIndex}
		 * 
		 */		
		public function moveElementAt(fromIndex:int, toIndex:int):void
		{			
			try
			{ 
				var object:Object = this._elements.removeItemAt(fromIndex);
				var element:Element = object ? (object as Element) : null;
				this._elements.addItemAt(element, toIndex);
			}
			catch(error:SmError)			
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}		
		}
		
		/**
		 * ${mapping_ElementsLayer_method_moveToTop_D} 
		 * @param element ${mapping_ElementsLayer_method_moveToTop_param_elements}
		 * @see #elements
		 * 
		 */		
		public function moveToTop(element:Element):void
		{
			var index:int = this.numChildren - 1; 
			if (this.getElementIndex(element) != index)
			{
				this.setChildIndex(element.component, index);
			}
		}
		
		/**
		 * ${mapping_ElementsLayer_attribute_elements_D} 
		 * @see com.supermap.web.core.Element
		 * @return 
		 * 
		 */		
		public function get elements():ArrayCollection
		{
			return _elements;
		}
		
		public function set elements(value:ArrayCollection):void
		{
			if(this._elements != value)
			{
				_elements.source = value.source;
				this.dispatchEvent(new ElementsLayerEvent(ElementsLayerEvent.ELEMENTS_CHANGE, null));
			}
		}
		
		/**
		 * ${mapping_ElementsLayer_attribute_numElements_D} 
		 * @return 
		 * 
		 */		
		public function get numElements():int
		{
			return this._elements.length;
		}
		
		private var _bounds:Rectangle2D;
		private var originalBoundsArr:Array = new Array();
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override public function get bounds():Rectangle2D
		{
			if(this._bounds)
			{
				return this._bounds;
			}
			var wrapper:Element;
			var bounds:Rectangle2D = new Rectangle2D();
			var count:int = this._elements.length;
			if(count > 0)
			{
				bounds = (this._elements[0] as Element).bounds;
			}
			for(var i:int = 1; i < count; i++)
			{
				var bUnion:Rectangle2D = (this._elements[i] as Element).bounds;
				if(bounds.isEmpty() && bUnion.isEmpty())
				{
					bounds = bounds.unionXY(bUnion.left, bUnion.bottom);
				}
				else if(bounds.isEmpty() && !bUnion.isEmpty())
				{
					bounds = bUnion.unionXY(bounds.left, bounds.bottom);
				}
				else if(!bounds.isEmpty() && !bUnion.isEmpty())
				{
					bounds = bounds.union(bUnion);
				}
				else
				{
					bounds = bounds.unionXY(bUnion.left, bUnion.bottom);
				}
			}
			return bounds;
		}
		
		override public function set bounds(value:Rectangle2D):void
		{
			this._bounds = value;
		}
		/**
		 * ${mapping_ElementsLayer_method_addComponent_D}.
		 * <p>${mapping_ElementsLayer_method_addComponent_remarks}</p> 
		 * @param component ${mapping_ElementsLayer_method_addComponent_param_component}
		 * @param bBox ${mapping_ElementsLayer_method_addComponent_param_bBox}
		 * @param offset ${mapping_ElementsLayer_method_addComponent_param_offset}
		 * @return ${mapping_ElementsLayer_method_addComponent_return}
		 * 
		 */		
		public function addComponent(component:DisplayObject, bBox:Rectangle2D,offset:Point = null):String
		{   
			try{
				var e:Element = new Element(component, bBox);
				if(offset != null)
				{
					e.offset = offset;
				}
				this._elements.addItem(e);
			}catch(error:Error)
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}
			if(this.hasEventListener(ElementsLayerEvent.ELEMENT_ADD))
			{
				this.dispatchEvent(new ElementsLayerEvent(ElementsLayerEvent.ELEMENT_ADD, e));	
			}
			return e.id;
		}
		
		/**
		 * ${mapping_ElementsLayer_method_addComponentAt_D}.
		 * <p>${mapping_ElementsLayer_method_addComponentAt_remarks}</p> 
		 * @param component ${mapping_ElementsLayer_method_addComponentAt_param_component}
		 * @param index ${mapping_ElementsLayer_method_addComponentAt_param_index}
		 * @param bBox ${mapping_ElementsLayer_method_addComponentAt_param_bBox}
		 * @param offset ${mapping_ElementsLayer_method_addComponentAt_param_offset}
		 * @return ${mapping_ElementsLayer_method_addComponentAt_return}
		 * @see #elements
		 * 
		 */		  
		public function addComponentAt(component:DisplayObject, index:int, bBox:Rectangle2D,offset:Point = null):String
		{
			
			try{
				var e:Element = new Element(component, bBox);
				if(offset != null)
				{
					e.offset = offset;
				}
				this._elements.addItemAt(e, index); 
			}catch(error:Error)
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}
			if(this.hasEventListener(ElementsLayerEvent.ELEMENT_ADD))
			{
				this.dispatchEvent(new ElementsLayerEvent(ElementsLayerEvent.ELEMENT_ADD, e));	
			}
			return e.id;
		}
		
		/**
		 * ${mapping_ElementsLayer_method_addElement_D} 
		 * @param element ${mapping_ElementsLayer_method_addElement_param_element}
		 * @return ${mapping_ElementsLayer_method_addElement_return}
		 * 
		 */		
		public function addElement(element:Element):String
		{
			this._elements.addItem(element); 
			if(this.hasEventListener(ElementsLayerEvent.ELEMENT_ADD))
			{
				this.dispatchEvent(new ElementsLayerEvent(ElementsLayerEvent.ELEMENT_ADD, element));	
			} 
			return element.id;	
		}
		
		//		public function addElementsByArray(elements:Array):void
		//		{
		//			var length:int = elements.length;
		//			for(var i:int = 0; i < length; i++)
		//			{
		//				var element:Element = elements[i];
		//				this._elements.addItem(element);
		//			} 
		//		}
		
		/**
		 * ${mapping_ElementsLayer_method_addElementAt_D} 
		 * @param element ${mapping_ElementsLayer_method_addElementAt_param_element}
		 * @param index ${mapping_ElementsLayer_method_addElementAt_param_index}
		 * @return ${mapping_ElementsLayer_method_addElementAt_return}
		 * 
		 */		
		public function addElementAt(element:Element, index:int):String
		{ 
			this._elements.addItemAt(element, index); 
			if(this.hasEventListener(ElementsLayerEvent.ELEMENT_ADD))
			{
				this.dispatchEvent(new ElementsLayerEvent(ElementsLayerEvent.ELEMENT_ADD, element));	
			} 
			return element.id;	
		}
		
		/**
		 * @private 
		 * @param child
		 * @return 
		 * 
		 */		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			return null;
		}
		
		/**
		 * @private 
		 * @param child
		 * @param index
		 * @return 
		 * 
		 */		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			return null;
		}
		
		/**
		 * @private 
		 * @param child
		 * @return 
		 * 
		 */		
		override public function removeChild(child:DisplayObject):DisplayObject
		{ 
			return super.removeChild(child);
		}
		
		/**
		 * @private 
		 * @param index
		 * @return 
		 * 
		 */		
		override public function removeChildAt(index:int):DisplayObject
		{
			return super.removeChildAt(index);  
		}
		
		/**
		 * ${mapping_ElementsLayer_method_clear_D} 
		 * 
		 */		
		public function clear():void
		{
			if(this._elements.length)
			{
				this._elements.removeAll(); 
				this.hashTableIDs.clear();
				dispatchEvent(new ElementsLayerEvent(ElementsLayerEvent.ELEMENT_REMOVE_ALL, null));
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function zoomStartHandler(event:ZoomEvent):void
		{
			super.zoomStartHandler(event);
			this._elementsCache = [];
			var count:int = numChildren;
			var child:DisplayObject;
			for (var index:int = 0; index < count; index++)
			{
				child = getChildAt(index) as DisplayObject;			 
				if (child && child.visible)
				{ 
					_elementsCache[index] = child;
					child.visible = false;
				}
			}
		}
		
		//	添加对元素的剪裁处理，平移或缩放后只是更新当前显示范围内的元素       yld  5-27	
		private function drawClipElements():void
		{
			var count:int = numChildren;
			var bContained:Boolean = true;
			var element:Element;
			var elementBounds:Rectangle2D;
			var clipRect:Rectangle2D;
			clipRect = map.viewBounds;
			this.boundsCollection = new Array();
			this.originalBoundsArr = new Array();
			for each(element in this._elements)
			{		
				if(!element)
				{
					continue;
				}	
				
				if(this._isViewportClip)
				{
					elementBounds = element.bounds;
					if(elementBounds.width && elementBounds.height)
						bContained = clipRect.intersects(elementBounds);
					else
						bContained = clipRect.contains(elementBounds.left, elementBounds.bottom);
					element.component.visible = bContained;
				}
				
				// 添加是否自动避让判断
				if(this.isAutoAvoidance && bContained)
				{
					if (isSamePoint(element.originalBounds.bottomLeft, element.originalBounds.topRight))
					{
						var ewidth:Number = element.component.width * this.resolution;
						var eheight:Number = element.component.height * this.resolution;
						var firstChangeBounds:Rectangle2D = new Rectangle2D(element.originalBounds.left, element.originalBounds.bottom, element.originalBounds.left + ewidth, element.originalBounds.bottom + eheight);
						element.bounds = firstChangeBounds;
						if (this.originalBoundsArr.length < count && element.component.visible)
						{
							this.originalBoundsArr.push(firstChangeBounds.clone());
						}
					}
					else
					{
						ewidth = element.originalBounds.width;
						eheight  = element.originalBounds.height;
					}
					element.bounds = isBoundsChange(element.bounds, this.referenceWidth, this.referenceHeight, this.referenceR);
					if (this.isIntersect)
					{
						if (this.isGetNewBounds)
						{
							element.component.visible = true;
							this.boundsCollection.push(element.bounds);
						}
						else
						{
							element.component.visible = false;
						}
					}
					else
					{
						element.component.visible = true;
						this.boundsCollection.push(element.bounds);
					}
				}
				
				if(bContained)
				{
					this.drawComponent(element); 
				}
			}
		}
		
		/**
		 * 判断两个点位置是否相同
		 */
		private function isSamePoint(point1:Point2D, point2:Point2D):Boolean
		{
			if (point1.x === point2.x && point1.y === point2.y)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		//比较计算后bounds和每个bounds的相交
		private function computeIntersectWithAll(bounds:Rectangle2D):Boolean
		{
			var boundsCollection:Array = this.boundsCollection;
			var originalBoundsArray:Array = this.originalBoundsArr;
			var flag:int = 0;
			for each (var item:Rectangle2D in boundsCollection)
			{
				if (item != null)
				{
					if (bounds.intersects(item))
					{
						return true;
					}
				}
			}
			for each (var item1:Rectangle2D in originalBoundsArray)
			{
				if (item1 != null)
				{
					if (bounds.intersects(item1))
					{
						return true;
					}
				}
			}
			return false;
		}
		
		private function isBoundsChange(bounds:Rectangle2D,ewidth:Number, eheight:Number, radius:Number):Rectangle2D
		{
			var rwidth:Number;
			var rheight:Number;
			var rradius:Number;
			if (isAvoidByPixel)
			{
				rwidth = this.resolution * ewidth;
				rheight = this.resolution * eheight;
				rradius = this.resolution * radius;
			}
			else
			{
				rwidth = ewidth;
				rheight = eheight;
				rradius = radius;
			}
			//初始化要修改的范围
			this.isIntersect = false;
			this.isGetNewBounds = false;
			var newBounds:Rectangle2D = new Rectangle2D();
			for (var i:int = 0; i < 8; i++)
			{
				switch (i)
				{
					case 0:
						newBounds = new Rectangle2D(bounds.left + rwidth / 2, bounds.bottom + rradius + rheight, bounds.right + rwidth / 2, bounds.top + rradius + rheight);
						break;
					case 1:
						newBounds = new Rectangle2D(bounds.left + rwidth / 2 + rradius, bounds.bottom, bounds.right + rwidth / 2 + rradius, bounds.top);
						break;
					case 2:
						newBounds = new Rectangle2D(bounds.left + rwidth / 2, bounds.bottom - rradius - rheight, bounds.right + rwidth / 2, bounds.top - rradius - rheight);
						break;
					case 3:
						newBounds = new Rectangle2D(bounds.left, bounds.bottom - rradius - rheight, bounds.right, bounds.top - rradius - rheight);
						break;
					case 4:
						newBounds = new Rectangle2D(bounds.left - rwidth / 2, bounds.bottom - rradius - rheight, bounds.right - rwidth / 2, bounds.top - rradius - rheight);
						break;
					case 5:
						newBounds = new Rectangle2D(bounds.left - rwidth / 2 - rradius, bounds.bottom, bounds.right - rwidth / 2 - rradius, bounds.top);
						break;
					case 6:
						newBounds = new Rectangle2D(bounds.left - rwidth / 2, bounds.bottom + rradius + rheight, bounds.right - rwidth / 2, bounds.top + rradius + rheight);
						break;
					case 7:
						newBounds = new Rectangle2D(bounds.left, bounds.bottom + rradius + rheight, bounds.right, bounds.top + rradius + rheight);
						break;
				}
				
				if (computeIntersectWithAll(newBounds))
				{
					isIntersect = true;
					continue;
				}
				else
				{
					isGetNewBounds = true;
					return newBounds;
				}
			}
			return bounds;
		}
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */		
		override protected function zoomEndHandler(event:ZoomEvent):void
		{
			super.zoomEndHandler(event);
			this.restoreElements();
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function draw() : void
		{
			if(this._isDrawedElements)
			{
				this._isDrawedElements = false;
			}
			else if(this._elements && this._elements.length)
			{
				this.drawClipElements();
			}
			
		}
		
		private function restoreElements():void
		{
			var component:DisplayObject; 
			this.graphics.clear();
			this.setLayerMap();
			// 缩放后，只把缩放前可视性变为false的元素变为可视，而不是所有元素   yld 2011-5-27
			for each(component in this._elementsCache)
			{ 
				if(!component.visible)
				{
					component.visible = true; 
				}
			}	 
			if(this.visible)
			{
				_isDrawedElements = true;
				this.drawClipElements();
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
			this.restoreElements();
		}
		/**
		 * ${mapping_ElementsLayer_method_getElementAt_D} 
		 * @param index ${mapping_ElementsLayer_method_getElementAt_param_index}
		 * @return ${mapping_ElementsLayer_method_getElementAt_return}
		 * 
		 */		
		public function getElementAt(index:int):Element
		{
			var element:Element;
			if(this._elements)
			{
				try
				{
					var object:Object = this._elements.getItemAt(index);
					element = object ? (object as Element) : null;
				}
				catch(error:Error)
				{
					throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
				}
			}
			return element;
		}
		
		/**
		 * ${mapping_ElementsLayer_method_getElementByID_D} 
		 * @param id ${mapping_ElementsLayer_method_getElementByID_param_id}
		 * @return ${mapping_ElementsLayer_method_getElementByID_return_Element}
		 * 
		 */		
		public function getElementByID(id:String):Element
		{
			var element:Element = null;
			if(id && this.hashTableIDs.containsKey(id))
			{
				element = this.hashTableIDs.find(id) as Element;
				if(element.id == id)
				{
					return element;
				}		
				else 
					element = null;
			}
			return element;
		}
		
		/**
		 * ${mapping_ElementsLayer_method_getElementIndex_D} 
		 * @param element ${mapping_ElementsLayer_method_getElementIndex_param_element}
		 * @return ${mapping_ElementsLayer_method_getElementIndex_return}
		 * @see #elements
		 * 
		 */		
		public function getElementIndex(element:Element):int
		{
			return this.getComponentIndex(element.id);
		}
		
		private function getComponentIndex(id:String):int
		{
			for(var i:int; i < this._elements.length; i++)
			{
				if(id == (this._elements[i] as Element).id)
				{
					return i;
				}
			}
			return -1;
		}
		
		/**
		 * ${mapping_ElementsLayer_method_removeElement_D} 
		 * @param component ${mapping_ElementsLayer_method_removeElement_param_component}
		 * @return ${mapping_ElementsLayer_method_removeElement_return}
		 * 
		 */		
		public function removeElement(element:Element):Element//change by zyn 0531
		{				
			return this.removeElementAt(getElementIndex(element));
		}
		
		/**
		 * ${mapping_ElementsLayer_method_removeElementAt_D} 
		 * @param index ${mapping_ElementsLayer_method_removeElementAt_param_index}
		 * @return ${mapping_ElementsLayer_method_removeElementAt_return}
		 * @see #elements
		 * 
		 */		
		public function removeElementAt(index:int):Element
		{			
			var element:Element = null;
			if(this._elements)
			{
				try
				{				
					var object:Object = this._elements.removeItemAt(index);
					element = object ? (object as Element) : null;
					if(this.hasEventListener(ElementsLayerEvent.ELEMENT_REMOVE))
					{
						dispatchEvent(new ElementsLayerEvent(ElementsLayerEvent.ELEMENT_REMOVE, element));
					}
				}
				catch(error:Error)
				{
					throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
				}
			}
			return element; 
		}
		
		/**
		 * ${mapping_ElementsLayer_attribute_referenceWidth_D} 
		 * @return 
		 * 
		 */	
		public function get referenceWidth():Number
		{
			return _referenceWidth;
		}
		
		public function set referenceWidth(value:Number):void
		{
			_referenceWidth = value;
			this._referenceR = 0.7 * value;
		}
		
		/**
		 * ${mapping_ElementsLayer_attribute_referenceHeight_D} 
		 * @return 
		 * 
		 */	
		public function get referenceHeight():Number
		{
			return _referenceHeight;
		}
		
		public function set referenceHeight(value:Number):void
		{
			_referenceHeight = value;
		}
		
		/**
		 * ${mapping_ElementsLayer_attribute_referenceR_D} 
		 * @return 
		 * 
		 */	
		public function get referenceR():Number
		{
			return _referenceR;
		}
		
		public function set referenceR(value:Number):void
		{
			_referenceR = value;
		}
		
		/**
		 * ${mapping_ElementsLayer_attribute_isAvoidByPixel_D} 
		 * @return 
		 * 
		 */
		public function get isAvoidByPixel():Boolean
		{
			return _isAvoidByPixel;
		}
		
		public function set isAvoidByPixel(value:Boolean):void
		{
			_isAvoidByPixel = value;
		}
		
		
	} 
}