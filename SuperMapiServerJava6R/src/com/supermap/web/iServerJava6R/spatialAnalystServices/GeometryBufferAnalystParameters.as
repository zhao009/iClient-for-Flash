package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;

	use namespace sm_internal;

	/**
	 * ${iServerJava6R_GeometryBufferAnalystParameters_Title}.
	 * <p>${iServerJava6R_GeometryBufferAnalystParameters_Description}</p> 
	 * 
	 */	
	public class GeometryBufferAnalystParameters extends BufferAnalystParameters
	{
		private var _sourceGeometry:Geometry;
		/**
		 * ${iServerJava6R_GeometryBufferAnalystParameters_constructor_D} 
		 * 
		 */		
		public function GeometryBufferAnalystParameters()
		{
			super();
		}

		/**
		 * ${iServerJava6R_GeometryBufferAnalystParameters_attribute_sourceGeometry_D} 
		 * @return 
		 * 
		 */		
		public function get sourceGeometry():Geometry
		{
			return _sourceGeometry;
		}

		public function set sourceGeometry(value:Geometry):void
		{
			_sourceGeometry = value;
		}
		
		sm_internal function getVariablesJson():String
		{
			var json:String = "";
			
			if(this.bufferSetting)
				json += "\"analystParameter\":" + this.bufferSetting.toJson() + ",";
			
			if(this.sourceGeometry)
			{
				var sg:ServerGeometry = ServerGeometry.fromGeometry(this.sourceGeometry);
				json += "\"sourceGeometry\":" + ServerGeometry.toJson(sg);
			}
			
			if(json.length > 0)
				json ="{" + json + "}";
			
			return json;
		}
	}
}