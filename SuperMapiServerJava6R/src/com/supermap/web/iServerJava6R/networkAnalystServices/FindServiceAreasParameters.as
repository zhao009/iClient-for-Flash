package com.supermap.web.iServerJava6R.networkAnalystServices
{
	/**
	 * ${iServerJava6R_ServiceAreaParameters_Title}.
	 * <p>${iServerJava6R_ServiceAreaParameters_Description}</p> 
	 * 
	 */	
	public class FindServiceAreasParameters
	{ 
		//--------------------------------------------------------------------------
		//
		//  服务区分析参数类
		//
		//--------------------------------------------------------------------------
		
		private var _centers:Array;
		private var _weights:Array;
		private var _isFromCenter:Boolean;
		private var _isCenterMutuallyExclusive:Boolean;
		private var _parameter:TransportationAnalystParameter;
		private var _isAnalyzeById:Boolean;
		/**
		 * ${iServerJava6R_ServiceAreaParameters_constructor_D} 
		 * 
		 */		
		public function FindServiceAreasParameters()
		{
		}
    
		/**
		 * ${iServerJava6R_ServiceAreaParameters_attribute_IsAnalyzeById}
		 * <p>${iServerJava6R_ServiceAreaParameters_attribute_IsAnalyzeById_remarks}</p> 
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
		 * ${iServerJava6R_ServiceAreaParameters_attribute_Parameter} 
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
		 * ${iServerJava6R_ServiceAreaParameters_attribute_IsCenterMutuallyExclusive}.
		 * <p>${iServerJava6R_ServiceAreaParameters_attribute_IsCenterMutuallyExclusive_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get isCenterMutuallyExclusive():Boolean
		{
			return _isCenterMutuallyExclusive;
		}

		public function set isCenterMutuallyExclusive(value:Boolean):void
		{
			_isCenterMutuallyExclusive = value;
		}

		/**
		 * ${iServerJava6R_ServiceAreaParameters_attribute_IsFromCenter}.
		 * <p>${iServerJava6R_ServiceAreaParameters_attribute_IsFromCenter_remarks}</p>
		 * @default false
		 * @return 
		 * 
		 */		
		public function get isFromCenter():Boolean
		{
			return _isFromCenter;
		}

		public function set isFromCenter(value:Boolean):void
		{
			_isFromCenter = value;
		}

		/**
		 * ${iServerJava6R_ServiceAreaParameters_attribute_Weights}.
		 * <p>${iServerJava6R_ServiceAreaParameters_attribute_Weights_remarks}</p>
		 * @see TransportationAnalystParameter#weightFieldName
		 * @see #centers
		 * @return 
		 * 
		 */		
		public function get weights():Array
		{
			return _weights;
		}

		public function set weights(value:Array):void
		{
			_weights = value;
		}

		/**
		 * ${iServerJava6R_ServiceAreaParameters_attribute_Centers}.
		 * <p>${iServerJava6R_ServiceAreaParameters_attribute_Centers_remarks}</p> 
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