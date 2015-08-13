package com.supermap.web.events
{
    import com.supermap.web.core.Feature;
    import com.supermap.web.core.Point2D;
    
    import flash.events.*;

	/**
	 * ${events_DrawEvent_Title}. 
	 * <p>${events_DrawEvent_Description}</p>
	 * 
	 */	
    public class DrawEvent extends Event
    {
        private var _feature:Feature;
		private var _startPoint:Point2D;
		private var _endPoint:Point2D;

		/**
		 * ${events_DrawEvent_field_DRAW_END_D} 
		 */	
        public static const DRAW_END:String = "drawEnd";
		
		/**
		 * ${events_ActionEvent_field_DRAW_UPDATE_D} 
		 */		
		public static const DRAW_UPDATE:String = "drawUpdate";
		
		/**
		 * ${events_DrawEvent_field_DRAW_START_D} 
		 */		
        public static const DRAW_START:String = "drawStart";
		
		
		/**
		 * ${events_ActionEvent_field_DRAW_CANCAL_D} 
		 */		
		public static const DRAW_CANCEL:String = "drawCancel";

		/**
		 * ${events_DrawEvent_constructor_D} 
		 * @param type ${events_DrawEvent_constructor_param_type}
		 * @param feature ${events_DrawEvent_constructor_param_feature}
		 * 
		 */		
        public function DrawEvent(type:String, feature:Feature = null, startPoint:Point2D = null, endPoint:Point2D = null)
        {
            super(type);
            this._feature = feature;
			this._startPoint = startPoint;
			this._endPoint = endPoint;
        }

		/**
		 * ${events_DrawEvent_attribute_endPoint_D} 
		 * @return 
		 * 
		 */		
		public function get endPoint():Point2D
		{
			return _endPoint;
		}

		/**
		 * ${events_DrawEvent_attribute_startPoint_D} 
		 * @return 
		 * 
		 */		
		public function get startPoint():Point2D
		{
			return _startPoint;
		}

		/**
		 * ${events_DrawEvent_attribute_feature_D} 
		 * 
		 */		
		public function get feature():Feature
		{
			return _feature;
		}

		/**
		 * @inheritDoc 
		 * @return 
		 * @private
		 * 
		 */		
        override public function clone():Event
        {
            return new DrawEvent(type, this.feature, this.startPoint, this.endPoint);
        }

		/**
		 * @inheritDoc 
		 * @return 
		 * @private
		 * 
		 */		
        override public function toString():String
        {
            return formatToString("DrawEvent", "type", "feature");
        }

    }
}
