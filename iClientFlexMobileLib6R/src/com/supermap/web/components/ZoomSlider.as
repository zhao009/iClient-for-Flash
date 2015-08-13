package com.supermap.web.components
{ 
	import com.supermap.web.events.MapEvent;
	import com.supermap.web.events.ViewBoundsEvent;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.MathUtil;
	
	import flash.events.*;
	
	import mx.binding.utils.*;
	import mx.controls.sliderClasses.*;
	import mx.events.*;
	
	import spark.components.supportClasses.*;
	
	use namespace sm_internal;
	
	[IconFile("/designIcon/ZoomSlider.png")]
	
	/**
	 * ${controls_ZoomSlider_Title}.
	 * <p>${controls_ZoomSlider_Description}</p> 
	 * 
	 */	
	public class ZoomSlider extends SkinnableComponent
	{
		private var _map:Map;
		private var _slider:SliderBase;
		private var _zoomInButton:ButtonBase; 
		private var _zoomOutButton:ButtonBase; 
		private var _sliderHeightParam:int = 10;
		
		private static var _skinParts:Object = {slider:false, zoomInButton:false, zoomOutButton:false};
		
		/**
		 * ${controls_ZoomSlider_constructor_None_D} 
		 * 
		 */		
		public function ZoomSlider()
		{     
			
		}
		 
		[Inspectable(category = "iClient")] 
		/**
		 * ${controls_ZoomSlider_field_sliderHeightParam_D}
		 * @default 10 
		 * @return 
		 * 
		 */		
		public function get sliderHeightParam():int
		{
			return _sliderHeightParam;
		}
		
		public function set sliderHeightParam(value:int):void
		{
			_sliderHeightParam = value;
		}
		
		[Inspectable(category = "iClient")] 
		/**
		 * ${controls_ZoomSlider_attribute_Map_D} 
		 * @return 
		 * 
		 */		
		public function get map() : Map
		{
			return this._map;
		}
		
		public function set map(value:Map) : void
		{ 
			if (this._map)
			{
				this._map.removeEventListener(MapEvent.LOAD, this.map_loadHandler);
				this._map.removeEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.map_viewBoundsChangeHandler);
				this._map.removeEventListener(ResizeEvent.RESIZE, this.map_resizeHandler);
				this._map.removeEventListener("resolutionsChange", map_resolutionChangeHandler);
				this._map.removeEventListener(FlexEvent.UPDATE_COMPLETE, mapUpdateCompleteHandler);
			}
			this._map = value;
			if (this._map)
			{
				this._map.addEventListener(MapEvent.LOAD, this.map_loadHandler);
				this._map.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.map_viewBoundsChangeHandler);
				this._map.addEventListener(ResizeEvent.RESIZE, this.map_resizeHandler); 
				this._map.addEventListener("resolutionsChange", map_resolutionChangeHandler); 
				this._map.addEventListener(FlexEvent.UPDATE_COMPLETE, mapUpdateCompleteHandler);
			} 
		}
		
		/**
		 * ${controls_ZoomSlider_attribute_slider_D} 
		 * @return 
		 * 
		 */		
		public function get slider():SliderBase
		{
			return this._slider;
		}
		
		public function set slider(value:SliderBase):void
		{
			this._slider = value;
		}
		
		/**
		 * ${controls_ZoomSlider_attribute_zoomInButton_D} 
		 * @return 
		 * 
		 */		
		public function get zoomInButton():ButtonBase
		{
			return this._zoomInButton;
		}
		
		public function set zoomInButton(value:ButtonBase):void
		{
			this._zoomInButton = value;
		}
		
		/**
		 * ${controls_ZoomSlider_attribute_zoomOutButton_D} 
		 * @return 
		 * 
		 */		
		public function get zoomOutButton():ButtonBase
		{
			return this._zoomOutButton;
		}
		
		public function set zoomOutButton(value:ButtonBase):void
		{
			this._zoomOutButton = value;
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
			if (this._map === null)
			{
				return "disabled";
			}
			if (this._map.loaded === false)
			{
				return "disabled";
			}
			if (enabled === false)
			{
				return this._map.resolutions && this._map.resolutions.length > 0 ? ("disabledWithSlider") : ("disabled");
			}
			return this._map.resolutions && this._map.resolutions.length > 0 ? ("normalWithSlider") : ("normal");
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
			
			if (instance === this.zoomInButton)
			{ 
				this.zoomInButton.addEventListener(MouseEvent.CLICK, this.zoomInButton_mouseClickHandler);
				this.zoomInButton.addEventListener(MouseEvent.MOUSE_DOWN, this.zoomInButton_mouseDownHandler);
			}
			else if (instance === this.slider)
			{  
				this.slider.addEventListener(Event.CHANGE, this.slider_changeHandler);
			}
			else if (instance === this.zoomOutButton)
			{ 
				this.zoomOutButton.addEventListener(MouseEvent.CLICK, this.zoomOutButton_mouseClickHandler);
				this.zoomOutButton.addEventListener(MouseEvent.MOUSE_DOWN, this.zoomOutButton_mouseDownHandler);
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
			if (instance === this.zoomInButton)
			{
				this.zoomInButton.removeEventListener(MouseEvent.CLICK, this.zoomInButton_mouseClickHandler);
				this.zoomInButton.removeEventListener(MouseEvent.MOUSE_DOWN, this.zoomInButton_mouseDownHandler);
			}
			else if (instance === this.slider)
			{
				this.slider.removeEventListener(Event.CHANGE, this.slider_changeHandler);
			}
			else if (instance === this.zoomOutButton)
			{
				this.zoomOutButton.removeEventListener(MouseEvent.CLICK, this.zoomOutButton_mouseClickHandler);
				this.zoomOutButton.removeEventListener(MouseEvent.MOUSE_DOWN, this.zoomOutButton_mouseDownHandler);
			} 
		}
		 
		private function mapUpdateCompleteHandler(event:FlexEvent):void
		{ 
			if(this.slider)
			{ 
				this._map.removeEventListener(FlexEvent.UPDATE_COMPLETE, mapUpdateCompleteHandler);
			} 
			this.refresh();  
		}
		
		private function map_resolutionChangeHandler(event:Event) : void
		{    
			this.refresh();      
		}
		
		private function map_viewBoundsChangeHandler(event:ViewBoundsEvent) : void
		{     
			this.refresh();    
		}
		
		private function map_loadHandler(event:MapEvent) : void
		{    
			this.refresh(); 
		}
		
		private function map_resizeHandler(event:ResizeEvent) : void
		{      
			var height:int = this.y + this.height; 
			if (height > this.map.height)
			{
				this.visible = false;
				this.includeInLayout = false;
			}
			else
			{
				this.visible = true;
				this.includeInLayout = true;
			} 
		}
		 
		private function slider_changeHandler(event:Event) : void
		{ 
			if (this._map)
			{
				this._map.zoomToLevel(this.slider.value);
			}
		}
		 
		private function zoomInButton_mouseClickHandler(event:MouseEvent) : void
		{
			if (event.currentTarget === this.zoomInButton)
			{
				this.zoomIn();
			}
			event.stopImmediatePropagation(); 
		}
		
		private function zoomInButton_mouseDownHandler(event:MouseEvent) : void
		{
			event.stopImmediatePropagation(); 
		}
		
		private function zoomOutButton_mouseClickHandler(event:MouseEvent) : void
		{
			if (event.currentTarget === this.zoomOutButton)
			{
				this.zoomOut();
			}
			event.stopImmediatePropagation(); 
		}
		
		private function zoomOutButton_mouseDownHandler(event:MouseEvent) : void
		{
			event.stopImmediatePropagation(); 
		} 
		 
		/**
		 * ${controls_ZoomSlider_attribute_refresh_D} 
		 * 
		 */		
		public function refresh():void
		{
			if (this.slider)
			{   
				if(this.map.resolutions)
				{
					this.slider.maximum = this.map.resolutions.length - 1;
					this.slider.height = this.map.resolutions.length * this.sliderHeightParam;
					this.slider.value = MathUtil.getNearestIndex(this.map.resolution, this.map.resolutions, this.map.minResolution, this.map.maxResolution) ; 
				}	
				else
				{
					this.slider.value = 0;
				}
				
			} 
			invalidateSkinState(); 
		}
		
		private function zoomIn() : void
		{
			if (this._map)
			{
				this._map.zoomIn();
			} 
		}
		
		private function zoomOut() : void
		{
			if (this._map)
			{
				this._map.zoomOut();
			} 
		}
	}
}