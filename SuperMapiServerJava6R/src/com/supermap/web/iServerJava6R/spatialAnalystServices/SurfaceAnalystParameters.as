package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.spatialAnalystServices.SurfaceAnalystMethod; 
	/**
	 * ${iServerJava6R_SurfaceAnalystParameters_Title}.
	 * <p>${iServerJava6R_SurfaceAnalystParameters_Description}</p> 
	 * 
	 */	
	public class SurfaceAnalystParameters
	{
		private var _surfaceAnalystMethod:String = SurfaceAnalystMethod.ISOLINE;
		private var _resolution:Number = 3000;
		
		/**
		 * ${iServerJava6R_SurfaceAnalystParameters_constructor_D} 
		 * 
		 */		
		public function SurfaceAnalystParameters()
		{
		}

		/**
		 * ${iServerJava6R_SurfaceAnalystParameters_attribute_resolution_D} 
		 * @default 3000
		 * @return 
		 * 
		 */		
		public function get resolution():Number
		{
			return _resolution;
		}

		public function set resolution(value:Number):void
			
		{
			_resolution = value;
		}

		/**
		 * ${iServerJava6R_SurfaceAnalystParameters_attribute_surfaceAnalystMethod_D} 
		 * @return 
		 * 
		 */		
		public function get surfaceAnalystMethod():String
		{
			return _surfaceAnalystMethod;
		}

		public function set surfaceAnalystMethod(value:String):void
		{
			_surfaceAnalystMethod = value;
		}

	}
}