package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.*;
	import com.supermap.web.utils.JsonUtil;
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_networkAnalystServices_NetworkAnalystParam_Title}.
	 * <p>${iServer2_networkAnalystServices_NetworkAnalystParam_Description}</p>
	 * @see NetworkModelSetting#tolerance
	 * 
	 * 
	 */
	public class NetworkAnalystParam
	{
		//障碍弧段ID列表
		private var _barrierEdges:Array = null;
		//障碍结点ID列表
		private var _barrierNodes:Array = null;
		//分析时途径结点的集合
		private var _nodeIDs:Array = null;
		//分析时途径点的集合
		private var _point2Ds:Array = null;
		//转向权重字段
		private var _turnWeightField:String = "";
		//权重信息的名字标识
		private var _weightName:String = "";
		//分析结果是否包含经过弧段的集合
		private var _isEdgesReturn:Boolean = false;
		//分析结果是否包含经过结点的集合
		private var _isNodesReturn:Boolean = false;
		//分析结果是否包含经过站点的集合
		private var _isStopsReturn:Boolean = false;
		//分析结果是否包含经过路由对象的集合
		private var _isPathsReturn:Boolean = false;
		//分析结果是否包含经过行驶导引的集合
		private var _isPathGuidesReturn:Boolean = false;
		
		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_isPathGuidesReturn_D}
		 * @default false
		 */
		public function get isPathGuidesReturn():Boolean
		{
			return _isPathGuidesReturn;
		}

		public function set isPathGuidesReturn(value:Boolean):void
		{
			_isPathGuidesReturn = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_isPathsReturn_D}
		 * @default false
		 */
		public function get isPathsReturn():Boolean
		{
			return _isPathsReturn;
		}

		public function set isPathsReturn(value:Boolean):void
		{
			_isPathsReturn = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_isStopsReturn_D} 
		 * @return 
		 * 
		 */		
		public function get isStopsReturn():Boolean
		{
			return _isStopsReturn;
		}

		public function set isStopsReturn(value:Boolean):void
		{
			_isStopsReturn = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_isNodeReturn_D}
		 * @default false
		 */
		public function get isNodesReturn():Boolean
		{
			return _isNodesReturn;
		}

		public function set isNodesReturn(value:Boolean):void
		{
			_isNodesReturn = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_isEdgesReturn_D}
		 * @default false
		 */
		public function get isEdgesReturn():Boolean
		{
			return _isEdgesReturn;
		}

		public function set isEdgesReturn(value:Boolean):void
		{
			_isEdgesReturn = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_weightName_D}.
		 * <p>${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_weightName_remarks}</p>
		 */
		public function get weightName():String
		{
			return _weightName;
		}

		public function set weightName(value:String):void
		{
			_weightName = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_turnWeightField_D}.
		 * <p>${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_turnWeightField_remarks}</p>
		 * @see NetworkModelSetting#turnTableSetting 
		 */
		public function get turnWeightField():String
		{
			return _turnWeightField;
		}

		public function set turnWeightField(value:String):void
		{
			_turnWeightField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_point2Ds_D}.
		 * <p>${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_point2Ds_remarks}</p>
		 * @see #nodeIDs
		 */
		public function get point2Ds():Array
		{
			return _point2Ds;
		}

		public function set point2Ds(value:Array):void
		{
			_point2Ds = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_nodeIDs_D}.
		 * <p>${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_nodeIDs_remarks}</p> 
		 * @see #point2Ds
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
		 * ${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_barrierNodes_D} 
		 */
		public function get barrierNodes():Array
		{
			return _barrierNodes;
		}

		public function set barrierNodes(value:Array):void
		{
			_barrierNodes = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkAnalystParam_attribute_barrierEdges_D}
		 */
		public function get barrierEdges():Array
		{
			return _barrierEdges;
		}

		public function set barrierEdges(value:Array):void
		{
			_barrierEdges = value;
		}

		sm_internal function toJson():String
		{
			var json:String = "";
			
			if (this.barrierEdges)
			{
				if(this.barrierEdges.length > 0)
				json += "\"barrierEdges\":" + "[" + this.barrierEdges.join(",") + "],";
			}
			else
				json += "\"barrierEdges\":" + null + ",";
			
			if (this.barrierNodes)
			{
				if(this.barrierNodes.length > 0)
				json += "\"barrierNodes\":" + "[" + this.barrierNodes.join(",") + "],";
			}
			else
				json += "\"barrierNodes\":" + null + ",";
			
			if (this.nodeIDs)
			{
				if(this.nodeIDs.length > 0)
				json += "\"nodeIDs\":" + "[" + this.nodeIDs.join(",") + "],";
			}
			else
				json += "\"nodeIDs\":" + null + ",";
			
			if (this.point2Ds)
			{
				if(this.point2Ds.length > 0)
				{
					var tempPoint2Ds:Array = new Array();
					for(var i:int = 0; i < this.point2Ds.length; i++)
					{
						var point2D:Point2D = point2Ds[i] as Point2D;
						tempPoint2Ds.push(JsonUtil.fromPoint2D(point2D));
					}
					json += "\"point2Ds\":" + "[" + tempPoint2Ds.join(",") + "],"
				}
			}
			
//			if (this.turnWeightField)
				json += "\"turnWeightField\":" + "\"" + this.turnWeightField + "\",";
			
//			if (this.weightName)
				json += "\"weightName\":" + "\"" + this.weightName + "\",";
			
			json += "\"isEdgesReturn\":" + this.isEdgesReturn + ",";
								
			json += "\"isNodesReturn\":" + this.isNodesReturn + ",";
			
			json += "\"isStopsReturn\":" + this.isStopsReturn + ",";
								
			json += "\"isPathsReturn\":" + this.isPathsReturn + ",";
			
			json += "\"isPathGuidesReturn\":" + this.isPathGuidesReturn;
			
			if(json.length > 0)
			json ="{" + json + "}";
			
            return json;
		}

	}
}