package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_FindMTSPPathsResult_Title}.
	 * <p>${iServerJava6R_FindMTSPPathsResult_Description}</p> 
	 * 
	 */	
	public class FindMTSPPathsResult
	{  
		//--------------------------------------------------------------------------
		//
		//  多旅行商分析结果类
		//
		//--------------------------------------------------------------------------
		
		private var _mtspPathList:Array;
		/**
		 * ${iServerJava6R_FindMTSPPathsResult_constructor_D} 
		 * 
		 */		
		public function FindMTSPPathsResult()
		{
			
		}
		
		/**
		 * ${iServerJava6R_FindMTSPPathsResult_attribute_MTSPathList_D}.
		 * <p>${iServerJava6R_FindMTSPPathsResult_attribute_MTSPathList_remarks}</p> 
		 * @see MTSPPath
		 * @return 
		 * 
		 */		
		public function get mtspPathList():Array
		{
			return _mtspPathList;
		}
 
		sm_internal static function fromJson(json:Object):FindMTSPPathsResult
		{
			if (json == null) 
				return null;
			
			var result:FindMTSPPathsResult  = new FindMTSPPathsResult();
			 
			if (json.pathList)
			{
				result._mtspPathList = [];
				var pathListLength:int = (json.pathList as Array).length;
				for (var i:int = 0; i < pathListLength; i++)
				{
					result._mtspPathList.push(MTSPPath.fromJson(json.pathList[i]));
				}
			} 
			return result;
		}
	}
}