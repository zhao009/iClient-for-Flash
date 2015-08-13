package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.*;
	import com.supermap.web.iServerJava2.ServerGeometry;
	use namespace sm_internal;
	
	/**
	 * ${iServer2_networkAnalystServices_ServiceAreaResult_Title}.
	 * <p>${iServer2_networkAnalystServices_ServiceAreaResult_Description}</p> 
	 * 
	 */	
	public class ServiceAreaResult
	{
		private var _areaRegions:Array;		
		private var _edges:Array;		
		private var _message:String;		
		private var _nodes:Array;		
		private var _pathGuides:Array;		
		private var _paths:Array;	
		private var _stops:Array;		
		private var _weights:Array;		
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaResult_attribute_areaRegions_D} 
		 * @return 
		 * 
		 */		
		public function get areaRegions():Array
		{
			return this._areaRegions;
		}
			
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaResult_attribute_edges_remarks} 
		 * @return 
		 * 
		 */		
		public function get edges():Array
		{
			return this._edges;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaResult_attribute_message_D} 
		 * @return 
		 * 
		 */		
		public function get message():String
		{
			return this._message;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaResult_attribute_nodes_D}.
		 * <p>${iServer2_networkAnalystServices_ServiceAreaResult_attribute_nodes_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get nodes():Array
		{
			return this._nodes;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaResult_attribute_pathGuides_D} 
		 * @see PathGuide
		 * @return 
		 * 
		 */		
		public function get pathGuides():Array
		{
			return this._pathGuides;
		}
	
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaResult_attribute_paths_D}.
		 * <p>${iServer2_networkAnalystServices_ServiceAreaResult_attribute_paths_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get paths():Array
		{
			return this._paths;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaResult_attribute_stops_D}.
		 * <p>${iServer2_networkAnalystServices_ServiceAreaResult_attribute_stops_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get stops():Array
		{
			return this._stops;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_ServiceAreaResult_attribute_weights_D} 
		 * <p>${iServer2_networkAnalystServices_ServiceAreaResult_attribute_weights_remarks}</p>
		 * @return 
		 * 
		 */		
		public function get weights():Array
		{
			return this._weights;
		}
		
		sm_internal static function toServiceAreaResult(object:Object):ServiceAreaResult
		{
			var serviceAreaResult:ServiceAreaResult;
			if(object)
			{
				serviceAreaResult = new ServiceAreaResult();
				
				var tempAreaRegions:Array = object.areaRegions;
				if(tempAreaRegions)
				{
					if(tempAreaRegions.length > 0)
					{
						serviceAreaResult._areaRegions = new Array();
						for(var i:int = 0; i < tempAreaRegions.length; i++)
							serviceAreaResult._areaRegions.push(ServerGeometry.fromJson(tempAreaRegions[i]));
					}
				}
				
				serviceAreaResult._message = object.message;
				serviceAreaResult._edges = object.edges;
				serviceAreaResult._nodes = object.nodes;
				serviceAreaResult._weights = object.weights;
				serviceAreaResult._stops = object.stops;
				
				var tempPathGuides:Array = object.pathGuides;
				if(tempPathGuides)
				{
					if(tempPathGuides.length > 0)
					{
						serviceAreaResult._pathGuides = new Array();
						for(var j:int = 0; j < tempPathGuides.length; j++)
							serviceAreaResult._pathGuides.push(PathGuide.toPathGuide(tempPathGuides[j]));
					}
				}
				
				var tempPaths:Array = object.paths;
				if(tempPaths)
				{
					if(tempPaths.length > 0)
					{
						serviceAreaResult._paths = new Array();
						for(var m:int = 0; m < tempPaths.length; m++)
							serviceAreaResult._paths.push(ServerGeometry.fromJson(tempPaths[m]));
					}
				}
				
				
			}
			return serviceAreaResult;
			
		}
	}
}