package com.supermap.web.mapping
{
	import com.supermap.web.core.Point2D;

	/**
	 * ${mapping_HeatMapLayer_HeatPoint_Title}.
	 * <p>${mapping_HeatMapLayer_HeatPoint_Description}</p> 
	 * 
	 */	
	public class HeatPoint
	{
		private var _x:Number;
		private var _y:Number;
		private var _value:Number;
		private var _geoRadius:Number;
		/**
		 * ${mapping_HeatMapLayer_HeatPoint_constructor_D} 
		 * @param x ${mapping_HeatMapLayer_HeatPoint_constructor_param_x}
		 * @param y ${mapping_HeatMapLayer_HeatPoint_constructor_param_y}
		 * @param value ${mapping_HeatMapLayer_HeatPoint_attribute_value_D}
		 * 
		 */		
		public function HeatPoint(x:Number, y:Number, value:Number = 1, geoRadius:Number = 0)
		{
			this._x = x;
			this._y = y;
			this._value = value;
			this.geoRadius = geoRadius;
		}

		/**
		 * ${mapping_HeatMapLayer_HeatPoint_attribute_geoRadius_D} 
		 * @see HeatMapLayer#radius
		 * @return 
		 * 
		 */		
		public function get geoRadius():Number
		{
			return _geoRadius;
		}

		public function set geoRadius(value:Number):void
		{
			if(value < 0)
				value = 0;
			_geoRadius = value;
		}

		[Bindable]
		/**
		 * ${mapping_HeatMapLayer_HeatPoint_attribute_value_D} 
		 * @return 
		 * 
		 */		
		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			_value = value;
		}

		[Bindable]
		/**
		 * ${mapping_HeatMapLayer_HeatPoint_attribute_y_D} 
		 * @return 
		 * 
		 */		
		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			_y = value;
		}

		[Bindable]
		/**
		 * ${mapping_HeatMapLayer_HeatPoint_attribute_x_D} 
		 * @return 
		 * 
		 */		
		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			_x = value;
		}
		
		/**
		 * ${mapping_HeatMapLayer_HeatPoint_attribute_point2D_D} 
		 * @return 
		 * 
		 */		
		public function get point2D():Point2D
		{
			return new Point2D(_x, _y);
		}

	}
}