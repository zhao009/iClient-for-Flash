package com.supermap.web.core.styles
{
	import com.supermap.web.core.*;
	
	import mx.events.PropertyChangeEvent;

	/**
	 * ${core_LineStyle_Title}.
	 * <p>${core_LineStyle_Description}</p> 
	 * 
	 */	
	public class LineStyle extends Style
	{
		private var _weight:Number = 2;
		private var _color:uint = 0x5082e5;
		private var _alpha:Number = 1;
		
		/**
		 * ${core_LineStyle_constructor_None_D} 
		 * 
		 */		
		public function LineStyle()
		{
		}

		/**
		 * ${core_LineStyle_attribute_alpha_D}.
		 * <p>${core_LineStyle_attribute_alpha_remarks}</p>
		 * @default 1
		 */
		public function get alpha():Number
		{
			return _alpha;
		}

		public function set alpha(value:Number):void
		{
			if(value <0)
			{
				return;
			}
			var oldValue:Number = this._alpha;
			if(value != this._alpha)
			{
				this._alpha = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "alpha", oldValue, value));
				}
			}
		}

		/**
		 * ${core_LineStyle_attribute_color_D}
		 * @default 0xFF0000
		 */
		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{			
			var oldValue:uint = this._color;
			if(value != this._color)
			{
				this._color = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "color", oldValue, value));
				}			
			}
		}

		/**
		 * ${core_LineStyle_attribute_weight_D}
		 * @default 1
		 */
		public function get weight():Number
		{
			return _weight;
		}

		public function set weight(value:Number):void
		{
			if(value < 0)
			{
				value = 0;
			}
			var oldValue:Number = this._weight;
			if(value != this._weight)
			{
				this._weight = value;
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "weight", oldValue, value));
				}
			}
		}
		

	}
}