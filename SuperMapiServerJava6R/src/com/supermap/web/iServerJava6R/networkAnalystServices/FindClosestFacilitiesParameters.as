package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import flash.events.Event;

	/**
	 * ${iServerJava6R_ClosestFacilitiesParameters_Title}.
	 * <p>${iServerJava6R_ClosestFacilitiesParameters_Description}</p>
	 * @see FindClosestFacilitiesService
	 */
	public class FindClosestFacilitiesParameters
	{ 
		private var _event:Object;
		private var _facilities:Array;
		private var _expectFacilityCount:int;
		private var _fromEvent:Boolean;
		private var _maxWeight:Number = 0;
		private var _parameter:TransportationAnalystParameter;

		private var _isAnalyzeById:Boolean;
		
		/**
		 * ${iServerJava6R_ClosestFacilitiesParameters_constructor_D} 
		 * 
		 */		
		public function FindClosestFacilitiesParameters()
		{
			this.expectFacilityCount = 1;
			this.maxWeight = 0;
		}

		/**
		 * ${iServerJava6R_ClosestFacilitiesParameters_attribute_parameter_D} 
		 * @return 
		 * 
		 */		
		public function get parameter():TransportationAnalystParameter
		{
			return _parameter;
		}

		public function set parameter(value:TransportationAnalystParameter):void
		{
			_parameter = value;
		}

		/**
		 * ${iServerJava6R_ClosestFacilitiesParameters_attribute_maxWeight_D}.
		 * <p>${iServerJava6R_ClosestFacilitiesParameters_attribute_maxWeight_remarks}</p>
		 * @see #parameter
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

		/**
		 * ${iServerJava6R_ClosestFacilitiesParameters_attribute_fromEvent_D}.
		 * <p>${iServerJava6R_ClosestFacilitiesParameters_attribute_fromEvent_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get fromEvent():Boolean
		{
			return _fromEvent;
		}

		public function set fromEvent(value:Boolean):void
		{
			_fromEvent = value;
		}

		/**
		 * ${iServerJava6R_ClosestFacilitiesParameters_attribute_expectFacilityCount_D} 
		 * @default 1
		 * @return 
		 * 
		 */		
		public function get expectFacilityCount():int
		{
			return _expectFacilityCount;
		}

		public function set expectFacilityCount(value:int):void
		{
			_expectFacilityCount = value;
		}

		/**
		 * ${iServerJava6R_ClosestFacilitiesParameters_attribute_facilities_D}.
		 * <p>${iServerJava6R_ClosestFacilitiesParameters_attribute_facilities_remarks}</p> 
		 * @see #isAnalyzeById
		 * @return 
		 * 
		 */		
		public function get facilities():Array
		{
			return _facilities;
		}

		public function set facilities(value:Array):void
		{
			_facilities = value;
		}

		/**
		 * ${iServerJava6R_ClosestFacilitiesParameters_attribute_isAnalyzeById_D}.
		 * <p>${iServerJava6R_ClosestFacilitiesParameters_attribute_isAnalyzeById_remarks}</p> 
		 * @see #event
		 * @see #facilities
		 * @return 
		 * 
		 */		
		public function get isAnalyzeById():Boolean
		{
			return _isAnalyzeById;
		}
		public function set isAnalyzeById(value:Boolean):void
		{
			_isAnalyzeById = value;
		}

		/**
		 * ${iServerJava6R_ClosestFacilitiesParameters_attribute_event_D}.
		 * <p>${iServerJava6R_ClosestFacilitiesParameters_attribute_event_remarks}</p>
		 * @see #isAnalyzeById
		 */
		public function get event():Object
		{
			return _event;
		}
		public function set event(value:Object):void
		{
			_event = value;
		}

	}
}