package com.supermap.web.symbol.event
{
	import com.supermap.web.core.styles.CompositeStyle;
	import com.supermap.web.sm_internal;
	import com.supermap.web.symbol.clover.SectorItem;
	import com.supermap.web.symbol.clover.SectorSprite;
	
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	use namespace sm_internal;
	
	/**
	 * ${symbol_event_CloverEvent_Title}.
	 * <p>${symbol_event_CloverEvent_Description}</p>
	 * @see com.supermap.web.symbol.clover.CloverStyle 
	 * 
	 */	
	public class CloverEvent extends MouseEvent
	{
		sm_internal var _mouseEvent:MouseEvent;		
		private var _sectorItem:SectorItem;
		private var _attributes:Object;

		/**
		 * ${symbol_event_CloverEvent_attribute_CLOVER_OVER_D} 
		 */		
		public static const CLOVER_OVER:String = "clover0ver";
		/**
		 * ${symbol_event_CloverEvent_attribute_CLOVER_OUT_D} 
		 */		
		public static const CLOVER_OUT:String = "clover0ut";

		/**
		 * ${symbol_event_CloverEvent_attribute_CLOVER_CLICK_D} 
		 */		
		public static const CLOVER_CLICK:String = "cloverClick";
		
		public static const GRAPHIC_CLICK:String = "graphicClick";
		
		/**
		 * ${symbol_event_CloverEvent_constructor_D} 
		 * @param type ${symbol_event_CloverEvent_constructor_param_type}
		 * @param sectorItem ${symbol_event_CloverEvent_constructor_param_sectorItem}
		 * @param attributes ${symbol_event_CloverEvent_constructor_param_attributes}
		 * 
		 */		
		public function CloverEvent(type:String, sectorItem:SectorItem = null, attributes:Object = null)
		{
			super(type, true, true);	
			this._sectorItem = sectorItem;
			this._attributes = attributes;
		}

		public function get attributes():Object
		{
			return _attributes;
		}

		sm_internal function get mouseEvent():MouseEvent
		{
			return _mouseEvent;
		}

		sm_internal function set mouseEvent(value:MouseEvent):void
		{
			_mouseEvent = value;
		}

		/**
		 * ${symbol_event_CloverEvent_attribute_sectorItem_D} 
		 * @return 
		 * 
		 */		
		public function get sectorItem():SectorItem
		{
			return _sectorItem;
		}

		public function set sectorItem(value:SectorItem):void
		{
			_sectorItem = value;
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function get stageX():Number
		{
			return this._mouseEvent.stageX;
//			return super.stageX;
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function get stageY():Number
		{
			return this._mouseEvent.stageY;
//			return super.stageY;
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			var cloverEvent:CloverEvent = new CloverEvent(type, this._sectorItem);
			cloverEvent.copyProperties(this._mouseEvent);
			return cloverEvent;
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

		sm_internal function copyProperties(event:MouseEvent):void
		{
			localX = event.localX;
			localY = event.localY;
			relatedObject = event.relatedObject;
			ctrlKey = event.altKey;
			altKey = event.altKey;
			shiftKey = event.shiftKey;
			buttonDown = event.buttonDown;
			delta = event.delta;
			this._mouseEvent = event;
		}

	}
}