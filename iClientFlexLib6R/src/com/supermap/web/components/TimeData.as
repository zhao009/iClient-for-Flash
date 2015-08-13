package com.supermap.web.components
{
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.events.*;
	import mx.utils.*;
	
	/**
	 * ${controls_TimeData_Title}.
	 * <p>${controls_TimeData_Description}</p> 
	 * @see TimeSlider
	 * 
	 */	
	public class TimeData extends EventDispatcher
	{
		private var _features:ArrayCollection = new ArrayCollection(); 
		private var _endTime:Date;
		private var _startTime:Date;
		private var _timeField:String = "timeIndex";
		private var _timeStops:Array;
		/**
		 * ${controls_TimeData_constructor_None_D} 
		 * 
		 */		
		public function TimeData()
		{ 
			this._startTime = new Date(0);
			this._endTime = new Date(0);
		}
		
		/**
		 * ${controls_TimeData_attribute_timeStops_D} 
		 * @return 
		 * 
		 */		
		public function get timeStops():Array
		{
			return _timeStops;
		}

		public function set timeStops(value:Array):void
		{
			_timeStops = value;
		}

		/**
		 * ${controls_TimeData_attribute_timeField_D}.
		 * @return 
		 * 
		 */		
		public function get timeField():String
		{
			return _timeField;
		}

		public function set timeField(value:String):void
		{
			_timeField = value;
		}

		/**
		 * ${controls_TimeData_attribute_features_D} 
		 * @return 
		 * 
		 */		
		public function get features():ArrayCollection
		{
			return _features;
		}

		public function set features(value:ArrayCollection):void
		{
			_features = value;
		}
  
		/**
		 * ${controls_TimeData_attribute_endTime_D} 
		 * @return 
		 * 
		 */		
		public function get endTime() : Date
		{
			return this._endTime;
		}
		
		public function set endTime(value:Date) : void
		{ 
			this._endTime = value;  
		}
		
		/**
		 * ${controls_TimeData_attribute_startTime_D} 
		 * @return 
		 * 
		 */		
		public function get startTime() : Date
		{
			return this._startTime;
		}
		
		public function set startTime(value:Date) : void
		{ 
			this._startTime = value; 
		}
	}
}