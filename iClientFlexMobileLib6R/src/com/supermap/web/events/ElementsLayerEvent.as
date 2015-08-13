package com.supermap.web.events
{
	import com.supermap.web.core.Element;
	import com.supermap.web.sm_internal;
	
	import flash.events.Event;
	
	import mx.core.INavigatorContent;

	/** 
	 * ${events_ElementsLayerEvent_Title}.
	 * <p>${events_ElementsLayerEvent_Description}</p>
	 */	 
	public class ElementsLayerEvent extends Event
	{
		/**
		 * ${events_ElementsLayerEvent_field_ELEMENT_ADD_D} 
		 */		
		public static const ELEMENT_ADD:String = "elementAdd";
		/**
		 * ${events_ElementsLayerEvent_field_ELEMENT_REMOVE_ALL_D} 
		 */		
		public static const ELEMENT_REMOVE_ALL:String = "elementRemoveAll";
		/**
		 * ${events_ElementsLayerEvent_field_ELEMENT_REMOVE_D} 
		 */		
		public static const ELEMENT_REMOVE:String = "elementRemove";
		/**
		 * ${events_ElementsLayerEvent_field_ELEMENTS_CHANGE_D} 
		 */
		public static const ELEMENTS_CHANGE:String = "elementsChange";
		
//		public static const ELEMENT:String = "elementBoundChange";//element的bounds的修改重绘事件
		
		/**
		 * ${events_ElementsLayerEvent_field_ELEMENT_CHANGE_D} 
		 */		
		public static const ELEMENT_CHANGE:String = "elementChange";//element的component属性修改事件
		
		/**
		 * ${events_ElementsLayerEvent_field_ELEMENT_WH_CHANGE_D} 
		 */		
		public static const ELEMENT_SIZE_CHANGE:String = "elementSizeChange";
		
		private var _element:Element;
//		private var _elementIndex:int;
//		private var _isBoundsChange:Boolean;
//		private var _isComponentChange:Boolean;
		
		/**
		 * ${events_ElementsLayerEvent_constructor_D} 
		 * @param type ${events_ElementsLayerEvent_constructor_param_type}
		 * @param element ${events_ElementsLayerEvent_constructor_param_element}
		 * 
		 */	
		
		public function ElementsLayerEvent(type:String, element:Element)
		{
			super(type);  
			this._element = element;
//			this._elementIndex = elementIndex;
//			this._isBoundsChange = isBoundsChange;
//			this._isComponentChange = isComponentChange;
		}
		
//		public function get isComponentChange():Boolean
//		{
//			return _isComponentChange;
//		}
//
//		public function set isComponentChange(value:Boolean):void
//		{
//			_isComponentChange = value;
//		}
//
//		public function get isBoundsChange():Boolean
//		{
//			return _isBoundsChange;
//		}
//
//		public function set isBoundsChange(value:Boolean):void
//		{
//			_isBoundsChange = value;
//		}
//
//		sm_internal function get elementIndex():int
//		{
//			return _elementIndex;
//		}
//
//		sm_internal function set elementIndex(value:int):void
//		{
//			_elementIndex = value;
//		}

		/**
		 * ${events_ElementsLayerEvent_attribute_element_D} 
		 * @return 
		 * 
		 */	
		public function get element():Element
		{
			return _element;
		}
        
		public function set element(value:Element):void
		{
			_element = value;
		}
		/**
		 * @private
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new ElementsLayerEvent(type, this._element);
		}
		/**
		 * @private 
		 * @return 
		 * 
		 */	
		override public function toString() : String
		{
			return formatToString("ElementsLayerEvent", "type", "element");
		}
	}
}