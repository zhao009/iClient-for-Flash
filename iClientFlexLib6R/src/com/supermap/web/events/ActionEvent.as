package com.supermap.web.events
{
	import com.supermap.web.actions.MapAction;
	
	import flash.events.Event;
	
	/**
	 * ${events_ActionEvent_Title}.
	 * <p>${events_ActionEvent_Description}</p> 
	 * 
	 * 
	 */	
	public class ActionEvent extends Event
	{
		/**
		 * ${events_ActionEvent_field_ACTION_CHANGED_D} 
		 */		
		public static const ACTION_CHANGED:String="actionChanged";
		
		private var _oldAction:MapAction;
		private var _newAction:MapAction;
		
		/**
		 * ${events_ActionEvent_constructor_D} 
		 * @param type ${events_ActionEvent_constructor_param_type}
		 * @param oldAction ${events_ActionEvent_constructor_param_oldAction}
		 * @param newAction ${events_ActionEvent_constructor_param_newAction}
		 * 
		 */		
		public function ActionEvent(type:String, oldAction:MapAction, newAction:MapAction)
		{
			super(type);
			this._oldAction=oldAction;
			this._newAction=newAction;
		}
		
		/**
		 * ${events_ActionEvent_attribute_oldAction_D} 
		 * 
		 */		
		public function get oldAction():MapAction
		{
			return this._oldAction;
		}
		
		/**
		 * ${events_ActionEvent_attribute_newAction_D} 
		 * 
		 */		
		public function get newAction():MapAction
		{
			return this._newAction;
		}
	}
}