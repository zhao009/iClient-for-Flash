package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.geometry.Route;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.serverTypes.ServerFeature;
	
	use namespace sm_internal; 

	 /**
	  * ${iServerJava6R_Path_Title}. 
	  * <p>${iServerJava6R_Path_Description}</p>
	  */	
	 public class Path
	{ 	  
		private var _edgeFeatures:Array;
		private var _edgeIDs:Array;
		private var _nodeFeatures:Array;
		private var _nodeIDs:Array;
		private var _pathGuideItems:Array;
		private var _route:Route;
		private var _stopWeights:Array;
		private var _weight:Number = 0;
  
		/**
		 * ${iServerJava6R_Path_constructor_D} 
		 * 
		 */		
		public function Path()
		{
			
		}
		 
		/**
		 * ${iServerJava6R_Path_attribute_weight_D} 
		 * @return 
		 * 
		 */		
		public function get weight():Number
		{
			return _weight;
		}

		public function set weight(value:Number):void
		{
			_weight = value;
		}

		/**
		 * ${iServerJava6R_Path_attribute_stopWeights_D} 
		 * @return 
		 * 
		 */		
		public function get stopWeights():Array
		{
			return _stopWeights;
		}

		public function set stopWeights(value:Array):void
		{
			_stopWeights = value;
		}

		/**
		 * ${iServerJava6R_Path_attribute_route_D} 
		 * @see Route
		 * @return 
		 * 
		 */		
		public function get route():Route
		{
			return _route;
		}

		public function set route(value:Route):void
		{
			_route = value;
		}

		/**
		 * ${iServerJava6R_Path_attribute_pathGuideItems_D} 
		 * @see PathGuideItem
		 * @return 
		 * 
		 */		
		public function get pathGuideItems():Array
		{
			return _pathGuideItems;
		}

		public function set pathGuideItems(value:Array):void
		{
			_pathGuideItems = value;
		}

		/**
		 * ${iServerJava6R_Path_attribute_nodeIDs_D} 
		 * @return 
		 * 
		 */		
		public function get nodeIDs():Array
		{
			return _nodeIDs;
		}

		public function set nodeIDs(value:Array):void
		{
			_nodeIDs = value;
		}

		/**
		 * ${iServerJava6R_Path_attribute_nodeFeatures_D} 
		 * @return 
		 * 
		 */		
		public function get nodeFeatures():Array
		{
			return _nodeFeatures;
		}

		public function set nodeFeatures(value:Array):void
		{
			_nodeFeatures = value;
		}

		/**
		 * ${iServerJava6R_Path_attribute_edgeIDs_D} 
		 * @return 
		 * 
		 */		
		public function get edgeIDs():Array
		{
			return _edgeIDs;
		}

		public function set edgeIDs(value:Array):void
		{
			_edgeIDs = value;
		}

		/**
		 * ${iServerJava6R_Path_attribute_edgeFeatures_D} 
		 * @return 
		 * 
		 */		
		public function get edgeFeatures():Array
		{
			return _edgeFeatures;
		}

		public function set edgeFeatures(value:Array):void
		{
			_edgeFeatures = value;
		}
 
		sm_internal static function fromJson(json:Object):Path 
		{
			if (json == null)
			{
				return null;
			}
			var result:Path = new Path();
			if (json.edgeFeatures)
			{   
				result.edgeFeatures = [];
				var edgeFeaturesLength:int = (json.edgeFeatures as Array).length;
				for (var i:int = 0; i < edgeFeaturesLength; i++)
				{ 
					var serverFeature:ServerFeature = ServerFeature.fromJson(json.edgeFeatures[i]);
					var feature:Feature = ServerFeature.toFeature(serverFeature);
					result.edgeFeatures.push(feature);
				}
			}
			if (json.edgeIDs)
			{
				result.edgeIDs = [];
				var edgeIDsLength:int = (json.edgeIDs as Array).length;
				for (i = 0; i < edgeIDsLength; i++)
				{
					result.edgeIDs.push(json.edgeIDs[i]);
				}
			}
			if (json.nodeFeatures)
			{
				result.nodeFeatures = [];
				var nodeFeaturesLength:int = (json.nodeFeatures as Array).length
				for (i = 0; i < nodeFeaturesLength; i++)
				{
					var nodeServerFeature:ServerFeature = ServerFeature.fromJson(json.nodeFeatures[i]);
					var nodeFeature:Feature = ServerFeature.toFeature(nodeServerFeature);
					result.nodeFeatures.push(nodeFeature); 
				}
			}
			if (json.nodeIDs)
			{
				result.nodeIDs = [];
				var nodeIDsLength:int = (json.nodeIDs as Array).length;
				for (i = 0; i < nodeIDsLength; i++)
				{
					result.nodeIDs.push(json.nodeIDs[i]);
				}
			}
			if (json.pathGuideItems)
			{
				result.pathGuideItems = [];
				var pathGuideItemsLength:int = (json.pathGuideItems as Array).length;
				for (i = 0; i < pathGuideItemsLength; i++)
				{ 
					result.pathGuideItems.push(PathGuideItem.formJson(json.pathGuideItems[i]));
				}
			}
			if (json.route)
			{
				result.route = Route.fromJson(json.route);
			}
			if (json.stopWeights)
			{
				result.stopWeights = [];
				var stopWeightsLength:int = (json.stopWeights as Array).length;
				for (i = 0; i < stopWeightsLength; i++)
				{
					result.stopWeights.push(json.stopWeights[i]);
				}
			}
			result.weight = json.weight; 
			return result;
		}
	}
}