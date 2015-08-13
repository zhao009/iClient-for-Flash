package com.supermap.web.gears.components
{
	
	import com.supermap.web.gears.events.LegendEvent;
	import com.supermap.web.sm_internal;
	
	import mx.collections.ArrayCollection;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_components_LegendItemInfo_Title}.
	 * <p>${iServerJava6R_components_LegendItemInfo_Description}</p> 
	 * 
	 */
	public class LegendItemInfo 
	{ 
		private var _name:String = ""; 
		private var _caption:String = ""; 
		private var _isVisible:Boolean = true;		
		private var _description:String = "";   
		private var _imageHeight:Number = 16;
		private var _imageWidth:Number  = 16; 
		private var _imageSource:String; 
		private var _children:ArrayCollection;  
		private var _itemReference:TreeItem;  
		private var _themeItemIndex:int;
		private var _layerUrl:String = "";  
 		private var _index:uint = 0;
//		sm_internal var _nameChanged:Boolean = false;
		sm_internal var _imageSourceChanged:Boolean = false;
		sm_internal var _nameChanged:Boolean = false;
		sm_internal var _imageWidthChanged:Boolean = false;
		sm_internal var isVisibleChanged:Boolean = false;
		//修改imagesource的时候调用
		sm_internal var legendItemInfoImageSource:String = "";		
		/**
		 * ${iServerJava6R_components_LegendItemInfo_constructor_D}  
		 */
		public function LegendItemInfo()
		{ 
		 	this._children = new ArrayCollection(); 
		}
   
		/**
		 * ${iServerJava6R_components_LegendItemInfo_attribute_layerItems_D}  
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
		 * ${iServerJava6R_components_LegendItemInfo_attribute_description_D} 
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
		public function get caption():String
		{
			return _caption;
		}
		
		public function set caption(value:String):void
		{
			_caption = value;
		}

		/**
		 * ${iServerJava6R_components_LegendItemInfo_attribute_isVisible_D} 
		 * <p>${iServerJava6R_components_LegendItemInfo_attribute_isVisible_remarks}</p> 
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
		
		sm_internal var legendItemInfoName:String = "";
		[Bindable]
		/**
		 * ${iServerJava6R_components_LegendItemInfo_attribute_name_D} 
		 * @return 
		 * 
		 */
		public function get name():String
		{
			return _name;
		}
		
		public function set name(value:String):void
		{			
			legendItemInfoName = this.name;			
			if(value != null)//不允许为空
			{				
				_name = value;
				if(!this._imageSourceChanged)//图片源没有改变的情况
					this.imageSource = this.setImageUrl(legendItemInfoName) + "height=" + this._imageHeight + "&width=" + this._imageWidth; 
				var legend:Legend = (this._itemReference as TreeItem).legend;
				if(legend)
				{
					var treeitem:TreeItem = legend.treeItems;	
					recursionItems(treeitem, legendItemInfoName);
				}
//				for(var i:int = 0; i < treeitem.length; i++)
//				{
//					var iteminfo:LegendItemInfo = (treeitem[i] as TreeItem).legendItemInfo;
//					var treeitem2:TreeItem = iteminfo.itemReference;
//					if(iteminfo.name == legendItemInfoName)
//					{						
//						(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_NAME_CHANGE, this));						
//						return;
//					}
//					if(treeitem2.isHasChildren == true)
//					{						
//						for(var j:int = 0; j < treeitem2.length; j++)
//						{ 
//							var itemInfo:LegendItemInfo = (treeitem2[j] as TreeItem).legendItemInfo;							
//							if(itemInfo.name == legendItemInfoName)
//							{ 
//								(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_NAME_CHANGE, this));
//								return;
//							} 
//							else
//							{
//								if(itemInfo.itemReference.isHasChildren == true)
//								{
//									//这里需要写一个递归
//								}
//							}
//						}
//					}
//				} 
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
					(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_NAME_CHANGE, this));						
					return;
				}
				if(treeitem2.isHasChildren == true)
				{						
					for(var j:int = 0; j < treeitem2.length; j++)
					{ 
						var itemInfo:LegendItemInfo = (treeitem2[j] as TreeItem).legendItemInfo;							
						if(itemInfo.name == legendItemInfoName)
						{ 
							(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_NAME_CHANGE, this));
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
	 
		[Bindable]
		/**
		 * ${iServerJava6R_components_LegendItemInfo_attribute_imageWidth_D} 
		 * @return 
		 * 
		 */
		public function get imageWidth():Number
		{
			return _imageWidth;
		}

		public function set imageWidth(value:Number):void
		{
//			legendItemInfoWidth = this.imageWidth;
			_imageWidthChanged = false;
			if(this._imageWidth != value)
			{				
				_imageWidth = value; 
				if(!this._imageSourceChanged)//图片源没有改变的情况
					this.imageSource = this.setImageUrl(legendItemInfoName) + "height=" + this._imageHeight + "&width=" + this._imageWidth; 
				var legend:Legend = (this._itemReference as TreeItem).legend;
				if(legend)
				{
					var treeitem:TreeItem = legend.treeItems;	
					recursionImageWidth(treeitem, this.name);
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
					(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_IMAGESIZE_CHANGE, this));						
					return;
				}
				if(treeitem2.isHasChildren == true)
				{						
					for(var j:int = 0; j < treeitem2.length; j++)
					{ 
						var itemInfo:LegendItemInfo = (treeitem2[j] as TreeItem).legendItemInfo;
						if(itemInfo.name == name)
						{ 
							(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_IMAGESIZE_CHANGE, this));
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
		 * ${iServerJava6R_components_LegendItemInfo_attribute_imageHeight_D} 
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
				if(!this._imageSourceChanged)//图片源没有改变的情况
					this.imageSource = this.setImageUrl(legendItemInfoName) + "height=" + this._imageHeight + "&width=" + this._imageWidth; 
				var legend:Legend = (this._itemReference as TreeItem).legend;
				if(legend)
				{
					var treeitem:TreeItem = legend.treeItems;	
					recursionImageWidth(treeitem, this.name);
//				this._itemReference.dispathRefreshEvent();
				}
			} 
		}
 
		[Bindable]
		/**
		 * ${iServerJava6R_components_LegendItemInfo_attribute_imageSource_D}.
		 * <p>${iServerJava6R_components_LegendItemInfo_attribute_imageSource_remarks}</p>
		 * @return 
		 * 
		 */
		public function get imageSource():String
		{  
			if(this._imageSource == null)//执行默认行为
			{ 
				if(this._layerUrl == null || this._layerUrl.length == 0)
				{ 
//					this._imageWidth = 0;
//					this._imageHeight = 0;
					return "";
				}  
				else  
				{
					return this.setImageUrl() + "height=" + this._imageHeight + "&width=" + this._imageWidth; 
				}
			}
			else 
			{ 
				return this._imageSource;
			} 
		}
          
		public function set imageSource(value:String):void
		{ 
			legendItemInfoImageSource = this.imageSource;
			_imageSourceChanged = false;
	 		if(value != null && value.length > 0)//不允许为空
			{
				this._imageSource = value;
				//if(!this._nameChanged)//名称没有改变的情况下
				var legend:Legend = (this._itemReference as TreeItem).legend;
				if(legend && legend.treeItems)
				{
					var treeitem:TreeItem = legend.treeItems;				
					recursionImageSource(treeitem, legendItemInfoImageSource);
				}
			}
		}
		
		private function recursionImageSource(treeItem:TreeItem, value:String):void
		{
			for(var i:int = 0; i < treeItem.length; i++)
			{
				var iteminfo:LegendItemInfo = (treeItem[i] as TreeItem).legendItemInfo;
				var treeitem2:TreeItem = iteminfo.itemReference;
				if(iteminfo.imageSource == value)
				{						
					(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_IMAGESOURCE_CHANGE, this));						
					return;
				}
				if(treeitem2.isHasChildren == true)
				{						
					for(var j:int = 0; j < treeitem2.length; j++)
					{ 
						var itemInfo:LegendItemInfo = (treeitem2[j] as TreeItem).legendItemInfo;
						if(itemInfo.imageSource == value)
						{ 								
							(this._itemReference as TreeItem).legend.dispatchEvent(new LegendEvent(LegendEvent.ITEM_IMAGESOURCE_CHANGE, this));
							return;
						} 
						else
						{
							recursionImageSource(treeitem2, value);
						}
					}
				}
			} 
		}
          
		//------------------------------------------------------------
		//
		//	内部方法
		//
		//------------------------------------------------------------
		
		/**
		 * 为TreeItem类型对象设置索引
		 */
		sm_internal function get index():uint
		{
			return _index;
		}
		
		sm_internal function set index(value:uint):void
		{
			_index = value;
		}

		sm_internal static function toLegendItemInfo(caption:String, name:String, isVisible:Boolean, descirption:String, index:int, width:int, height:int):LegendItemInfo
		{
			var legendItemInfo:LegendItemInfo = new LegendItemInfo();
			legendItemInfo._name = name;
			legendItemInfo.caption = caption;
			legendItemInfo._isVisible = isVisible;
			if(descirption)
			{
				legendItemInfo._description = descirption;
			} 
			legendItemInfo._themeItemIndex = index; 
			if(!width)				
				legendItemInfo._imageWidth = 16;
			if(!height)
				legendItemInfo._imageHeight = 16;
			return legendItemInfo;
		}
		
		sm_internal function setImageUrl(name:String = ""):String
		{
			var url:String = "";
			if(name == "")
				url = this.layerUrl + "layers/" + this.resetName(this.name, this._themeItemIndex) + "@@" + this.getMapName(this.layerUrl) + this.isHasThemeItem(this._themeItemIndex) +  "/legend.png?"
			else
				url = this.layerUrl + "layers/" + this.resetName(name, this._themeItemIndex) + "@@" + this.getMapName(this.layerUrl) + this.isHasThemeItem(this._themeItemIndex) +  "/legend.png?"
			return url;
		}
			
		sm_internal function get layerUrl():String
		{ 
			return _layerUrl;
		}
		
		sm_internal function set layerUrl(value:String):void
		{
			_layerUrl = value;
		}
		 
		sm_internal function setDescription(value:String):void
		{
			this._description = value;
		}
		
		sm_internal function set itemReference(value:TreeItem):void
		{
			this._itemReference = value;
		}
		
		sm_internal function get itemReference():TreeItem
		{
			return this._itemReference 
		}
	 
		private function getMapName(url:String):String//返回地图名
		{ 
			var mapUrl:String = url; 
			if(mapUrl.charAt(mapUrl.length - 1) == "/")
			{
				mapUrl = mapUrl.substr(0, mapUrl.length - 1);
			}
			var index:int = mapUrl.lastIndexOf("/");
			var mapName:String = mapUrl.substring(index + 1, mapUrl.length);  
			return mapName;
		} 
		
		private function resetName(name:String, index:int):String
		{
			if(index != TreeItem.NONE_THEME && this._itemReference.parent)
			{
				name = this._itemReference.parent.legendItemInfo.name;//如果是专题图子项
			} 
			if(name.match("#"))
			{
				return name.replace("#", ".");
			}
			return name;
		}
		
		private function isHasThemeItem(index:int):String
		{ 
			if(index == TreeItem.NONE_THEME)
			{
				return "";
			}
			else
			{
				return "/items/" + index;
			} 	
		}
	}
}
