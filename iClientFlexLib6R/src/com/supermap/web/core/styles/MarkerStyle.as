package com.supermap.web.core.styles
{
	import flash.events.Event;
	
	import mx.events.PropertyChangeEvent;

	/**
	 * ${core_MarkerStyle_Title}.
	 * <p>${core_MarkerStyle_Description}</p> 
	 * 
	 */	
	public class MarkerStyle extends Style
	{
		private var _angle:Number = 0;
		private var _xOffset:Number = 0;
		private var _yOffset:Number = 0;

		/**
		 * ${core_MarkerStyle_constructor_None_D} 
		 * 
		 */		
		public function MarkerStyle()
		{			
		}
	
		[Bindable]
		/**
		 * ${core_MarkerStyle_attribute_offsetY_D} 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get yOffset():Number
		{
			return _yOffset;
		}
		public function set yOffset(value:Number):void
		{
			var oldValue:Number = this.yOffset;
			if(this._yOffset !== value)
			{
				this._yOffset = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"yOffset",oldValue, value));
				}
			}
		}

		[Bindable]
		/**
		 * ${core_MarkerStyle_attribute_offsetX_D}
		 * @default 0 
		 * @return 
		 * 
		 */		
		public function get xOffset():Number
		{
			return _xOffset;
		}

		public function set xOffset(value:Number):void
		{
			var oldValue:Number = this.xOffset;
			if(this._xOffset !== value)
			{
				this._xOffset = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"xOffset",oldValue, value));
				}
			}
		}

		[Bindable]
		/**
		 * ${core_MarkerStyle_attribute_angle_D} 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get angle():Number
		{
			return _angle;
		}

		public function set angle(value:Number):void
		{
			var oldValue:Number = this.angle;
			if(this._angle !== value)
			{
				this._angle = value;
				dispatchEvent(new Event(Event.CHANGE));
				if(this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this,"angle",oldValue, value));
				}
			}
			
		}
	
	}
}