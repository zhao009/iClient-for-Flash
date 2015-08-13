package com.supermap.web.iServerJava6R.networkAnalystServices
{
	/**
	 * ${iServerJava6R_FindLocationParameters_Title}.
	 * <p>${iServerJava6R_FindLocationParameters_Description}</p> 
	 * @see FindLocationService
	 * 
	 */	
	public class FindLocationParameters
	{ 
		private var _expectedSupplyCenterCount:int = 1;
		private var _isFromCenter:Boolean;
		private var _supplyCenters:Array;
		//private var _expectedSupplyCenterCount:int;
		//private var _nodeDemandField:String;
		private var _weightName:String;
		private var _turnWeightField:String;
		
		//这里提供TransportationAnalystParameter提供的三个参数，与接口文档保持一致
		private var _returnEdgeFeature:Boolean;
		private var _returnEdgeGeometry:Boolean;
		private var _returnNodeFeature:Boolean;
		  
		/**
		 * ${iServerJava6R_FindLocationParameters_constructor_D} 
		 * 
		 */		
		public function FindLocationParameters()
		{
		}

		/**
		 * ${iServerJava6R_FindLocationParameters_attribute_returnNodeFeature_D}.
		 * @return 
		 * 
		 */		
		public function get returnNodeFeature():Boolean
		{
			return _returnNodeFeature;
		}

		public function set returnNodeFeature(value:Boolean):void
		{
			_returnNodeFeature = value;
		}

		/**
		 * ${iServerJava6R_FindLocationParameters_attribute_returnEdgeFeature_D}.
		 * <p>${iServerJava6R_FindLocationParameters_attribute_returnEdgeFeature_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get returnEdgeFeature():Boolean
		{
			return _returnEdgeFeature;
		}

		public function set returnEdgeFeature(value:Boolean):void
		{
			_returnEdgeFeature = value;
		}

		/**
		 * ${iServerJava6R_FindLocationParameters_attribute_isFromCenter_D}.
		 * <p>${iServerJava6R_FindLocationParameters_attribute_isFromCenter_remarks}</p> 
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
		 * ${iServerJava6R_FindLocationParameters_attribute_supplyCenters_D}.
		 * <p>${iServerJava6R_FindLocationParameters_attribute_supplyCenters_remarks}</p> 
		 * @see SupplyCenter
		 * @return 
		 * 
		 */		
		public function get supplyCenters():Array
		{
			return _supplyCenters;
		}

		public function set supplyCenters(value:Array):void
		{
			_supplyCenters = value;
		}
 
		/**
		 * ${iServerJava6R_FindLocationParameters_attribute_ReturnEdgeGeometry_D}.
		 * <p>${iServerJava6R_FindLocationParameters_attribute_ReturnEdgeGeometry_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get returnEdgeGeometry():Boolean
		{
			return _returnEdgeGeometry;
		}

		public function set returnEdgeGeometry(value:Boolean):void
		{
			_returnEdgeGeometry = value;
		}
 
		/**
		 * ${iServerJava6R_FindLocationParameters_attribute_TurnWeightField_D} 
		 * @return 
		 * 
		 */		
		public function get turnWeightField():String
		{
			return _turnWeightField;
		}

		public function set turnWeightField(value:String):void
		{
			_turnWeightField = value;
		}

		/**
		 * ${iServerJava6R_FindLocationParameters_attribute_WeightName_D}.
		 * <p>${iServerJava6R_FindLocationParameters_attribute_WeightName_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get weightName():String
		{
			return _weightName;
		}

		public function set weightName(value:String):void
		{
			_weightName = value;
		}

		

		/**
		 * ${iServerJava6R_FindLocationParameters_attribute_ExpectedSupplyCenterCount_D}.
		 * <p>${iServerJava6R_FindLocationParameters_attribute_ExpectedSupplyCenterCount_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get expectedSupplyCenterCount():int
		{
			return this._expectedSupplyCenterCount;
		}

		public function set expectedSupplyCenterCount(value:int):void
		{
			if (value < 1)
			{
				value = 1;
			}
			_expectedSupplyCenterCount = value;
		} 
	}
}