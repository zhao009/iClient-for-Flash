package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_GeometryOverlayAnalystParms_Title}. 
	 * <p>${iServerJava6R_GeometryOverlayAnalystParms_Description}</p>
	 * 
	 */	
	public class GeometryOverlayAnalystParameters extends OverlayAnalystParameters
	{
		private var _sourceGeometry:Geometry;
		private var _operateGeometry:Geometry;
		
		/**
		 * ${iServerJava6R_GeometryOverlayAnalystParms_constructor_D} 
		 * 
		 */		
		public function GeometryOverlayAnalystParameters()
		{
			super();
		}
		
		/**
		 * ${iServerJava6R_GeometryOverlayAnalystParms_attribute_operateGeometry_D} 
		 * @return 
		 * 
		 */		
		public function get operateGeometry():Geometry
		{
			return _operateGeometry;
		}

		public function set operateGeometry(value:Geometry):void
		{
			_operateGeometry = value;
		}

		/**
		 * ${iServerJava6R_GeometryOverlayAnalystParms_attribute_sourceGeometry_D} 
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
			
			if(this.operateGeometry)
			{
				json += "\"operateGeometry\":" + ServerGeometry.toJson(ServerGeometry.fromGeometry(this.operateGeometry)) + ",";
			}
			if(this.sourceGeometry)
			{
				json += "\"sourceGeometry\":" + ServerGeometry.toJson(ServerGeometry.fromGeometry(this.sourceGeometry)) + ",";
			}
			
			json += "\"operation\":" + "\"" + this.operation + "\"";
			
			if(json.length > 0)
				json ="{" + json + "}";
			
			return json;
		}
		
		
	}
}