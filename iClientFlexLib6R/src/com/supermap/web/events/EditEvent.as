package com.supermap.web.events
{
    import com.supermap.web.core.Feature;
    import com.supermap.web.core.Point2D;
    
    import flash.events.*;

	/**
	 * ${events_EditEvent_Title}. 
	 * <p>${events_EditEvent_Description}</p>
	 * 
	 */	
    public class EditEvent extends Event
    {
        private var _feature:Feature;
		private var _node:Point2D;

		/**
		 * ${events_EditEvent_field_DRAG_NODE_END_D} 
		 */	
        public static const DRAG_NODE_END:String = "dragNodeEnd";
		
		/**
		 * ${events_EditEvent_field_DRAG_NODE_START_D} 
		 */	
		public static const DRAG_NODE_START:String = "dragNodeStart";
		
		/**
		 * ${events_EditEvent_field_ADD_NODE_D} 
		 */	
		public static const ADD_NODE:String = "addNode";

		/**
		 * ${events_EditEvent_constructor_D} 
		 * @param type ${events_EditEvent_constructor_param_type}
		 * @param feature ${events_EditEvent_constructor_param_feature}
		 * @param feature ${events_EditEvent_constructor_param_node}
		 * 
		 */		
        public function EditEvent(type:String, feature:Feature = null, node:Point2D = null)
        {
            super(type);
            this._feature = feature;
			this._node = node;
        }

		/**
		 * ${events_EditEvent_attribute_feature_D} 
		 * 
		 */		
		public function get feature():Feature
		{
			return _feature;
		}
		
		
		/**
		 * ${events_EditEvent_attribute_node_D} 
		 * 
		 */		
		public function get node():Point2D
		{
			return _node;
		}

		/**
		 * @inheritDoc 
		 * @return 
		 * @private
		 * 
		 */		
        override public function clone():Event
        {
            return new EditEvent(type, this.feature);
        }

		/**
		 * @inheritDoc 
		 * @return 
		 * @private
		 * 
		 */		
        override public function toString():String
        {
            return formatToString("EditEvent", "type", "feature");
        }
    }
}
