package com.supermap.web.samples.clientTheme
{
	public class ClientThemeGraphItem
	{
		/** 标签 */
		private var _label:String;
		/** 值 */
		private var _value:Number;
		
		public function ClientThemeGraphItem(label:String = null,value:Number = NaN)
		{
			_label = label;
			_value = value;
		}
		
		public function set label(value:String):void{
			_label = value;
		}
		
		public function get label():String{
			return _label;
		}
		
		public function set value(value:Number):void{
			_value = value;
		}
		
		public function get value():Number{
			return _value;
		}
	}
}