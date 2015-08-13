package com.supermap.web.core
{	
	import com.supermap.web.events.ElementsLayerEvent;
	import com.supermap.web.mapping.ElementsLayer;
	import com.supermap.web.sm_internal;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	
	import mx.core.UIComponent;
	import mx.events.ResizeEvent;
	import mx.utils.NameUtil;
	
	/**
	 * ${core_Element_Title}.
	 * <p>${core_Element_Description}</p>
	 * 
	 */	
	public class Element
	{
		private var _bounds:Rectangle2D;
		private var _component:UIComponent;
		private var _id:String;
//		private var _oldComponent:DisplayObject;		
//		private var _componentChange:Boolean = false;
		private var _oldBounds:Rectangle2D;
		private var _offset:Point = new Point(0,0);
//		private var _boundsChange:Boolean = false;
//		private var _needUpdate:Boolean;

		private var disObjWidth:int;
		private var disObjHeight:int;
//		sm_internal function get boundsChange():Boolean
//		{
//			return _boundsChange;
//		}
//
//		sm_internal function set boundsChange(value:Boolean):void
//		{
//			_boundsChange = value;
//		}
//
//		sm_internal function get oldBounds():Rectangle2D
//		{
//			return _oldBounds;
//		}
//
//		sm_internal function get componentChange():Boolean
//		{
//			return _componentChange;
//		}

//		sm_internal function set componentChange(value:Boolean):void
//		{
//			_componentChange = value;
//		}
//
//		sm_internal function get oldComponent():DisplayObject
//		{
//			return _oldComponent;
//		}

		/**
		 * ${core_Element_attribute_offset_D} 
		 * @return 
		 */	
		public function get offset():Point
		{
			return _offset;
		}
		
		public function set offset(value:Point):void
		{
			_offset = value; 
		}

		/**
		 * ${core_Element_attribute_id_D} 
		 * @return 
		 */	
		public function get id():String
		{
			return _id;
		}

		public function set id(value:String):void
		{
			_id = value; 
		}

		/**
		 * ${core_Element_constructor_D} 
		 * @param component ${core_Element_constructor_param_component}
		 * @param bBox ${core_Element_constructor_param_bBox}
		 * 
		 */		
		public function Element(component:UIComponent = null, bounds:Rectangle2D = null)
		{
			super();
			this._component = component;
			this._bounds = bounds;  
			this._id = NameUtil.createUniqueName(this);
		}
        
		/**
		 * ${core_Element_attribute_component_D} 
		 * @return 
		 * 
		 */		
		public function get component():UIComponent
		{
			return _component;
		}
    
		public function set component(elementObj:UIComponent):void
		{
			
//			if(this._component)
//			{
//				if(value != this._component)
//				{
//					_oldComponent = this._component;
//					this._component = value;
//					_componentChange = true;
//					this.needUpdate = true;
//				}
//			}
//			else
//			{
				_component = elementObj; 
//			}
			
//			if(value.width)	
//			{
//				disObjWidth = value.width;	
//			}
//			if(value.height)
//			{
//				disObjHeight = value.height;
//			}
//			var obj:Object = {
//				width:disObjWidth,
//				height:disObjHeight
//			}
//			if(this._component.parent is ElementsLayer)
//			{
//				var el:ElementsLayer = this._component.parent as ElementsLayer;
//				
//				value.dispatchEvent(new ElementsLayerEvent(ElementsLayerEvent.ELEMENT_WH_CHANGE, this));
//			}
			elementObj.addEventListener(ResizeEvent.RESIZE,resizeHandler);
		}
		
		private function resizeHandler(event:ResizeEvent):void{
			trace("Bounds:"+this._bounds);
			
			var parent:DisplayObject = this._component.parent;
			if(parent && parent is ElementsLayer)
			{
				var el:ElementsLayer = parent as ElementsLayer;
				el.dispatchEvent(new ElementsLayerEvent(ElementsLayerEvent.ELEMENT_SIZE_CHANGE, this));
			}
		}
		
		private function reDrawHandler(event:ElementsLayerEvent):void
		{
			
		}
		
		/**
		 * ${core_Element_attribute_bBox_D}.
		 * <p>${core_Element_attribute_bBox_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}
        
		public function set bounds(value:Rectangle2D):void
		{
			if(this._bounds)
			{
				if(this._bounds != value)
				{
					_oldBounds = this._bounds;
					this._bounds = value;
//					_boundsChange = true;
					this.refresh();
//					if(this._component)
//						this.needUpdate = true;
				}
			}
			else
			{
				_bounds = value;
			}
		}   
		
//		private  function set needUpdate(value:Boolean):void
//		{
//			if(_needUpdate == value) return;
//			_needUpdate = value;	
//			if(_needUpdate) 
//			{
//				this.component.addEventListener(Event.RENDER, refresh);		
//				if(this.component.stage != null) 
//					this.component.stage.invalidate();		
//			} 
//			else 
//			{		
//				this.component.removeEventListener(Event.RENDER, refresh);			
//			}
//		}
		
		private function refresh():void
		{
			var parent:DisplayObjectContainer;
//			if(_boundsChange)
//				parent = _component.parent;
//			if(!parent)
//				parent = this._oldComponent.parent;
			parent = this._component.parent;
			if(parent && parent is ElementsLayer)
			{
//				if(_componentChange)
//				{
//					var elementLayer:ElementsLayer = parent as ElementsLayer;
//					var index:int;
//					if(elementLayer.elements)
//					{
//						var len:int = elementLayer.elements.length;
//						for(var i:int = 0; i < len; i++)
//						{
//							var element:Element = elementLayer.getElementAt(i) as Element;
//							if(element.component == _oldComponent)
//								index = i;
//						}
//					}
//				}
				var changeEvent:ElementsLayerEvent = new ElementsLayerEvent(ElementsLayerEvent.ELEMENT_CHANGE, this);
				parent.dispatchEvent(changeEvent);
				
			}
			
//			this.needUpdate = false;
		}
	}
}
 