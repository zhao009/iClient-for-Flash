package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.iServerJava6R.FilterParameter;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	use namespace sm_internal;

	
	/**
	 * ${iServerJava6R_InterpolationAnalystParameters_Title} 
	 * 
	 */	
	public class InterpolationAnalystParameters
	{
		//定义参数
		private var _bounds:Rectangle2D;
		private var _searchRadius:Number = 0;
		private var _zValueFieldName:String;
		private var _zValueScale:Number = 1;
		private var _resolution:Number = 3000;
		private var _filterQueryParameter:FilterParameter;
		private var _outputDatasetName:String;
		private var _pixelFormat:String=PixelFormat.UBIT8;	
		private var _inputPoints:Array = null;
		private var _InterpolationAnalystType:String = "dataset";
		private var _dataset:String;
		
		private var _outputDatasourceName:String;
		private var _clipParam:ClipParameter;
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_constructor_D} 
		 * 
		 */	
		public function InterpolationAnalystParameters()
		{
		}

		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_bounds_D} 
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}
		
		public function set bounds(value:Rectangle2D):void
		{
			_bounds = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_searchRadius_D} 
		 * @return 
		 * 
		 */		
		public function get searchRadius():Number
		{
			return _searchRadius;
		}
		
		public function set searchRadius(value:Number):void
		{
			_searchRadius = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_zValueFieldName_D} 
		 * @return 
		 * 
		 */		
		public function get zValueFieldName():String
		{
			return _zValueFieldName;
		}
		
		public function set zValueFieldName(value:String):void
		{
			_zValueFieldName = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_zValueScale_D} 
		 * @return 
		 * 
		 */		
		public function get zValueScale():Number
		{
			return _zValueScale;
		}
		
		public function set zValueScale(value:Number):void
		{
			_zValueScale = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_resolution_D}
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
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_filterQueryParameter_D} 
		 * @return 
		 * 
		 */		
		public function get filterQueryParameter():FilterParameter
		{
			return _filterQueryParameter;
		}
		
		public function set filterQueryParameter(value:FilterParameter):void
		{
			_filterQueryParameter = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_outputDatasetName_D} 
		 * @return 
		 * 
		 */		
		public function get outputDatasetName():String
		{
			return _outputDatasetName;
		}
		
		public function set outputDatasetName(value:String):void
		{
			_outputDatasetName = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_pixelFormat_D} 
		 * @see PixelFormat
		 * @return 
		 * 
		 */				
		public function get pixelFormat():String
		{
			return _pixelFormat;
		}
		
		public function set pixelFormat(value:String):void
		{
			_pixelFormat = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_inputPoints_D} 
		 * @return 
		 * 
		 */
		public function get inputPoints():Array
		{
			return _inputPoints;
		}
		
		public function set inputPoints(value:Array):void
		{
			_inputPoints = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_InterpolationAnalystType_D} 
		 * @return 
		 * 
		 */
		public function get InterpolationAnalystType():String
		{
			return _InterpolationAnalystType;
		}
		
		public function set InterpolationAnalystType(value:String):void
		{
			_InterpolationAnalystType = value;
		}		
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_dataset_D} 
		 * @return 
		 * 
		 */	
		
		public function get dataset():String
		{
			return _dataset;
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_outputDatasourceName_D}
		 * @return 
		 * 
		 */	
		public function get outputDatasourceName():String
		{
			return _outputDatasourceName;
		}
		
		public function set outputDatasourceName(value:String):void
		{
			_outputDatasourceName = value;
		}
		
		/**
		 * ${iServerJava6R_InterpolationAnalystParameters_attribute_clipParam_D}
		 * @return 
		 * 
		 */
		public function get clipParam():ClipParameter
		{
			return _clipParam;
		}
		
		public function set clipParam(value:ClipParameter):void
		{
			_clipParam = value;
		}
		
		public function set dataset(value:String):void
		{
			_dataset = value;
		}
				
		sm_internal function getVariablesJson():String
		{
		    return "";
		}
		
		sm_internal function fromRectangle2D(rectangle2D:Rectangle2D) : String
		{
			if (rectangle2D == null)
			{
				return "{}";
			}	
			return "{\"rightTop\":{\"y\":" + rectangle2D.top + ",\"x\":" + rectangle2D.right + "}," +
				"\"leftBottom\":{\"y\":" + rectangle2D.bottom+ ",\"x\":" + rectangle2D.left + "}}"; 
		}
		
		sm_internal function fromInputPoints(points:Array):String
		{
			if (points == null)
			{
				return "[]";
			}
			var str:String = "";
			for (var i:int = 0; i < points.length; i++)
			{			
				str += "{\"x\":" + points[i].x + ",\"y\":" + points[i].y + ",\"z\":" + points[i].tag + "}";
				if(i < points.length-1)
					str += ",";				
			}
			return "[" + str + "]";
		}
	}
}