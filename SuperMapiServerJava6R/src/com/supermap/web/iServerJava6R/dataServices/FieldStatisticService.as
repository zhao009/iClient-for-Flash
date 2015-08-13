package com.supermap.web.iServerJava6R.dataServices
{
	import com.supermap.web.utils.serverTypes.*;
	import com.supermap.web.iServerJava6R.serviceEvents.FieldStatisticEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	import com.supermap.web.service.ServiceBase;
	
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */	
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.FieldStatisticEvent")]
	
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */	
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_FieldStatisticService_Title}.
	 * <p>${iServerJava6R_FieldStatisticService_Description}</p> 
	 * 
	 */	
	public class FieldStatisticService extends ServiceBase
	{
		/**
		 * ${iServerJava6R_FieldStatisticService_constructor_D} 
		 * @param url ${iServerJava6R_FieldStatisticService_constructor_param_url}
		 * 
		 */	
		override public function FieldStatisticService(url:String)
		{
			super(url);
		}
		
		private var _lastResult:FieldStatisticResult;
		private var _datasource:String;
		private var _dataset:String;
		private var _field:String;
		private var _statisticMode:String;
		
		sm_internal function get lastResult():FieldStatisticResult
		{
			return this._lastResult;
		}
        
		/**
		 * ${iServerJava6R_FieldStatisticService_attribute_datasource_D} 
		 * @return 
		 * 
		 */	
		public function get datasource():String
		{
			return _datasource;
		}
        
		public function set datasource(value:String):void
		{
			_datasource = value;
		}

		/**
		 * ${iServerJava6R_FieldStatisticService_attribute_dataset_D} 
		 * @return 
		 * 
		 */	
		public function get dataset():String
		{
			return _dataset;
		}

		public function set dataset(value:String):void
		{
			_dataset = value;
		}

		/**
		 * ${iServerJava6R_FieldStatisticService_attribute_field_D} 
		 * @return 
		 * 
		 */	
		public function get field():String
		{
			return _field;
		}

		public function set field(value:String):void
		{
			_field = value;
		}

		/**
		 * ${iServerJava6R_FieldStatisticService_attribute_statisticMode_D} 
		 * @see StatisticMode
		 * @return 
		 * 
		 */	
		public function get statisticMode():String
		{
			return _statisticMode;
		}

		public function set statisticMode(value:String):void
		{
			_statisticMode = value;
		}
		
		/**
		 * ${iServerJava6R_FieldStatisticService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_FieldStatisticService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_FieldStatisticService_method_ProcessAsync_param_parameters}
		 * @param responder ${iServerJava6R_FieldStatisticService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_FieldStatisticService_method_ProcessAsync_return}
		 * 
		 */	
		public function processAsync(parameters:Object, responder:IResponder = null):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			if(!(parameters.datasource && parameters.dataset && parameters.field && parameters.statisticMode))
			{
				throw new SmError("参数不正确，请检查参数！");
				return null;
			}
			
			var extendUrl:String;
			this._datasource = parameters.datasource;
			this._dataset = parameters.dataset;
			this._field = parameters.field;
			this._statisticMode = parameters.statisticMode;
			extendUrl="/datasources/" + this._datasource + "/datasets/" + this._dataset + "/fields/" + this._field + "/" + this._statisticMode + ".json?";
			extendUrl += "&X-RequestEntity-ContentType=applicationflex";
			return sendURL(extendUrl, null, responder, this.handleDecodedObject);	
			
		}
		
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = FieldStatisticResult.fromJson(object);
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new FieldStatisticEvent(FieldStatisticEvent.PROCESS_COMPLETE, this._lastResult, object));
		}



	}
}