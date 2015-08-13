package com.supermap.web.gears.components
{   
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.events.MapEvent;
	import com.supermap.web.gears.events.LegendEvent;
	import com.supermap.web.gears.components.skins.LegendSkin;
	import com.supermap.web.iServerJava6R.layerServices.ServerLayer;
	import com.supermap.web.iServerJava6R.layerServices.SuperMapLayerType;
	import com.supermap.web.iServerJava6R.layerServices.UGCLayer;
	import com.supermap.web.iServerJava6R.layerServices.UGCThemeLayer;
	import com.supermap.web.iServerJava6R.serviceEvents.GetLayersInfoEvent;
	import com.supermap.web.iServerJava6R.themeServices.ThemeDotDensity;
	import com.supermap.web.iServerJava6R.themeServices.ThemeGraduatedSymbol;
	import com.supermap.web.iServerJava6R.themeServices.ThemeGraphItem;
	import com.supermap.web.iServerJava6R.themeServices.ThemeLabelItem;
	import com.supermap.web.iServerJava6R.themeServices.ThemeRangeItem;
	import com.supermap.web.iServerJava6R.themeServices.ThemeUniqueItem;
	import com.supermap.web.mapping.ImageLayer;
	import com.supermap.web.mapping.Layer;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Tree;
	import mx.events.PropertyChangeEvent;
	
	import spark.components.supportClasses.*;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_components_Legend_event_legendLoaded_D} 
	 */	
	[Event(name="legendLoaded", type="com.supermap.web.gears.events.LegendEvent")]
	/**
	 * ${iServerJava6R_components_Legend_Title}.
	 * <p>${iServerJava6R_components_Legend_Description}</p> 
	 * 
	 */		
	public class Legend extends SkinnableComponent
	{  
		private var _legendLayers:Array;//map里的图层集合 一般一个图层 如：动态图层
		private var _layerIDs:Array; 
		
		private var _map:Map; 
		
		private var _isLayerChanged:Boolean = false; 
		private var _isUrlChanged:Boolean = false; 
		private var _isMapChanged:Boolean = false;  
		private var _isRefresh:Boolean = false;
		private var _isLayerAdd:Boolean = false;
		private var _isInit:Boolean = false;
		private var _isShowOnlyVisibleLayers:Boolean = false;//是否只显示可见图层
		
		private var _layerItems:ArrayCollection = new ArrayCollection();//用该参数来做索引值保存	对外开放	  
		private var _treeItems:TreeItem; //该参数用来做实际的可见性操作 内容可变 参照layeritems里的值进行比对 
		
		private var legendCollection:Array;  
		private var taskCompleteCount:int = 0; //图层数量为多少,请求数量就是多少 
		
		private var _isExpandChildrenItem:Boolean = true;//是否展开树节点 默认展开
		
		private var _sourceImageHeight:int = 16;
		private var _sourceImageWidth:int = 16;		  
		
		sm_internal var _dataProvider:Object;
		
		/**
		 * ${iServerJava6R_components_Legend_constructor_None_D} 
		 * 
		 */		
		public function Legend()
		{   
			this.legendCollection = new Array();
			this._legendLayers = new Array();
			this._treeItems = new TreeItem("root", "root", false, "root", TreeItem.NONE_THEME, this); 
			this.addEventListener(LegendEvent.ITEM_REFRESH, itemRefreshHandler);
			this.addEventListener(LegendEvent.ITEM_VISIBLE_CHANGE, itemVisibleChangeHandler);//注册可见性控制事件
			this.addEventListener(LegendEvent.ITEM_IMAGESOURCE_CHANGE, itemImagesourceChangeHandler);//注册图片源修改监听事件
			this.addEventListener(LegendEvent.ITEM_NAME_CHANGE, itemNameChangeHandler);
			this.addEventListener(LegendEvent.ITEM_IMAGESIZE_CHANGE, itemImageSizeChangeHandler);
			
		}
		
		sm_internal function get treeItems():TreeItem
		{
			return _treeItems;
		}
		
		private function itemVisibleChangeHandler(event:LegendEvent):void
		{ 	 
			if(event.legendItemInfo.isVisible == false)
			{
				event.legendItemInfo.index = event.legendItemInfo.itemReference.getIndex();
				this.removeItem(event.legendItemInfo);
			}
			else if(event.legendItemInfo.isVisible == true)
			{  
				var index:uint = event.legendItemInfo.index;
				try{
					this.addItemAt(event.legendItemInfo, index);
				}catch(error:Error)
				{
					this.addItemAt(event.legendItemInfo, 0);
				} 
			}
		}
		
		private function itemImagesourceChangeHandler(event:LegendEvent):void
		{
			var itemInfoForm:LegendItemInfo = event.legendItemInfo;
			recursionItemImageSourceChange(this.treeItems, itemInfoForm);	
			
			
			//			var itemInfoForm:LegendItemInfo = event.legendItemInfo;			
			//			for(var i:int = 0; i < this.treeItems.length; i++)
			//			{
			//				var itemInfo:LegendItemInfo = (this.treeItems[i] as TreeItem).legendItemInfo;
			//				if(itemInfo.name == itemInfoForm.name && itemInfo.index == itemInfoForm.index && itemInfo.imageSource != itemInfoForm.imageSource)
			//				{ 
			//					//修改主图片
			//					itemInfo.imageSource = itemInfoForm.imageSource;
			//					itemInfo.imageHeight = itemInfoForm.imageHeight;
			//					itemInfo.imageWidth = itemInfoForm.imageWidth;
			//					itemInfoForm._imageSourceChanged = true;
			//					return;
			//				}
			//				if(itemInfo.itemReference.isHasChildren == true)
			//				{
			//					var layerItem:LegendItemInfo = (this.treeItems[i] as TreeItem).legendItemInfo;
			//					var treeItemsLength:int = this.treeItems[i].length;
			//					for(var j:int = 0; j < treeItemsLength; j++)
			//					{ 
			//						//修改子节点图片
			//						var itemInfo2:LegendItemInfo = (this.treeItems[i] as TreeItem)[j].legendItemInfo;
			//						if(itemInfo2.name == itemInfoForm.name && itemInfo2.index == itemInfoForm.index &&　itemInfo2.imageSource != itemInfoForm.imageSource)
			//						{ 							
			//							itemInfo2.imageSource = itemInfoForm.imageSource;
			//							itemInfo2.imageHeight = itemInfoForm.imageHeight;
			//							itemInfo2.imageWidth = itemInfoForm.imageWidth;
			//							itemInfoForm._imageSourceChanged = true;
			//						} 
			//					}
			//				}
			//			} 
			
		}
		
		private function recursionItemImageSourceChange(treeItems:TreeItem, itemInfoForm:LegendItemInfo):void
		{
			for(var i:int = 0; i < treeItems.length; i++)
			{
				var itemInfo:LegendItemInfo = (treeItems[i] as TreeItem).legendItemInfo;
				if(itemInfo.name == itemInfoForm.name)
				{ 
					//修改主图片
					itemInfo.imageSource = itemInfoForm.imageSource;
					itemInfo.imageHeight = itemInfoForm.imageHeight;
					itemInfo.imageWidth = itemInfoForm.imageWidth;
					itemInfoForm._imageSourceChanged = true;
					itemInfo._imageSourceChanged = true;
					return;
				}
				if(itemInfo.itemReference.isHasChildren == true)
				{
					var layerItem:LegendItemInfo = (treeItems[i] as TreeItem).legendItemInfo;
					var treeItemsLength:int = treeItems[i].length;
					for(var j:int = 0; j < treeItemsLength; j++)
					{ 
						//修改子节点图片
						var itemInfo2:LegendItemInfo = (treeItems[i] as TreeItem)[j].legendItemInfo;
						if(itemInfo2.name == itemInfoForm.name)
						{
							itemInfo2.imageSource = itemInfoForm.imageSource;
							itemInfo2.imageHeight = itemInfoForm.imageHeight;
							itemInfo2.imageWidth = itemInfoForm.imageWidth;
							if(itemInfo2.index == itemInfoForm.index &&　itemInfo2.imageSource != itemInfoForm.imageSource)
							{ 							
								itemInfo2.imageSource = itemInfoForm.imageSource;
								itemInfo2.imageHeight = itemInfoForm.imageHeight;
								itemInfo2.imageWidth = itemInfoForm.imageWidth;
								itemInfoForm._imageSourceChanged = true;
								return;
							}
						}						
						else
						{
							recursionItemImageSourceChange(treeItems[i], itemInfoForm);
						}
						
					}
				}
			} 
		}
		
		//这里暂根据图层名称的对应关系来进行定位 以后需要修改为按照索引位置来遍历。。。两者都能实现
		private function itemNameChangeHandler(event:LegendEvent):void
		{
			var itemInfoForm:LegendItemInfo = event.legendItemInfo;
			recursionItemNameChange(this.treeItems, itemInfoForm);
		}	
		
		//递归
		private function recursionItemNameChange(treeItems:TreeItem, itemInfoForm:LegendItemInfo):void
		{
			for(var i:int = 0; i < treeItems.length; i++)
			{
				var itemInfo:LegendItemInfo = (treeItems[i] as TreeItem).legendItemInfo;	
				//				var treeitem2:TreeItem = itemInfo.itemReference; 
				if(itemInfo.imageSource == itemInfoForm.imageSource)
				{ 
					//修改父节点名称
					itemInfo.name = itemInfoForm.name;
					itemInfoForm._nameChanged = true;
					if(itemInfoForm._imageSourceChanged)
					{
						itemInfo.imageSource = itemInfoForm.imageSource;
						itemInfo.imageHeight = itemInfoForm.imageHeight;
						itemInfo.imageWidth = itemInfoForm.imageWidth;
					}
					return;
				}
				if(itemInfo.itemReference.isHasChildren == true)
				{
					var layerItem:LegendItemInfo = (treeItems[i] as TreeItem).legendItemInfo;
					var treeItemsLength:int = treeItems[i].length;
					for(var j:int = 0; j < treeItemsLength; j++)
					{ 
						//修改子节点名称
						var itemInfo2:LegendItemInfo = (treeItems[i] as TreeItem)[j].legendItemInfo;
						if(itemInfo2.imageSource == itemInfoForm.imageSource)
						{ 							
							itemInfo2.name = itemInfoForm.name;
							itemInfoForm._nameChanged = true;
							if(itemInfoForm._imageSourceChanged)
							{
								itemInfo2.imageSource = itemInfoForm.imageSource;
								itemInfo2.imageHeight = itemInfoForm.imageHeight;
								itemInfo2.imageWidth = itemInfoForm.imageWidth;
							}
							return;
						}
						else
						{
							recursionItemNameChange(treeItems[i], itemInfoForm);
						}
					}
				}
			} 
		}
		
		//修改高度
		private function itemImageSizeChangeHandler(event:LegendEvent):void
		{
			var itemInfoForm:LegendItemInfo = event.legendItemInfo;
			recursionImageSize(this.treeItems, itemInfoForm);
			//			for(var i:int = 0; i < this.treeItems.length; i++)
			//			{
			//				var itemInfo:LegendItemInfo = (this.treeItems[i] as TreeItem).legendItemInfo;
			//				if(itemInfo.name == itemInfoForm.name)
			//				{ 
			//					itemInfo.imageSource = itemInfoForm.imageSource;
			//					itemInfo.imageHeight = itemInfoForm.imageHeight;
			//					itemInfo.imageWidth = itemInfoForm.imageWidth;					
			//					return;
			//				}
			//				if(itemInfo.itemReference.isHasChildren == true)
			//				{
			//					var layerItem:LegendItemInfo = (this.treeItems[i] as TreeItem).legendItemInfo;
			//					var treeItemsLength:int = this.treeItems[i].length;
			//					for(var j:int = 0; j < treeItemsLength; j++)
			//					{ 
			//						//修改子节点名称
			//						var itemInfo2:LegendItemInfo = (this.treeItems[i] as TreeItem)[j].legendItemInfo;
			//						if(itemInfo2.name == itemInfoForm.name)
			//						{ 			
			//							if(itemInfoForm._imageSourceChanged)//如果图片已经改变 则只需要修改大小即可
			//							{		
			//								itemInfo2._imageSourceChanged = true;
			//								itemInfo2.imageSource = itemInfoForm.imageSource;
			//								itemInfo2.imageHeight = itemInfoForm.imageHeight;
			//								itemInfo2.imageWidth = itemInfoForm.imageWidth;	
			//								return;
			//							}
			//							else
			//							{
			//								itemInfo2.imageSource = itemInfoForm.imageSource;
			//								itemInfo2.imageHeight = itemInfoForm.imageHeight;
			//								itemInfo2.imageWidth = itemInfoForm.imageWidth;	
			//							}
			//						} 
			//					}
			//				}
			//			} 
		}
		
		
		//递归 修改size
		private function recursionImageSize(treeItems:TreeItem, itemInfoForm:LegendItemInfo):void
		{
			for(var i:int = 0; i < treeItems.length; i++)
			{
				var itemInfo:LegendItemInfo = (treeItems[i] as TreeItem).legendItemInfo;
				if(itemInfo.name == itemInfoForm.name)
				{ 
					if(!itemInfoForm._imageSourceChanged)
					{
						itemInfo.imageHeight = itemInfoForm.imageHeight;
						itemInfo.imageWidth = itemInfoForm.imageWidth;	
					}
					else
					{
						itemInfo.imageSource = itemInfoForm.imageSource;
						itemInfo.imageHeight = itemInfoForm.imageHeight;
						itemInfo.imageWidth = itemInfoForm.imageWidth;		
					}
					return;
				}
				if(itemInfo.itemReference.isHasChildren == true)
				{
					var layerItem:LegendItemInfo = (treeItems[i] as TreeItem).legendItemInfo;
					var treeItemsLength:int = treeItems[i].length;
					for(var j:int = 0; j < treeItemsLength; j++)
					{ 
						//修改子节点名称
						var itemInfo2:LegendItemInfo = (treeItems[i] as TreeItem)[j].legendItemInfo;
						if(itemInfo2.name == itemInfoForm.name)
						{ 			
							if(itemInfoForm._imageSourceChanged)//如果图片已经改变 则只需要修改大小即可
							{		
								itemInfo2._imageSourceChanged = true;
								itemInfo2.imageSource = itemInfoForm.imageSource;
								itemInfo2.imageHeight = itemInfoForm.imageHeight;
								itemInfo2.imageWidth = itemInfoForm.imageWidth;	
								return;
							}
							else
							{
								itemInfo2.imageSource = itemInfoForm.imageSource;
								itemInfo2.imageHeight = itemInfoForm.imageHeight;
								itemInfo2.imageWidth = itemInfoForm.imageWidth;	
							}
						}
						else
						{
							recursionImageSize(treeItems[i], itemInfoForm);
						}
					}
				}
			} 
		}
		
		sm_internal function get sourceImageWidth():int
		{
			return _sourceImageWidth;
		}
		
		sm_internal function set sourceImageWidth(value:int):void
		{
			_sourceImageWidth = value;
		}
		
		sm_internal function get sourceImageHeight():int
		{
			return _sourceImageHeight;
		}
		
		sm_internal function set sourceImageHeight(value:int):void
		{
			_sourceImageHeight = value;
		}
		
		/**
		 * ${iServerJava6R_components_Legend_attribute_isExpandChildrenItem_D}  
		 * @return 
		 * 
		 */	
		public function get isExpandChildrenItem():Boolean
		{
			return _isExpandChildrenItem;
		}
		
		//是否展开整个tree的所有节点
		public function set isExpandChildrenItem(value:Boolean):void
		{
			_isExpandChildrenItem = value;			
			if(this.skin is LegendSkin)
			{
				var skinTree:Tree = (this.skin as LegendSkin).legendTree;
				skinTree.expandChildrenOf(skinTree.dataProvider, value);
			}  
		}
		
		/**
		 * ${iServerJava6R_components_Legend_attribute_layerItems_D} .
		 * <p>${iServerJava6R_components_Legend_attribute_layerItems_remarks}</p>
		 * @return 
		 * 
		 */	
		public function get layerItems():ArrayCollection
		{
			return _layerItems;
		}	
		
		private function set layerItems(value:ArrayCollection):void
		{
			_layerItems = value;
		}
		
		[Bindable]
		/**
		 * ${iServerJava6R_components_Legend_attribute_dataProvider_D}  
		 * @return 
		 * 
		 */	
		sm_internal function get dataProvider():Object
		{
			return this._treeItems as Object;
		}
		
		/**
		 * 
		 * @private
		 * 
		 */			
		sm_internal function set dataProvider(value:Object):void
		{ 	 
		}
		
		//设置某一个节点不可见 即是移除某一个节点 
		sm_internal function removeItem(legendItemInfo:LegendItemInfo):Boolean
		{
			for(var i:int = 0; i < this._treeItems.length; i++)
			{
				if((this._treeItems[i] as TreeItem).legendItemInfo == legendItemInfo)
				{
					this._treeItems.removeItemAt(i);
					this._treeItems.refresh();
					return true;
				}
				if((this._treeItems[i] as TreeItem).isHasChildren == true)
				{
					var treeItem:TreeItem = this._treeItems[i] as TreeItem;
					for(var j:int = 0; j < treeItem.length; j++)
					{ 
						//						if((treeItem[j] as TreeItem).legendItemInfo == legendItemInfo)
						//						{
						//							treeItem.removeItemAt(j);
						//							this._treeItems.refresh();
						//							return true;
						//						} 
						var ItemInfo:LegendItemInfo = (treeItem[j] as TreeItem).legendItemInfo;
						if(ItemInfo && ItemInfo.name == legendItemInfo.name)
						{
							treeItem.removeItemAt(j);
							this._treeItems.refresh();
							return true;
						}
					}
				}
			} 
			return false;
		}
		
		sm_internal function findItem(legendItemInfo:LegendItemInfo):int
		{
			this._treeItems.refresh();
			for(var i:int = 0; i < this._treeItems.length; i++)
			{
				if((this._treeItems[i] as TreeItem).legendItemInfo == legendItemInfo)
				{ 
					return i;
				}
				if((this._treeItems[i] as TreeItem).isHasChildren == true)
				{
					var treeItem:TreeItem = this._treeItems[i] as TreeItem;
					for(var j:int = 0; j < treeItem.length; j++)
					{ 
						if((treeItem[j] as TreeItem).legendItemInfo == legendItemInfo)
						{ 
							return j;
						} 
					}
				}
			} 
			return -1;
		}
		
		sm_internal function findLayerItem(legendItemInfo:LegendItemInfo):int
		{
			this._layerItems.refresh();
			for(var i:int = 0; i < this._layerItems.length; i++)
			{
				if((this._layerItems[i] as LegendItemInfo).name == legendItemInfo.name && (this._layerItems[i] as LegendItemInfo).index == legendItemInfo.index)
				{ 
					return i;
				}
				if((this._layerItems[i] as LegendItemInfo).itemReference.isHasChildren == true)
				{
					var layerItem:TreeItem = (this._layerItems[i] as LegendItemInfo).itemReference;
					for(var j:int = 0; j < layerItem.length; j++)
					{ 
						var itemInfo:LegendItemInfo = (layerItem[j] as TreeItem).legendItemInfo;
						if(itemInfo.name == legendItemInfo.name && itemInfo.index == legendItemInfo.index)
						{ 
							return j;
						} 
					}
				}
			} 
			return -1;
		}
		
		sm_internal function addItem(legendItemInfo:LegendItemInfo):void
		{
			var isAlreadyIn:int = findItem(legendItemInfo);
			if(isAlreadyIn > -1)
			{
				return;
			} 
			var parent:TreeItem = legendItemInfo.itemReference.parent;
			for(var i:int = 0; i < this._treeItems.length; i++)
			{
				if(parent.legendItemInfo == (this._treeItems[i] as TreeItem).legendItemInfo)
				{ 
					(this._treeItems[i] as TreeItem).addItem(legendItemInfo.itemReference);
				}
				if((this._treeItems[i] as TreeItem).isHasChildren == true)
				{
					var treeItem:TreeItem = this._treeItems[i] as TreeItem;
					for(var j:int = 0; j < treeItem.length; j++)
					{
						if(parent.legendItemInfo == (treeItem[j] as TreeItem).legendItemInfo)
						{
							(treeItem[j] as TreeItem).addItem(legendItemInfo.itemReference);
						}
					}
				}	
			}
		}
		
		//这里要处理移除后的添加情况处理
		sm_internal function addItemAt(legendItemInfo:LegendItemInfo, index:int = 0):void
		{
			var isAlreadyIn:int = this.findItem(legendItemInfo);			
			//处理移除后添加的情况
			var layerItemIndex:int = this.findLayerItem(legendItemInfo);
			if(isAlreadyIn == -1 && layerItemIndex >= 0)//treeItem不包含 而layerItem包含的时候
			{
				this.addLayerItemAt(legendItemInfo, layerItemIndex);
				return;
			}
			if(isAlreadyIn > -1)
			{
				return;
			} 
			this.addTreeItemAt(legendItemInfo, index);
		}
		
		sm_internal function addTreeItemAt(legendItemInfo:LegendItemInfo, index:int = 0):void
		{		
			var parent:TreeItem = legendItemInfo.itemReference.parent;
			for(var i:int = 0; i < this._treeItems.length; i++)
			{
				if(parent.legendItemInfo == (this._treeItems[i] as TreeItem).legendItemInfo)
				{  
					(this._treeItems[i] as TreeItem).addItemAt(legendItemInfo.itemReference, index);
				}
				if((this._treeItems[i] as TreeItem).isHasChildren == true)
				{
					var treeItem:TreeItem = this._treeItems[i] as TreeItem;
					for(var j:int = 0; j < treeItem.length; j++)
					{
						if(parent.legendItemInfo == (treeItem[j] as TreeItem).legendItemInfo)
						{
							(treeItem[j] as TreeItem).addItemAt(legendItemInfo.itemReference, index);
						}
					}
				}	
			}
		}	
		
		//根据删除的那个节点的信息 找到在treeItem里对应的位置 然后再行添加
		sm_internal function addLayerItemAt(legendItemInfo:LegendItemInfo, index:int = 0):void
		{
			var parent:TreeItem = legendItemInfo.itemReference.parent;
			for(var i:int = 0; i < this._treeItems.length; i++)
			{
				var layerItem:LegendItemInfo = (this._treeItems[i] as TreeItem).legendItemInfo;
				if(parent.legendItemInfo.name == layerItem.name && parent.legendItemInfo.index == layerItem.index )
				{  
					(this._treeItems[i] as TreeItem).addItemAt(legendItemInfo.itemReference, index);
					this._treeItems.refresh();
				}
				//				if((this._treeItems[i] as TreeItem).isHasChildren == true)
				//				{
				//					var treeItem:TreeItem = this._treeItems[i] as TreeItem;											
				//					treeItem.addItemAt(legendItemInfo.itemReference, index);
				//				}	
			}
		}
		
		/**
		 * ${iServerJava6R_components_Legend_attribute_isShowOnlyVisibleLayers_D} 
		 * @return 
		 * 
		 */	
		public function get isShowOnlyVisibleLayers():Boolean
		{
			return _isShowOnlyVisibleLayers;
		}
		
		public function set isShowOnlyVisibleLayers(value:Boolean):void
		{
			_isShowOnlyVisibleLayers = value;
			dispatchRefreshEvent();
		}
		
		/**
		 * ${iServerJava6R_components_Legend_attribute_layerIDs_D} 
		 * @return 
		 * 
		 */		
		public function get layerIDs():Array
		{
			return _layerIDs;
		}
		
		public function set layerIDs(value:Array):void
		{
			if(value != null)
			{ 
				this._layerIDs = value; 
				this.layerIDChange();
			}
		}
		
		[Bindable]
		/**
		 * ${iServerJava6R_components_Legend_attribute_map_D} 
		 * @return 
		 * 
		 */		
		public function get map() : Map
		{
			return this._map;
		}
		
		public function set map(value:Map) : void
		{
			if (value != null && this._map !== value)
			{
				this._map = value;
				this._map.addEventListener(MapEvent.LOAD, layerAddHandler);  
				this._isMapChanged = true;
				invalidateProperties();
			} 
		}
		
		private function layerIDChange():void
		{  
			var item:Object;
			for(var i:int = 0; i < this.legendCollection.length; i++)
			{
				item = this.legendCollection[i];
				this.setItemVisible(item);
			} 
			this.initLayerItems();
		}
		
		private function layerAddHandler(event:MapEvent):void
		{ 
			if(event.layer &&  !(event.layer is ImageLayer))
			{
				return;
			}
			this._isLayerChanged = true;
			this._isLayerAdd = true;
			this.legendCollection.length = 0;
			this._legendLayers.length = 0;
			this.invalidateProperties(); 
		}
		
		private function getLayers():void//从map中提取layer
		{
			this._legendLayers.length = 0;
			if(this._map.layers)
			{ 
				for(var i:int = 0; i < (this._map.layers as ArrayCollection).length; i++)
				{
					var temp:Layer = this._map.layers[i];
					if(temp is ImageLayer)
					{ 
						if(temp.loaded)
							this._legendLayers.push(temp);
					}
				} 
			} 
		}
		
		private function refreshLegend():void
		{
			this.getLayers();
			this.legendCollection.length = 0;
			this.taskCompleteCount = 0;
			for (var n:int; n < this._legendLayers.length; n++)
			{ 
				var layer:Layer = this._legendLayers[n] as Layer; 
				layer.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, urlPropertyChangeHandler); 
				var _task:LegendTask = new LegendTask(layer.url);
				_task.url = layer.url; 
				_task.layerID = layer.id;
				_task.addEventListener(GetLayersInfoEvent.PROCESS_COMPLETE, secondGetLayersInfoResult, false, 0, true);
				_task.excute();
			}  
		}
		
		private function secondGetLayersInfoResult(event:GetLayersInfoEvent):void
		{ 
			this._isRefresh = true;
			this.addLayersInfoItem(event, false);
			this.taskCompleteCount++;
			if(this.taskCompleteCount == this._legendLayers.length)
			{
				this.invalidateProperties(); 
			}  
		}
		/**
		 * ${iServerJava6R_components_Legend_attribute_getCurrentSkinState_D}.
		 * <p>${iServerJava6R_components_Legend_attribute_getCurrentSkinState_remarks}</p> 
		 * @return 
		 * 
		 */		
		override protected function getCurrentSkinState() : String
		{
			if (enabled === false)
			{
				return "disabled";
			}
			if (this._map === null)
			{
				return "disabled";
			} 
			if (this._map.layers === null)
			{
				return "disabled";
			}
			return "normal";
		}
		
		/**
		 * @private 
		 * 
		 */		
		override protected function commitProperties() : void
		{ 
			super.commitProperties(); 
			
			if(this._isMapChanged)
			{
				this._isMapChanged = false;
				this.getLayers();
			} 
			if(this._isLayerChanged)
			{
				this._isLayerChanged = false;
				this.getLayers();
			} 
			if(this._isInit == false)
			{
				this.initLegend();
			}
			if(this._isRefresh)
			{
				this._isRefresh = false;
				if(this.taskCompleteCount == this.legendCollection.length)
				{
					this.dispatchRefreshEvent(); 
				}
			}
			if(this._isLayerAdd)
			{
				this._isLayerAdd = false;
				this.refreshLegend();
			}
		} 
		
		private function initLegend() : void//这个方法分解:1初始化,2刷新
		{  
			this._isInit = true;
			for each (var layer:Layer in this._legendLayers)
			{  
				layer.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, urlPropertyChangeHandler); 
				//				layer.addEventListener(LayerEvent.LOAD, loadHandler);
			}  
			this.excuteTask(this._legendLayers); 
		}
		
		private function loadHandler(event:LayerEvent):void
		{
			this._isUrlChanged = true;
			var task:LegendTask = new LegendTask(event.layer.url); 
			task.layerID = (event.currentTarget as Layer).id;
			task.addEventListener(GetLayersInfoEvent.PROCESS_COMPLETE, urlChangeResult, false, 0, false);
			task.excute();
		}
		
		private function excuteTask(successfullyLoadedLayers:Array) : void
		{     
			for (var n:int; n < this._legendLayers.length; n++)
			{ 
				var layer:Layer = successfullyLoadedLayers[n] as Layer;
				var task:LegendTask = new LegendTask(layer.url); 
				task.layerID = layer.id;
				task.addEventListener(GetLayersInfoEvent.PROCESS_COMPLETE, firstGetLayersInfoResult, false, 0, true);
				task.excute();
			}  
		}  
		
		private function urlPropertyChangeHandler(event:PropertyChangeEvent):void
		{ 
			if(event.property == "url")
			{
				this._isUrlChanged = true;
				var task:LegendTask = new LegendTask(event.newValue as String); 
				task.layerID = (event.currentTarget as Layer).id;
				task.addEventListener(GetLayersInfoEvent.PROCESS_COMPLETE, urlChangeResult, false, 0, false);
				task.excute();
			}
		}
		
		private function deleteItemByData(item:Object):void
		{
			for(var i:int; i < this.legendCollection.length; i++)
			{
				if(item.title == this.legendCollection[i].title)
				{ 
					this.legendCollection.splice(i, 1);
				}
			}
		}
		
		private function setItemVisible(item:Object):void
		{
			if(this._layerIDs && this._layerIDs.length > 0)
			{
				for(var i:int; i < this._layerIDs.length; i++)
				{
					var layerID:String = this._layerIDs[i];
					if(item.title == layerID)
					{
						item.visible = true;
						return;
					}
				}
				item.visible = false; 
			}
			else
			{
				item.visible = true;
			}
		}
		
		private function addLayersInfoItem(event:GetLayersInfoEvent, isReplace:Boolean = true):void
		{
			var item:Object = new Object();
			item.layersInfo = event.result.layersInfo; //图层里面的所有子图层集合 array类型
			item.title = (event.target as LegendTask).layerID; //地图服务名 如WORLD MAP
			item.url = (event.target as LegendTask).url;//地图服务url
			this.setItemVisible(item);
			if(isReplace)
			{
				this.deleteItemByData(item); 
			}
			if(addLengendCollection(this.legendCollection, (event.target as LegendTask).layerID))//如果包含了同样的map 则不再添加
				this.legendCollection.push(item); 
		}
		
		//判断是否已经包含了同一个map
		private function addLengendCollection(legendCollection:Array, itemTitle:String):Boolean
		{
			var isAdd:Boolean = true;
			if(legendCollection && legendCollection.length)
			{
				for(var i:int = 0; i < legendCollection.length; i++)
				{
					if((legendCollection[i] as Object).title == itemTitle) isAdd = false;					
				}
			}			
			return isAdd;
		}
		
		private function urlChangeResult(event:GetLayersInfoEvent):void//这个方法应该根据layerID进行调整
		{    
			this.addLayersInfoItem(event);
			var layers:Array = this._legendLayers;
			this.dispatchRefreshEvent()
		}
		
		private function findIndexByLayerID(layerID:String):int
		{
			for(var i:int; i < this.legendCollection.length; i++)
			{
				var item:Object = this.legendCollection[i];
				if(item.title == layerID)
				{
					return i;
				}
			}
			return -1;//没找到
		}
		
		private function dispatchRefreshEvent():void
		{ 
			this.taskCompleteCount = 0;
			this.initLayerItems();
			this.isExpandChildrenItem = this._isExpandChildrenItem; 
			this.dispatchEvent(new LegendEvent(LegendEvent.LEGEND_LOADED));  
		}
		
		private function initLayerItems():void
		{
			this._treeItems.removeAll(); 
			this._layerItems.removeAll();
			if(this.legendCollection)
			{    
				for(var i:int; i < this.legendCollection.length; i++)
				{ 
					if(this.legendCollection[i].visible)
					{
						var treeItem:TreeItem = new TreeItem(this.legendCollection[i].title, this.legendCollection[i].title, this.legendCollection[i].visible, "", TreeItem.NONE_THEME, this);  
						this._treeItems.addItem(treeItem);
						var layerItem:TreeItem = new TreeItem(this.legendCollection[i].title, this.legendCollection[i].title, this.legendCollection[i].visible, "", TreeItem.NONE_THEME, this);
						this._layerItems.addItem(layerItem.legendItemInfo);
						this.addSubLayerItems(i, treeItem);//进行层级处理
						this.addSubLayerItems(i, layerItem);//进行层级处理
					}
				}
			}			
		}
		
		//设置是否所有图层可见 根据服务端的默认isVisible进行判断 外部接口为isShowOnlyVisibleLayers
		private function addSubLayerItems(index:int, parent:TreeItem):void//每个图层的信息
		{
			var infoItem:Object = this.legendCollection[index];  
			if(infoItem != null && infoItem.visible == true)
			{
				var length:int = infoItem.layersInfo.length; //14
				for(var i:int; i < length; i++)
				{       
					var subLayer:ServerLayer = infoItem.layersInfo[i] as ServerLayer; 
					var treeItem:TreeItem = new TreeItem(subLayer.caption, subLayer.name, subLayer.isVisible, subLayer.description, TreeItem.NONE_THEME, this);  
					if(subLayer.isVisible == false)
					{ 
						if(this.isShowOnlyVisibleLayers == true)
						{
							continue;
						} 
					}    
					treeItem.legendItemInfo.layerUrl = infoItem.url;  
					//this._layerItems.addItem(treeItem.legendItemInfo); 
					parent.addItem(treeItem); 
					if(subLayer.ugcLayerType == SuperMapLayerType.THEME)//添加专题图
					{      
						this.prepareThemeNodeItems(subLayer.ugcLayer, treeItem);//插入ugcLayer的节点,在插入子图层标签之后插入
					}
				} 
			}
		}
		
		private function addThemeNodeItems(items:Array, parent:TreeItem):void
		{ 
			for(var i:int; i < items.length; i++)
			{
				var item:Object = items[i];
				var label:String = item.caption; 
				var treeItem:TreeItem;    
				if(item is ThemeGraphItem)
				{  
					treeItem = new TreeItem(label, label, true, "", i, this);  
				}
				else if(item is ThemeUniqueItem)
				{  
					treeItem = new TreeItem(label, label, (item as ThemeUniqueItem).visible, "", i, this);  
				}
				else if(item is ThemeRangeItem)
				{ 
					treeItem = new TreeItem(label, label, (item as ThemeRangeItem).visible, "", i, this); 
				} 
				else if(item is ThemeLabelItem)
				{  
					treeItem = new TreeItem(label, label, (item as ThemeLabelItem).visible, "", i, this);  
				} 
				treeItem.legendItemInfo.layerUrl = parent.legendItemInfo.layerUrl;
				//this._layerItems.addItem(treeItem.legendItemInfo);  
				parent.addItem(treeItem);
			}
		}
		
		private function prepareThemeNodeItems(subLayer:UGCLayer, parent:TreeItem):void
		{ 
			var subItem:Object = (subLayer as UGCThemeLayer).theme;
			var treeItem:TreeItem;
			if(subItem is ThemeGraduatedSymbol)//等级符号专题图不设置items
			{    
			}
			else if(subItem is ThemeDotDensity)//点密度专题图不设置items
			{   
			}
			else if(subItem != null)
			{  
				if(subItem.items)
				{   
					this.addThemeNodeItems(subItem.items, parent);
				}  
			}
		}
		
		private function firstGetLayersInfoResult(event:GetLayersInfoEvent):void//处理监听到的事件结果
		{  
			this.addLayersInfoItem(event, false);
			this.taskCompleteCount ++; 
			if(this.taskCompleteCount == this._legendLayers.length)
			{
				this.dispatchRefreshEvent(); 
			}
		} 
		
		private function itemRefreshHandler(event:Event):void
		{
			this.isExpandChildrenItem = !this.isExpandChildrenItem;
			this.isExpandChildrenItem = !this.isExpandChildrenItem;
		}
	}
}
