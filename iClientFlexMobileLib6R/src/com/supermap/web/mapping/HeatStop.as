package com.supermap.web.mapping
{
	/**
	 * ${mapping_HeatStop_Title}.
	 * <p>${mapping_HeatStop_Description}</p> 
	 * 
	 */	
	public class HeatStop
	{
		private var _color:uint;
		private var _offset:Number;
		
		/**
		 * ${mapping_HeatStop_constructor_D} 
		 * @param color ${mapping_HeatStop_constructor_param_color}
		 * @param offset ${mapping_HeatStop_constructor_param_offset}
		 * 
		 */		
		public function HeatStop(color:uint = 0xFFFFFFFF, offset:Number = 0)
		{
			this.color = color;
			this.offset = offset;
		}

		//[0,1]区间,值由小到大代表的热度由冷到热
		/**
		 * ${mapping_HeatStop_attribute_offset_D}.
		 * <p>${mapping_HeatStop_attribute_offset_remarks}</p> 
		 * @see HeatMapLayer
		 * @return 
		 * 
		 */		
		public function get offset():Number
		{
			return _offset;
		}
		public function set offset(value:Number):void
		{
			this._offset = value > 1 ? 1 : value;
			this._offset = this._offset < 0 ? 0 : this._offset;
		}

		//渐变中使用的 ARGB 十六进制颜色值（例如，红色为 0xFFFF0000，蓝色为 0xFF0000FF，等等）。
		/**
		 * ${mapping_HeatStop_attribute_color_D} 
		 * @return 
		 * 
		 */		
		public function get color():uint
		{
			return _color;
		}
		public function set color(value:uint):void
		{
			_color = value;
		}

	}
}