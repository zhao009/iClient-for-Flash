package com.supermap.web.iServerJava6R.dataServices
{
	import com.supermap.web.iServerJava6R.FilterParameter;
	import com.supermap.web.iServerJava6R.serviceEvents.GetFeaturesEvent;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.GetFeaturesEvent")]
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_GetFeaturesByIDsService_Title}.
	 * <p>${iServerJava6R_GetFeaturesByIDsService_Description}</p> 
	 * 
	 */	
	public class GetFeaturesByIDsService extends ServiceBase
	{
		/**
		 * ${iServerJava6R_GetFeaturesByIDsService_constructor_D} 
		 * @param url ${iServerJava6R_GetFeaturesByIDsService_constructor_param_url}
		 */		
		override public function GetFeaturesByIDsService(url:String)
		{
			super(url);
		}
		
		private var _lastResult:GetFeaturesResult;
	
		sm_internal function get lastResult():GetFeaturesResult
		{
			return this._lastResult;
		}
		
		/**
		 * ${iServerJava6R_GetFeaturesByIDsService_method_ProcessAsync_D}.
		 * <P>${iServerJava6R_GetFeaturesByIDsService_method_ProcessAsync_remarks}</P> 
		 * @param parameters ${iServerJava6R_GetFeaturesByIDsService_method_ProcessAsync_param_parameters}
		 * @param responder ${iServerJava6R_GetFeaturesByIDsService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_GetFeaturesByIDsService_method_ProcessAsync_return}
		 * 
		 */		
		public function processAsync(parameters:GetFeaturesByIDsParameters, responder:IResponder = null):AsyncToken
		{		
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			var extendURL:String;
			
			extendURL = ".json?returnContent=true";//直接获取添加地物SmID
			
			if(!isNaN(parameters.fromIndex))
			{
				extendURL += "&fromIndex=" + parameters.fromIndex;
			}
			if(!isNaN(parameters.toIndex))
			{
				extendURL += "&toIndex=" + parameters.toIndex;
			}
			
			extendURL += "&X-RequestEntity-ContentType=application/flex&flexAgent=true";
		
			return sendURL(extendURL, getVariables(parameters), responder, this.handleDecodedObject);	
		}
		
		private function getVariables(parameters:GetFeaturesByIDsParameters):String
		{
			var postJson:String = "";
			postJson = '{\"getFeatureMode\":\"ID\",\"datasetNames\":';		
			if(parameters.datasetNames != null)
			{
				var datasetNamesString:String = "[";
				var length:int = parameters.datasetNames.length
				for(var i:int = 0; i < length; i++)
				{
					if(i!=0) datasetNamesString += ",";
					datasetNamesString += '\"' + parameters.datasetNames[i] + '\"';
				}
				postJson += datasetNamesString + "]";
			}	
			postJson += ',\"ids":';
			if(parameters.IDs != null)
			{
				var idsString:String = "[";
				var idCount:int = parameters.IDs.length
				for(i = 0; i < idCount; i++)
				{
					if(i != 0)
					{
						idsString += ",";
					}
					idsString += parameters.IDs[i];
				}
				postJson += idsString + "]";
			}
			
			
			if (parameters.fields != null && parameters.fields.length > 0)
			{
				var fp:FilterParameter = new FilterParameter();
				fp.fields = parameters.fields;
				postJson += (',\"queryParameter\":' + fp.toJson());
			}
			
			postJson += '}';		
			return postJson;
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = GetFeaturesResult.fromJson(object);
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new GetFeaturesEvent(GetFeaturesEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
	}
}