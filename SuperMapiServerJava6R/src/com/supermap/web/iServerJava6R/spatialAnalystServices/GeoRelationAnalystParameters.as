package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.FilterParameter;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_DatasetsGeoReAnalystParms_Title}.
	 * <p>${iServerJava6R_DatasetsGeoReAnalystParms_Description}</p> 
	 * 
	 */	
	public class GeoRelationAnalystParameters
	{
		private var _dataset:String;
		private var _sourceFilter:FilterParameter;
		private var _referenceFilter:FilterParameter;
		private var _spatialRelationType:String;
		private var _isBorderInside:Boolean;
		private var _returnFeature:Boolean;
		private var _returnGeoRelatedOnly:Boolean = true;
		private var _startRecord:int = 0;
		private var _expectCount:int = 500;
		/**
		 * ${iServerJava6R_DatasetsGeoReAnalystParms_constructor_D} 
		 * 
		 */	
		public function GeoRelationAnalystParameters()
		{
		}
		/**
		 * ${iServerJava6R_DatasetsGeoReAnalystParms_attribute_sourceFilter_D}.
		 * @return 
		 * 
		 */	
		public function get sourceFilter():FilterParameter
		{
			return _sourceFilter;
		}

		public function set sourceFilter(value:FilterParameter):void
		{
			_sourceFilter = value;
		}
		/**
		 * ${iServerJava6R_DatasetsGeoReAnalystParms_attribute_referenceFilter_D}.
		 * <p>${iServerJava6R_DatasetsGeoReAnalystParms_attribute_referenceFilter_remarks}</p>
		 * @return 
		 * 
		 */	
		public function get referenceFilter():FilterParameter
		{
			return _referenceFilter;
		}

		public function set referenceFilter(value:FilterParameter):void
		{
			_referenceFilter = value;
		}
		/**
		 * ${iServerJava6R_DatasetsGeoReAnalystParms_attribute_spatialRelationType_D}.
		 * @return 
		 * @see SpatialRelationType
		 */	
		public function get spatialRelationType():String
		{
			return _spatialRelationType;
		}

		public function set spatialRelationType(value:String):void
		{
			_spatialRelationType = value;
		}
		/**
		 * ${iServerJava6R_DatasetsGeoReAnalystParms_attribute_isBorderInside_D}. 
		 * @return 
		 * 
		 */
		public function get isBorderInside():Boolean
		{
			return _isBorderInside;
		}

		public function set isBorderInside(value:Boolean):void
		{
			_isBorderInside = value;
		}
		/**
		 * ${iServerJava6R_DatasetsGeoReAnalystParms_attribute_returnFeature_D}.
		 * @return 
		 * 
		 */
		public function get returnFeature():Boolean
		{
			return _returnFeature;
		}

		public function set returnFeature(value:Boolean):void
		{
			_returnFeature = value;
		}
		/**
		 * ${iServerJava6R_DatasetsGeoReAnalystParms_attribute_returnGeoRelatedOnly_D}.
		 * <p>${iServerJava6R_DatasetsGeoReAnalystParms_attribute_returnGeoRelatedOnly_remarks}</p>
		 * @return 
		 * 
		 */
		public function get returnGeoRelatedOnly():Boolean
		{
			return _returnGeoRelatedOnly;
		}

		public function set returnGeoRelatedOnly(value:Boolean):void
		{
			_returnGeoRelatedOnly = value;
		}
		/**
		 * ${iServerJava6R_DatasetsGeoReAnalystParms_attribute_startRecord_D}.
		 * @return 
		 * 
		 */
		public function get startRecord():int
		{
			return _startRecord;
		}

		public function set startRecord(value:int):void
		{
			_startRecord = value;
		}
		/**
		 * ${iServerJava6R_DatasetsGeoReAnalystParms_attribute_expectCount_D}.
		 * @return 
		 * 
		 */
		public function get expectCount():int
		{
			return _expectCount;
		}

		public function set expectCount(value:int):void
		{
			_expectCount = value;
		}
		/**
		 * ${iServerJava6R_DatasetsGeoReAnalystParms_attribute_dataset_D}.
		 * @return 
		 * 
		 */
		public function get dataset():String
		{
			return _dataset;
		}

		public function set dataset(value:String):void
		{
			_dataset = value;
		}

		sm_internal function getVariablesJson():String
		{
			var json:String = "";
			
			json += "\"isBorderInside\":" + this.isBorderInside + ",";
			if(this._sourceFilter)
				json += "\"sourceFilter\":" + this.sourceFilter.toJson() + ",";	
			if(this._referenceFilter)
				json += "\"referenceFilter\":" + this.referenceFilter.toJson() + ",";
			json += "\"startRecord\":" + this.startRecord + ",";
			json += "\"expectCount\":" + this.expectCount + ",";
			json += "\"spatialRelationType\":" + this.spatialRelationType + ",";
			json += "\"returnFeature\":" + this.returnFeature + ",";
			json += "\"returnGeoRelatedOnly\":" + this.returnGeoRelatedOnly;
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}