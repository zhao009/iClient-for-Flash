package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.utils.serverTypes.ServerGeometry;

	/**
	 * ${iServerJava6R_GeometryOverlayAnalystResult_Title}.
	 * <p>${iServerJava6R_GeometryOverlayAnalystResult_Description}</p> 
	 * 
	 */	
	public class GeometryOverlayAnalystResult extends SpatialAnalystResult
	{
		private var _resultGeometry:Geometry;

		/**
		 * ${iServerJava6R_GeometryOverlayAnalystResult_constructor_D} 
		 * 
		 */		
		public function GeometryOverlayAnalystResult()
		{
			
		}
		/**
		 * ${iServerJava6R_GeometryOverlayAnalystResult_attribute_resultGeometry_D} 
		 * @return 
		 * 
		 */		
		public function get resultGeometry():Geometry
		{
			return _resultGeometry;
		}
		
		sm_internal static function fromJson(object:Object):GeometryOverlayAnalystResult
		{
			var geometryResult:GeometryOverlayAnalystResult;
			if(object)
			{
				geometryResult = new GeometryOverlayAnalystResult();
				
				if(object.succeed)
				{
					geometryResult._resultGeometry = ServerGeometry.toGeometry(ServerGeometry.fromJson(object.resultGeometry));
				}
				else
					geometryResult.setErrorMsgValue(object.error.errorMsg);
				
				geometryResult.setSucceedValue(object.succeed);
			}
			return geometryResult;
		}
	}
}