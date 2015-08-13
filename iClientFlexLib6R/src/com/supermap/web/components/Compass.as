package com.supermap.web.components
{ 
	import com.supermap.web.events.MapEvent;
	import com.supermap.web.events.ViewBoundsEvent;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.MouseEvent;
	
	import spark.components.supportClasses.ButtonBase;
	import spark.components.supportClasses.SkinnableComponent;

	use namespace sm_internal;
	
	[IconFile("/designIcon/Compass.png")]
	/**
	 * ${controls_Compass_Title}.
	 * <p>${controls_Compass_Description}</p> 
	 * 
	 */	
	public class Compass extends SkinnableComponent
	{  
		private var _map:Map;
		/**
		 * @private 
		 */		
		public var panUpElement:ButtonBase;
		/**
		 * @private 
		 */
		public var panDownElement:ButtonBase;
		/**
		 * @private 
		 */
		public var panLeftElement:ButtonBase;
		/**
		 * @private 
		 */
		public var panRightElement:ButtonBase; 
		/**
		 * @private 
		 */
		public var panCenterElement:ButtonBase;
		
		private static var _skinParts:Object = {panUpElement:false, panDownElement:false, panLeftElement:false, panRightElement:false, panCenterElement:false};
		 
		private var _deltaX:Number = 0;
		private var _deltaY:Number = 0;
		
		/**
		 * ${controls_Compass_constructor_None_D} 
		 * 
		 */		
		public function Compass()
		{
			super();
		} 
	 
		/**
		 * ${controls_Compass_attribute_map_D} 
		 * @return 
		 * 
		 */		
		public function get map():Map
		{
			return _map;
		}
 
		public function set map(value:Map):void
		{
			if(this._map != value && value != null)
			{ 
				this._map = value;
				this._map.addEventListener(MapEvent.LOAD, map_loadHandler, false, 0, true); 
				this._map.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, viewBoundsChangeHandler, false, 0, true);
				if(this._map.loaded)
				{
					this.setPanOffset(true);
				} 
		 	}  
		}
          
		private function viewBoundsChangeHandler(event:ViewBoundsEvent):void
		{
			this.setPanOffset(event.levelChange);
		}
		
		private function map_loadHandler(event:MapEvent):void
		{ 
			this.setPanOffset(true);
		}
		
		private function setPanOffset(isLevelChange:Boolean):void
		{
			if(this._map.viewBounds)
			{
				_deltaX = this._map.panFactor * this._map.viewBounds.width;
				_deltaY = this._map.panFactor * this._map.viewBounds.height;
			} 
		}
		
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override protected function get skinParts() : Object
		{
			return _skinParts;
		}
	  
		/**
		 * @private 
		 * @param value
		 * 
		 */		
		override public function set width(value:Number):void
		{
			
		}
	 
		/**
		 * @private 
		 * @param value
		 * 
		 */		
		override public function set height(value:Number):void
		{
			
		}
	 
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override protected function getCurrentSkinState() : String
		{
			if (this.map === null || this.map.loaded === false || this.enabled === false)
			{
				return "disabled";
			} 
			return "normal";
		}
		
		/**
		 * @private 
		 * @param partName
		 * @param instance
		 * 
		 */		
		override protected function partAdded(partName:String, instance:Object) : void
		{ 
			super.partAdded(partName, instance);
			
			if (instance === this.panUpElement)
			{  
				this.panUpElement.addEventListener(MouseEvent.CLICK, this.panUpHandler); 
			}
			else if (instance === this.panDownElement)
			{  
				this.panDownElement.addEventListener(MouseEvent.CLICK, this.panDownHandler); 
			}
			else if (instance === this.panLeftElement)
			{ 
				this.panLeftElement.addEventListener(MouseEvent.CLICK, this.panLeftHandler); 
			} 
			else if (instance === this.panRightElement)
			{ 
				this.panRightElement.addEventListener(MouseEvent.CLICK, this.panRightHandler); 
			}   
			else if (instance === this.panCenterElement)
			{ 
				this.panCenterElement.addEventListener(MouseEvent.CLICK, this.showEntire); 
			} 
		}
	 	
		/**
		 * @private 
		 * @param partName
		 * @param instance
		 * 
		 */		
		override protected function partRemoved(partName:String, instance:Object) : void
		{
			super.partRemoved(partName, instance);
		 
			if (instance === this.panUpElement)
			{ 
				this.panUpElement.removeEventListener(MouseEvent.CLICK, this.panUpHandler); 
			}
			else if (instance === this.panDownElement)
			{  
				this.panDownElement.removeEventListener(MouseEvent.CLICK, this.panDownHandler); 
			}
			else if (instance === this.panLeftElement)
			{ 
				this.panLeftElement.removeEventListener(MouseEvent.CLICK, this.panLeftHandler); 
			} 
			else if (instance === this.panRightElement)
			{ 
				this.panRightElement.removeEventListener(MouseEvent.CLICK, this.panRightHandler); 
			}  
			else if (instance === this.panCenterElement)
			{ 
				this.panCenterElement.removeEventListener(MouseEvent.CLICK, this.showEntire); 
			}  
		}
	 
		/**
		 * ${controls_Compass_method_panUpHandler_D} 
		 * @param event
		 * 
		 */		
		protected function panUpHandler(event:MouseEvent):void
		{
			if(this._map){
				if(this._map.restrictedBounds && (this._map.restrictedBounds.bottom - this._map.viewBounds.bottom)  <= _deltaY)
					return;
				else
					this._map.pan(0, _deltaY);
			}
		}
		
		/**
		 * ${controls_Compass_method_panDownHandler_D} 
		 * @param event
		 * 
		 */		
		protected function panDownHandler(event:MouseEvent):void
		{
			if(this._map){
				if(this._map.restrictedBounds && (this._map.restrictedBounds.top - this._map.viewBounds.top)  >= -_deltaY)
					return;
				else
					this._map.pan(0, -_deltaY);
			}
		}
		
		/**
		 * ${controls_Compass_method_panLeftHandler_D} 
		 * @param event
		 * 
		 */	
		protected function panLeftHandler(event:MouseEvent):void
		{
			if(this._map)
			{
				if(this._map.restrictedBounds && (this._map.restrictedBounds.right - this._map.viewBounds.right)  >= -_deltaX)
					return;
				else
					this._map.pan(-_deltaX, 0);
			}
		}
		
		/**
		 * ${controls_Compass_method_panRightHandler_D} 
		 * @param event
		 * 
		 */	
		protected function panRightHandler(event:MouseEvent):void
		{
			if(this._map)
			{
				if(this._map.restrictedBounds && (this._map.restrictedBounds.left - this._map.viewBounds.left)  <= _deltaX)
					return;
				else
					this._map.pan(_deltaX, 0);
			}
		}
		
		/**
		 * ${controls_Compass_method_showEntire_D} 
		 * @param event
		 * 
		 */	
		protected function showEntire(event:MouseEvent):void
		{
			if(this._map)
				this._map.viewEntire();
		} 
	}
}