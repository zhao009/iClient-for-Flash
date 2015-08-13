package com.supermap.web.gears.components 
{
	import com.supermap.web.gears.events.LegendEvent;
	import com.supermap.web.sm_internal;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;

 	use namespace sm_internal;
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
	public class TreeItem extends ArrayCollection
	{ 
		private var _children:TreeItem;
		private var _parent:TreeItem;
		private var _isHasChildren:Boolean;
		private var _legend:Legend;
		private var _legendItemInfo:LegendItemInfo;
	 
		public static const NONE_THEME:int = -1;
	 
		public function TreeItem(caption:String, name:String, isVisible:Boolean, description:String, index:int, legend:Legend)
		{  
			super(null); 
			this._legend = legend;
			var width:int;
			var height:int;
			if(this._legend)
			{
				width = this._legend.sourceImageWidth;
				height = this._legend.sourceImageHeight; 
			}
			if(this.parent == null)
			{
				this.legendItemInfo = LegendItemInfo.toLegendItemInfo(caption, name, isVisible, description, index, width, height); 
		 	}
			else
			{
				this.legendItemInfo = LegendItemInfo.toLegendItemInfo(caption, name, isVisible, description, index, width, height); 
	 		} 
			this.legendItemInfo.itemReference = this; 
		 	this.children = this; 
			this.addEventListener(CollectionEvent.COLLECTION_CHANGE,notifitionParent); 
		}
 
		public function get legend():Legend
		{
			return _legend;
		}

		[Bindable]
		public function get isHasChildren():Boolean
		{
			return _isHasChildren;
		}

		public function set isHasChildren(value:Boolean):void
		{
			_isHasChildren = value;
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
	    	
		override public function addItem(item:Object):void
		{
			super.addItem(item); 
			if(item is TreeItem)
			{
				item.parent=this;  
				this.isHasChildren = true; 
			} 
		}
 	
		override public function addItemAt(item:Object,index:int):void
		{
			super.addItemAt(item,index);
			if(item is TreeItem)
			{
				item.parent=this;  
				this.isHasChildren = true; 
			} 
		}
	    
		sm_internal function dispathRefreshEvent():void
		{
			var legendEvent:LegendEvent = new LegendEvent(LegendEvent.ITEM_REFRESH, this.legendItemInfo);
			this._legend.dispatchEvent(legendEvent);  
		}
		
		sm_internal function dispathVisibleChangehEvent():void
		{
			var legendEvent:LegendEvent = new LegendEvent(LegendEvent.ITEM_VISIBLE_CHANGE, this.legendItemInfo);
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