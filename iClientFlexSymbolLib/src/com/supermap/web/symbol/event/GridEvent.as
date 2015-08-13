package com.supermap.web.symbol.event
{
	import com.supermap.web.symbol.grid.GridItem;
	
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class GridEvent extends MouseEvent
	{
		/**
		 *  与该事件绑定的方格对象
		 */
		private var _gridItem:GridItem;
		/**
		 *  事件数据对象
		 */
		private var _attributes:Object;
		/**
		 *  鼠标移动到方格对象上面时触发
		 */
		public static const GRID_OVER:String = "grid0ver";
		/**
		 *  鼠标移出方格对象上面时触发
		 */
		public static const GRID_OUT:String = "grid0ut";
		/**
		 *  鼠标单击方格对象上面时触发
		 */
		public static const GRID_CLICK:String = "gridClick";
		/**
		 *  鼠标单击方格对象上面时触发，仅使用在Graphic上
		 */
		public static const GRAPHIC_CLICK:String = "graphicClick";
		
		/**
		 * 构造函数
		 * @param type
		 * @param gridItem
		 * @param attributes
		 */
		public function GridEvent(type:String, gridItem:GridItem = null, attributes:Object = null)
		{
			super(type, true, true);	
			this._gridItem = gridItem;
			this._attributes = attributes;
		}
		
		/**
		 *  获取方格事件绑定的属性封装对象
		 *  @return 
		 */
		public function get attributes():Object
		{
			return _attributes;
		}

		public function set attributes(value:Object):void
		{
			_attributes = value;
		}

		/**
		 *  获取方格事件绑定的方格项
		 *  @return 
		 */
		public function get gridItem():GridItem
		{
			return _gridItem;
		}

		public function set gridItem(value:GridItem):void
		{
			_gridItem = value;
		}

		/**
		 * @private 
		 * @return 
		 * 
		 */	
		override public function clone():Event
		{
			var gridEvent:GridEvent = new GridEvent(type, this._gridItem);
			return gridEvent;
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */	
		override public function toString():String
		{
			return formatToString("CloverEvent", "type");
		}
	}
}