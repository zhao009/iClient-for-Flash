package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_BufferDistance_Title}.
	 * <p>${iServerJava6R_BufferDistance_Description}</p> 
	 * 
	 */	
	public class BufferDistance
	{
		private var _expression:String;
		private var _value:Number = 100;
		
		/**
		 * ${iServerJava6R_BufferDistance_constructor_D} 
		 * 
		 */		
		public function BufferDistance()
		{
		}

		/**
		 * ${iServerJava6R_BufferDistance_attribute_value_D} 
		 * @return 
		 * 
		 */		
		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			_value = value;
		}

		/**
		 * ${iServerJava6R_BufferDistance_attribute_exp_D} 
		 * @return 
		 * 
		 */		
		public function get expression():String
		{
			return _expression;
		}

		public function set expression(value:String):void
		{
			_expression = value;
		}
		
		sm_internal function toJson():String
		{
			var json:String = "";
			
			if (this.expression)
				json += "\"exp\":" + "\"" + this.expression + "\",";
			else
				json += "\"exp\":" + null + ",";
			
			json += "\"value\":" + this.value;
			
			json ="{" + json + "}";
			
			return json;
		}
	}
}