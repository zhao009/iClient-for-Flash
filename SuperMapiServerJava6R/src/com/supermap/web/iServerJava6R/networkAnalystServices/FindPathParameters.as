package com.supermap.web.iServerJava6R.networkAnalystServices
{
	/**
	 * ${iServerJava6R_FindPathParameters_Title}.
	 * <p>${iServerJava6R_FindPathParameters_Description}</p> 
	 * 
	 */	
	public class FindPathParameters
	{ 
		private var _nodes:Array; 
		private var _hasLeastEdgeCount:Boolean 
		private var _parameter:TransportationAnalystParameter;
		private var _isAnalyzeById:Boolean;
		
		/**
		 * ${iServerJava6R_FindPathParameters_constructor_D} 
		 * 
		 */		
		public function FindPathParameters()
		{
		}

		/**
		 * ${iServerJava6R_TransportationAnalystParameter_attribute_isAnalyzeById_D}.
		 * <p>${iServerJava6R_TransportationAnalystParameter_attribute_isAnalyzeById_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get isAnalyzeById():Boolean
		{
			return _isAnalyzeById;
		}

		public function set isAnalyzeById(value:Boolean):void
		{
			_isAnalyzeById = value;
		}

		/**
		 * ${iServerJava6R_FindPathParameters_attribute_parameter_D} 
		 * @return 
		 * 
		 */		
		public function get parameter():TransportationAnalystParameter
		{
			return _parameter;
		}

		public function set parameter(value:TransportationAnalystParameter):void
		{
			_parameter = value;
		}

		/**
		 * ${iServerJava6R_FindPathParameters_attribute_hasLeastEdgeCount_D}.
		 * <p>${iServerJava6R_FindPathParameters_attribute_hasLeastEdgeCount_remarks}</p>
		 * @return 
		 * 
		 */		
		public function get hasLeastEdgeCount():Boolean
		{
			return _hasLeastEdgeCount;
		}

		public function set hasLeastEdgeCount(value:Boolean):void
		{
			_hasLeastEdgeCount = value;
		}

		/**
		 * ${iServerJava6R_FindPathParameters_attribute_nodes_D}.
		 * <P>${iServerJava6R_FindPathParameters_attribute_nodes_remarks}</P> 
		 * @see #isAnalyzeById
		 * @return 
		 * 
		 */		
		public function get nodes():Array
		{
			return _nodes;
		}

		public function set nodes(value:Array):void
		{
			_nodes = value;
		}

	}
}