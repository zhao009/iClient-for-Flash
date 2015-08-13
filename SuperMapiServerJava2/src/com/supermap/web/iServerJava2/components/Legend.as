package com.supermap.web.iServerJava2.components
{   
	import com.supermap.web.events.LayerEvent;
	import com.supermap.web.events.MapEvent;
	import com.supermap.web.iServerJava2.components.skins.LegendSkin;
	import com.supermap.web.iServerJava2.components.supportClasses.LegendTask;
	import com.supermap.web.iServerJava2.components.supportClasses.TreeItem;
	import com.supermap.web.iServerJava2.mapServices.GetMapStatusResult;
	import com.supermap.web.iServerJava2.mapServices.ServerLayer;
	import com.supermap.web.mapping.ImageLayer;
	import com.supermap.web.mapping.Layer;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Tree;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	
	import spark.components.supportClasses.*;

    use namespace sm_internal;
	
	/**
	 * ${iServerJava2_components_Legend_event_legendLoaded_D} 
	 */	
	[Event(name="legendLoaded", type="com.supermap.web.iServerJava2.components.LegendEvent")]
	/**
	 * ${iServerJava2_components_Legend_Title}.
	 * <p>${iServerJava2_components_Legend_Description}</p> 
	 * 
	 */		
	public class Legend extends SkinnableComponent
	{  
		private var _legendLayers:Array;
		private var _layerIDs:Array;  
		private var _map:Map;  
		private var _isLayerChanged:Boolean = false; 
		private var _isUrlChanged:Boolean = false; 
		private var _isMapChanged:Boolean = false;  
		private var _isRefresh:Boolean = false;
		private var _isLayerAdd:Boolean = false;
		private var _isInit:Boolean = false;
		private var _isShowOnlyVisibleLayers:Boolean = false;		
		private var _layerItems:ArrayCollection;
		private var _legendCollection:Array;  
		private var _taskCompleteCount:int = 0; //图层数量为多少,请求数量就是多少 
		private var _treeItems:TreeItem;
		private var _isExpandChildrenItem:Boolean = true;
		
		sm_internal var _dataProvider:Object;
		
		/**
		 * @private 
		 */		
		public static const LEGEND_LOADED:String = "legendLoaded";  
		/**
		 * ${iServerJava2_components_Legend_constructor_None_D} 
		 * 
		 */		
		public function Legend()
		{   
			this._legendCollection = new Array();
			this._legendLayers = new Array();
			this._layerItems = new ArrayCollection();
			this._treeItems = new TreeItem("root", false, "root", -1, this); 
			this.addEventListener(LegendEvent.ITEM_VISIBLE_CHANGE, itemVisibleChangeHandler);
			this.addEventListener(LegendEvent.ITEM_IMAGESOURCE_CHANGE, itemImagesourceChangeHandler);//注册图片源修改监听事件
			//this.addEventListener(LegendEvent.ITEM_NAME_CHANGE, itemNameChangeHandler);
			//this.addEventListener(FlexEvent., createCompleteHandler);
		}
	    
		private function createCompleteHandler(event:FlexEvent):void
		{
			for(var i:int = 0; i < (this.treeItems[0] as TreeItem).length; i++)
			{
//				trace(((this.treeItems[0] as TreeItem)[i] as TreeItem).legendItemInfo.layerSettingType);
			}
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
				try
				{
					this.addItemAt(event.legendItemInfo, index);
				}
				catch(error:Error)
				{
					this.addItemAt(event.legendItemInfo, 0);
				} 
			}
		}
		
		private function itemImagesourceChangeHandler(event:LegendEvent):void
		{
			var itemInfoForm:LegendItemInfo = event.legendItemInfo;
			recursionItemImageSourceChange(this.treeItems, itemInfoForm);	
		}
		
		private function recursionItemImageSourceChange(treeItems:TreeItem, itemInfoForm:LegendItemInfo):void
		{
			for(var i:int = 0; i < treeItems.length; i++)
			{
				var itemInfo:LegendItemInfo = (treeItems[0] as TreeItem).legendItemInfo;
				if(itemInfo.name == itemInfoForm.name)
				{ 
					//修改主图片
					itemInfo.imageSource = itemInfoForm.imageSource;
					itemInfo.imageHeight = itemInfoForm.imageHeight;
					itemInfo.imageWidth = itemInfoForm.imageWidth;
					itemInfoForm._imageSourceChanged = true;
					return;
				}
//				if(itemInfo.itemReference.legendItemInfo.isHasChildren == true)
//				{
//					var layerItem:LegendItemInfo = (treeItems[i] as TreeItem).legendItemInfo;
//					var treeItemsLength:int = treeItems[i].length;
//					for(var j:int = 0; j < treeItemsLength; j++)
//					{ 
//						//修改子节点图片
//						var itemInfo2:LegendItemInfo = (treeItems[i] as TreeItem)[j].legendItemInfo;
//						if(itemInfo2.name == itemInfoForm.name)
//						{
//							itemInfo2.imageSource = itemInfoForm.imageSource;
//							itemInfo2.imageHeight = itemInfoForm.imageHeight;
//							itemInfo2.imageWidth = itemInfoForm.imageWidth;
//							if(itemInfo2.index == itemInfoForm.index &&　itemInfo2.imageSource != itemInfoForm.imageSource)
//							{ 							
//								itemInfo2.imageSource = itemInfoForm.imageSource;
//								itemInfo2.imageHeight = itemInfoForm.imageHeight;
//								itemInfo2.imageWidth = itemInfoForm.imageWidth;
//								itemInfoForm._imageSourceChanged = true;
//								return;
//							}
//						}						
//						else
//						{
//							recursionItemImageSourceChange(treeItems[i], itemInfoForm);
//						}
//						
//					}
//				}
			} 
		}
		
		//这里暂根据图层名称的对应关系来进行定位 以后需要修改为按照索引位置来遍历。。。两者都能实现
		private function itemNameChangeHandler(event:LegendEvent):void
		{
			var itemInfoForm:LegendItemInfo = event.legendItemInfo;
			//recursionItemNameChange(this.treeItems, itemInfoForm);
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
//				if(itemInfo.itemReference.legendItemInfo.isHasChildren == true)
//				{
//					var layerItem:LegendItemInfo = (treeItems[i] as TreeItem).legendItemInfo;
//					var treeItemsLength:int = treeItems[i].length;
//					for(var j:int = 0; j < treeItemsLength; j++)
//					{ 
//						//修改子节点名称
//						var itemInfo2:LegendItemInfo = (treeItems[i] as TreeItem)[j].legendItemInfo;
//						if(itemInfo2.imageSource == itemInfoForm.imageSource)
//						{ 							
//							itemInfo2.name = itemInfoForm.name;
//							itemInfoForm._nameChanged = true;
//							if(itemInfoForm._imageSourceChanged)
//							{
//								itemInfo2.imageSource = itemInfoForm.imageSource;
//								itemInfo2.imageHeight = itemInfoForm.imageHeight;
//								itemInfo2.imageWidth = itemInfoForm.imageWidth;
//							}
//							return;
//						}
//						else
//						{
//							recursionItemNameChange(treeItems[i], itemInfoForm);
//						}
//					}
//				}
			} 
		}
		
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
				if((this._treeItems[i] as TreeItem).legendItemInfo.itemReference.length > 0)
				{
					var treeItem:TreeItem = this._treeItems[i] as TreeItem;
					for(var j:int = 0; j < treeItem.length; j++)
					{ 
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
				if((this._treeItems[i] as TreeItem).legendItemInfo.itemReference.length > 0)
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
		
		sm_internal function addItem(legendItemInfo:LegendItemInfo, index:int):void
		{
			var isAlreadyIn:int = findItem(legendItemInfo);
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
			}
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
				if((this._layerItems[i] as LegendItemInfo).itemReference.legendItemInfo.itemReference.length > 0)
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
		
		sm_internal function addTreeItemAt(legendItemInfo:LegendItemInfo, index:int = 0):void
		{		
			var parent:TreeItem = legendItemInfo.itemReference.parent;
			for(var i:int = 0; i < this._treeItems.length; i++)
			{
				if(parent.legendItemInfo == (this._treeItems[i] as TreeItem).legendItemInfo)
				{  
					(this._treeItems[i] as TreeItem).addItemAt(legendItemInfo.itemReference, index);
				}
				if((this._treeItems[i] as TreeItem).legendItemInfo.itemReference.length > 0)
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
		
		/**
		 * ${iServerJava2_components_Legend_attribute_isExpandChildrenItem_D}  
		 * @return 
		 * 
		 */	
		public function get isExpandChildrenItem():Boolean
		{
			return _isExpandChildrenItem;
		}

		public function set isExpandChildrenItem(value:Boolean):void
		{
			_isExpandChildrenItem = value;
			if(this.skin is LegendSkin)
			{
				var skinTree:Tree = (this.skin as LegendSkin).legendTree;
				skinTree.expandChildrenOf(skinTree.dataProvider, value);
			}
		}
          
		[Bindable]
		/**
		 * ${iServerJava2_components_Legend_attribute_dataProvider_D} . 
		 * @return 
		 * 
		 */	
		sm_internal function get dataProvider():Object
		{
			return this._treeItems as Object;
		}
		
		sm_internal function set dataProvider(value:Object):void
		{ 
		}
 
		/**
		 * ${iServerJava2_components_Legend_attribute_layerItems_D} .
		 * <p>${iServerJava2_components_Legend_attribute_layerItems_remarks}</p>
		 * @see com.supermap.web.iServerJava2.components.LegendItemInfo
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
 
		/**
		 * ${iServerJava2_components_Legend_attribute_isShowOnlyVisibleLayers_D} 
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
		 * ${iServerJava2_components_Legend_attribute_layerIDs_D} 
		 * @return 
		 * 
		 */		
		public function get layerIDs():Array
		{
			return _layerIDs;
		}

		public function set layerIDs(value:Array):void
		{
			this._layerIDs = value;  
		}
 
		private function isExpandChildren(isExpand:Boolean):void
		{
		
		}
		
		/**
		 * ${iServerJava2_components_Legend_attribute_Map_D} 
		 * @return 
		 * 
		 */		
		public function get map() : Map
		{
			return this._map;
		}
		
		public function set map(value:Map) : void
		{
			if (this._map !== value && value != null)
			{
				this._map = value;
				this._map.addEventListener(MapEvent.LOAD, layerAddHandler);   
				this._isMapChanged = true;
				invalidateProperties();
			} 
		}
	    
		private function layerAddHandler(event:MapEvent):void
		{ 
			if(event.layer && !(event.layer is ImageLayer))
			{
				return;
			}
				this._isLayerChanged = true;
				this._isLayerAdd = true;
				this._legendCollection.length = 0;
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
			this._legendCollection.length = 0;
			this._taskCompleteCount = 0;
			for (var n:int; n < this._legendLayers.length; n++)
			{ 
				var layer:Layer = this._legendLayers[n] as Layer; 
				layer.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, urlPropertyChangeHandler); 
				var _task:LegendTask = LegendTask.toLegendTask(layer); 
				_task.addEventListener(LegendEvent.PROCESS_COMPLETE, secondGetLayersInfoResult, false, 0, true);
				_task.excute();
			}  
		}
             
		private function secondGetLayersInfoResult(event:LegendEvent):void
		{ 
			this._isRefresh = true;
			this.addLayersInfoItem(event, false);
			this._taskCompleteCount++;
			if(this._taskCompleteCount == this._legendLayers.length)
			{
				this.invalidateProperties(); 
			}  
		}
		/**
		 * ${iServerJava2_components_Legend_attribute_getCurrentSkinState_D}.
		 * <p>${iServerJava2_components_Legend_attribute_getCurrentSkinState_remarks}</p> 
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
				if(this._taskCompleteCount == this._legendCollection.length)
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
			var task:LegendTask = LegendTask.toLegendTask(event.target as Layer); 
		 	task.addEventListener(LegendEvent.PROCESS_COMPLETE, urlChangeResult, false, 0, false);
			task.excute();
		}
	    	  
    	private function excuteTask(successfullyLoadedLayers:Array) : void
		{     
			for (var n:int = 0; n < this._legendLayers.length; n++)
			{ 
				var layer:Layer = successfullyLoadedLayers[n] as Layer; 
				var task:LegendTask = LegendTask.toLegendTask(layer);  
				task.addEventListener(LegendEvent.PROCESS_COMPLETE, firstGetLayersInfoResult, false, 0, true);
				task.excute();
			}  
		}  
           
		private function urlPropertyChangeHandler(event:PropertyChangeEvent):void
		{ 
//			if(event.property == "url")
//			{
//				this._isUrlChanged = true;
//				var task:LegendTask = new LegendTask(event.newValue as String); 
//				task.layerID = (event.currentTarget as Layer).id;
//				task.addEventListener(LegendEvent.PROCESS_COMPLETE, urlChangeResult, false, 0, false);
//				task.excute();
//			}
		}
	 
		private function deleteItemByData(item:Object):void
		{
			for(var i:int; i < this._legendCollection.length; i++)
			{
				if(item.title == this._legendCollection[i].title)
				{ 
					this._legendCollection.splice(i, 1);
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
		
		private function addLayersInfoItem(event:LegendEvent, isReplace:Boolean = true):void
		{
			var item:Object = new Object();
			item.layersInfo = (event.result as GetMapStatusResult).serverLayers;  
			item.title = (event.currentTarget as LegendTask).layerID; 
			this.setItemVisible(item);
			if(isReplace)
			{
				this.deleteItemByData(item); 
			}
			this._legendCollection.push(item); 
		}
	    	
		private function urlChangeResult(event:LegendEvent):void//这个方法应该根据layerID进行调整
		{    
			this.addLayersInfoItem(event);
			var layers:Array = this._legendLayers;
			this.dispatchRefreshEvent()
		}
           
		private function findIndexByLayerID(layerID:String):int
		{
			for(var i:int; i < this._legendCollection.length; i++)
			{
				var item:Object = this._legendCollection[i];
				if(item.title == layerID)
				{
					return i;
				}
			}
			return -1;//没找到
		}
	   
		private function dispatchRefreshEvent():void
		{ 
			this._taskCompleteCount = 0;
			this.initLayerItems();
			this.isExpandChildrenItem = this._isExpandChildrenItem;
			this.dispatchEvent(new LegendEvent(LegendEvent.LEGEND_LOADED, null, null));  
		}
	    	  
		private function initLayerItems():void
		{
			this._layerItems.removeAll(); 
			this._treeItems.removeAll();
			if(this._legendCollection)
			{    
				for(var i:int; i < this._legendCollection.length; i++)
				{  
					if(this._legendCollection[i].visible)
					{
						var treeItem:TreeItem = new TreeItem(this._legendCollection[i].title, this._legendCollection[i].visible, null, -1, this);  
						treeItem.legendItemInfo.imageSource = null; 
						treeItem.legendItemInfo.imageWidth = 0;
						var layerItem:TreeItem = new TreeItem(this._legendCollection[i].title, this._legendCollection[i].visible, null, -1, this);
						this._layerItems.addItem(layerItem.legendItemInfo);
						this._treeItems.addItem(treeItem); 
						this.addSubLayerItems(i, treeItem);//进行层级处理
						this.addSubLayerItems(i, layerItem);//进行层级处理
					}
				}
			}
		}
	    
		private function addSubLayerItems(index:int, parent:TreeItem):void//每个图层的信息
		{
			var infoItem:Object = this._legendCollection[index];  
			if(infoItem != null && infoItem.visible == true)
			{ 
				var serverSubLayers:Array = (infoItem.layersInfo[0] as ServerLayer).serverSubLayers;
				var length:int = serverSubLayers.length;
				for(var i:int; i < length; i++)
				{     
					var subLayer:ServerLayer = serverSubLayers[i] as ServerLayer; 
					var layerType:int = subLayer.layerSettingType; 
					var treeItem:TreeItem = new TreeItem(subLayer.name, subLayer.visible, subLayer.description, layerType, this); 
					if(treeItem.legendItemInfo.isVisible == false)
					{ 
						if(this.isShowOnlyVisibleLayers == false)
						{
							continue;
						} 
					} 
					//treeItem.legendItemInfo.imageUrl = "../assets/legend/" + this.getDataSetType(subLayer.layerSettingType) + ".png";  
					//_layerItems.addItem(treeItem.legendItemInfo); 
					parent.addItem(treeItem);  
				} 
			}
		}
	       
		private function getDataSetType(type:int):String
		{
			switch(type)
			{
				case 149:
					return "cad";
				case 83:
					return "grid";
				case 81:
					return "image";
				case 3:
					return "line";
				case 35:
					return "linem";
				case 4:
					return "network";
				case 1:
					return "point";
				case 5:
					return "region";
				case 0:
					return "tabular";
				case 7:
					return "text";
				case -1: 
					return "undefined";
					
				default:
					return "undefined"; 
			}
		}
		
		private function firstGetLayersInfoResult(event:LegendEvent):void//处理监听到的事件结果
		{  
			this.addLayersInfoItem(event, false);
			this._taskCompleteCount ++; 
			if(this._taskCompleteCount == this._legendLayers.length)
			{
				this.dispatchRefreshEvent(); 
			}
		}  
	}
}
