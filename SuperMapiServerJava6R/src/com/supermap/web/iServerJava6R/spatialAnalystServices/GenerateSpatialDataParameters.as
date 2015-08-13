package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_GenerateSpatialDataParameters_Title}.
	 * <p>${iServerJava6R_GenerateSpatialDataParameters_Description}</p> 
	 * 
	 */	
	public class GenerateSpatialDataParameters
	{
		private var _routeTable:String;
		private var _routeIDField:String;
		private var _eventTable:String;
		private var _eventRouteIDField:String;
		private var _measureField:String;
		private var _measureStartField:String;
		private var _measureEndField:String;
		private var _measureOffsetField:String;
		private var _errorInfoField:String;
		private var _retainedFields:Array=null;
		private var _dataReturnOption:DataReturnOption = new DataReturnOption();
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_constructor_D} 
		 * 
		 */	
		public function GenerateSpatialDataParameters()
		{
		}
		
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_attribute_routeTable_D}.
		 * @return 
		 * 
		 */	
		public function get routeTable():String
		{
			return _routeTable;
		}

		public function set routeTable(value:String):void
		{
			_routeTable = value;
		}
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_attribute_routeIDField_D}.
		 * @return 
		 * 
		 */
		public function get routeIDField():String
		{
			return _routeIDField;
		}

		public function set routeIDField(value:String):void
		{
			_routeIDField = value;
		}
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_attribute_eventTable_D}.
		 * @return 
		 * 
		 */
		public function get eventTable():String
		{
			return _eventTable;
		}

		public function set eventTable(value:String):void
		{
			_eventTable = value;
		}
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_attribute_eventRouteIDField_D}.
		 * @return 
		 * 
		 */
		public function get eventRouteIDField():String
		{
			return _eventRouteIDField;
		}

		public function set eventRouteIDField(value:String):void
		{
			_eventRouteIDField = value;
		}
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_attribute_measureField_D}.
		 * @return 
		 * 
		 */
		public function get measureField():String
		{
			return _measureField;
		}

		public function set measureField(value:String):void
		{
			_measureField = value;
		}
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_attribute_measureStartField_D}.
		 * @return 
		 * 
		 */
		public function get measureStartField():String
		{
			return _measureStartField;
		}

		public function set measureStartField(value:String):void
		{
			_measureStartField = value;
		}
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_attribute_measureEndField_D}.
		 * @return 
		 * 
		 */
		public function get measureEndField():String
		{
			return _measureEndField;
		}

		public function set measureEndField(value:String):void
		{
			_measureEndField = value;
		}
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_attribute_measureOffsetField_D}.
		 * @return 
		 * 
		 */
		public function get measureOffsetField():String
		{
			return _measureOffsetField;
		}

		public function set measureOffsetField(value:String):void
		{
			_measureOffsetField = value;
		}
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_attribute_errorInfoField_D}.
		 * @return 
		 * 
		 */
		public function get errorInfoField():String
		{
			return _errorInfoField;
		}

		public function set errorInfoField(value:String):void
		{
			_errorInfoField = value;
		}
		
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_attribute_retainedFields_D}.
		 * @return 
		 * 
		 */
		public function get retainedFields():Array
		{
			return _retainedFields;
		}
		
		public function set retainedFields(value:Array):void
		{
			_retainedFields = value;
		}
		
		/**
		 * ${iServerJava6R_GenerateSpatialDataParameters_attribute_dataReturnOption_D}.
		 * @return 
		 * 
		 */
		public function get dataReturnOption():DataReturnOption
		{
			return _dataReturnOption;
		}

		public function set dataReturnOption(value:DataReturnOption):void
		{
			_dataReturnOption = value;
		}

		sm_internal function getVariablesJson():String
		{
			var json:String = "";
			
			
			
			
			if(this.routeIDField)
			{
				json += "\"routeIDField\":\"" + this.routeIDField + "\",";	
			}
			if(this.eventTable)
			{
				json += "\"eventTable\":\"" + this.eventTable + "\",";
			}
			if(this.eventRouteIDField)
			{
				json += "\"eventRouteIDField\":\"" + this.eventRouteIDField + "\",";
			}
			if(this.measureField)
			{
				json += "\"measureField\":\"" + this.measureField + "\",";
			}
			if(this.measureStartField)
			{
				json += "\"measureStartField\":\"" + this.measureStartField + "\",";
			}
			if(this.measureEndField)
			{
				json += "\"measureEndField\":\"" + this.measureEndField + "\",";
			}
			if(this.measureOffsetField)
			{
				json += "\"measureOffsetField\":\"" + this.measureOffsetField + "\",";
			}
			if(this.errorInfoField)
			{
				json += "\"errorInfoField\":\"" + this.errorInfoField + "\",";
			}
			if(this.retainedFields)
			{	
				json += "\"retainedFields\":" +"[" + this.retainedFields + "],";
			}
			
			json += "\"dataReturnOption\":" + this.dataReturnOption.toJson();
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}