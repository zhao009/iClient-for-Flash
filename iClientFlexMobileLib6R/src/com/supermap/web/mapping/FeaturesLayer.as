package com.supermap.web.mapping
{
//	import com.supermap.web.clustering.Clusterer;
	import com.supermap.web.core.*;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.styles.*;
	import com.supermap.web.events.*;
	import com.supermap.web.mapping.*;
//	import com.supermap.web.rendering.*;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
//	import com.supermap.web.utils.Hashtable;
	
	import flash.display.DisplayObject;
	import flash.events.*;
	import flash.utils.*;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.events.*;
	
	use namespace sm_internal;
	
	/**
	 * ${mapping_FeatureLayer_Event_styleChange_D} 
	 * @see #style
	 */	
	[Event(name="styleChange", type="flash.events.Event")]
	/**
	 * ${mapping_FeatureLayer_Event_featureAdd_D} 
	 */	
	[Event(name="featureAdd", type="com.supermap.web.events.FeatureLayerEvent")]
	/**
	 * ${mapping_FeatureLayer_Event_featureRemove_D} 
	 */	
	[Event(name="featureRemove", type="com.supermap.web.events.FeatureLayerEvent")]
	/**
	 * ${mapping_FeatureLayer_Event_updateEnd_D} 
	 */	
	[Event(name="featureRemoveAll", type="com.supermap.web.events.FeatureLayerEvent")]
	
	[IconFile("/designIcon/FeaturesLayer.png")]
	[DefaultProperty("features")]
	/**
	 * ${mapping_FeatureLayer_Title}. 
	 * <p>${mapping_FeatureLayer_Description}</p>
	 * 
	 */
	public class FeaturesLayer extends Layer
	{
//		private var _clusterer:Clusterer;
		private var _features:ArrayCollection;
		private var _style:Style;
		private var _featuresCache:Array;
//		private var _renderer:Renderer;	
		private var _styleChanged:Boolean;
		private var _bounds:Rectangle2D;
		private var _isRealtimeRefresh:Boolean = false; 
		private var _isViewportClip:Boolean = true;
		private var _isFront:Boolean = true;
		private var _isFeatureMouseOver:Boolean = true;
		private var _isPanEnableOnFeature:Boolean = false; 
		private var _viewBoundsExpandFactor:int = 1;
		sm_internal var viewBoundsExpandFactorChanged:Boolean = false;
		sm_internal var viewBoundsOutPts:Array ;
		//		sm_internal var hashTable:Hashtable = new Hashtable();
		sm_internal var hashTableIDs:Hashtable;
		private const STYLE_CHANGE:String = "styleChange";
		sm_internal var _isDrawedFeatures:Boolean;
		
		
		private var _graduatedFeatures:Array = [];
		private var _graduatedCount:int = 1;
		
		
		/**
		 * ${mapping_FeatureLayer_constructor_None_D} 
		 * 
		 */		
		public function FeaturesLayer()
		{
			this._features = new ArrayCollection();
			hashTableIDs = new Hashtable();
			this._features.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			addEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
		}
		
		/**
		 * ${mapping_FeatureLayer_attribute_graduatedCount_D}.
		 * <p>${mapping_FeatureLayer_attribute_graduatedCount_remarks}</p> 
		 * @default 1
		 * @return 
		 * 
		 */	
		public function get graduatedCount():int
		{
			return _graduatedCount;
		}
		
		public function set graduatedCount(value:int):void
		{
			if(value <= 0 )
				value = 1;
			_graduatedCount = value;
		}
		
		/**
		 * ${mapping_FeatureLayer_attribute_viewBoundsExpandFactor_D}.
		 * <p>${mapping_FeatureLayer_attribute_viewBoundsExpandFactor_remarks}</p> 
		 * @default 1
		 * @return 
		 * 
		 */	
		public function get viewBoundsExpandFactor():int
		{
			return _viewBoundsExpandFactor;
		}
		
		public function set viewBoundsExpandFactor(value:int):void
		{
			if(value)
			{
				var oldValue:Number = this._viewBoundsExpandFactor;
				if(this._viewBoundsExpandFactor !== value)
				{
					this._viewBoundsExpandFactor = value;
					viewBoundsExpandFactorChanged = true;
					this.invalidateLayer();
					if(this.hasEventListener("propertyChange"))
					{
						this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"viewBoundsExpandFactor",oldValue, value));
					}
				}
			}
		}
		
		/**
		 * ${mapping_FeaturesLayer_attribute_isPanEnableOnFeature_D} 
		 * @return 
		 * 
		 */		
		public function get isPanEnableOnFeature():Boolean
		{
			return _isPanEnableOnFeature;
		}
		
		public function set isPanEnableOnFeature(value:Boolean):void
		{
			_isPanEnableOnFeature = value;
		}
		
		/**
		 * ${mapping_FeatureLayer_attribute_isFeatureMouseOver_D}.
		 * <p>${mapping_FeatureLayer_attribute_isFeatureMouseOver_remarks}</p> 
		 * @see com.supermap.web.core.Feature#autoMoveToTop
		 * @default true
		 * @return 
		 * 
		 */		
		public function get isFeatureMouseOver():Boolean
		{
			return _isFeatureMouseOver;
		}
		
		public function set isFeatureMouseOver(value:Boolean):void
		{
			_isFeatureMouseOver = value;
		}
		
		/**
		 * ${mapping_FeatureLayer_attribute_isFront_D}.
		 * <p>${mapping_FeatureLayer_attribute_isFront_remarks}</p> 
		 * @default true
		 * @return 
		 * 
		 */		
		public function get isFront():Boolean
		{
			return _isFront;
		}
		
		public function set isFront(value:Boolean):void
		{
			if(_isFront = true && this._features.length > 1)
			{
				for(var i:int = this._features.length - 1; i >= 0; i--)
				{
					this.moveToTop(this.getFeatureAt(i));
				}
			}
			_isFront = value;			
		}
		
		/**
		 * ${mapping_FeatureLayer_method_creationCompleteHandler_D} 
		 * 
		 */		
		protected function creationCompleteHandler(event:FlexEvent) : void
		{
			removeEventListener(FlexEvent.CREATION_COMPLETE, this.creationCompleteHandler);
			setLoaded(true);
		}
		
		/**
		 * ${mapping_FeaturesLayer_attribute_bounds_D}
		 * @see com.supermap.web.core.geometry.Geometry#bounds
		 * @return 
		 * 
		 */		
		override public function get bounds():Rectangle2D
		{
			if(this._bounds)
			{
				return this._bounds;
			}
			var wrapper:Feature;
			var bounds:Rectangle2D = new Rectangle2D();
			var count:int = this._features.length;
			if(count > 0)
			{
				bounds = this._features[0].geometry.bounds;
			}
			for(var i:int = 1; i < count; i++)
			{
				var bUnion:Rectangle2D = this._features[i].geometry.bounds;
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
			if (!this._bounds || !this._bounds.equals(value))
			{	
				this._bounds = value;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "bounds", this._bounds, value));
				}
			}
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_FeatureLayer_attribute_clusterer_D} 
		 * @see com.supermap.web.clustering.Clusterer
		 * @return 
		 * 
		 */		
//		public function get clusterer() : Clusterer
//		{
//			return this._clusterer;
//		}	
//		public function set clusterer(value:Clusterer) : void
//		{
//			var old_value:Clusterer = this.clusterer;
//			if (old_value !== value)
//			{
//				if (this._clusterer)
//				{
//					this._clusterer.removeEventListener(Event.CHANGE, this.clusterer_changeHandler);
//					this._clusterer.destroy(this);
//				}
//				this._clusterer = value;
//				if (this._clusterer)
//				{
//					this._clusterer.addEventListener(Event.CHANGE, this.clusterer_changeHandler);
//				}
//				
//				invalidateProperties();
//				if (this._features)
//				{
//					this._features.refresh();
//				}				
//			}
//			
//		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_FeatureLayer_attribute_features_D} 
		 * @return 
		 * 
		 */		
		public function get features():Object
		{
			return this._features;
		}
		
		public function set features(value:Object):void
		{
			var features:Array;
			if (this._features)
			{
				this._features.removeEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			}
			
			if (value is Array)
			{
				this._features = new ArrayCollection(value as Array);
			}
			else if (value is ArrayCollection)
			{
				this._features = value as ArrayCollection;
			}
			else
			{
				features = [];
				if (value != null)
				{
					features.push(value);
				}
				this._features = new ArrayCollection(features);
			}
			
			this._features.addEventListener(CollectionEvent.COLLECTION_CHANGE, this.collectionChangeHandler);
			var event:CollectionEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
			event.kind = CollectionEventKind.RESET;
			this.collectionChangeHandler(event);			
		}
		
		/**
		 * ${mapping_FeatureLayer_attribute_isRealtimeRefresh_D} 
		 * @return 
		 * 
		 */		
		public function get isRealtimeRefresh() : Boolean
		{
			return _isRealtimeRefresh;
		}
		public function set isRealtimeRefresh(value:Boolean) : void
		{
			if(this._isRealtimeRefresh != value)
			{
				this._isRealtimeRefresh = value;
				if(this._isRealtimeRefresh)
				{
					this.addMapPanListeners();
				}
				else
				{
					this.removeMapPanListeners();
				}
			}
		}
		
		/**
		 * ${mapping_FeatureLayer_attribute_isViewportClip_D}.
		 * <p>${mapping_FeatureLayer_attribute_isViewportClip_remarks}</p> 
		 * @default true
		 * @return 
		 * 
		 */		
		public function get isViewportClip() : Boolean
		{
			return _isViewportClip;
		}
		public function set isViewportClip(value:Boolean) : void
		{
			this._isViewportClip = value;
		}
		
		
		/**
		 * ${mapping_FeatureLayer_attribute_numFeatures_D} 
		 * @return 
		 * 
		 */		
		public function get numFeatures():int
		{
			return this._features.length;
		}
		
		
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${mapping_FeatureLayer_method_style_D}.
		 * <p>${mapping_FeatureLayer_method_style_remarks}</p> 
		 * @see #renderer
		 * @see com.supermap.web.core.Feature #style
		 * @return 
		 * 
		 */		
		public function get style():Style
		{
			return this._style;
		}
		
		public function set style(value:Style):void
		{
			if (this._style !== value)
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
				invalidateProperties();
				dispatchEvent(new Event(STYLE_CHANGE));
			}
		}
		
		/**
		 * @inheritDoc
		 * 
		 */		
		override protected function removeMapListeners() : void
		{
			super.removeMapListeners();
			this.removeMapPanListeners();
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function addMapListeners() : void
		{
			super.addMapListeners();
			this.addMapPanListeners();
		}
		
		//		override protected function viewBoundsChangedHandler(event:ViewBoundsEvent) : void
		//		{
		//			
		//		}
		
		//仍然重写draw方法，不过此方法只执行一次,且在layer在没有加到map里面时，添加要素会调用
		// yld 2011-6-8
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function draw() : void
		{
			if(this._isDrawedFeatures)
			{
				this._isDrawedFeatures = false;
			}
			else if(this._features && this._features.length)
				this.drawFeatures();
			
		}
		/**
		 * @private 
		 * 
		 */		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			if (this._styleChanged || viewBoundsExpandFactorChanged)
			{
				if(this._styleChanged)
					this._styleChanged = false;
				else
					viewBoundsExpandFactorChanged = false;
				this.invalidateGraphicsWithNoSymbol();
			}
			
		}
		
		private function addMapPanListeners() : void
		{
			if(map)
			{
				this.map.addEventListener(PanEvent.PAN_END, panEndHandler); 
				
				if (this._isRealtimeRefresh)
				{
					map.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_UPDATE, this.onPanHandler, false, 0, true);
				}
			}
		}
		
		private function removeMapPanListeners() : void
		{
			if (map)
			{
				this.map.removeEventListener(PanEvent.PAN_END, panEndHandler);
				
				if(this._isRealtimeRefresh)
					map.removeEventListener(ViewBoundsEvent.VIEW_BOUNDS_UPDATE, this.onPanHandler);
			}
		}
		
		//平移结束后调用drawFeatures进行要素更新，不再等待调用draw方法   yld 2011-5-27
		private function panEndHandler(event:PanEvent):void
		{ 
			_isDrawedFeatures = true;
			this.drawFeatures();
		}
		
		private function onPanHandler(event:ViewBoundsEvent) : void
		{
			this.invalidateLayer();
		}
		
		private function style_changeHandler():void
		{
			this.invalidateGraphicsWithNoSymbol();
		}
		
		private function invalidateGraphicsWithNoSymbol():void
		{
			var fea:Feature = null;
			for each (fea in this._features)
			{
				if (fea.style == null)
				{
					fea.invalidateGraphic();
				}
			}
		}
		
		private function collectionChangeHandler(event:CollectionEvent):void
		{
			dispatchEvent(event);
//			if (this._clusterer)
//			{
//				invalidateLayer();
//			}
//			else
//			{
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
//				}
			}
		}
		
		private function clusterer_changeHandler(event:Event) : void
		{
			invalidateLayer();
			
		}
		
		private function collectionAddHandler(event:CollectionEvent):void
		{
			var wrapper:Feature;
			for each (wrapper in event.items)
			{				
				addChildAt(wrapper, event.location);
				//				this.hashTable.add(event.location, wrapper);
				addHashTableIDs(wrapper);
			}
		}
		
		private function collectionMoveHandler(event:CollectionEvent):void
		{
			var wrapper:Feature;
			for each (wrapper in event.items)
			{
				setChildIndex(wrapper, event.location);
			}
		}
		
		//当用户使用features 进行赋值时，可分批显示要素，对数组进行拆分，显示第一批后再显示下一批，通过属性graduatedCount来控制
		//yld 2011-5-27
		private function collectionRefreshAndResetHandler():void
		{
			var wrapper:Feature;
			removeAllChildren();
			var addFeatures:Array = this._features.source;
			
			if(addFeatures.length == 0||this.hashTableIDs.size)
			{
				this.hashTableIDs.clear();
			}
			
			if(this._graduatedCount != 1)
			{
				var internalNum:int = this._features.length / this._graduatedCount;
				
				for(var i:int = 0; i < this._graduatedCount; i++)
				{
					var partFeatures:Array = addFeatures.slice((i * internalNum), (internalNum * ( i + 1)));
					this._graduatedFeatures.push(partFeatures);
				}
				
				addFeatures = this._graduatedFeatures.shift();
				this.addEventListener(Event.ENTER_FRAME, this.addFeaturesFrameHandler);
			}
			
			for each (wrapper in addFeatures)
			{				
				addChild(wrapper);
				addHashTableIDs(wrapper);
			}
		}
		
		private function addFeaturesFrameHandler(event:Event):void
		{
			if(this._graduatedFeatures && this._graduatedFeatures.length)
			{
				var addFeatures:Array = this._graduatedFeatures.shift();
				var wrapper:Feature;
				for each (wrapper in addFeatures)
				{				
					addChild(wrapper);
					addHashTableIDs(wrapper);
				}
			}
			else
			{
				this.removeEventListener(Event.ENTER_FRAME, this.addFeaturesFrameHandler);
			}
		}
		
		private function collectionRemoveHandler(event:CollectionEvent):void
		{
			var wrapper:Feature;
			for each (wrapper in event.items)
			{
				removeChild(wrapper);
				removeHashTableIDs(wrapper);
			}
		}
		
		private function collectionReplaceHandler(event:CollectionEvent):void
		{
			var propertyEvent:PropertyChangeEvent = PropertyChangeEvent(event.items[0]);
			var newWrapper:Feature = Feature(propertyEvent.newValue);
			addChildAt(newWrapper, event.location);
			addHashTableIDs(newWrapper);
			var oldWrapper:Feature = Feature(propertyEvent.oldValue);
			if (oldWrapper)
			{
				removeChild(oldWrapper);
				removeHashTableIDs(oldWrapper);
			}
		}
		
		//增加id键值对到哈希表
		private function addHashTableIDs(feature:Feature):void
		{
			var featureID:String = feature.id;
			if(featureID && !this.hashTableIDs.containsKey(featureID))
			{
				this.hashTableIDs.add(featureID, feature);
			}
		}
		
		//移除id键值对从哈希表
		private function removeHashTableIDs(feature:Feature):void
		{
			var featureID:String = feature.id;
			if(featureID && this.hashTableIDs.containsKey(featureID))
			{
				this.hashTableIDs.remove(featureID);
			}
		}			
		
		//不再重写父类layer的draw方法，平移和缩放调用不同的事件响应函数，然后再调用drawFeatures进行更新
		private function drawFeatures():void
		{
//			if (!this._clusterer)
//			{		
				var count:int = numChildren;
				var bContained:Boolean = true;
				var wrapper:Feature;
				var geometry:Geometry;
				var clipRect:Rectangle2D;
				if(this._viewBoundsExpandFactor == 1)
					clipRect = map.viewBounds;
				else
					clipRect = map.viewBounds.expand(this._viewBoundsExpandFactor);
				for each(wrapper in this._features)
				{		
					if(!wrapper)
					{
						continue;
					}					
					if(_isViewportClip)
					{
						geometry = wrapper.geometry;
						if(!geometry){
							continue;
						}
						if(geometry is GeoPoint)
						{
							bContained = clipRect.contains(GeoPoint(geometry).x, GeoPoint(geometry).y);
						}
						else
						{
							bContained = clipRect.intersects(geometry.bounds);
						}
						wrapper.bDisvisibleFromNotContained = (wrapper.visible && !bContained);
						if(wrapper.visible)
							wrapper.setVisible(bContained, true);
						//	wrapper.visible = bContained;
						
					}	
					
					if(bContained && wrapper.visible)
					{
						wrapper.invalidateGraphic();
					}
				}
				
				geometry = null;
				wrapper = null;
				clipRect = null;
//			}
//			else
//			{
//				if(_isViewportClip)
//				{
//					removeAllChildren();
//				}
//				else
//				{
//					super.removeAllChildren();
//				}		
//				var features:Array = this._clusterer.clusterFeatures(this, this._features);
//				var featureItem:Feature;
//				for each (featureItem in features)
//				{			
//					if(!featureItem)
//					{
//						continue;
//					}
//					addChild(featureItem);
//					//addHashTableIDs(featureItem);
//					featureItem.validateNow();
//				}
//			}	
			addEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
		}
		
		/**
		 * ${mapping_FeatureLayer_method_enterFrameHandler_D} 
		 * 
		 */		
		protected function enterFrameHandler(event:Event) : void
		{
			removeEventListener(Event.ENTER_FRAME, this.enterFrameHandler);
			dispatchEvent(new LayerEvent(LayerEvent.UPDATE_END, this, null, true));		
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		protected override function removeAllChildren() : void
		{
			while (numChildren > 0)
			{			
				var obj:DisplayObject = removeChildAt(0);
			}
		}
		
		private function restoreFeatures():void
		{
			var feature:Feature;
			graphics.clear();
			for each (feature in this._featuresCache)
			{
				var sv:Boolean = feature.getFeatureSuperVisible();
				if(sv)
				{
					if(!this.isViewportClip)
					{
						feature.setVisible(true,true);
					}
					else if(this.isViewportClip && !feature.bDisvisibleFromNotContained)
					{
						feature.setVisible(true,true);
					}
				}
			}	
			
			//缩放结束后调用drawFeatures进行要素更新，不再等待调用draw方法   yld 2011-5-27
			this._featuresCache = null;
			if(this.visible)
			{
				this.drawFeatures();
				this._isDrawedFeatures = true;
			}
		}
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */		
		override protected function zoomStartHandler(event:ZoomEvent):void
		{
			if(!map)
				return;
			super.zoomStartHandler(event);
			if(!this._featuresCache)
			{
				this._featuresCache = [];
			}		
			var count:int = numChildren;
			var feature:Feature = null;
			for (var index:int = 0; index < count; index++)
			{
				var obj:Object = getChildAt(index);
				if(obj is Feature)
				{
					feature = obj as Feature;
					if(feature.visible)
					{
						if(!this.isViewportClip)
						{
							this._featuresCache[index] = feature;
							feature.setVisible(false,true);
						}
						else if(this.isViewportClip && !feature.bDisvisibleFromNotContained)
						{
							this._featuresCache[index] = feature;
							feature.setVisible(false,true);
						}
					}
				}
			}
		}
		
		/**
		 * @inheritDoc 
		 * 
		 */		
		override protected function zoomEndHandler(event:ZoomEvent):void
		{
			if(!map)
				return;
			super.zoomEndHandler(event);
			this.restoreFeatures();
		}
		
		override protected function showHandler(event:FlexEvent) : void
		{
		    if(!map)
		     	return;
			super.showHandler(event);
			this.restoreFeatures();
//			var feature:Feature;
//			graphics.clear();
//			for each (feature in this._featuresCache)
//			{
//				if (!(feature.getFeatureSuperVisible()) || (this.isViewportClip && feature.bDisvisibleFromNotContained))
//				{
//					feature.setVisible(true,true);
//				}
//			}	
			
			//缩放结束后调用drawFeatures进行要素更新，不再等待调用draw方法   yld 2011-5-27
//			this._featuresCache = null;
//			this.drawFeatures();
//			this._isDrawedFeatures = true;
		}
		
		//增加派发事件
		/**
		 * ${mapping_FeatureLayer_method_addFeature_D} 
		 * @param feature ${mapping_FeatureLayer_method_addFeature_param_feature}
		 * @see #isFront
		 * @return 
		 * 
		 */		
		public function addFeature(feature:Feature,isfront:Boolean = true):String
		{
			isfront = this.isFront;
			if(isfront)
				this._features.addItem(feature);
			else
				this._features.addItemAt(feature,0);
			
			if(this.hasEventListener(FeatureLayerEvent.FEATURE_ADD))
			{
				dispatchEvent(new FeatureLayerEvent(FeatureLayerEvent.FEATURE_ADD,feature));
			}
			return feature.id;	
		}		
		
		
		//根据索引位置来添加新的feature对象
		/**
		 * ${mapping_FeatureLayer_method_addFeatureAt_D} 
		 * @param feature ${mapping_FeatureLayer_method_addFeatureAt_param_feature}
		 * @param index ${mapping_FeatureLayer_method_addFeatureAt_param_index}
		 * @return ${mapping_FeatureLayer_method_addFeatureAt_return}
		 * @see features
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */		
		public function addFeatureAt(feature:Feature, index:int):String
		{
			try
			{
				this._features.addItemAt(feature,index);
			}
			catch(error:Error)
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}
			if(this.hasEventListener(FeatureLayerEvent.FEATURE_ADD))
			{
				dispatchEvent(new FeatureLayerEvent(FeatureLayerEvent.FEATURE_ADD,feature));
			}
			return feature.id;	
		}
		
		//增加派发事件	
		/**
		 * ${mapping_FeatureLayer_method_clear_D} 
		 * 
		 */		
		public function clear():void
		{
			if(this._features)
			{
				this._features.removeAll();	
				this.hashTableIDs.clear();
				if(this.hasEventListener(FeatureLayerEvent.FEATURE_REMOVE_ALL))
					dispatchEvent(new FeatureLayerEvent(FeatureLayerEvent.FEATURE_REMOVE_ALL));
			}
		}
		
		//取出来指定feature所在的索引位置
		/**
		 * ${mapping_FeatureLayer_method_getFeatureIndex_D} 
		 * @param feature ${mapping_FeatureLayer_method_getFeatureIndex_param_feature}
		 * @return ${mapping_FeatureLayer_method_getFeatureIndex_return}
		 * 
		 */		
		public function getFeatureIndex(feature:Feature):int
		{
			var featureIndex:int = -1;
			if(this._features && feature)
			{
				featureIndex = this._features.getItemIndex(feature);
			}
			return featureIndex;
		}
		
		/**
		 * ${mapping_FeatureLayer_method_getFeatureAt_D} 
		 * @param index ${mapping_FeatureLayer_method_getFeatureAt_param_index}
		 * @return ${mapping_FeatureLayer_method_getFeatureAt_return}
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */		
		public function getFeatureAt(index:int):Feature
		{
			var feature:Feature = null;
			if(this._features)
			{
				try
				{
					var object:Object = this._features.getItemAt(index);
					feature = object ? (object as Feature) : null;
				}
				catch(error:Error)
				{
					throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
				}
			}
			return feature;
		}
		
		//根据feature的id值获取该feature
		/**
		 * ${mapping_FeatureLayer_method_getFeatureById_D} 
		 * @param Id ${mapping_FeatureLayer_method_getFeatureById_id}
		 * @return ${mapping_FeatureLayer_method_getFeatureById_Feature}
		 * 
		 */		
		public function getFeatureByID(id:String):Feature
		{
			var feature:Feature = null;
			if(id && this.hashTableIDs.containsKey(id))
			{
				feature = this.hashTableIDs.find(id) as Feature;
				if(feature.id == id)
				{
					return feature;
				}		
				else 
					feature = null;
			}
			return feature;
		}
		
		//根据feature对象名称来移动到指定索引位置
		/**
		 * ${mapping_FeatureLayer_method_moveFeature_D} 
		 * @param feature ${mapping_FeatureLayer_method_moveFeature_param_feature}
		 * @param index ${mapping_FeatureLayer_method_moveFeature_param_index}
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */		
		public function moveFeature(feature:Feature, index:int):void
		{			
			try
			{
				this._features.removeItemAt(this.getFeatureIndex(feature));
				this._features.addItemAt(feature, index);
			}
			catch(error:SmError)			
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}			
		}
		
		//根据feature对象索引来移动到指定索引位置
		/**
		 * ${mapping_FeatureLayer_method_moveFeatureAt_D} 
		 * @param featureIndex ${mapping_FeatureLayer_method_moveFeatureAt_param_featureIndex}
		 * @param index ${mapping_FeatureLayer_method_moveFeatureAt_param_index}
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */		
		public function moveFeatureAt(fromIndex:int, toIndex:int):void
		{			
			try
			{
				var object:Object = this._features.removeItemAt(fromIndex);
				var feature:Feature = object ? (object as Feature) : null;
				this._features.addItemAt(feature, toIndex);
			}
			catch(error:SmError)			
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}		
		}
		
		/**
		 * ${mapping_FeatureLayer_method_moveToTop_D} 
		 * @param feature ${mapping_FeatureLayer_method_moveToTop_param_feature}
		 * 
		 */		
		public function moveToTop(feature:Feature):void
		{
			var index:int = numChildren - 1;
			
			if (getChildIndex(feature) != index)
			{
				setChildIndex(feature, index);
			}
		}
		
		//根据Feature对象名称来进行删除操作
		/**
		 * ${mapping_FeatureLayer_method_removeFeature_D} 
		 * @param feature ${mapping_FeatureLayer_method_removeFeature_param_feature}
		 * @return ${mapping_FeatureLayer_method_removeFeature_return}
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */		
		public function removeFeature(feature:Feature):Feature
		{				
			return this.removeFeatureAt(getFeatureIndex(feature));
		}
		
		//根据Feature对象所在索引来进行删除操作
		/**
		 * ${mapping_FeatureLayer_method_removeFeatureAt_D} 
		 * @param featureIndex ${mapping_FeatureLayer_method_removeFeatureAt_param_featureIndex}
		 * @return $[mapping_FeatureLayer_method_removeFeatureAt_return}
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */		
		public function removeFeatureAt(index:int):Feature
		{			
			var feature:Feature = null;
			if(this._features)
			{
				try
				{				
					var object:Object = this._features.removeItemAt(index);
					feature = object ? (object as Feature) : null;
					if(this.hasEventListener(FeatureLayerEvent.FEATURE_REMOVE))
					{
						dispatchEvent(new FeatureLayerEvent(FeatureLayerEvent.FEATURE_REMOVE, feature));
					}
				}
				catch(error:Error)
				{
					throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
				}
			}
			return feature;
			
		}
		
		
		/**
		 * ${mapping_FeatureLayer_attribute_renderer_D}
		 * @return 
		 * 
		 */					
//		public function get renderer():Renderer
//		{
//			return this._renderer;
//		}
//		
//		public function set renderer(value:Renderer):void
//		{
//			if (this._renderer != value)
//			{
//				this._renderer = value;
//				invalidateProperties();
//			}
//		}
	}
}
