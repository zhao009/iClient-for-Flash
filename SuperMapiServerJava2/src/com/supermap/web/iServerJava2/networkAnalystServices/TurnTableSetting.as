package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${iServer2_networkAnalystServices_TurnTableSetting_Title}.
	 * <p>${iServer2_networkAnalystServices_TurnTableSetting_Description_1}</p>
	 * <p><img src="../../../../../images/turn.png"/></p>
	 * <p>${iServer2_networkAnalystServices_TurnTableSetting_Description_2}</p>
	 * <p><img src="../../../../../images/turnTable.jpg"/></p>
	 * 
	 * 
	 */
	public class TurnTableSetting
	{
		//转向表数据源的名字
		private var _turnDataSourceName:String;
		//转向表数据集的名字
		private var _turnDatasetName:String;
		//转向表中转弯结点标识ID对应的字段名称
		private var _turnNodeIDField:String;
		//转向表中从起始弧段到终止弧段转向的耗费权重对应的字段名称数组。
		private var _turnWeightFields:Array;
		//转向表中起始弧段（即进入转弯结点前所在的弧段）标识ID对应的字段名称。
		private var _turnFromEdgeIDField:String;
		//转向表中终止弧段（即离开转弯结点后所在饿弧段）标识ID对应的字段名称。
		private var _turnToEdgeIDField:String;
			
		/**
		 * ${iServer2_networkAnalystServices_TurnTableSetting_constructor_None_D} 
		 * 
		 */		
		public function TurnTableSetting()
		{
			
		}
		/**
		 * ${iServer2_networkAnalystServices_TurnTableSetting_attribute_turnToEdgeIDField_D} 
		 */
		public function get turnToEdgeIDField():String
		{
			return _turnToEdgeIDField;
		}

		public function set turnToEdgeIDField(value:String):void
		{
			_turnToEdgeIDField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_TurnTableSetting_attribute_turnFromEdgeIDField_D} 
		 */
		public function get turnFromEdgeIDField():String
		{
			return _turnFromEdgeIDField;
		}

		public function set turnFromEdgeIDField(value:String):void
		{
			_turnFromEdgeIDField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_TurnTableSetting_attribute_turnWeightFields_D}.
		 * <p>${iServer2_networkAnalystServices_TurnTableSetting_attribute_turnWeightFields_remarks}</p> 
		 */
		public function get turnWeightFields():Array
		{
			return _turnWeightFields;
		}

		public function set turnWeightFields(value:Array):void
		{
			_turnWeightFields = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_TurnTableSetting_attribute_turnToEdgeIDField_D} 
		 */
		public function get turnNodeIDField():String
		{
			return _turnNodeIDField;
		}

		public function set turnNodeIDField(value:String):void
		{
			_turnNodeIDField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_TurnTableSetting_attribute_turnDatasetName_D}.
		 * <p>${iServer2_networkAnalystServices_TurnTableSetting_attribute_turnDatasetName_remarks}</p> 
		 */
		public function get turnDatasetName():String
		{
			return _turnDatasetName;
		}

		public function set turnDatasetName(value:String):void
		{
			_turnDatasetName = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_TurnTableSetting_attribute_turnDataSourceName_D} 
		 */
		public function get turnDataSourceName():String
		{
			return _turnDataSourceName;
		}
		
		public function set turnDataSourceName(value:String):void
		{
			_turnDataSourceName = value;
		}

		sm_internal function toJson():String
		{
			var json:String = "";
			
			if (this.turnFromEdgeIDField)
				json += "\"turnFromEdgeIDField\":" + "\"" + this.turnFromEdgeIDField + "\",";
				
			if (this.turnNodeIDField)
				json += "\"turnNodeIDField\":" + "\"" + this.turnNodeIDField + "\",";
				
			if (this.turnToEdgeIDField)
				json += "\"turnToEdgeIDField\":" + "\"" + this.turnToEdgeIDField + "\",";
			
			if(this.turnWeightFields)
			{
				if(this.turnWeightFields.length > 0)
				
				var tempTurnWeightFields:Array = new Array();
				
				for(var i:int = 0; i < this.turnWeightFields.length; i++)
					tempTurnWeightFields.push("\"" + this.turnWeightFields[i] + "\"");
					
				json += "\"turnWeightFields\":" + "[" + tempTurnWeightFields.join(",") + "],";
			}
			
			if (this.turnDatasetName)
				json += "\"turnDatasetName\":" + "\"" + this.turnDatasetName + "\",";
				
			if (this.turnDataSourceName)
				json += "\"turnDataSourceName\":" + "\"" + this.turnDataSourceName + "\"";
			
			if(json.length > 0)
			json ="{" + json + "}";
			
            return json;
		}

	}
}
