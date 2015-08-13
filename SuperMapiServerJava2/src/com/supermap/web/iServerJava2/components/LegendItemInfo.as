package com.supermap.web.iServerJava2.components
{ 
	import com.supermap.web.iServerJava2.components.supportClasses.TreeItem;
	import com.supermap.web.sm_internal;
	
	import mx.collections.ArrayCollection;

	use namespace sm_internal;
	/**
	 * ${iServerJava2_components_LegendItemInfo_Title}.
	 * <p>${iServerJava2_components_LegendItemInfo_Description}</p> 
	 * 
	 */
	public class LegendItemInfo 
	{ 
		private var _name:String = ""; 
		private var _isVisible:Boolean = true;   
		private var _description:String = "";  
		private var _layerSettingType:int; 
		private var _imageSource:String = "";  
		private var _isHasChildren:Boolean = false;   
		private var _imageHeight:Number = 16;
		private var _imageWidth:Number  = 16;  
		private var _children:ArrayCollection; 
		[Bindable]
		private var _itemReference:TreeItem;
		private var _index:uint;		
		
		sm_internal var _imageSourceChanged:Boolean = false;
		sm_internal var _nameChanged:Boolean = false;
		sm_internal var _imageWidthChanged:Boolean = false;
		sm_internal var isVisibleChanged:Boolean = false;
		/**
		 * ${iServerJava2_components_LegendItemInfo_constructor_D}  
		 * 
		 */
		public function LegendItemInfo()
		{ 
		 	this._children = new ArrayCollection(); 
		}
   
		//----------------------------------------------------------------------------
		//
		//	只读属性
		//
		//----------------------------------------------------------------------------
 
		sm_internal function get index():uint
		{
			return _index;
		}

		sm_internal function set index(value:uint):void
		{
			_index = value;
		}

		sm_internal function get layerSettingType():int
		{
			return _layerSettingType;
		}

		sm_internal function set layerSettingType(value:int):void
		{
			_layerSettingType = value;
		}
        
		/**
		 * ${iServerJava2_components_LegendItemInfo_attribute_layerItems_D} 
		 * @return 
		 * 
		 */
		public function get layerItems():ArrayCollection
		{
			this._children.removeAll();
			for(var i:int = 0; i < this._itemReference.length; i++)
			{
				var legendItemInfo:LegendItemInfo = (this._itemReference[i] as TreeItem).legendItemInfo;
				this._children.addItem(legendItemInfo);
			}
			return _children;
		}
 
		[Bindable]
		/**
		 * ${iServerJava2_components_LegendItemInfo_attribute_description_D} 
		 * @return 
		 * 
		 */
		public function get description():String
		{
			return _description;
		}

		public function set description(value:String):void
		{
			_description = value;
		}

		[Bindable]
		/**
		 * ${iServerJava2_components_LegendItemInfo_attribute_isVisible_D} 
		 *  <p>${iServerJava2_components_LegendItemInfo_attribute_isVisible_remarks}</p>  
		 * @return 
		 * 
		 */
		public function get isVisible():Boolean
		{
			return _isVisible;
		}
		
		public function set isVisible(value:Boolean):void
		{
			if(this._isVisible != value)
			{
				isVisibleChanged = true;
				_isVisible = value;
				this._itemReference.dispathVisibleChangehEvent(); 
			}
			if(this.isVisible)
			{				
				isVisibleChanged = false;
				_isVisible = value;
				this._itemReference.dispathVisibleChangehEvent(); 
				//this.layerItems[0];
			}
		}
		
		[Bindable]
		/**
		 * ${iServerJava2_components_LegendItemInfo_attribute_name_D} 
		 * @return 
		 * 
		 */
		public function get name():String
		{
			return _name;
		}
		
		sm_internal var legendItemInfoName:String = "";
		public function set name(value:String):void
		{
			legendItemInfoName = this.name;			
			if(value != null && legendItemInfoName == value)//不允许为空
			{				
				_name = value;
//				if(!this._imageSourceChanged)//图片源没有改变的情况
//					this.imageSource = this.setImageUrl(legendItemInfoName) + "height=" + this._imageHeight + "&width=" + this._imageWidth; 
//				var treeitem:TreeItem = (this._itemReference as TreeItem).legend.treeItems;	
//				recursionItems(treeitem, legendItemInfoName);
			}
		}
		
		//递归
		private function recursionItems(treeItem:TreeItem, legendItemInfoName:String):void      
		{
			for(var i:int = 0; i < treeItem.length; i++)
			{
				var iteminfo:LegendItemInfo = (treeItem[i] as TreeItem).legendItemInfo;
				var treeitem2:TreeItem = iteminfo.itemReference;
				if(iteminfo.name == legendItemInfoName)
				{						
					(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_NAME_CHANGE, null, this));						
					return;
				}
				if(treeitem2.legendItemInfo.isHasChildren == true)
				{						
					for(var j:int = 0; j < treeitem2.length; j++)
					{ 
						var itemInfo:LegendItemInfo = (treeitem2[j] as TreeItem).legendItemInfo;							
						if(itemInfo.name == legendItemInfoName)
						{ 
							(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_NAME_CHANGE, null, this));
							return;
						} 
						else
						{
							recursionItems(treeitem2, legendItemInfoName);
						}
					}
				}
			} 
		}
		 
		//----------------------------------------------------------------------------
		//
		//	用于控制显示的属性
		//
		//----------------------------------------------------------------------------
	 

		[Bindable]
		/**
		 * ${iServerJava2_components_LegendItemInfo_attribute_imageWidth_D} 
		 * @return 
		 * 
		 */
		public function get imageWidth():Number
		{
			return _imageWidth;
		}

		public function set imageWidth(value:Number):void
		{
			_imageWidthChanged = false;
			if(this._imageWidth != value)
			{				
				_imageWidth = value; 
//				if(!this._imageSourceChanged)//图片源没有改变的情况
//					this.imageSource = this.setImageUrl(legendItemInfoName) + "height=" + this._imageHeight + "&width=" + this._imageWidth; 
				var legend:Legend = (this._itemReference as TreeItem).legend;
				if(legend)
				{
					var treeitem:TreeItem = (this._itemReference as TreeItem).legend.treeItems;	
					//recursionImageWidth(treeitem, this.name);
				}
			}
		}
		
		private function recursionImageWidth(treeItem:TreeItem, name:String):void
		{
			for(var i:int = 0; i < treeItem.length; i++)
			{
				var iteminfo:LegendItemInfo = (treeItem[i] as TreeItem).legendItemInfo;
				var treeitem2:TreeItem = iteminfo.itemReference;
				if(iteminfo.name == name)
				{						
					(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_IMAGESIZE_CHANGE, null, this));						
					return;
				}
				if(treeitem2.legendItemInfo.isHasChildren == true)
				{						
					for(var j:int = 0; j < treeitem2.length; j++)
					{ 
						var itemInfo:LegendItemInfo = (treeitem2[j] as TreeItem).legendItemInfo;
						if(itemInfo.name == name)
						{ 
							(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_IMAGESIZE_CHANGE, null, this));
							return;
						} 
						else
						{
							recursionImageWidth(treeitem2, name);
						}
					}
				}
			}
		}

		[Bindable]
		/**
		 * ${iServerJava2_components_LegendItemInfo_attribute_imageHeight_D} 
		 * @return 
		 * 
		 */
		public function get imageHeight():Number
		{
			return _imageHeight;
		}

		public function set imageHeight(value:Number):void
		{
			if(this._imageHeight != value)
			{
				_imageHeight = value; 
//				if(!this._imageSourceChanged)//图片源没有改变的情况
//					this.imageSource = this.setImageUrl(legendItemInfoName) + "height=" + this._imageHeight + "&width=" + this._imageWidth;
				var legend:Legend = (this._itemReference as TreeItem).legend;
				if(legend)
				{
					var treeitem:TreeItem = legend.treeItems;
					//recursionImageWidth(treeitem, this.name);
				}

			}
		}

		[Bindable]
		/**
		 * ${iServerJava2_components_LegendItemInfo_attribute_isHasChildren_D} 
		 * @return 
		 * 
		 */	
		public function get isHasChildren():Boolean
		{
			return _isHasChildren;
		}

		public function set isHasChildren(value:Boolean):void
		{
			_isHasChildren = value;
		}
 
		[Bindable]
		/**
		 * ${iServerJava2_components_LegendItemInfo_attribute_imageSource_D}.
		 * <p>${iServerJava2_components_LegendItemInfo_attribute_imageSource_remarks}</p> 
		 * @return 
		 * 
		 */
		public function get imageSource():String
		{
			return _imageSource;
		}
 
		sm_internal var legendItemInfoImageSource:String = "";
		public function set imageSource(value:String):void
		{
			legendItemInfoImageSource = this.imageSource;
			_imageSourceChanged = false;
			if(value != null && value.length > 0)//不允许为空
			{
				this._imageSource = value;
				//if(!this._nameChanged)//名称没有改变的情况下				
				var treeitem:TreeItem = (this._itemReference as TreeItem).legend.treeItems;				
				recursionImageSource(treeitem, legendItemInfoImageSource);
			}
		}
		
		private function recursionImageSource(treeItem:TreeItem, value:String):void
		{
//			for(var i:int = 0; i < treeItem.length; i++)
//			{				
				var iteminfo:LegendItemInfo = (treeItem[0] as TreeItem).legendItemInfo;
				var treeitem2:TreeItem = iteminfo.itemReference;
				if(iteminfo.imageSource == value)
				{						
					(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_IMAGESOURCE_CHANGE, null, this));						
					return;
				}
//				if(treeitem2.legendItemInfo.isHasChildren == true)
//				{						
//					for(var j:int = 0; j < treeitem2.length; j++)
//					{ 
//						var itemInfo:LegendItemInfo = (treeitem2[j] as TreeItem).legendItemInfo;
//						if(itemInfo.imageSource == value)
//						{ 								
//							(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_IMAGESOURCE_CHANGE, null, this));
//							return;
//						} 
//						else
//						{
//							recursionImageSource(treeitem2, value);
//						}
//					}
//				}
//			} 
		}
		
		//------------------------------------------------------------
		//
		//	内部方法
		//
		//------------------------------------------------------------
		
		sm_internal static function toLegendItemInfo(name:String, isVisible:Boolean, descirption:String, layerType:int):LegendItemInfo
		{
			var legendItemInfo:LegendItemInfo = new LegendItemInfo();
			legendItemInfo._name = name;
			legendItemInfo._isVisible = isVisible;
			if(descirption)
			{
				legendItemInfo._description = descirption;
			}
			legendItemInfo._layerSettingType = layerType;
			return legendItemInfo;
		}	
		
		sm_internal function set itemReference(value:TreeItem):void
		{
			this._itemReference = value;
		}
		
		sm_internal function get itemReference():TreeItem
		{
			return this._itemReference;
		}
	}
}
