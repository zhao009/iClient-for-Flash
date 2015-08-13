package com.supermap.web.iServerJava6R.measureServices
{
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.iServerJava6R.serviceEvents.MeasureEvent;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.MeasureEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	/**
	 * ${iServerJava6R_MeasureService_Tile}.
	 * <p>${iServerJava6R_MeasureService_Description}</p> 
	 * 
	 */
	public class MeasureService extends ServiceBase
	{
		private var _lastResult:MeasureResult;
		
		/**
		 * ${iServerJava6R_MeasureService_constructor_D_as} 
		 * @param url ${iServerJava6R_MeasureService_constructor_String_param_url}
		 * 
		 */
		public function MeasureService(url:String)
		{
			super(url);
		}
		
		/**
		 * ${iServerJava6R_MeasureService_method_execute_D_as} 
		 * @param parameters ${iServerJava6R_MeasureService_method_ProcessAsync_param_parameters}
		 * @param responder ${iServerJava6R_MeasureService_method_execute_param_responder_as}
		 * @return ${iServerJava6R_MeasureService_method_execute_return_as}
		 * 
		 */		
		public function processAsync(parameters:MeasureParameters, responder:IResponder = null):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			var reqVar:URLVariables = new URLVariables();
         	var extendURL:String;
			
			if (parameters.geometry == null)
				throw "Geometry null";
			
			var arrPoint2d:Array = [];
			
			if (parameters.geometry is GeoLine)
			{
				if ((parameters.geometry as GeoLine).partCount != 0)
					arrPoint2d = (parameters.geometry as GeoLine).getPart(0);
				extendURL = "/distance.json?_method=GET&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			}
			
			if (parameters.geometry is GeoRegion)
			{
				if ((parameters.geometry as GeoRegion).partCount != 0)
					arrPoint2d = (parameters.geometry as GeoRegion).getPart(0);
				extendURL = "/area.json?_method=GET&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			}
			


			
			var json:String = "";
			
			json += "\"point2Ds\":" + JsonUtil.fromArray(arrPoint2d);
			json += ",\"unit\":\"" + parameters.unit + "\"";
			if(parameters.prjCoordSys)
			{
				var prjCoordSysTemp:String
				prjCoordSysTemp = '{"epsgCode"'+parameters.prjCoordSys.substring(parameters.prjCoordSys.indexOf(":"),parameters.prjCoordSys.length) +"}";	
				json += ",\"prjCoordSys\":" + prjCoordSysTemp;			
			}
			json ="{" + json + "}";
			
//         	reqVar.point2Ds = JsonUtil.fromArray(arrPoint2d);
//            reqVar.unit = parameters.unit;
            
            return sendURL(extendURL, json, responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			 var responder:IResponder;
            this._lastResult = MeasureResult.toMeasureResult(object);
            for each (responder in asyncToken.responders)
            {
                responder.result(this._lastResult);
            }
			this.dispatchEvent(new MeasureEvent(MeasureEvent.PROCESS_COMPLETE, this._lastResult, object));
		}

		sm_internal function get lastResult():MeasureResult
		{
			return this._lastResult;
		}
		
	}
}