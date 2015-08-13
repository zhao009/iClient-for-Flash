package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServer2_networkAnalystServices_WeightFieldInfo_Title}.
	 * <p>${iServer2_networkAnalystServices_WeightFieldInfo_Description}</p>
	 * 
	 */
	public class WeightFieldInfo
	{
		//权值字段信息的名称
		private var _name:String;
		//正向权值字段，默认为"SMLENGTH"
		private var _fTWeightField:String;
		//反向权值字段，默认为"SMLENGTH"
		private var _tFWeightField:String;
		
		/**
		 * ${iServer2_networkAnalystServices_WeightFieldInfo_constructor_D} 
		 * 
		 */		
		public function WeightFieldInfo()
		{
			
		}
		
		/**
		 * ${iServer2_networkAnalystServices_WeightFieldInfo_attribute_tfWeightField_D}.
		 * <p>${iServer2_networkAnalystServices_WeightFieldInfo_attribute_tfWeightField_remarks}</p> 
		 */
		public function get tFWeightField():String
		{
			return _tFWeightField;
		}

		public function set tFWeightField(value:String):void
		{
			_tFWeightField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_WeightFieldInfo_attribute_ftWeightField_D}.
		 * <p>{iServer2_networkAnalystServices_WeightFieldInfo_attribute_ftWeightField_remarks}</p>
		 */
		public function get fTWeightField():String
		{
			return _fTWeightField;
		}

		public function set fTWeightField(value:String):void
		{
			_fTWeightField = value;
		}

		/**
		 * ${iServer2_networkAnalystServices_WeightFieldInfo_attribute_name_D} 
		 */
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		sm_internal static function toJson(weightFieldInfo:WeightFieldInfo):String
		{
			var json:String = "";
			
			if (weightFieldInfo.name)
				json += "\"name\":" + "\"" + weightFieldInfo.name + "\",";
				
			if (weightFieldInfo.fTWeightField)
				json += "\"fTWeightField\":" + "\"" + weightFieldInfo.fTWeightField + "\",";
				
			if (weightFieldInfo.tFWeightField)
				json += "\"tFWeightField\":" + "\"" + weightFieldInfo.tFWeightField + "\"";
			
			if(json.length > 0)
			json ="{" + json + "}";
			
            return json;
		}

	}
}