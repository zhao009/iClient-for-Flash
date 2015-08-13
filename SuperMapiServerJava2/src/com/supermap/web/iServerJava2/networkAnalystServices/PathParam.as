package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServer2_networkAnalystServices_PathParam_Title}.
	 * <p>${iServer2_networkAnalystServices_PathParam_Description}</p>
	 * 
	 * 
	 */
	public class PathParam
	{
		//是否弧段数最少
		private var _hasLeastEdgeCount:Boolean = false;
		//网络参数信息，用于设置网络中各种参数，包括障碍边、障碍点等
		private var _networkAnalystParam:NetworkAnalystParam;
		
		/**
		 * ${iServer2_networkAnalystServices_PathParam_attribute_networkAnalystParam_D}.
		 * <p>${iServer2_networkAnalystServices_PathParam_attribute_networkAnalystParam_remarks}</p> 
		 */
		public function get networkAnalystParam():NetworkAnalystParam
		{
			return _networkAnalystParam;
		}

		public function set networkAnalystParam(value:NetworkAnalystParam):void
		{
			_networkAnalystParam = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_PathParam_attribute_hasLeastEdgeCount_D}.
		 * <p>${iServer2_networkAnalystServices_PathParam_attribute_hasLeastEdgeCount_remarks}</p> 
		 */
		public function get hasLeastEdgeCount():Boolean
		{
			return _hasLeastEdgeCount;
		}

		public function set hasLeastEdgeCount(value:Boolean):void
		{
			_hasLeastEdgeCount = value;
		}

		sm_internal function toJson():String
		{
			var json:String = "";
			
			if (this.networkAnalystParam)
				json += "\"networkAnalystParam\":" + this.networkAnalystParam.toJson() + ",";
			
			json += "\"hasLeastEdgeCount\":" + this.hasLeastEdgeCount;
			
			if(json.length > 0)
			json ="{" + json + "}";
			
            return json;
  		}
		

	}
}