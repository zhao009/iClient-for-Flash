package com.supermap.web.events
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.ogc.wmts.WMTSCapabilitiesResult;
	
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * ${mapping_OGC_WMTSResultEvent_Title}.
	 * <p>${mapping_OGC_WMTSResultEvent_Description}</p> 
	 * 
	 */	
	public class WMTSResultEvent extends Event
	{
		private var _wmtsCapabilitiesResult:WMTSCapabilitiesResult;	
		
		/**
		 * ${mapping_OGC_WMTSResultEvent_attribute_GET_WMTS_DATA_D} 
		 */		
		public static const GET_DATA:String = "getData";
		public static const PROCESS_COMPLETE:String = "processComplete";

		/**
		 * ${mapping_OGC_WMTSResultEvent_constructor_string_D} 
		 * @param type ${mapping_OGC_WMTSResultEvent_constructor_param_type}
		 * @param wmtsCapabilitiesResult ${mapping_OGC_WMTSResultEvent_constructor_param_wmtsCapabilitiesResult}
		 * 
		 */		
		public function WMTSResultEvent(type:String, wmtsCapabilitiesResult:WMTSCapabilitiesResult = null)
		{
			super(type);
			this._wmtsCapabilitiesResult = wmtsCapabilitiesResult;			
		}
		
		/**
		 * ${mapping_OGC_WMTSResultEvent_attribute_wmtsCapabilitiesResult_D} 
		 * @return 
		 * 
		 */		
		public function get wmtsCapabilitiesResult():WMTSCapabilitiesResult
		{
			return _wmtsCapabilitiesResult;
		}
		
		//TODO:
		override public function clone() : Event
		{
			return null;
		}		
		
		//TODO:
		override public function toString() : String
		{
			return "";
		}
	}
}