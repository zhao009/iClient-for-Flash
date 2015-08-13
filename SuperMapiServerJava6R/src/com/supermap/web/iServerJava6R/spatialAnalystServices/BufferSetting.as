package com.supermap.web.iServerJava6R.spatialAnalystServices
{
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.Unit;
	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_BufferSetting_Title}.
	 * <p>${iServerJava6R_BufferSetting_Description}</p> 
	 * 
	 */	
	public class BufferSetting
	{
		private var _endType:String = BufferEndType.ROUND;
		private var _leftDistance:BufferDistance = new BufferDistance();
		private var _rightDistance:BufferDistance = new BufferDistance();
		private var _semicircleLineSegment:int = 4;
		private var _radiusUnit:String = Unit.METER;
		private var _isDatasetBufferAnalystParameters:Boolean = false;
		
		/**
		 * ${iServerJava6R_BufferSetting_constructor_D} 
		 * 
		 */		
		public function BufferSetting()
		{
		}

		
		/**
		 * ${iServerJava6R_BufferSetting_attribute_radiusUnit_D} 
		 * @return 
		 * 
		 */			 
		public function get radiusUnit():String
		{
			return _radiusUnit;
		}
		
		public function set radiusUnit(value:String):void
		{
			_radiusUnit = value;
		}
		
		sm_internal function set isDatasetBufferAnalystParameters(value:Boolean):void
		{
			this._isDatasetBufferAnalystParameters = value;
		}
		
		/**
		 * ${iServerJava6R_BufferSetting_attribute_semicircleLineSegment_D} 
		 * @return 
		 * 
		 */		
		public function get semicircleLineSegment():int
		{
			return _semicircleLineSegment;
		}

		public function set semicircleLineSegment(value:int):void
		{
			_semicircleLineSegment = value;
		}

		/**
		 * ${iServerJava6R_BufferSetting_attribute_rightDistance_D}.
		 * <p>${iServerJava6R_BufferSetting_attribute_rightDistance_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get rightDistance():BufferDistance
		{
			return _rightDistance;
		}

		public function set rightDistance(value:BufferDistance):void
		{
			_rightDistance = value;
		}

		/**
		 * ${iServerJava6R_BufferSetting_attribute_leftDistance_D}.
		 * <p>${iServerJava6R_BufferSetting_attribute_leftDistance_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get leftDistance():BufferDistance
		{
			return _leftDistance;
		}

		public function set leftDistance(value:BufferDistance):void
		{
			_leftDistance = value;
		}

		/**
		 * ${iServerJava6R_BufferSetting_attribute_endType_D}.
		 * <p>${iServerJava6R_BufferSetting_attribute_endType_remarks}</p> 
		 * @see BufferEndType
		 * @default BufferEndType.FLAT
		 * @return 
		 * 
		 */		
		public function get endType():String
		{
			return _endType;
		}

		public function set endType(value:String):void
		{
			_endType = value;
		}
		
		sm_internal function toJson():String
		{
			var json:String = "";
			
			if(this._isDatasetBufferAnalystParameters)
			{
				json += "\"radiusUnit\":" + "\"" + this.radiusUnit.toUpperCase() + "\",";
			}
			
			json += "\"endType\":" + "\"" + this.endType + "\",";
			
		
			json += "\"leftDistance\":" + this.leftDistance.toJson() + ",";
		
			json += "\"rightDistance\":" + this.rightDistance.toJson() + ",";
		
			json += "\"semicircleLineSegment\":" + this.semicircleLineSegment;
			
			json ="{" + json + "}";
			
			return json;
		}

	}
}