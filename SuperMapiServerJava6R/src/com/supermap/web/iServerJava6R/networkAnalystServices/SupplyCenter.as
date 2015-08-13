package com.supermap.web.iServerJava6R.networkAnalystServices
{  
	import com.supermap.web.sm_internal;
	 
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_SupplyCenter_Title}.
	 * <p>${iServerJava6R_SupplyCenter_Description}</p> 
	 * 
	 */	
	public class SupplyCenter
	{ 
		private var _maxWeight:Number = 0;
		private var _nodeID:int;
		private var _resourceValue:Number = 0;
		private var _type:String;
		
		/**
		 * ${iServerJava6R_SupplyCenter_constructor_D} 
		 * 
		 */		
		public function SupplyCenter()
		{
			
		}
		/**
		 * ${iServerJava6R_SupplyCenter_attribute_type_D}
		 * @see SupplyCenterType
		 * @return 
		 * 
		 */		
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		/**
		 * ${iServerJava6R_SupplyCenter_attribute_resourceValue_D}.
		 * <p>${iServerJava6R_SupplyCenter_attribute_resourceValue_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get resourceValue():Number
		{
			return _resourceValue;
		}

		public function set resourceValue(value:Number):void
		{
			_resourceValue = value;
		}

		/**
		 * ${iServerJava6R_SupplyCenter_attribute_nodeID_D} 
		 * @return 
		 * 
		 */		
		public function get nodeID():int
		{
			return _nodeID;
		}

		public function set nodeID(value:int):void
		{
			_nodeID = value;
		}

		/**
		 * ${iServerJava6R_SupplyCenter_attribute_maxWeight_D}.
		 * <p>${iServerJava6R_SupplyCenter_attribute_maxWeight_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get maxWeight():Number
		{
			return _maxWeight;
		}

		public function set maxWeight(value:Number):void
		{
			_maxWeight = value;
		}
        //这里用object方式
		sm_internal static function toJson(param:Object):String
		{
			if (param == null)
				return null;
			
			var json:String = "{"; 
			var list:Array = [];
			list.push(String("\"maxWeight\":" + param.maxWeight));
			list.push(String("\"nodeID\":" + param.nodeID));
			list.push(String("\"resourceValue\":" + param.resourceValue));
			list.push(String("\"type\":" + param.type));
			
			json += list.toString();
			json += "}";
			return json;
		}
		
		sm_internal static function fromJson(json:Object):SupplyCenter
		{
			if (json == null)
				return null;
			
			var result:SupplyCenter = new SupplyCenter(); 
			result.maxWeight = json.maxWeight;
			result.nodeID = json.nodeID;
			result.resourceValue = json.resourceValue;
			result.type = json.type as String;
			return result;
		}
	}
}