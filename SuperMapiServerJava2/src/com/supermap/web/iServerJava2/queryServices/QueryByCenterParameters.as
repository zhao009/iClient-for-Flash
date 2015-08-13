package com.supermap.web.iServerJava2.queryServices
{
	import com.supermap.web.core.geometry.GeoPoint;
	
	/**
	 * ${iServer2_queryByCenterParameters_Title}.
	 * <br/> ${iServer2_queryByCenterParameters_Description_as} 
	 * 
	 * 
	 */	
	public class QueryByCenterParameters extends QueryParametersBase
	{
			
		private var _center:GeoPoint;		
		private var _tolerance:Number = 50;		
		private var _isNearest:Boolean;//没有默认值。

		/**
		 * ${iServer2_queryByCenterParameters_constructor_D_as} 
		 * @param mapName ${iServer2_queryByCenterParameters_constructor_param_mapName_D_as}
		 * @param queryParam ${iServer2_queryByCenterParameters_constructor_param_queryParam_D_as}
		 * 
		 */		
		public function QueryByCenterParameters(mapName:String = null, queryParam:QueryParam = null)
		{
			super(mapName, queryParam);
		}

		 /**
		  * ${iServer2_queryByCenterParameters_attribute_centerPoint_D} 
		  * 
		  */		 
		public function get center():GeoPoint
		{
			return this._center;
		}
		
		public function set center(value:GeoPoint):void
		{
			this._center = value;
		}
		
		/**
		 * ${iServer2_queryByCenterParameters_attribute_tolerance_D} 
		 * 
		 */				
		public function get tolerance():Number
		{
			return this._tolerance;
		}
		
		public function set tolerance(value:Number):void
		{
			if(!value)
				value = 50;
			this._tolerance = value;
		}
		
		/**
		 * ${iServer2_queryByCenterParameters_attribute_isNearest_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get isNearest():Boolean
		{
			return this._isNearest;
		}
		
		public function set isNearest(value:Boolean):void
		{
			this._isNearest = value;
		}	
	}
}
