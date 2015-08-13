package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	
	import mx.collections.ArrayCollection;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_TransportationAnalystResultSetting_Title}.
	 * <p>${iServerJava6R_TransportationAnalystResultSetting_Description}</p> 
	 * @see TransportationAnalystResultSetting 
	 */	
	public class TransportationAnalystResultSetting
	{  
		private var _returnEdgeFeatures:Boolean;
		private var _returnEdgeGeometry:Boolean;
		private var _returnEdgeIDs:Boolean;
		
		private var _returnNodeFeatures:Boolean;
		private var _returnNodeGeometry:Boolean;
		private var _returnNodeIDs:Boolean;
		private var _returnPathGuides:Boolean;
		private var _returnRoutes:Boolean;
		
		/**
		 * ${iServerJava6R_TransportationAnalystResultSetting_constructor_D} 
		 * 
		 */		
		public function TransportationAnalystResultSetting()
		{
			
		}
 
		/**
		 * ${iServerJava6R_TransportationAnalystResultSetting_attribute_returnRoutes_D} 
		 * @default false
		 * @see Route
		 */		
		public function get returnRoutes():Boolean
		{
			return _returnRoutes;
		}
		public function set returnRoutes(value:Boolean):void
		{
			_returnRoutes = value;
		}

		/**
		 * ${iServerJava6R_TransportationAnalystResultSetting_attribute_ReturnPathGuides_D} 
		 * @default false
		 * @see PathGuideItem
		 */		
		public function get returnPathGuides():Boolean
		{
			return _returnPathGuides;
		}

		public function set returnPathGuides(value:Boolean):void
		{
			_returnPathGuides = value;
		}

		/**
		 * ${iServerJava6R_TransportationAnalystResultSetting_attribute_ReturnNodeIDs_D} 
		 * @default false
		 */		
		public function get returnNodeIDs():Boolean
		{
			return _returnNodeIDs;
		}

		public function set returnNodeIDs(value:Boolean):void
		{
			_returnNodeIDs = value;
		}
		
		/**
		 * ${iServerJava6R_TransportationAnalystResultSetting_attribute_ReturnNodeGeometry_D}.
		 * <p>${iServerJava6R_TransportationAnalystResultSetting_attribute_ReturnNodeGeometry_remarks}</p> 
		 * @see #returnNodeFeatures
		 * @default false
		 * 
		 */		
		public function get returnNodeGeometry():Boolean
		{
			return _returnNodeGeometry;
		}

		public function set returnNodeGeometry(value:Boolean):void
		{
			_returnNodeGeometry = value;
		}

		/**
		 * ${iServerJava6R_TransportationAnalystResultSetting_attribute_ReturnNodeFeatures_D}.
		 * <p>${iServerJava6R_TransportationAnalystResultSetting_attribute_ReturnNodeFeatures_remarks}</p> 
		 * @see #returnNodeGeometry
		 * @return 
		 * 
		 */		
		public function get returnNodeFeatures():Boolean
		{
			return _returnNodeFeatures;
		}

		public function set returnNodeFeatures(value:Boolean):void
		{
			_returnNodeFeatures = value;
		}

		/**
		 * ${iServerJava6R_TransportationAnalystResultSetting_attribute_ReturnEdgeIDs_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get returnEdgeIDs():Boolean
		{
			return _returnEdgeIDs;
		}

		public function set returnEdgeIDs(value:Boolean):void
		{
			_returnEdgeIDs = value;
		}

		/**
		 * ${iServerJava6R_TransportationAnalystResultSetting_attribute_ReturnEdgeGeometry_D}.
		 * <p>${iServerJava6R_TransportationAnalystResultSetting_attribute_ReturnEdgeGeometry_remarks}</p>
		 * @see #returnEdgeFeatures
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
		 * ${iServerJava6R_TransportationAnalystResultSetting_attribute_ReturnEdgeFeatures_D}.
		 * <p>${iServerJava6R_TransportationAnalystResultSetting_attribute_ReturnEdgeFeatures_remarks}</p> 
		 * @see #returnEdgeGeometry
		 * @return 
		 * 
		 */		
		public function get returnEdgeFeatures():Boolean
		{
			return _returnEdgeFeatures;
		}

		public function set returnEdgeFeatures(value:Boolean):void
		{
			_returnEdgeFeatures = value;
		}

		sm_internal static function toJson(param:TransportationAnalystResultSetting):String
		{
			if (param)
			{
				var json:String = "{"; 
				var list:ArrayCollection = new ArrayCollection();
				
				list.addItem(String("\"returnEdgeFeatures\":" + param.returnEdgeFeatures.toString().toLowerCase())); 
				list.addItem(String("\"returnEdgeGeometry\":" + param.returnEdgeGeometry.toString().toLowerCase())); 
				list.addItem(String("\"returnEdgeIDs\":" + param.returnEdgeIDs.toString().toLowerCase()));
		 
				list.addItem(String("\"returnNodeFeatures\":" + param.returnNodeFeatures.toString().toLowerCase()));
				list.addItem(String("\"returnNodeGeometry\":" + param.returnNodeGeometry.toString().toLowerCase()));
				list.addItem(String("\"returnNodeIDs\":" + param.returnNodeIDs.toString().toLowerCase()));
				list.addItem(String("\"returnPathGuides\":" + param.returnPathGuides.toString().toLowerCase()));
				list.addItem(String("\"returnRoutes\":" + param.returnRoutes.toString().toLowerCase()));
		  
				json += list.toString(); 
				json += "}";
				return json;
			}
			return null;
		}
		
		
	}
}