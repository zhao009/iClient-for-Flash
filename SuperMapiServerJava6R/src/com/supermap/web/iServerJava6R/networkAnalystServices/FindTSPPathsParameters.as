package com.supermap.web.iServerJava6R.networkAnalystServices
{
	/**
	 * ${iServerJava6R_FindTSPPathsParameters_Title}.
	 * <p>${iServerJava6R_FindTSPPathsParameters_Description}</p> 
	 * @see TransportationAnalystParameter
	 * 
	 */	
	public class FindTSPPathsParameters
	{
		private var _nodes:Array;
		private var _endNodeAssigned:Boolean;
		private var _parameter:TransportationAnalystParameter; 
		private var _isAnalyzeById:Boolean
		
		/**
		 * ${iServerJava6R_FindTSPPathsParameters_constructor_D} 
		 * 
		 */		
		public function FindTSPPathsParameters()
		{
		}

		/**
		 * ${iServerJava6R_FindTSPPathsParameters_attribute_isAnalyzeById_D}.
		 * <p>${iServerJava6R_FindTSPPathsParameters_attribute_isAnalyzeById_remarks}</p> 
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
		 * ${iServerJava6R_FindTSPPathsParameters_attribute_parameter_D} 
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
		 * ${iServerJava6R_FindTSPPathsParameters_attribute_endNodeAssigned_D}.
		 * <p>${iServerJava6R_FindTSPPathsParameters_attribute_endNodeAssigned_remarks}</p> 
		 * @see #nodes
		 * @return 
		 * 
		 */		
		public function get endNodeAssigned():Boolean
		{
			return _endNodeAssigned;
		}

		public function set endNodeAssigned(value:Boolean):void
		{
			_endNodeAssigned = value;
		}

		/**
		 * ${iServerJava6R_FindTSPPathsParameters_attribute_nodes_D}.
		 * <p>${iServerJava6R_FindTSPPathsParameters_attribute_nodes_remarks}</p> 
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