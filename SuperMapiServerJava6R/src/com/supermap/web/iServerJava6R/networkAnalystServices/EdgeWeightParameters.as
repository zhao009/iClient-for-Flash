package com.supermap.web.iServerJava6R.networkAnalystServices
{
	/**
	 * ${iServerJava6R_EdgeWeightParameters_Title}.
	 * <p>${iServerJava6R_EdgeWeightParameters_Description}</p> 
	 * @see com.supermap.web.iServerJava6R.networkAnalystServices.UpdateEdgeWeightService
	 * 
	 */
	public class EdgeWeightParameters
	{
		private var _edgeID:int;
		private var _fromNodeID:int;
		private var _toNodeID:int;
		private var _weightField:String=EdgeWeightFieldType.TIME;
		private var _weight:int;
		
		/**
		 * ${iServerJava6R_EdgeWeightParameters_constructor_D} 
		 * 
		 */	
		public function EdgeWeightParameters()
		{
			
		}
		/**
		 * ${iServerJava6R_EdgeWeightParameters_attribute_edgeID_D}.
		 * @return 
		 * 
		 */	
		public function get edgeID():int
		{
			return _edgeID;
		}
		public  function set edgeID(value:int):void
		{
			_edgeID=value;
		}
		/**
		 * ${iServerJava6R_EdgeWeightParameters_attribute_fromNodeID_D}.
		 * @return 
		 * 
		 */	
		public function get fromNodeID():int
		{
			return _fromNodeID;
		}
		public  function set fromNodeID(value:int):void
		{
			_fromNodeID=value;
		}
		/**
		 * ${iServerJava6R_EdgeWeightParameters_attribute_toNodeID_D}.
		 * @return 
		 * 
		 */
		public function get toNodeID():int
		{
			return _toNodeID;
		}
		public  function set toNodeID(value:int):void
		{
			_toNodeID=value;
		}
		/**
		 * ${iServerJava6R_EdgeWeightParameters_attribute_weightField_D}.
		 * @return 
		 * 
		 */
		public function get weightField():String
		{
			return _weightField;
		}
		public  function set weightField(value:String):void
		{
			_weightField=value;
		}
		/**
		 * ${iServerJava6R_EdgeWeightParameters_attribute_weight_D}.
		 * @return 
		 * 
		 */
		public function get weight():int
		{
			return _weight;
		}
		public  function set weight(value:int):void
		{
			_weight=value;
		}
		
	}
}