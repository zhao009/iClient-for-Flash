package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_FindPathResult_Title}.
	 * <p>${iServerJava6R_FindPathResult_Description}</p> 
	 * 
	 */	
	public class FindPathResult
	{ 
		private var _pathList:Array;
		
		/**
		 * ${iServerJava6R_FindPathResult_constructor_D} 
		 * 
		 */		
		public function FindPathResult()
		{
			
		}
		
		/**
		 * ${iServerJava6R_FindPathResult_attribute_pathList_D}.
		 * <p>${iServerJava6R_FindPathResult_attribute_pathList_remarks}</p> 
		 * @see Path
		 * @return 
		 * 
		 */		
		public function get pathList():Array
		{
			return _pathList;
		}
 
		sm_internal static function fromJson(json:Object):FindPathResult
		{
			if (json == null)
				return null;
			 
			var result:FindPathResult = new FindPathResult();
 
			if (json.pathList != null)
			{
				result._pathList = [];
				var pathListLength:int = (json.pathList as Array).length;
				for (var i:int = 0; i < pathListLength; i++)
				{
					result._pathList.push(Path.fromJson(json.pathList[i]));//对结果进行组装
				}
			} 
			return result;
		}
	 
	}
} 