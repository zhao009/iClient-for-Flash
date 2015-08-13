package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	import com.supermap.web.iServerJava2.ServerGeometry;
	use namespace sm_internal;
	
	/**
	 * ${iServer2_networkAnalystServices_NetworkAnalystResult_Title}.
	 * <p>${iServer2_networkAnalystServices_NetworkAnalystResult_Description}</p>
	 * @see NetworkAnalystParam
	 * 
	 * 
	 */
	public class NetworkAnalystResult
	{
		//分析结果的途经弧段ID集合
		private var _edges:Array;
		//路径分析过程中出现的异常信息，失败信息
		private var _message:String;
		//分析结果的途经结点 ID 的集合
		private var _nodes:Array;
		//行驶导引集合
		private var _pathGuides:Array;
		//分析结果的路由对象集合
		private var _paths:Array;
		//站点 ID 的集合
		private var _stops:Array;
		//阻力值的集合
		private var _weights:Array;
		
		/**
		 * @private
		 * ${iServer2_networkAnalystServices_NetworkAnalystResult_None_constructor_D} 
		 * 
		 */		
		public function NetworkAnalystResult()
		{
			
		}
		
		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystResult_attribute_edges_D}.
		 * <p>${iServer2_networkAnalystServices_NetworkAnalystResult_attribute_edges_remarks}</p>
		 * 
		 */
		public function get edges():Array
		{
			return this._edges;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystResult_attribute_message_D}
		 * 
		 */
		public function get message():String
		{
			return this._message;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystResult_attribute_nodes_D}.
		 * <p>${iServer2_networkAnalystServices_NetworkAnalystResult_attribute_nodes_remarks}</p>
		 * 
		 */
		public function get nodes():Array
		{
			return this._nodes;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystResult_attribute_pathGuides_D}
		 * @see PathGuide
		 * 
		 */
		public function get pathGuides():Array
		{
			return this._pathGuides;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystResult_attribute_paths_D}.
		 * <p>${iServer2_networkAnalystServices_NetworkAnalystResult_attribute_paths_remarks}</p>
		 * @see ServerGeometry
		 * 
		 */
		public function get paths():Array
		{
			return this._paths;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystResult_attribute_stops_D}.
		 * <p>${iServer2_networkAnalystServices_NetworkAnalystResult_attribute_stops_remarks}</p>
		 * 
		 */
		public function get stops():Array
		{
			return this._stops;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystResult_attribute_weights_D}
		 * 
		 */
		public function get weights():Array
		{
			return this._weights;
		}
		
		sm_internal static function toNetworkAnalystResult(object:Object):NetworkAnalystResult
		{
			var networkAnalystResult:NetworkAnalystResult;
			if(object)
			{
				networkAnalystResult = new NetworkAnalystResult();
					
				networkAnalystResult._message = object.message;
				networkAnalystResult._edges = object.edges;
				networkAnalystResult._nodes = object.nodes;
				networkAnalystResult._weights = object.weights;
				networkAnalystResult._stops = object.stops;
				
				var tempPathGuides:Array = object.pathGuides;
				if(tempPathGuides)
				{
					if(tempPathGuides.length > 0)
					{
						networkAnalystResult._pathGuides = new Array();
						for(var j:int = 0; j < tempPathGuides.length; j++)
							networkAnalystResult._pathGuides.push(PathGuide.toPathGuide(tempPathGuides[j]));
					}
				}
				
				var tempPaths:Array = object.paths;
				if(tempPaths)
				{
					if(tempPaths.length > 0)
					{
						networkAnalystResult._paths = new Array();
						for(var m:int = 0; m < tempPaths.length; m++)
							networkAnalystResult._paths.push(ServerGeometry.fromJson(tempPaths[m]));
					}
				}
			}
			return networkAnalystResult;
		}

	}
}