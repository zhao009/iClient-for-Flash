package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_MTSPPath_Title}.
	 * <p>${iServerJava6R_MTSPPath_Description}</p> 
	 * 
	 */	
	public class MTSPPath extends TSPPath
	{ 
		private var _center:Object;
		private var _nodesVisited:Array;
		/**
		 * ${iServerJava6R_TSPPath_constructor_D} 
		 * 
		 */		
		public function MTSPPath()
		{
			super();
		}
		
		/**
		 * ${iServerJava6R_MTSPPath_attribute_NodesVisited_D} 
		 * @return 
		 * 
		 */		
		public function get nodesVisited():Array
		{
			return _nodesVisited;
		}

		public function set nodesVisited(value:Array):void
		{
			_nodesVisited = value;
		}

		/**
		 * ${iServerJava6R_MTSPPath_attribute_Center_D} 
		 * @return 
		 * 
		 */		
		public function get center():Object
		{
			return _center;
		}

		public function set center(value:Object):void
		{
			_center = value;
		}

		/**
		 * ${iServerJava6R_MTSPPath_method_fromJson_D} 
		 * @param json ${iServerJava6R_MTSPPath_method_fromJson_param_jsonObject}
		 * @return ${iServerJava6R_MTSPPath_method_fromJson_return}
		 * 
		 */		
		public static function fromJson(json:Object):MTSPPath
		{
			if (json == null)
				return null;
			
			var result:MTSPPath = new MTSPPath();
			result.center = json.center;
			
			if (json.nodesVisited)
			{
				result.nodesVisited = [];
				var nodesVisitedLength:int = (json.nodesVisited as Array).length;
				for (var i:int = 0; i < nodesVisitedLength; i++)
				{
					result.nodesVisited.push(json.nodesVisited[i]);
				}
			}
			
			if (json.stopIndexes)
			{
				result.stopIndexes = [];
				var stopIndexesLength:int = (json.stopIndexes as Array).length;
				for (i = 0; i < stopIndexesLength; i++)
				{
					result.stopIndexes.push(json.stopIndexes[i]);
				}
			}
			
			//对应父类中的属性；
			var path:Path = Path.fromJson(json);
			result.edgeFeatures = path.edgeFeatures;
			result.edgeIDs = path.edgeIDs;
			result.nodeFeatures = path.nodeFeatures;
			result.nodeIDs = path.nodeIDs;
			result.pathGuideItems = path.pathGuideItems;
			result.route = path.route;
			result.stopWeights = path.stopWeights;
			result.weight = path.weight;
			
			return result;
		}
		
	}
}