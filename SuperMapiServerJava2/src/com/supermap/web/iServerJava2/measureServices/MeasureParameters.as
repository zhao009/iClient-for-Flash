package com.supermap.web.iServerJava2.measureServices
{
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.iServerJava2.ParametersBase;
	
	/**
	 * ${iServer2_measureServices_MeasureParameters_Title}.
	 * <p>${iServer2_measureServices_MeasureParameters_Description}</p> 
	 * 
	 * 
	 */	
	public class MeasureParameters extends ParametersBase
	{
		private var _geometry:Geometry;
		
		/**
		 * ${iServer2_measureServices_MeasureParameters_constructor_String_D} 
		 * @param mapName ${iServer2_measureServices_MeasureParameters_constructor_String_param_mapName}
		 * 
		 */		
		public function MeasureParameters(mapName:String=null)
		{
			super(mapName);
		}
		
		/**
		 * ${iServer2_measureServices_MeasureParameters_attribute_geometry_D} 
		 * @return 
		 * 
		 */		
		public function get geometry():Geometry
		{
			return this._geometry;
		}
		
		public function set geometry(value:Geometry):void
		{
			this._geometry = value;
		}
	}
}