package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_FindTSPPathsResult_Title}.
	 * <p>${iServerJava6R_FindTSPPathsResult_Description}</p> 
	 * 
	 */	
	public class FindTSPPathsResult
	{ 
		private var _tspPathList:Array;
		
		/**
		 * ${iServerJava6R_FindTSPPathsResult_constructor_D} 
		 * 
		 */		
		public function FindTSPPathsResult()
		{
			
		}
		
		/**
		 * ${iServerJava6R_FindTSPPathsResult_attribute_tspPathList_D}.
		 * <p>${iServerJava6R_FindTSPPathsResult_attribute_tspPathList_remarks}</p> 
		 * @see TSPPath
		 * @return 
		 * 
		 */		
		public function get tspPathList():Array
		{
			return _tspPathList;
		}
 
		sm_internal static function fromJson(json:Object):FindTSPPathsResult//解析json的标准方法
		{
			if (json == null)
				return null;
			
			var result:FindTSPPathsResult = new FindTSPPathsResult();
			 
			if (json.tspPathList && (json.tspPathList as Array).length)
			{ 
				result._tspPathList = [];
				var tspPathListLength:int = (json.tspPathList as Array).length;
				for (var i:int = 0; i < tspPathListLength; i++)
				{
					result._tspPathList.push(TSPPath.fromJson(json.tspPathList[i]));
				}
			}
			return result;
		}
	}
}