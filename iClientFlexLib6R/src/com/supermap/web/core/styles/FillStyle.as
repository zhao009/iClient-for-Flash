package com.supermap.web.core.styles
{
	import flash.events.*;
	
	import mx.events.*;
	
	/**
	 * ${core_styles_FillStyle_Title}.
	 * <p>${core_styles_FillStyle_Description}</p> 
	 * @see PredefinedFillStyle
	 * @author zyn
	 * 
	 */	
	public class FillStyle extends Style
	{
		private var _border:PredefinedLineStyle;
		
		/**
		 * ${core_styles_FillStyle_constructor_None_D} 
		 * 
		 */		
		public function FillStyle()
		{
			
		}
		
		/**
		 * ${core_styles_FillStyle_attribute_border_D} 
		 * @return 
		 * 
		 */		
		public function get border() : PredefinedLineStyle
		{
			return this._border;
		}
		
		public function set border(value:PredefinedLineStyle) : void
		{
			var oldValue:PredefinedLineStyle = this.border;
			if (oldValue !== value)
			{
				if (this._border)
				{
					this._border.removeEventListener(Event.CHANGE, this.border_changeHandler);
				}
				this._border = value;				
				if (this._border)
				{
					this._border.addEventListener(Event.CHANGE, this.border_changeHandler);
				}
				dispatchEventChange();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "border", oldValue, value));
				}
			}			
		}
		
		private function border_changeHandler(event:Event) : void
		{
			dispatchEventChange();			
		}
		
	}
}