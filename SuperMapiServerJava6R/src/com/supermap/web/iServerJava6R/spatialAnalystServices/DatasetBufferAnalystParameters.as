package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.iServerJava6R.FilterParameter;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	import flash.net.URLVariables;
	import com.supermap.web.utils.Unit;
	
	/**
	 * ${iServerJava6R_DatasetsBufAnalystParms_Title}.
	 * <p>${iServerJava6R_DatasetsBufAnalystParms_Description}</p> 
	 * 
	 */	
	public class DatasetBufferAnalystParameters extends BufferAnalystParameters
	{
		private var _filterQueryParameter:FilterParameter;
		private var _isAttributeRetained:Boolean = true;
		private var _isUnion:Boolean = false;
		private var _dataset:String;
		private var _resultSetting:DataReturnOption = new DataReturnOption();
		
		/**
		 * ${iServerJava6R_DatasetsBufAnalystParms_constructor_D} 
		 * 
		 */		
		public function DatasetBufferAnalystParameters()
		{
			super();
		}

		/**
		 * ${iServerJava6R_DatasetsBufAnalystParms_attribute_filterQueryParameter_D}.
		 * <p>${iServerJava6R_DatasetsBufAnalystParms_attribute_filterQueryParameter_remarks}</p> 
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
		 * ${iServerJava6R_DatasetsBufAnalystParms_attribute_isAttributeRetained_D}.
		 * <p>${iServerJava6R_DatasetsBufAnalystParms_attribute_isAttributeRetained_remarks}</p>
		 * @see #isUnion
		 * @return 
		 * 
		 */		
		public function get isAttributeRetained():Boolean
		{
			return _isAttributeRetained;
		}

		public function set isAttributeRetained(value:Boolean):void
		{
			_isAttributeRetained = value;
		}

		/**
		 * ${iServerJava6R_DatasetsBufAnalystParms_attribute_isUnion_D} 
		 * @return 
		 * 
		 */		
		public function get isUnion():Boolean
		{
			return _isUnion;
		}

		public function set isUnion(value:Boolean):void
		{
			_isUnion = value;
		}

		/**
		 * ${iServerJava6R_DatasetsBufAnalystParms_attribute_dataset_D} 
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
		
		/**
		 * ${iServerJava6R_DatasetsBufAnalystParms_attribute_resultSetting_D} 
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

		override public function get bufferSetting():BufferSetting
		{
			return super.bufferSetting;
		}

		override public function set bufferSetting(value:BufferSetting):void
		{
			super.bufferSetting = value;
			super.bufferSetting.isDatasetBufferAnalystParameters = true;
		}
		
		sm_internal function getVariablesJson():String
		{
			var json:String = "";
			
			if(this.bufferSetting)
				json += "\"bufferAnalystParameter\":" + this.bufferSetting.toJson() + ",";
			if(this.filterQueryParameter)
				json += "\"filterQueryParameter\":" + this.filterQueryParameter.toJson() + ",";
			
			json += "\"isAttributeRetained\":" + this.isAttributeRetained + ",";
			
			json += "\"isUnion\":" + this.isUnion + ",";
			
			json += "\"dataReturnOption\":" + this.resultSetting.toJson();
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}