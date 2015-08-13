package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.FilterParameter;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_DatasetsOverlayAnalystParms_Title}.
	 * <p>${iServerJava6R_DatasetsOverlayAnalystParms_Description}</p> 
	 * 
	 */	
	public class DatasetOverlayAnalystParameters extends OverlayAnalystParameters
	{
		private var _sourceDataset:String;
		private var _sourceDatasetFilter:FilterParameter;
		private var _operateDataset:String;
		private var _operateDatasetFilter:FilterParameter;
		private var _operateRegions:Array;
		private var _sourceDatasetFields:Array;
		private var _operateDatasetFields:Array;
		private var _resutlSetting:DataReturnOption = new DataReturnOption();
		private var _tolerance:Number = 0;
		
		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystParms_constructor_D} 
		 * 
		 */		
		public function DatasetOverlayAnalystParameters()
		{
			super();
		}

		

		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystParms_attribute_sourceDataset_D} 
		 * @return 
		 * 
		 */		
		public function get sourceDataset():String
		{
			return _sourceDataset;
		}

		public function set sourceDataset(value:String):void
		{
			_sourceDataset = value;
		}

		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystParms_attribute_operateDatasetFields_D} 
		 * @return 
		 * 
		 */		
		public function get operateDatasetFields():Array
		{
			return _operateDatasetFields;
		}

		public function set operateDatasetFields(value:Array):void
		{
			_operateDatasetFields = value;
		}

		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystParms_attribute_sourceDatasetFields_D} 
		 * @return 
		 * 
		 */		
		public function get sourceDatasetFields():Array
		{
			return _sourceDatasetFields;
		}

		public function set sourceDatasetFields(value:Array):void
		{
			_sourceDatasetFields = value;
		}

		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystParms_attribute_operateRegions_D} 
		 * @return 
		 * 
		 */		
		public function get operateRegions():Array
		{
			return _operateRegions;
		}

		public function set operateRegions(value:Array):void
		{
			_operateRegions = value;
		}

		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystParms_attribute_operateDatasetFilter_D}.
		 * <p>${iServerJava6R_DatasetsOverlayAnalystParms_attribute_operateDatasetFilter_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get operateDatasetFilter():FilterParameter
		{
			return _operateDatasetFilter;
		}

		public function set operateDatasetFilter(value:FilterParameter):void
		{
			_operateDatasetFilter = value;
		}

		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystParms_attribute_operateDataset_D} 
		 * @return 
		 * 
		 */		
		public function get operateDataset():String
		{
			return _operateDataset;
		}

		public function set operateDataset(value:String):void
		{
			_operateDataset = value;
		}

		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystParms_attribute_sourceDatasetFilter_D}.
		 * <p>${iServerJava6R_DatasetsOverlayAnalystParms_attribute_sourceDatasetFilter_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get sourceDatasetFilter():FilterParameter
		{
			return _sourceDatasetFilter;
		}

		public function set sourceDatasetFilter(value:FilterParameter):void
		{
			_sourceDatasetFilter = value;
		}
		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystParms_attribute_tolerance_D} 
		 * @return 
		 * 
		 */	
		public function get tolerance():Number
		{
			return _tolerance;
		}
		
		public function set tolerance(value:Number):void
		{
			_tolerance = value;
		}
		/**
		 * ${iServerJava6R_DatasetsOverlayAnalystParms_attribute_resutlSetting_D} 
		 * @return 
		 * 
		 */	
		public function get resutlSetting():DataReturnOption
		{
			return _resutlSetting;
		}
		
		public function set resutlSetting(value:DataReturnOption):void
		{
			_resutlSetting = value;
		}
		sm_internal function getVariablesJson():String
		{
			var json:String = "";
			
			if(this.operateDataset)
				json += "\"operateDataset\":\"" + this.operateDataset +  "\",";
			else
				json += "\"operateDataset\":\"\",";
			
			json += "\"dataReturnOption\":" + this._resutlSetting.toJson();
//			json += "\"returnRecordset\":true,";
//			json += "\"overwriteExistResultDataset\":true,";
			json += ",\"operation\":\"" + this.operation + "\",";
			json += "\"tolerance\":" + this.tolerance.toString() + ",";
			
			if(this.sourceDatasetFilter)
				json += "\"sourceDatasetFilter\":" + this.sourceDatasetFilter.toJson() + ",";
			
			if(this.operateDatasetFilter)
				json += "\"operateDatasetFilter\":" + this.operateDatasetFilter.toJson() + ",";
			
			if(this.sourceDatasetFields && this.sourceDatasetFields.length)
				json += "\"sourceDatasetFields\":[" + sourceDatasetFields.join(",") + "],";
			else
				json += "\"sourceDatasetFields\":[],"
			
			if(this.operateDatasetFields && this.operateDatasetFields.length)
				json += "\"operateDatasetFields\":[" + operateDatasetFields.join(",") + "],";
			else
				json += "\"operateDatasetFields\":[],"
			
			if(this.operateRegions && this.operateRegions.length)
			{
				var operateRegionArray:Array = [];
				var oprLength:int = this.operateRegions.length;
				for(var i:int = 0; i < oprLength; i++)
				{
					var serverGeometry:ServerGeometry = ServerGeometry.fromGeometry(operateRegions[i]);
					operateRegionArray.push(ServerGeometry.toJson(serverGeometry));
				}
				json += "\"operateRegions\":[" + operateRegionArray.join(",") + "]";
			}
			else
				json += "\"operateRegions\":[]";
			
			json ="{" + json + "}";
		
			return json;
		}

	}
}