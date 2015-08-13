package com.supermap.web.iServerJava6R.networkAnalystServices
{
	/**
	 * ${iServerJava6R_FindMTSPPathsParameters_Title}.
	 * <p>${iServerJava6R_FindMTSPPathsParameters_Description}</p> 
	 * @see FindMTSPPathsService
	 * @see TransportationAnalystParameter
	 * 
	 */	
	public class FindMTSPPathsParameters
	{ 
		
		//--------------------------------------------------------------------------
		//
		//  多旅行商分析参数类
		//
		//--------------------------------------------------------------------------
		
		private var _centers:Array;
		private var _nodes:Array;
		private var _hasLeastTotalCost:Boolean;
		private var _parameter:TransportationAnalystParameter;
		private var _isAnalyzeById:Boolean;
		/**
		 * ${iServerJava6R_FindMTSPPathsParameters_constructor_D} 
		 * 
		 */		
		public function FindMTSPPathsParameters()
		{
		}

		/**
		 * ${iServerJava6R_FindTSPPathsParameters_attribute_isAnalyzeById_D}.
		 * <p>${iServerJava6R_FindTSPPathsParameters_attribute_isAnalyzeById_remarks}</p> 
		 * @see nodes
		 * @see centers
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
		 * ${iServerJava6R_FindMTSPPathsParameters_attribute_Parameter_D} 
		 * @see TransportationAnalystParameter
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
		 * ${iServerJava6R_FindMTSPPathsParameters_attribute_HasLeastTotalCost_D}.
		 * <p>${iServerJava6R_FindMTSPPathsParameters_attribute_HasLeastTotalCost_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get hasLeastTotalCost():Boolean
		{
			return _hasLeastTotalCost;
		}

		public function set hasLeastTotalCost(value:Boolean):void
		{
			_hasLeastTotalCost = value;
		}

		/**
		 * ${iServerJava6R_FindMTSPPathsParameters_attribute_Nodes_D}.
		 * <p>${iServerJava6R_FindMTSPPathsParameters_attribute_Nodes_remarks}</p> 
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
		/**
		 * ${iServerJava6R_FindMTSPPathsParameters_attribute_centers_D}.
		 * <p>${iServerJava6R_FindMTSPPathsParameters_attribute_centers_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get centers():Array
		{
			return _centers;
		}

		public function set centers(value:Array):void
		{
			_centers = value;
		}

	}
}