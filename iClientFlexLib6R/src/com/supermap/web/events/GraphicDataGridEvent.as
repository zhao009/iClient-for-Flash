package com.supermap.web.events
{
	import com.supermap.web.core.Graphic;
	
	import flash.events.Event;
	
	import mx.events.DataGridEvent;
	
	/**
	 * ${events_GraphicDataGridEvent_Title}.
	 * <p>${events_GraphicDataGridEvent_Description}</p> 
	 * @see com.supermap.web.components.GraphicDataGrid
	 * 
	 */	
	public class GraphicDataGridEvent extends DataGridEvent
	{
		private var _graphic:Graphic;
		/**
		 * ${events_GraphicDataGridEvent_field_GRAPHIC_SELECTED_D} 
		 */	
		public static const GRAPHIC_SELECTED:String = "graphicSelected";
		/**
		 * ${events_GraphicDataGridEvent_field_Graphic_CLICK_D} 
		 */	
		public static const GRAPHIC_CLICK:String    = "graphicClick";
		/**
		 * ${events_GraphicDataGridEvent_field_Graphic_DELETE_D} 
		 */	
		public static const GRAPHIC_DELETE:String   = "graphicDelete";
		/**
		 * ${events_GraphicDataGridEvent_constructor_D} 
		 * @param type ${events_GraphicDataGridEvent_constructor_param_type}
		 * @param graphic ${events_GraphicDataGridEvent_constructor_param_graphic}
		 * 
		 */	
		public function GraphicDataGridEvent(type:String, graphic:Graphic = null)
		{
			super(type);
			this._graphic = graphic;
		}
		
		/**
		 * ${events_GraphicDataGridEvent_field_graphic_D} 
		 * @return 
		 * 
		 */	
		public function get graphic():Graphic
		{
			return _graphic;
		}
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function clone():Event
		{
			return new GraphicDataGridEvent(type, this._graphic);
		}
		/**
		 * @private 
		 * @return 
		 * 
		 */		
		override public function toString():String
		{
			return formatToString("GraphicDataGridEvent", "type", "graphic"); 
		}
	}
}