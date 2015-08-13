package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServer2_networkAnalystServices_NetworkModelSetting_Title}.
	 * <p>${iServer2_networkAnalystServices_NetworkModelSetting_Description}</p> 
	 * 
	 */	
	public class NetworkModelSetting
	{
		private var _networkDataSourceName:String;
		//网络数据对应的数据集名称
		private var _networkDatasetName:String;
		//网络数据集中的弧段 ID 对应的字段名
		private var _edgeIDField:String;
		//网络数据集中的弧段 name对应的字段名
		private var _edgeNameField:String = "";
		//网络数据集中的结点 ID 对应的字段名
		private var _nodeIDField:String;
		//网络数据集中的结点 name对应的字段名
		private var _nodeNameField:String = "";
		//网络数据集中标志弧段起始结点 ID 的字段名
		private var _fNodeIDField:String;
		//网络数据集中标志弧段终止结点 ID 的字段名
		private var _tNodeIDField:String;
		//障碍弧段ID列表
		private var _barrierEdges:Array = null;
		//障碍结点ID列表
		private var _barrierNodes:Array = null;
		//网络模型中的容限参数，默认为100.0
		private var _tolerance:Number = 100;
		//转向表设置对象
		private var _turnTableSetting:TurnTableSetting = null;
		//网络数据集中的权重字段信息数组
		private var _weightFieldInfos:Array = null;
		
		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_constructor_None_D} 
		 * 
		 */		
		public function NetworkModelSetting()
		{
			
		}
		
		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_weightFieldInfos_D}.
		 * <p>${iServer2_networkAnalystServices_NetworkModelSetting_attribute_weightFieldInfos_remarks}</p>
		 * @default WeightFieldInfo 
		 */
		public function get weightFieldInfos():Array
		{
			return _weightFieldInfos;
		}

		public function set weightFieldInfos(value:Array):void
		{
			_weightFieldInfos = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_turnTableSetting_D} 
		 */
		public function get turnTableSetting():TurnTableSetting
		{
			return _turnTableSetting;
		}

		public function set turnTableSetting(value:TurnTableSetting):void
		{
			_turnTableSetting = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_tolerance_D}.
		 * <p>${iServer2_networkAnalystServices_NetworkModelSetting_attribute_tolerance_remarks}</p> 
		 */
		public function get tolerance():Number
		{
			return _tolerance;
		}

		public function set tolerance(value:Number):void
		{
			_tolerance = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_barrierNodes_D} 
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
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_barrierEdges_D} 
		 */
		public function get barrierEdges():Array
		{
			return _barrierEdges;
		}

		public function set barrierEdges(value:Array):void
		{
			_barrierEdges = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_tNodeIDField_D} 
		 */
		public function get tNodeIDField():String
		{
			return _tNodeIDField;
		}

		public function set tNodeIDField(value:String):void
		{
			_tNodeIDField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_fNodeIDField_D} 
		 */
		public function get fNodeIDField():String
		{
			return _fNodeIDField;
		}

		public function set fNodeIDField(value:String):void
		{
			_fNodeIDField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_nodeNameField_D} 
		 */
		public function get nodeNameField():String
		{
			return _nodeNameField;
		}

		public function set nodeNameField(value:String):void
		{
			_nodeNameField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_nodeIDField_D}
		 */
		public function get nodeIDField():String
		{
			return _nodeIDField;
		}

		public function set nodeIDField(value:String):void
		{
			_nodeIDField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_edgeNameField_D}
		 */
		public function get edgeNameField():String
		{
			return _edgeNameField;
		}

		public function set edgeNameField(value:String):void
		{
			_edgeNameField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_edgeIDField_D}
		 */
		public function get edgeIDField():String
		{
			return _edgeIDField;
		}

		public function set edgeIDField(value:String):void
		{
			_edgeIDField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_networkDataSourceName_D}
		 */
		public function get networkDatasetName():String
		{
			return _networkDatasetName;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_networkDatasetName_D}.
		 * <p>${iServer2_networkAnalystServices_NetworkModelSetting_attribute_networkDatasetName_remarks}</p> 
		 * @param value
		 * 
		 */		
		public function set networkDatasetName(value:String):void
		{
			_networkDatasetName = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_NetworkModelSetting_attribute_networkDataSourceName_D} 
		 * @return 
		 * 
		 */		
		public function get networkDataSourceName():String
		{
			return _networkDataSourceName;
		}

		public function set networkDataSourceName(value:String):void
		{
			_networkDataSourceName = value;
		}

		sm_internal function toJson():String
		{
			var json:String = "";
			
			if (this.networkDatasetName)
				json += "\"networkDatasetName\":" + "\"" + this.networkDatasetName + "\",";
			
			if (this.networkDataSourceName)
				json += "\"networkDataSourceName\":" + "\"" + this.networkDataSourceName + "\",";
			
			json += "\"tolerance\":" + this.tolerance.toString() + ",";
			
			if (this.nodeIDField)
				json += "\"nodeIDField\":" + "\"" + this.nodeIDField + "\",";
			
			if (this.edgeIDField)
				json += "\"edgeIDField\":" + "\"" + this.edgeIDField + "\",";
			
			if (this.weightFieldInfos)
			{
				if(this.weightFieldInfos.length > 0)
				{
					var weightFields:Array = new Array();
					for(var i:int = 0; i < this.weightFieldInfos.length; i++)
					{
						weightFields.push(WeightFieldInfo.toJson(weightFieldInfos[i]));
					}
					json += "\"weightFieldInfos\":" + "[" + weightFields.join(",") + "],"
				}
			}
			
			if (this.tNodeIDField)
				json += "\"tNodeIDField\":" + "\"" + this.tNodeIDField + "\",";
			
			if (this.fNodeIDField)
				json += "\"fNodeIDField\":" + "\"" + this.fNodeIDField + "\",";
			
			json += "\"nodeNameField\":" + "\"" + this.nodeNameField + "\",";
			
			json += "\"edgeNameField\":" + "\"" + this.edgeNameField + "\",";
			
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
			
			if(this.turnTableSetting)
				json += "\"turnTableSetting\":" + this.turnTableSetting.toJson();
			else
				json += "\"turnTableSetting\":" + null;
			
			if(json.length > 0)
				json ="{" + json + "}";
			
			return json;
		}
	}
}