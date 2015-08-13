package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.geometry.Route;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.serverTypes.ServerFeature;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ServiceArea_Title}.
	 * <p>${iServerJava6R_ServiceArea_Description}</p> 
	 * 
	 */	
	public class ServiceArea
	{ 
		private var _edgeFeatures:Array;
		private var _edgeIDs:Array;
		private var _nodeFeatures:Array;
		private var _nodeIDs:Array;
		private var _routes:Array;
		private var _serviceRegion:Geometry;
		
		/**
		 * ${iServerJava6R_ServiceArea_constructor_D} 
		 * 
		 */		
		public function ServiceArea()
		{
			
		}
		    
		/**
		 * ${iServerJava6R_ServiceArea_attribute_ServiceRegion_D} 
		 */
		public function get serviceRegion():Geometry
		{
			return _serviceRegion;
		}

		/**
		 * @private
		 */
		public function set serviceRegion(value:Geometry):void
		{
			_serviceRegion = value;
		}

		/**
		 * ${iServerJava6R_ServiceArea_attribute_Routes_D} 
		 * @see Route
		 */
		public function get routes():Array
		{
			return _routes;
		}

		/**
		 * @private
		 */
		public function set routes(value:Array):void
		{
			_routes = value;
		}

		/**
		 * ${iServerJava6R_ServiceArea_attribute_NodeIDs_D} 
		 */
		public function get nodeIDs():Array
		{
			return _nodeIDs;
		}

		/**
		 * @private
		 */
		public function set nodeIDs(value:Array):void
		{
			_nodeIDs = value;
		}

		/**
		 * ${iServerJava6R_ServiceArea_attribute_NodeFeatures_D} 
		 */
		public function get nodeFeatures():Array
		{
			return _nodeFeatures;
		}

		/**
		 * @private
		 */
		public function set nodeFeatures(value:Array):void
		{
			_nodeFeatures = value;
		}

		/**
		 * ${iServerJava6R_ServiceArea_attribute_EdgeIDs_D} 
		 */
		public function get edgeIDs():Array
		{
			return _edgeIDs;
		}

		/**
		 * @private
		 */
		public function set edgeIDs(value:Array):void
		{
			_edgeIDs = value;
		}

		/**
		 * ${iServerJava6R_ServiceArea_attribute_EdgeFeatures_D} 
		 */
		public function get edgeFeatures():Array
		{
			return _edgeFeatures;
		}

		/**
		 * @private
		 */
		public function set edgeFeatures(value:Array):void
		{
			_edgeFeatures = value;
		}

		/**
		 * ${iServerJava6R_ServiceArea_method_FromJson_D} 
		 * @param json ${iServerJava6R_ServiceArea_method_FromJson_param_jsonObject}
		 * @return ${iServerJava6R_ServiceArea_method_FromJson_return}
		 * 
		 */		
		public static function  fromJson(json:Object):ServiceArea
		{
			if (json == null)
				return null;
			
			var result:ServiceArea = new ServiceArea(); 
			if (json.edgeFeatures != null)
			{
				result.edgeFeatures = [];
				var edgeFeaturesLength:int = (json.edgeFeatures as Array).length;
				for (var i:int = 0; i < edgeFeaturesLength; i++)
				{
	   				result.edgeFeatures.push(ServerFeature.toFeature(ServerFeature.fromJson(json.edgeFeatures[i])));
				}
			}
			if (json.edgeIDs != null)
			{
				result.edgeIDs = [];
				var edgeIDsLength:int = (json.edgeIDs as Array).length;
				for (i = 0; i < edgeIDsLength; i++)
				{
					result.edgeIDs.push(json.edgeIDs[i]);
				}
			}
			if (json.nodeFeatures != null)
			{
				result.nodeFeatures = [];
				var nodeFeaturesLength:int = (json.nodeFeatures as Array).length;
				
				for (i = 0; i < nodeFeaturesLength; i++)
				{
					result.nodeFeatures.push(ServerFeature.toFeature(ServerFeature.fromJson(json.nodeFeatures[i])));
				}
			}
			if (json.nodeIDs != null)
			{ 
				result.nodeIDs = [];
				var nodeIDsLength:int = (json.nodeIDs as Array).length;
				for (i = 0; i < nodeIDsLength; i++)
				{
					result.nodeIDs.push(json.nodeIDs[i]);
				}
			}
			if (json.routes != null)
			{ 
				result.routes = [];
				var routesLength:int = (json.routes as Array).length; 
				for (i = 0; i < routesLength; i++)
				{
					result.routes.push(Route.fromJson(json.routes[i]));
				}
			}
			result.serviceRegion = ServerGeometry.toGeometry(ServerGeometry.fromJson(json.serviceRegion));
			
			return result;
		}
	}
}