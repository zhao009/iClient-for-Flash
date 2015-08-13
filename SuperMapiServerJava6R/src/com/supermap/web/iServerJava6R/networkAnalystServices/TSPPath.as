package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_TSPPath_Title}.
	 * <p>${iServerJava6R_TSPPath_Description}</p> 
	 * 
	 */	
	public class TSPPath extends Path
	{ 
		
		//--------------------------------------------------------------------------
		//
		//  旅行商路径类
		//
		//--------------------------------------------------------------------------
		/**
		 * ${iServerJava6R_TSPPath_attribute_stopIndexes_D}.
		 * <p>${iServerJava6R_TSPPath_attribute_stopIndexes_remarks}</p> 
		 */		
		public var stopIndexes:Array;
		/**
		 * ${iServerJava6R_TSPPath_constructor_D} 
		 * 
		 */		
		public function TSPPath()
		{
			super();
		}
		
		/**
		 * ${iServerJava6R_TSPPath_method_fromJson_D} 
		 * @param json ${iServerJava6R_TSPPath_method_fromJson_param_jsonObject}
		 * @return ${iServerJava6R_TSPPath_method_fromJson_return}
		 * 
		 */		
		public static function fromJson(json:Object):TSPPath
		{
			if (json == null)
				return null;
			
			var result:TSPPath = new TSPPath();
			if (json.stopIndexes)
			{
				result.stopIndexes = [];
				var stopsLength:int = (json.stopIndexes as Array).length;
				for (var i:int = 0; i < stopsLength; i++)
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