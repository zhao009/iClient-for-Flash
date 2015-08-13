package com.supermap.web.events
{
	import flash.events.Event;

	/**
	 * ${events_TimeSliderEvent_Title}.
	 * <p>${events_TimeSliderEvent_Description}</p> 
	 * 
	 */	
	public class TimeSliderEvent extends Event
	{
		/**
		 * ${events_TimeSliderEvent_field_TIME_CHANGE_D} 
		 */		
		public static const TIME_CHANGE:String = "timeChange";
		
		private var _startTime:Date;
		private var _endTime:Date;
		private var _timeStops:Array;
		private var _timeStop:Date;
		
		/**
		 * ${events_TimeSliderEvent_constructor_D} 
		 * @param startTime ${events_TimeSliderEvent_constructor_param_startTime}
		 * @param endTime ${events_TimeSliderEvent_constructor_param_endTime}
		 * @param timeStop ${events_TimeSliderEvent_constructor_param_timeStop}
		 * @param timeStops ${events_TimeSliderEvent_constructor_param_timeStops}
		 * 
		 */		
		public function TimeSliderEvent(startTime:Date, endTime:Date,timeStop:Date, timeStops:Array)
		{
			super(TimeSliderEvent.TIME_CHANGE); 
			this._startTime = startTime;
			this._endTime = endTime;
			this._timeStop = timeStop;
			this._timeStops = timeStops;
		}
	 
		/**
		 * ${events_TimeSliderEvent_field_timeStop_D} 
		 * @return 
		 * 
		 */		
		public function get timeStop():Date
		{
			return _timeStop;
		}
 
		/**
		 * ${events_TimeSliderEvent_field_timeStops_D} 
		 * @return 
		 * 
		 */		
		public function get timeStops():Array
		{
			return _timeStops;
		}
 
		/**
		 * ${events_TimeSliderEvent_field_endTime_D} 
		 * @return 
		 * 
		 */		
		public function get endTime():Date
		{
			return _endTime;
		}
 
		/**
		 * ${events_TimeSliderEvent_field_startTime_D} 
		 * @return 
		 * 
		 */		
		public function get startTime():Date
		{
			return _startTime;
		}
 
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new TimeSliderEvent(startTime, endTime, timeStop, timeStops);
		}
	 
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function toString() : String
		{
			return formatToString("TimeSliderEvent", "type");
		}
	}
}