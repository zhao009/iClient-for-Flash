package com.supermap.web.events
{
	import com.supermap.web.mapping.Layer;
	
	import flash.events.Event;
	
	import mx.rpc.*;
	import com.supermap.web.sm_internal;
	
	/**
	 * ${events_LayerEvent_Title} 
	 * @see com.supermap.web.mapping.Layer
	 * 
	 * 
	 */	
	public class LayerEvent extends Event
	{
		
		private var _fault:Fault;
		private var _isInResolutionRange:Boolean;
		private var _layer:Layer;
		private var _updateSuccess:Boolean;
		
		/**
		 * ${events_LayerEvent_field_IS_IN_RESOLUTION_RANGE_CHANGE_D} 
		 */		
		public static const IS_IN_RESOLUTION_RANGE_CHANGE:String = "isInResolutionRangeChange";
		/**
		 * ${events_LayerEvent_field_LOAD_D} 
		 */		
		public static const LOAD:String = "load";
		/**
		 * ${events_LayerEvent_field_LOAD_ERROR_D} 
		 */		
		public static const LOAD_ERROR:String = "loadError";
		/**
		 * ${events_LayerEvent_field_UPDATE_END_D} 
		 */		
		public static const UPDATE_END:String = "updateEnd";
		/**
		 * ${events_LayerEvent_field_UPDATE_START_D} 
		 */		
		public static const UPDATE_START:String = "updateStart";
		sm_internal static const LOADED:String = "loaded";
		
		/**
		 * ${events_LayerEvent_constructor_D} 
		 * @param type ${events_LayerEvent_constructor_param_type}
		 * @param layer ${events_LayerEvent_constructor_param_layer}
		 * @param fault ${events_LayerEvent_constructor_param_fault}
		 * @param updateSuccess ${events_LayerEvent_constructor_param_updateSuccess}
		 * @param isInResolutionRange ${events_LayerEvent_constructor_param_isInResolutionRange}
		 * 
		 */		
		public function LayerEvent(type:String, layer:Layer, fault:Fault = null, updateSuccess:Boolean = false, isInResolutionRange:Boolean = false)
		{
			super(type);
			this._layer = layer;
			this._fault = fault;
			this._updateSuccess = updateSuccess;
			this._isInResolutionRange = isInResolutionRange;
		}
		
		/**
		 * ${events_LayerEvent_attribute_updateSuccess_D} 
		 * 
		 */		
		public function get updateSuccess():Boolean
		{
			return _updateSuccess;
		}


		/**
		 * ${events_LayerEvent_attribute_layer_D} 
		 * 
		 */		
		public function get layer():Layer
		{
			return _layer;
		}


		/**
		 * ${events_LayerEvent_attribute_isInResolutionRange_D} 
		 * 
		 */		
		public function get isInResolutionRange():Boolean
		{
			return _isInResolutionRange;
		}


		/**
		 * ${events_LayerEvent_attribute_fault_D} 
		 * 
		 */		
		public function get fault():Fault
		{
			return _fault;
		}


		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone() : Event
		{
			return new LayerEvent(type, this.layer, this.fault, this.updateSuccess, this.isInResolutionRange);
		}
		/**
		 * @private 
		 * @return 
		 * 
		 */	
		override public function toString() : String
		{
			return formatToString("LayerEvent", "type", "layer", "fault", "updateSuccess", "isInResolutionRange");
		}

	}
}