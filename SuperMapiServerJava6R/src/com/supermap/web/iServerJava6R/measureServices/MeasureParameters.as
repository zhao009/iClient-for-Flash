package com.supermap.web.iServerJava6R.measureServices
{
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.utils.Unit;
	
	/**
	 * ${iServerJava6R_MeasureParameters_Tile}.
	 * <p>${iServerJava6R_MeasureParameters_Description}</p> 
	 * 
	 * 
	 */	
	public class MeasureParameters
	{
		private var _geometry:Geometry;
		private var _unit:String = Unit.METER.toUpperCase();
		private var _prjCoordSys:String = null;
		
		/**
		 * ${iServerJava6R_MeasureParameters_constructor_D} 
		 * @param geometry ${iServerJava6R_MeasureParameters_constructor_param_geometry}
		 * 
		 */		
		public function MeasureParameters(geometry:Geometry):void
		{
			this.geometry = geometry;
		}

		/**
		 * ${iServerJava6R_MeasureParameters_attribute_PrjCoordSys_D} 
		 */
		public function get prjCoordSys():String
		{
			return _prjCoordSys;
		}
		public function set prjCoordSys(value:String):void
		{
			_prjCoordSys = value;
		}

		/**
		 * ${iServerJava6R_MeasureParameters_attribute_Unit_D} 
		 * @see com.supermap.web.utils.Unit
		 */
		public function get unit():String
		{
			return _unit;
		}
		public function set unit(value:String):void
		{
			_unit = value.toUpperCase();
		}

		/**
		 * ${iServerJava6R_MeasureParameters_attribute_Geometry_D} 
		 */
		public function get geometry():Geometry
		{
			return _geometry;
		}
		public function set geometry(value:Geometry):void
		{
			_geometry = value;
		}

	}
}
