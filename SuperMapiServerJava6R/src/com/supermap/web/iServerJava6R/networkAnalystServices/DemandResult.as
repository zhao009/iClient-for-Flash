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
	 * ${iServerJava6R_DemandResult_Title}.
	 * <p>${iServerJava6R_DemandResult_Description}</p> 
	 * 
	 */	
	public class DemandResult
	{
		//--------------------------------------------------------------------------
		//
		//  要求结果
		//
		//--------------------------------------------------------------------------
		
		private var _actualResourceValue:Number= 0;
		private var _demandID:int;
		private var _isEdge:Boolean;
		private var _supplyCenter:SupplyCenter;
		private var _feature:Feature;
		/**
		 * ${iServerJava6R_DemandResult_constructor_D} 
		 * 
		 */		
		public function DemandResult()
		{
			
		}

		/**
		 * ${iServerJava6R_DemandResult_attribute_feature_D} 
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
		 * ${iServerJava6R_DemandResult_attribute_supplyCenter_D} 
		 * @return 
		 * 
		 */		
		public function get supplyCenter():SupplyCenter
		{
			return _supplyCenter;
		}
 
		/**
		 * ${iServerJava6R_DemandResult_attribute_isEdge_remarks} 
		 * @return 
		 * 
		 */		
		public function get isEdge():Boolean
		{
			return _isEdge;
		}
 
		/**
		 * ${iServerJava6R_DemandResult_attribute_demandID_D}.
		 * <p>${iServerJava6R_DemandResult_attribute_demandID_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get demandID():int
		{
			return _demandID;
		}
 
		/**
		 * ${iServerJava6R_DemandResult_attribute_actualResourceValue_D} 
		 * @return 
		 * 
		 */		
		public function get actualResourceValue():Number
		{
			return _actualResourceValue;
		}
 
		sm_internal static function fromJson(json:Object):DemandResult 
		{
			if (json == null)
				return null;
			
			var result:DemandResult = new DemandResult();
			result._actualResourceValue = json.actualResourceValue;
			result._demandID = json.demandID;
			result._isEdge = json.isEdge;
			result._supplyCenter = SupplyCenter.fromJson(json.supplyCenter);
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