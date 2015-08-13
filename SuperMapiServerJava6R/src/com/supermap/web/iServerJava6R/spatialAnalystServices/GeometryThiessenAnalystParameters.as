package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_GeometryThiessenParameters_Title}.
	 * <p>${iServerJava6R_GeometryThiessenParameters_Description}</p> 
	 * 
	 */	
	public class GeometryThiessenAnalystParameters extends ThiessenAnalystParameters
	{
		private var _points:Array;
		/**
		 * ${iServerJava6R_GeometryThiessenParameters_constructor_D} 
		 * 
		 */	
		public function GeometryThiessenAnalystParameters()
		{
			createResultDataset = false;
			returnResultRegion = true;
		}
		/**
		 * ${iServerJava6R_GeometryThiessenParameters_attribute_points_D} 
		 * @return 
		 * 
		 */	
		public function get points():Array
		{
			return _points;
		}

		public function set points(value:Array):void
		{
			_points = value;
		}

		sm_internal function getVariablesJson():String
		{
			var json:String = "";
			if(this.clipRegion)
			{
				var sg:ServerGeometry = ServerGeometry.fromGeometry(this.clipRegion);
				json += "\"clipRegion\":" + ServerGeometry.toJson(sg) + ",";
			}	
			json += "\"createResultDataset\":" + this.createResultDataset + ",";
			json += "\"resultDatasetName\":" + this.resultDatasetName + ",";
			json += "\"resultDatasourceName\":" + this.resultDatasourceName + ",";
			json += "\"returnResultRegion\":" + this.returnResultRegion + ",";
			if(this.points)
			{
				var pointsJson:String = "";
				for(var i:int=0;i<this.points.length-1;i++)
				{
					var point:Point2D= (points[i] as Point2D);
					pointsJson += point.toJsonString()+",";
				}
				pointsJson += (points[this.points.length-1] as Point2D).toJsonString();
				pointsJson ="[" + pointsJson + "]";
				json += "\"points\":" + pointsJson;
			}
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}