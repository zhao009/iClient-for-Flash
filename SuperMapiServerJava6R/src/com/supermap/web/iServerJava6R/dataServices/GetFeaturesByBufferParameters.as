package com.supermap.web.iServerJava6R.dataServices
{
	import com.supermap.web.core.geometry.Geometry;

	/**
	 * ${iServerJava6R_GetFeaturesByBufferParameters_Title}.
	 * <p>${iServerJava6R_GetFeaturesByBufferParameters_Description}</p> 
	 * 
	 */	
	public class GetFeaturesByBufferParameters extends GetFeaturesParametersBase
	{
		private var _geometry:Geometry;
		private var _bufferDistance:Number;
		private var _attributeFilter:String;
		private var _fields:Array;
		
		/**
		 * ${iServerJava6R_GetFeaturesByBufferParameters_constructor_D} 
		 * 
		 */		
		public function GetFeaturesByBufferParameters()
		{
			super();
		}

		/**
		 * ${iServerJava6R_GetFeaturesByBufferParameters_attribute_attributeFilter_D}.
		 * <p>${iServerJava6R_GetFeaturesByBufferParameters_attribute_attributeFilter_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get attributeFilter():String
		{
			return _attributeFilter;
		}

		public function set attributeFilter(value:String):void
		{
			_attributeFilter = value;
		}

		/**
		 * ${iServerJava6R_GetFeaturesByBufferParameters_attribute_bufferDistance_D} 
		 * @return 
		 * 
		 */		
		public function get bufferDistance():Number
		{
			return _bufferDistance;
		}

		public function set bufferDistance(value:Number):void
		{
			_bufferDistance = value;
		}

		/**
		 * ${iServerJava6R_GetFeaturesByBufferParameters_attribute_fields_D}.
		 * <p>${iServerJava6R_GetFeaturesByBufferParameters_attribute_fields_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get fields():Array
		{
			return _fields;
		}

		public function set fields(value:Array):void
		{
			_fields = value;
		}

		/**
		 * ${iServerJava6R_GetFeaturesByBufferParameters_attribute_geometry_D} 
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

	}
}