package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	

	/**
	 * ${iServerJava6R_SurfaceAnalystParametersSetting_Title}.
	 * <p>${iServerJava6R_SurfaceAnalystParametersSetting_Description}</p> 
	 * 
	 */	
	public class SurfaceAnalystParametersSetting
	{
		private var _clipRegion:GeoRegion;
		private var _datumValue:Number = 0;
		private var _expectedZValues:Array;
		private var _interval:Number = 0;
		private var _resampleTolerance:Number = 0;
		private var _smoothMethod:String = SmoothMethod.BSPLINE;
		private var _smoothness:Number = 0;
		
		/**
		 * ${iServerJava6R_SurfaceAnalystParamsSetting_constructor_D} 
		 * 
		 */		
		public function SurfaceAnalystParametersSetting()
		{
		}

		/**
		 * ${iServerJava6R_SurfaceAnalystParametersSetting_attribute_Smoothness_D}.
		 * <p>${iServerJava6R_SurfaceAnalystParametersSetting_attribute_Smoothness_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get smoothness():Number
		{
			return _smoothness;
		}

		public function set smoothness(value:Number):void
		{
			_smoothness = value;
		}

		/**
		 * ${iServerJava6R_SurfaceAnalystParamsSetting_attribute_SmoothMethod_D} 
		 * @see SmoothMethod
		 * @return 
		 * 
		 */		
		public function get smoothMethod():String
		{
			return _smoothMethod;
		}

		public function set smoothMethod(value:String):void
		{
			_smoothMethod = value;
		}

		/**
		 * ${iServerJava6R_SurfaceAnalystParamsSetting_attribute_ResampleTolerance_D}.
		 * <p>${iServerJava6R_SurfaceAnalystParametersSetting_attribute_ResampleTolerance_remarks}</p> 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get resampleTolerance():Number
		{
			return _resampleTolerance;
		}

		public function set resampleTolerance(value:Number):void
		{
			_resampleTolerance = value;
		}

		/**
		 * ${iServerJava6R_SurfaceAnalystParametersSetting_attribute_Interval_D}.
		 * <p>${iServerJava6R_SurfaceAnalystParametersSetting_attribute_Interval_remarks}</p> 
		 * @default 0
		 * @return 
		 * 
		 */		
		public function get interval():Number
		{
			return _interval;
		}

		public function set interval(value:Number):void
		{
			_interval = value;
		}

		/**
		 * ${iServerJava6R_SurfaceAnalystParametersSetting_attribute_ExpectedZValues_D}.
		 * <p>${iServerJava6R_SurfaceAnalystParametersSetting_attribute_ExpectedZValues_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get expectedZValues():Array
		{
			return _expectedZValues;
		}

		public function set expectedZValues(value:Array):void
		{
			_expectedZValues = value;
		}

		/**
		 * ${iServerJava6R_SurfaceAnalystParametersSetting_attribute_DatumValue_D}.
		 * <p>${iServerJava6R_SurfaceAnalystParametersSetting_attribute_DatumValue_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get datumValue():Number
		{
			return _datumValue;
		}

		public function set datumValue(value:Number):void
		{
			_datumValue = value;
		}

		/**
		 * ${iServerJava6R_SurfaceAnalystParametersSetting_attribute_ClipRegion_D} 
		 * @return 
		 * 
		 */		
		public function get clipRegion():GeoRegion
		{
			return _clipRegion;
		}

		public function set clipRegion(value:GeoRegion):void
		{
			_clipRegion = value;
		}
		
		sm_internal function toJson():String
		{
			var json:String = "";
			
			if (this.clipRegion)
				json += "\"clipRegion\":" + ServerGeometry.toJson(ServerGeometry.fromGeometry(this.clipRegion)) + ",";
			else
				json += "\"clipRegion\":" + null + ",";
			
			if (this.expectedZValues && this.expectedZValues.length)
			{
				json += "\"expectedZValues\":" + "[" + expectedZValues.join(",") + "],";
			}
			
			json += "\"datumValue\":" + this.datumValue + ",";
			
			json += "\"interval\":" + this.interval + ",";
			
			json += "\"resampleTolerance\":" + resampleTolerance + ",";
			
			json += "\"smoothMethod\":" + "\"" + this.smoothMethod + "\",";
			
			json += "\"smoothness\":" + this.smoothness;
			
			json ="{" + json + "}";
			
			return json;
		}

	}
}