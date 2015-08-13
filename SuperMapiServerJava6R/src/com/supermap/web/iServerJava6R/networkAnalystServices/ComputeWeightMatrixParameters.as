package com.supermap.web.iServerJava6R.networkAnalystServices
{
	//耗费矩阵分析参数类
	/**
	 * ${iServerJava6R_ComputeWeightMatrixParameters_Title}. 
	 * <p>${iServerJava6R_ComputeWeightMatrixParameters_Description}</p>
	 * @see ComputeWeightMatrixService
	 */	
	public class ComputeWeightMatrixParameters
	{ 
		
		private var _nodes:Array; 
		private var _parameter:TransportationAnalystParameter;
		private var _isAnalyzeById:Boolean;
		/**
		 * ${iServerJava6R_ComputeWeightMatrixParameters_constructor_D} 
		 * 
		 */		
		public function ComputeWeightMatrixParameters()
		{
		}

		/**
		 * ${iServerJava6R_ComputeWeightMatrixParameters_attribute_isAnalyzeById_D} 
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
		 * ${iServerJava6R_ComputeWeightMatrixParameters_attribute_parameter_D} 
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
		 * ${iServerJava6R_ComputeWeightMatrixParameters_attribute_Nodes_D}.
		 * <p>${iServerJava6R_ComputeWeightMatrixParameters_attribute_Nodes_remarks}</p> 
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