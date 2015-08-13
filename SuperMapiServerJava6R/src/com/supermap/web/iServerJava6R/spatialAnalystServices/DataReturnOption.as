package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_DataReturnOption_Title}.
	 * <p>${iServerJava6R_DataReturnOption_Description}</p> 
	 * 
	 */	
	public class DataReturnOption
	{
		private var _expectCount:int = 1000;
		private var _dataset:String;
		private var _dataReturnMode:String = DataReturnMode.RECORDSET_ONLY;
		private var _deleteExistResultDataset:Boolean = true;
		
		/**
		 * ${iServerJava6R_DataReturnOption_constructor_D} 
		 * 
		 */		
		public function DataReturnOption()
		{
		}

		/**
		 * ${iServerJava6R_DataReturnOption_attribute_expectCount_D} 
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
		 * ${iServerJava6R_DataReturnOption_attribute_deleteExistResultDataset_D}
		 * @see #dataset
		 * @return 
		 * 
		 */		
		public function get deleteExistResultDataset():Boolean
		{
			return _deleteExistResultDataset;
		}

		public function set deleteExistResultDataset(value:Boolean):void
		{
			_deleteExistResultDataset = value;
		}

		/**
		 * ${iServerJava6R_DataReturnOption_attribute_dataReturnMode_D} 
		 * @see DataReturnMode
		 * @return 
		 * 
		 */		
		public function get dataReturnMode():String
		{
			return _dataReturnMode;
		}

		public function set dataReturnMode(value:String):void
		{
			_dataReturnMode = value;
		}
		
		/**
		 * ${iServerJava6R_DataReturnOption_attribute_dataset_D}
		 * @see  DataReturnMode
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
		
		sm_internal function toJson():String
		{
			var json:String = "";
			
			if(this.expectCount)
			{
				json += "\"expectCount\":" + this.expectCount + ",";
			}
			if(this._dataset)
			{
				json += "\"dataset\":\"" + this._dataset + "\",";
			}
			
			json += "\"dataReturnMode\":\"" + this._dataReturnMode + "\"";
			
			json += ",\"deleteExistResultDataset\":" + this._deleteExistResultDataset;
			
			json = "{" + json + "}";
			
			return json;
		}

	}
}