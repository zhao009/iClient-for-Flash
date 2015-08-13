package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.utils.serverTypes.ServerFeature;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_SupplyResult_Title}.
	 * <p>${iServerJava6R_SupplyResult_Description}</p> 
	 * @see FindLocationService
	 * @see DemandResult
	 */
	public class SupplyResult
	{ 
		private var _actualResourceValue:Number = 0;
		private var _averageWeight:Number = 0;
		private var _demandCount:int;
		private var _maxWeight:Number = 0;
		private var _nodeID:int;
		private var _resourceValue:Number = 0;
		private var _totalWeights:Number = 0;
		private var _type:String;
		private var _feature:Feature;
		
		/**
		 * ${iServerJava6R_SupplyResult_constructor_D} 
		 * 
		 */		
		public function SupplyResult()
		{
		}
		
		/**
		 * ${iServerJava6R_SupplyResult_attribute_feature_D} 
		 * @return 
		 * 
		 */		
		public function get feature():Feature
		{
			return _feature;
		}

		public function set feature(value:Feature):void
		{
			_feature = value;
		}

		/**
		 * ${iServerJava6R_SupplyResult_attribute_type_D}
		 * @see SupplyCenterType 
		 * @return 
		 * 
		 */		
		public function get type():String
		{
			return _type;
		}
 
		/**
		 * ${iServerJava6R_SupplyResult_attribute_totalWeights_D} 
		 * @return 
		 * 
		 */		
		public function get totalWeights():Number
		{
			return _totalWeights;
		}
 
		/**
		 * ${iServerJava6R_SupplyResult_attribute_resourceValue_D}.
		 * <p>${iServerJava6R_SupplyResult_attribute_resourceValue_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get resourceValue():Number
		{
			return _resourceValue;
		}
 
		/**
		 * ${iServerJava6R_SupplyResult_attribute_nodeID_D} 
		 * @return 
		 * 
		 */		
		public function get nodeID():int
		{
			return _nodeID;
		}
 
		/**
		 * ${iServerJava6R_SupplyResult_attribute_maxWeight_D}.
		 * <p>${iServerJava6R_SupplyResult_attribute_maxWeight_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get maxWeight():Number
		{
			return _maxWeight;
		}
 
		/**
		 * ${iServerJava6R_SupplyResult_attribute_demandCount_D} 
		 * @return 
		 * 
		 */		
		public function get demandCount():int
		{
			return _demandCount;
		}
 
		/**
		 * ${iServerJava6R_SupplyResult_attribute_averageWeight_D} 
		 * @return 
		 * 
		 */		
		public function get averageWeight():Number
		{
			return _averageWeight;
		}
 
		/**
		 * ${iServerJava6R_SupplyResult_attribute_actualResourceValue_D} 
		 * @return 
		 * 
		 */		
		public function get actualResourceValue():Number
		{
			return _actualResourceValue;
		} 
		
		sm_internal static function fromJson(json:Object):SupplyResult
		{
			if (json == null)
				return null;
			 
			var result:SupplyResult = new SupplyResult();
			result._actualResourceValue = json.actualResourceValue;
			result._averageWeight = json.averageWeight;
			result._demandCount = json.demandCount;
			result._maxWeight = json.maxWeight;
			result._nodeID = json.nodeID;
			result._resourceValue = json.resourceValue;
			result._totalWeights = json.totalWeights;
			result._type = json.type as String;
			result._feature = getFeature(json);
			return result;
		}
		private static function getFeature(json:Object):Feature
		{
			var serverFeature:ServerFeature = ServerFeature.fromJson(json);
			return ServerFeature.toFeature(serverFeature);
		}
	}
}