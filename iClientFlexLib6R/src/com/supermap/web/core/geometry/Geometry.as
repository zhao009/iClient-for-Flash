package com.supermap.web.core.geometry
{
	import com.supermap.web.sm_internal;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.styles.Style;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	use namespace sm_internal; 
	/**
	 * ${core_Geometry_Title}.
	 * <p>${core_Geometry_Description}</p> 
	 * 
	 * 
	 */	
	public class Geometry extends EventDispatcher
	{
		
		private var _bounds:Rectangle2D;
		private var _type:String;
		protected var _center:Point2D;
		private var _SRID:int;
		
		//GEOMETRY TYPES
		/**
		 * ${core_Geometry_const_GEOPOINT} 
		 */		
		public static const GEOPOINT:String="SmGeoPoint";
		/**
		 * ${core_Geometry_const_GEOLINE} 
		 */		
		public static const GEOLINE:String="SmGeoLine";
		/**
		 * ${core_Geometry_const_GEOREGION} 
		 */		
		public static const GEOREGION:String="SmGeoRegion";		
		
		/**
		 * ${core_Geometry_const_GEOMETRY_CHANGE} 
		 */		
		public static const GEOMETRY_CHANGE:String = "geometryChange";
		
		public function Geometry()
		{
			this.addEventListener("geometryChange", geometryChangeHandler);
		}
		
		protected function geometryChangeHandler(event:Event):void
		{
			this._center = null;
		}
		
		/**
		 * ${core_Geometry_attribute_Geometry_D} 
		 * @return 
		 * 
		 */		
		public function get center():Point2D
		{
			return _center;
		}

		/**
		 * ${core_Geometry_attribute_type_D} 
		 * 
		 */		
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}
		
		/**
		 * ${core_Geometry_attribute_SRID_D} 
		 * 
		 */	
		public function get SRID():int
		{
			return _SRID;
		}
		
		public function set SRID(value:int):void
		{
			_SRID = value;
		}
		
		/**
		 * ${core_Geometry_attribute_bounds_D} 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{			
			return null;
		}
		
		/**
		 * ${core_Geometry_method_clone_D}. 
		 * ${core_Geometry_method_clone_remarks_D}
		 * @return ${core_Geometry_method_clone_return}
		 * 
		 */		
		public function clone():Geometry
		{			
			return null;
		}	
		
		/**
		 * ${core_Geometry_method_equals_D} 
		 * @param geometry ${core_Geometry_method_equals_param_geometry_D}
		 * @return ${core_Geometry_method_equals_return_D}
		 * 
		 */		
		public function equals(geometry:Geometry):Boolean
		{		
			return false;
		}
		
		/**
		 * ${core_Geometry_method_defaultStyle_D} 
		 * 
		 */		
		public function get defaultStyle():Style
		{
			return null;
		}
		
		sm_internal function toJSON():String
		{
			return "";
		}
		//TODO:toJson():String;
		//TODO:defaultStyle():Style;		
		//TODO:GEOTEXT
		
		

	}
}