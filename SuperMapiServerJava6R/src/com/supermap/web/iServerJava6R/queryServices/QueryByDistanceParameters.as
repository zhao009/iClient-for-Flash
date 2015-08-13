package com.supermap.web.iServerJava6R.queryServices
{
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.resources.SmError;
	
	/**
	 * ${iServerJava6R_QueryByDistanceParameters_Tile}.
	 * <p>${iServerJava6R_QueryByDistanceParameters_Description}</p> 
	 * 
	 */	
	public class QueryByDistanceParameters extends QueryParameters
	{
		private var _distance:Number;
		private var _geometry:Geometry;
		private var _isNearest:Boolean = false;
		/**
		 * ${iServerJava6R_QueryByDistanceParameters_constructor_None_D} 
		 * 
		 */		
		public function QueryByDistanceParameters()
		{
			super();
		}
		
		/**
		 * ${iServerJava6R_QueryByDistanceParameters_attribute_IsNearest_D}.
		 * <p>${iServerJava6R_QueryByDistanceParameters_attribute_IsNearest_remarks}</p>
		 * @see QueryParameters#expectCount 
		 * @return 
		 * 
		 */		
		public function get isNearest():Boolean
		{
			return _isNearest;
		}

		public function set isNearest(value:Boolean):void
		{
			_isNearest = value;
		}

		/**
		 * ${iServerJava6R_QueryByDistanceParameters_attribute_Geometry_D}
		 * @return 
		 * 
		 */		
		public function get geometry():Geometry
		{
			return _geometry;
		}

		public function set geometry(value:Geometry):void
		{
			_geometry = value;
		}

		/**
		 * ${iServerJava6R_QueryByDistanceParameters_attribute_Distance_D}
		 * @see #isNearest 
		 * @return 
		 * 
		 */		
		public function get distance():Number
		{
			return _distance;
		}

		public function set distance(value:Number):void
		{
			if(value > 0)
				_distance = value;
			else
				throw new SmError(SmResource.NUMBER_LESSTHAN_OR_EQUAL_ZERO);
		}

	}
}