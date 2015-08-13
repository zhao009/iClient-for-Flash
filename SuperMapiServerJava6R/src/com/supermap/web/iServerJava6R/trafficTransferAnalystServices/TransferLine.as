package com.supermap.web.iServerJava6R.trafficTransferAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_TransferLine_Title}.
	 * 
	 */	
	public class TransferLine
	{
		private var _startStopName:String;
		private var _startStopIndex:int;
		private var _lineName:String;
		private var _lineID:int;
		private var _endStopName:String;
		private var _endStopIndex:int;

		/**
		 * ${iServerJava6R_TransferLine_contructor_D } 
		 * 
		 */			
		public function TransferLine()
		{
		}

		/**
		 * ${iServerJava6R_TransferLine_attribute_endStopIndex_D} 
		 * @return 
		 * 
		 */			
		public function get endStopIndex():int
		{
			return _endStopIndex;
		}

		/**
		 * ${iServerJava6R_TransferLine_attribute_endStopName_D} 
		 * @return 
		 * 
		 */		
		public function get endStopName():String
		{
			return _endStopName;
		}

		/**
		 * ${iServerJava6R_TransferLine_attribute_lineID_D} 
		 * @return 
		 * 
		 */	
		public function get lineID():int
		{
			return _lineID;
		}

		/**
		 * ${iServerJava6R_TransferLine_attribute_lineName_D} 
		 * @return 
		 * 
		 */	
		public function get lineName():String
		{
			return _lineName;
		}

		/**
		 * ${iServerJava6R_TransferLine_attribute_startStopIndex_D} 
		 * @return 
		 * 
		 */	
		public function get startStopIndex():int
		{
			return _startStopIndex;
		}

		/**
		 * ${iServerJava6R_TransferLine_attribute_startStopName_D} 
		 * @return 
		 * 
		 */	
		public function get startStopName():String
		{
			return _startStopName;
		}

		sm_internal static function fromJson(object:Object):TransferLine
		{
			var transferLine:TransferLine = null;
			if(object)
			{
				transferLine = new TransferLine();
				transferLine._endStopIndex = object.endStopIndex;
				transferLine._endStopName = object.endStopName;
				transferLine._lineID = object.lineID;
				transferLine._lineName = object.lineName;
				transferLine._startStopIndex = object.startStopIndex;
				transferLine._startStopName = object.startStopName;
			}
			return transferLine;
		}
		
		sm_internal function toJson():String
		{
			var json:String = "";
	
			json += "\"endStopIndex\":" + this.endStopIndex + ",";
			json += "\"endStopName\":" + "\"" + this.endStopName + "\",";
			json += "\"lineID\":" + this.lineID + ",";
			json += "\"lineName\":" + "\"" + this.lineName + "\",";
			json += "\"startStopIndex\":" + this.startStopIndex + ",";
			json += "\"startStopName\":" + "\"" + this.startStopName + "\"";
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}