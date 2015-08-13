package com.supermap.web.symbol.grid
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.sm_internal;
	
	import flash.events.Event;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.events.PropertyChangeEvent;
	
	use namespace sm_internal;
	
	public class GridItem extends Style
	{
		private var _size:Number = 10;
		private var _color:uint = 0xFF0000;
		private var _alpha:Number = 1;
		private var _isBorder:Boolean = false;
		private var _borderColor:uint = 0x0000FF;
		private var _borderAlpha:Number = 0.8;
		private var _borderWeight:Number = 1;
		private var _attributes:Object;
		sm_internal var _itemCenterX:Number;
		sm_internal var _itemCenterY:Number;
		
		sm_internal var pts:Array;
		sm_internal var centerX:Number;
		sm_internal var centerY:Number;
		
		/**
		 *  构造函数
		 *  @param size 方格项默认大小 默认为10
		 *  @param clolr 方格默认颜色 默认为0xFF0000
		 *  @param alpha 方格透明度 默认为1
		 *  @param attributes 方格属性绑定信息 默认为Null
		 *  @param isBorder 方格是否显示边框 默认为false
		 *  @param borderColor 方格边框颜色 默认为0x0000FF
		 *  @param borderAlpha 方格边框透明度 默认为1
		 *  @param borderWeight 方格边框宽度 默认为1
		 */
		public function GridItem(size:Number = 10, color:uint = 0xFF0000, alpha:Number = 1, attributes:Object = null, isBorder:Boolean = false, borderColor:uint = 0x0000FF, borderAlpha:Number = 1, borderWeight:Number = 1)
		{			
			this._color = color;
			this._alpha = alpha;
			this._attributes = attributes;
			this._isBorder = isBorder;
			this._borderColor = borderColor;
			this._borderAlpha = borderAlpha;
			this._borderWeight = borderWeight;
		}
		
		/**
		 *  返回方格项的中心位置Y坐标值 该值是地理坐标
		 *  @return 
		 */
		sm_internal function get itemCenterY():Number
		{
			return _itemCenterY;
		}

		/**
		 *  返回方格项的中心位置X坐标值 该值是地理坐标
		 */
		sm_internal function get itemCenterX():Number
		{
			return _itemCenterX;
		}

		/**
		 *  获取方格项对应的属性绑定对象
		 *  @return Object
		 */
		public function get attributes():Object
		{
			return _attributes;
		}
		
		public function set attributes(value:Object):void
		{
			var oldValue:Object = this._attributes;
			if(this._attributes !== value)
			{
				this._attributes = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"attributes",oldValue, value));
				}
			}
		}
		
		/**
		 *  方格边框宽度 默认为1
		 *  @return Number
		 */
		public function get borderWeight():Number
		{
			return _borderWeight;
		}
		
		public function set borderWeight(value:Number):void
		{
			var oldValue:Number = this.borderWeight;
			if(this._borderWeight !== value)
			{
				this._borderWeight = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"borderWeight",oldValue, value));
				}
			}
		}
		
		/**
		 *  方格边框透明度 默认为1
		 *  @return Number
		 */
		public function get borderAlpha():Number
		{
			return _borderAlpha;
		}
		
		public function set borderAlpha(value:Number):void
		{
			var oldValue:Number = this.borderAlpha;
			if(this._borderAlpha !== value)
			{
				this._borderAlpha = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"borderAlpha",oldValue, value));
				}
			}
		}
		
		/**
		 *  方格边框颜色 默认为0x0000FF
		 *  @return Number
		 */
		public function get borderColor():uint
		{
			return _borderColor;
		}
		
		public function set borderColor(value:uint):void
		{
			var oldValue:Number = this.borderColor;
			if(this._borderColor !== value)
			{
				this._borderColor = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"borderColor",oldValue, value));
				}
			}
		}
		
		/**
		 *  方格是否显示边框 默认为false
		 *  @return Boolean
		 */
		public function get isBorder():Boolean
		{
			return _isBorder;
		}
		
		public function set isBorder(value:Boolean):void
		{
			var oldValue:Boolean = this.isBorder;
			if(this._isBorder !== value)
			{
				this._isBorder = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"isBorder",oldValue, value));
				}
			}
		}
		
		/**
		 *  方格透明度 默认为1
		 *  @return Number
		 */
		public function get alpha():Number
		{
			return _alpha;
		}
		
		public function set alpha(value:Number):void
		{
			var oldValue:Number = this.alpha;
			if(this._alpha !== value)
			{
				this._alpha = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"alpha",oldValue, value));
				}
			}
		}
		
		/**
		 *  方格默认颜色 默认为0xFF0000
		 *  @return uint
		 */
		public function get color():uint
		{
			return _color;
		}
		
		public function set color(value:uint):void
		{
			var oldValue:Number = this.color;
			if(this._color !== value)
			{
				this._color = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"color",oldValue, value));
				}
			}
		}
		
		/**
		 *  @private
		 */
		override public function toString():String
		{
			return "";
		}
		
		sm_internal static function formGridItem(gridItem:GridItem):GridItem
		{
			var newGridItem:GridItem;
			if(gridItem)
			{
				newGridItem = new GridItem();
				var obj:Object;
				if(gridItem.attributes){
					obj = GridItem.clone(gridItem.attributes);
					newGridItem.attributes = obj;
				}
				newGridItem.borderAlpha = gridItem.borderAlpha;
				newGridItem.borderColor = gridItem.borderColor;
				newGridItem.borderWeight = gridItem.borderWeight;
				newGridItem.isBorder = gridItem.isBorder;
				newGridItem.color = gridItem.color;
				newGridItem.alpha = gridItem.alpha;
			}
			return newGridItem;
		}
		
		/**
		 *  对象深复制
		 *  @private
		 */
		public static function clone(object:Object):Object
		{
			var qClassName:String = getQualifiedClassName(object);			
			var objectType:Class = getDefinitionByName(qClassName) as Class;			
			registerClassAlias(qClassName, objectType);			
			var copier : ByteArray = new ByteArray();			
			copier.writeObject(object);			
			copier.position = 0;			
			return copier.readObject();
		}
	}
}