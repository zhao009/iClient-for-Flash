package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_queryByGeometryParameters_Title}.
	 * <br/> ${iServer2_queryByGeometryParameters_Description_as}
	 * @see ParametersBase
	 * @see QueryParam
	 * 
	 * 
	 */	
	public class QueryByGeometryParameters extends QueryParametersBase
	{
		private var _geometry:Geometry;
		private var _queryType:String;
		
		/* 几何查询类型 */

		private const QUERY_TYPE_POINT:String			= "QueryByPoint";
			
		private const QUERY_TYPE_LINE:String			= "QueryByLine";
			
		private const QUERY_TYPE_POLYGON:String		    = "QueryByPolygon";
		
		/**
		 * ${iServer2_queryByGeometryParameters_constructor_D} 
		 * @param mapName ${iServer2_queryByGeometryParameters_constructor_param_mapName_D}
		 * @param queryParam ${iServer2_queryByGeometryParameters_constructor_param_queryParam_D}
		 * 
		 */		
		public function QueryByGeometryParameters(mapName:String = null, queryParam:QueryParam = null)
		{
			super(mapName, queryParam);
		}
		
		/**
		 * ${iServer2_queryByGeometryParameters_attribute_geometry_D} 
		 * 
		 */		
		public function get geometry():Geometry
		{
			return this._geometry;
		}
		
		public function set geometry(value:Geometry):void
		{
			this._geometry = value;
			if(value is GeoPoint)
				this._queryType = this.QUERY_TYPE_POINT;
			else if(value is GeoLine)
				this._queryType = this.QUERY_TYPE_LINE;
		  	else 
		  		this._queryType = this.QUERY_TYPE_POLYGON;
		}
		
		/**
		 * @private
		 * ${iServer2_queryByGeometryParameters_attribute_queryType_D} 
		 * 
		 */		
		sm_internal function get queryType():String
		{
			return this._queryType;
		}
	}
}