package com.supermap.web.iServerJava2.measureServices
{
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	import com.supermap.web.iServerJava2.ServerGeometry;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_measureServices_measureService_Title}.
	 * <p>${iServer2_measureServices_measureService_Description}</p> 
	 * 
	 * 
	 */	
	public class MeasureService extends ServiceBase
	{
		private var _measureType:String;
		private var _lastResult:MeasureResult;
		
		/**
		 * ${iServer2_measureServices_measureService_constructor_String_D} 
		 * @param url ${iServer2_measureServices_measureService_constructor_String_param_url}
		 * 
		 */		
		public function MeasureService(url:String)
		{
			super(url);
		}
		
		/**
		 * ${iServer2_measureServices_measureService_attribute_lastResult_D} 
		 * 
		 */		
		public function get lastResult():Object
		{
			return this._lastResult;
		}
			
		/**
		 * ${iServer2_measureServices_measureService_method_execute_D} 
		 * @param responder ${iServer2_measureServices_measureService_method_execute_param_responder}
		 * @param parameters ${iServer2_measureServices_measureService_method_execute_param_parameters}
		 * @return ${iServer2_measureServices_measureService_method_execute_return_AsyncToken_D}
		 * 
		 */		
		public function execute(responder:IResponder, parameters:MeasureParameters):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			if(parameters.geometry is GeoLine)
				this._measureType = "MeasureDistance";
			else 
				this._measureType = "MeasureArea";
			
			var reqVar:URLVariables = new URLVariables();
            reqVar.mapName = parameters.mapName;
            reqVar.method = this._measureType;
            reqVar.params = "<uis>" + 
            		"<command>" + 
            			"<name>" + this._measureType + "</name>" + 
            			"<parameter>" + 
            				"<mapName>" + parameters.mapName + "</mapName>";
			if(parameters.geometry is GeoLine) 
				reqVar.params += "<points>" + ServerGeometry.fromGeoLine(parameters.geometry as GeoLine) + "</points>";
				
			else
				reqVar.params += "<points>" + ServerGeometry.fromGeoRegion(parameters.geometry as GeoRegion) + "</points>";
							
			reqVar.params += "<needHighLight>false</needHighLight>" + 
            				"<customParam></customParam>" + 
            			"</parameter>" + 
            		"</command>" + 
            		"</uis>";
            return sendURL("/commonhandler", reqVar, responder, this.handleDecodedObject);	
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			 var responder:IResponder;
            this._lastResult = MeasureResult.toMeasureResult(object);
            for each (responder in asyncToken.responders)
            {
                responder.result(this.lastResult);
            }
		}
		
	}
}