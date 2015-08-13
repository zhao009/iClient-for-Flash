package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	import flash.net.URLVariables;

	/**
	 * ${iServerJava6R_GeometryBufAnalystResult_Title}.
	 * <p>${iServerJava6R_GeometryBufAnalystResult_Description}</p> 
	 * 
	 */	
	public class GeometryBufferAnalystResult extends SpatialAnalystResult
	{
		private var _resultGeometry:Geometry;
		/**
		 * ${iServerJava6R_GeometryBufAnalystResult_constructor_D} 
		 * 
		 */		
		public function GeometryBufferAnalystResult()
		{
			super();
		}

		/**
		 * ${iServerJava6R_GeometryBufAnalystResult_attribute_returnGeometry_D} 
		 * @return 
		 * 
		 */		
		public function get resultGeometry():Geometry
		{
			return _resultGeometry;
		}
		
		sm_internal static function fromJson(object:Object):GeometryBufferAnalystResult
		{
			var geoResult:GeometryBufferAnalystResult;
			if(object)
			{
				geoResult = new GeometryBufferAnalystResult();
				
				if(object.succeed)
				{
					var serverGeometry:ServerGeometry = ServerGeometry.fromJson(object.resultGeometry);
					geoResult._resultGeometry = ServerGeometry.toGeometry(serverGeometry);
				}
				else
					geoResult.setErrorMsgValue(object.error.errorMsg);
				
				geoResult.setSucceedValue(object.succeed);
			}
			return geoResult;
		}
	}
}