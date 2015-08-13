package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.core.geometry.Geometry;
	/**
	 * ${iServerJava6R_ThiessenParams_Title}
	 * 
	 */	
	public class ThiessenAnalystParameters
	{
		private var _clipRegion:Geometry;
		private var _createResultDataset:Boolean = true;
		private var _resultDatasetName:String;
		private var _resultDatasourceName:String;
		private var _returnResultRegion:Boolean = false;
		/**
		 * ${iServerJava6R_ThiessenParams_constructor_D} 
		 * 
		 */	
		public function ThiessenAnalystParameters()
		{
		}
		/**
		 * ${iServerJava6R_ThiessenParams_attribute_clipRegion_D} 
		 * @return 
		 * 
		 */	
		public function get clipRegion():Geometry
		{
			return _clipRegion;
		}

		public function set clipRegion(value:Geometry):void
		{
			_clipRegion = value;
		}
		/**
		 * ${iServerJava6R_ThiessenParams_attribute_createResultDataset_D} 
		 * @return 
		 * 
		 */	
		public function get createResultDataset():Boolean
		{
			return _createResultDataset;
		}

		public function set createResultDataset(value:Boolean):void
		{
			_createResultDataset = value;
		}
		/**
		 * ${iServerJava6R_ThiessenParams_attribute_resultDatasetName_D} 
		 * @return 
		 * 
		 */	
		public function get resultDatasetName():String
		{
			return _resultDatasetName;
		}

		public function set resultDatasetName(value:String):void
		{
			_resultDatasetName = value;
		}
		/**
		 * ${iServerJava6R_ThiessenParams_attribute_resultDatasourceName_D} 
		 * @return 
		 * 
		 */	
		public function get resultDatasourceName():String
		{
			return _resultDatasourceName;
		}

		public function set resultDatasourceName(value:String):void
		{
			_resultDatasourceName = value;
		}
		/**
		 * ${iServerJava6R_ThiessenParams_attribute_returnResultRegion_D} 
		 * @return 
		 * 
		 */	
		public function get returnResultRegion():Boolean
		{
			return _returnResultRegion;
		}

		public function set returnResultRegion(value:Boolean):void
		{
			_returnResultRegion = value;
		}
	}
}