package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	import flash.net.URLVariables;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_GeometrySurfaceAnalystParameters_Title}.
	 * <p>${iServerJava6R_GeometrySurfaceAnalystParameters_Description}</p> 
	 * 
	 */	
	public class GeometrySurfaceAnalystParameters extends SurfaceAnalystParameters
	{
		private var _points:Array;
		private var _zValues:Array;
		private var _surfaceParametersSetting:SurfaceAnalystParametersSetting;
		private var _resultSetting:DataReturnOption = new DataReturnOption();
		
		/**
		 * ${iServerJava6R_GeometrySurfaceAnalystParameters_constructor_D} 
		 * 
		 */		
		public function GeometrySurfaceAnalystParameters()
		{
			super();
		}

		/**
		 * ${iServerJava6R_GeometrySurfaceAnalystParameters_attribute_resultSetting_D} 
		 * @return 
		 * 
		 */		
		public function get resultSetting():DataReturnOption
		{
			return _resultSetting;
		}

		public function set resultSetting(value:DataReturnOption):void
		{
			_resultSetting = value;
		}

		/**
		 * ${iServerJava6R_GeometrySurfaceAnalystParameters_attribute_ExtractParamsSetting_D} 
		 * @return 
		 * 
		 */		
		public function get extractParamsSetting():SurfaceAnalystParametersSetting
		{
			return _surfaceParametersSetting;
		}

		public function set extractParamsSetting(value:SurfaceAnalystParametersSetting):void
		{
			_surfaceParametersSetting = value;
		}

		/**
		 * ${iServerJava6R_GeometrySurfaceAnalystParameters_attribute_ZValues_D}.
		 * <p>${iServerJava6R_GeometrySurfaceAnalystParameters_attribute_ZValues_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get zValues():Array
		{
			return _zValues;
		}

		public function set zValues(value:Array):void
		{
			_zValues = value;
		}

		/**
		 * ${iServerJava6R_GeometrySurfaceAnalystParameters_attribute_Points_D} 
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
			
			if(this.points && this.points.length)
			{
				var tempPoints:Array = [];
				var pointsLength:int = this.points.length;
				for(var i:int = 0; i < pointsLength; i++)
				{
					var p:Point2D = this.points[i] as Point2D;
					if((p.x > -Number.MAX_VALUE) && (p.y > -Number.MAX_VALUE))
						tempPoints.push(JsonUtil.fromPoint2D(p));
				}
				
				json += "\"points\":[" + tempPoints.join(",") + "],";
			}
			else
				json += "\"points\":[],"
			
			if(this.zValues && this.zValues.length)
				json += "\"zValues\":[" + this.zValues.join(",") + "],";
			else
				json += "\"zValues\":[],";
			
			if(this.extractParamsSetting)
				json += "\"extractParameter\":" +  this.extractParamsSetting.toJson() + ",";
			else
				json += "\"extractParameter\":null,";
			
			json += "\"resultSetting\":" + this.resultSetting.toJson() + ",";
			
			json += "\"resolution\":" + this.resolution;
				
			json ="{" + json + "}";
			
			return json;
		}
	}
}