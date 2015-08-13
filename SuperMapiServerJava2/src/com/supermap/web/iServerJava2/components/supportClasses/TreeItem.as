package com.supermap.web.iServerJava2.components.supportClasses 
{
	import com.supermap.web.iServerJava2.components.Legend;
	import com.supermap.web.iServerJava2.components.LegendItemInfo;
	import com.supermap.web.sm_internal;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import com.supermap.web.iServerJava2.components.LegendEvent;

 	use namespace sm_internal; 
	/**
	 * @private
	 * @author lirh
	 * 
	 */	
	public class TreeItem extends ArrayCollection
	{ 
		private var _children:TreeItem;
		private var _parent:TreeItem;
		private var _legendItemInfo:LegendItemInfo;	 
		private var _legend:Legend;
		
		public function TreeItem(name:String, isVisible:Boolean, description:String, layerType:int, legend:Legend)
		{
			super(null); 
			this._legendItemInfo = LegendItemInfo.toLegendItemInfo(name, isVisible, description, layerType);
			this._legendItemInfo.itemReference = this;
		 	this._legend = legend;
		 	this.children = this; 
			addEventListener(CollectionEvent.COLLECTION_CHANGE,notifitionParent);
		}
	  
		public function get legend():Legend
		{
			return _legend;
		}

		public function get parent():TreeItem
		{
			return _parent;
		}

		public function set parent(value:TreeItem):void
		{
			_parent = value; 
		} 
		
		public function get children():TreeItem
		{
			return _children;
		}

		public function set children(value:TreeItem):void
		{
			_children = value; 
			for(var i:int = 0; i < value.length; i++)
			{
				var treeItem:TreeItem = value[i] as TreeItem;
				this.legendItemInfo.layerItems.addItem(treeItem.legendItemInfo);
			}
		}
 
		[Bindable]
		public function get legendItemInfo():LegendItemInfo
		{
			return _legendItemInfo;
		}

		public function set legendItemInfo(value:LegendItemInfo):void
		{
			_legendItemInfo = value;
		}
  	
		override public function addItem(item:Object):void
		{
			super.addItem(item);
			if(item is TreeItem)
			{
				item.parent=this; 
				this.legendItemInfo.isHasChildren = true;
			}
		
		}
	 	
		override public function addItemAt(item:Object,index:int):void
		{
			super.addItemAt(item,index);
			if(item is TreeItem)
			{
				item.parent=this; 
				this.legendItemInfo.isHasChildren = true;
			}
		}
	    
		public function getIndex():uint
		{
			var index:uint = 0;
			if(this.parent)
			{ 
				for(var i:int = 0; i < this.parent.length; i++)
				{
					var itemInfo:LegendItemInfo = (this.parent[i] as TreeItem).legendItemInfo;
					if(itemInfo == this.legendItemInfo)
					{
						index = i;
					}
				}
			}
			return index;
		}
	 
		sm_internal function dispathVisibleChangehEvent():void
		{
			var legendEvent:LegendEvent = new LegendEvent(LegendEvent.ITEM_VISIBLE_CHANGE, null, this._legendItemInfo);
			if(this._legend)
				this._legend.dispatchEvent(legendEvent);  
		}
		 
		private function notifitionParent(event:CollectionEvent):void
		{
			if(parent)
			{
				parent.itemUpdated(this);
			}
		}  
	}
}