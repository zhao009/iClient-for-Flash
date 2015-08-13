package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	import mx.collections.ArrayCollection;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_TransportationAnalystParameter_Title}.
	 * <p>${iServerJava6R_TransportationAnalystParameter_Description}</p> 
	 * @see TransportationAnalystResultSetting
	 * @see #weightFieldName
	 * @see #turnWeightField
	 * 
	 */	
	public class TransportationAnalystParameter
	{ 
		
		//--------------------------------------------------------------------------
		//
		//    交通网络分析通用参数
		//
		//--------------------------------------------------------------------------
		
		private var _barrierPoints:Array;
		private var _barrierEdgeIDs:Array; 
		private var _barrierNodeIDs:Array;
		private var _resultSetting:TransportationAnalystResultSetting;
		private var _turnWeightField:String;
		private var _weightFieldName:String;
		
		
		/**
		 * ${iServerJava6R_TransportationAnalystParameter_constructor_D} 
		 * 
		 */		
		public function TransportationAnalystParameter()
		{
			
		}
		
		/**
		 * ${iServerJava6R_TransportationAnalystParameter_attribute_BarrierPoints_D} 
		 * @see com.supermap.web.core.Point2D
		 * @return 
		 * 
		 */		
		public function get barrierPoints():Array
		{
			return _barrierPoints;
		}

		public function set barrierPoints(value:Array):void
		{
			_barrierPoints = value;
		}

		/**
		 * ${iServerJava6R_TransportationAnalystParameter_attribute_weightFieldName_D}.
		 * <p>${iServerJava6R_TransportationAnalystParameter_attribute_weightFieldName_remarks}</p> 
		 * <p>${iServerJava6R_TransportationAnalystParameter_attribute_weightFieldName_remarks1}</p>
		 * @return 
		 * 
		 */		
		public function get weightFieldName():String
		{
			return _weightFieldName;
		}

		public function set weightFieldName(value:String):void
		{
			_weightFieldName = value;
		}

		/**
		 * ${iServerJava6R_TransportationAnalystParameter_attribute_turnWeightField_D}.
		 * <p>${iServerJava6R_TransportationAnalystParameter_attribute_turnWeightField_Remarks_1}</p> 
		 * <p>${iServerJava6R_TransportationAnalystParameter_attribute_turnWeightField_Remarks_2}</p>
		 * <p>${iServerJava6R_TransportationAnalystParameter_attribute_turnWeightField_Remarks_3}</p>
		 * @return 
		 * 
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
		 * ${iServerJava6R_TransportationAnalystParameter_attribute_resultSetting_D} 
		 * @return 
		 * 
		 */		
		public function get resultSetting():TransportationAnalystResultSetting
		{
			return _resultSetting;
		}

		public function set resultSetting(value:TransportationAnalystResultSetting):void
		{
			_resultSetting = value;
		}

		/**
		 * ${iServerJava6R_TransportationAnalystParameter_attribute_barrierNodeIDs_D} 
		 * @return 
		 * 
		 */		
		public function get barrierNodeIDs():Array
		{
			return _barrierNodeIDs;
		}

		public function set barrierNodeIDs(value:Array):void
		{
			_barrierNodeIDs = value;
		}

		/**
		 * ${iServerJava6R_TransportationAnalystParameter_attribute_barrierEdgeIDs_D} 
		 * @return 
		 * 
		 */		
		public function get barrierEdgeIDs():Array
		{
			return _barrierEdgeIDs;
		}

		public function set barrierEdgeIDs(value:Array):void
		{
			_barrierEdgeIDs = value;
		}

		sm_internal static function toJson(param:TransportationAnalystParameter):String
		{
			if (param)
			{
				var json:String = "{"; 
				var list:ArrayCollection = new ArrayCollection();
				if (param.barrierEdgeIDs && param.barrierEdgeIDs.length)
				{
					var temp:ArrayCollection = new ArrayCollection();
					for each (var id:int in param.barrierEdgeIDs)
					{
						temp.addItem(id.toString());
					}
					list.addItem(String("\"barrierEdgeIDs\":[" + temp.toString() + "]"));
				}
				
				if (param.barrierNodeIDs && param.barrierNodeIDs.length)
				{
					var temps:ArrayCollection = new ArrayCollection();
					
					for each (var ids:int in param.barrierNodeIDs)
					{
						temps.addItem(ids.toString());
					}
					list.addItem(String("\"barrierNodeIDs\":[" + temps.toArray() + "]"));
				}
				 
				if (param.barrierPoints && param.barrierPoints.length)
				{
					var tempps:ArrayCollection = new ArrayCollection();
					
					for each (var p:Point2D in param.barrierPoints)
					{
						tempps.addItem(JsonUtil.fromPoint2D(p));
					}
					list.addItem(String("\"barrierPoints\":[" + tempps.toArray() + "]"));
				}
				
				if(param.resultSetting)
					list.addItem(String("\"resultSetting\":" + TransportationAnalystResultSetting.toJson(param.resultSetting)));
				
				if(param.turnWeightField)
					list.addItem(String("\"turnWeightField\":\"" + param.turnWeightField + "\""));
				
				if (param.weightFieldName)
					list.addItem(String("\"weightFieldName\":\"" + param.weightFieldName + "\""));
				
				json += list.toString();
				json += "}";
				return json;
			}
			
			return null;
		}
	}
}