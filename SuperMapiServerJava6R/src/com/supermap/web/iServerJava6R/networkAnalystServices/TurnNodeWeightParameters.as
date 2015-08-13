package com.supermap.web.iServerJava6R.networkAnalystServices
{
	

	/**
	 * ${iServerJava6R_TurnNodeWeightParameters_Title}.
	 * <p>${iServerJava6R_TurnNodeWeightParameters_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.UpdateTurnNodeWeightService
	 * 
	 */
	public class TurnNodeWeightParameters
	{
		private var _nodeID:int;
		private var _fromEdgeID:int;
		private var _toEdgeID:int;
		private var _weightField:String=TurnNodeWeightFieldType.TURNCOST;
		private var _weight:int;
		/**
		 * ${iServerJava6R_TurnNodeWeightParameters_constructor_D} 
		 * 
		 */	
		public function TurnNodeWeightParameters()
		{
		}
		/**
		 * ${iServerJava6R_TurnNodeWeightParameters_attribute_nodeID_D}.
		 * @return 
		 * 
		 */	
		public function get nodeID():int
		{
			return _nodeID;
		}
		public function set nodeID(value:int):void
		{
			_nodeID=value;
		}
		/**
		 * ${iServerJava6R_TurnNodeWeightParameters_attribute_fromEdgeID_D}.
		 * @return 
		 * 
		 */	
		public function get fromEdgeID():int
		{
			return _fromEdgeID;
		}
		public function set fromEdgeID(value:int):void
		{
			_fromEdgeID = value;
		}
		/**
		 * ${iServerJava6R_TurnNodeWeightParameters_attribute_toEdgeID_D}.
		 * @return 
		 * 
		 */	
		public function get toEdgeID():int
		{
			return _toEdgeID;
		}
		public function set toEdgeID(value:int):void
		{
			_toEdgeID=value;
		}
		/**
		 * ${iServerJava6R_TurnNodeWeightParameters_attribute_weightField_D}.
		 * @return 
		 * 
		 */	
		public function get weightField():String
		{
			return _weightField;
		}
		public function set weightField(value:String):void
		{
			_weightField=value;
		}
		/**
		 * ${iServerJava6R_TurnNodeWeightParameters_attribute_weight_D}.
		 * @return 
		 * 
		 */	
		public function get weight():int
		{
			return _weight;
		}
		public function set weight(value:int):void
		{
			_weight=value;
		}
	}
}