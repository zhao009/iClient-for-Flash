package com.supermap.web.iServerJava6R.dataServices
{
	import com.supermap.web.iServerJava6R.serviceEvents.EditFeaturesEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	import com.supermap.web.utils.serverTypes.ServerFeature;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;

	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_Service_event_processComplete_D} 
	 */	
	[Event(name="processComplete", type="com.supermap.web.iServerJava6R.serviceEvents.EditFeaturesEvent")]
	
	/**
	 * ${iServerJava6R_Service_event_fault_D} 
	 */	
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${iServerJava6R_EditFeaturesService_Title}.
	 * <p>${iServerJava6R_EditFeaturesService_Description}</p> 
	 * 
	 */	
	public class EditFeaturesService extends ServiceBase
	{
		/**
		 * ${iServerJava6R_EditFeaturesService_constructor_D} 
		 * @param url ${iServerJava6R_EditFeaturesService_constructor_param_url}
		 * 
		 */		
		override public function EditFeaturesService(url:String)
		{
			super(url);
		}

		private var _lastResult:EditFeaturesResult;
						
		sm_internal function get lastResult():EditFeaturesResult
		{
			return this._lastResult;
		}
		
		/**
		 * ${iServerJava6R_EditFeaturesService_method_ProcessAsync_D}.
		 * <p>${iServerJava6R_EditFeaturesService_method_ProcessAsync_remarks}</p> 
		 * @param parameters ${iServerJava6R_EditFeaturesService_method_ProcessAsync_param_parameters}
		 * @param responder ${iServerJava6R_EditFeaturesService_method_ProcessAsync_param_IResponder}
		 * @return ${iServerJava6R_EditFeaturesService_method_ProcessAsync_return}
		 * 
		 */		
		public function processAsync(parameters:EditFeaturesParameters, responder:IResponder = null):AsyncToken
		{		
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
				return null;
			}
			var extendURL:String;
			if (parameters.editType == EditType.ADD)
			{
				if(parameters.isUseBatch)
				{
					extendURL = ".json?isUseBatch=true";
				}
				else
				{
					extendURL = ".json?returnContent=" + parameters.returnContent;//直接获取添加地物SmID
				}
			}
			else if (parameters.editType == EditType.DELETE)
			{
				extendURL = ".json?_method=DELETE";
			}
			else
			{
				extendURL = ".json?_method=PUT";
			}
			
			extendURL += "&X-RequestEntity-ContentType=application/flex&flexAgent=true";
			
			return sendURL(extendURL, getVariables(parameters), responder, this.handleDecodedObject);	
		}
		
		private function getVariables(parameters:EditFeaturesParameters):String
		{
			var postJson:String = "";
			if(parameters.editType == EditType.DELETE)
			{
				if (parameters.IDs != null)
				{
					postJson = "[" + parameters.IDs.join(",") + "]";
				}
				else
				{
					postJson = "[]";	
				}
			}
			else
			{
				if(parameters.features && parameters.features.length)
				{
					var length:int = parameters.features.length;
					postJson += "[";
					for(var i:int = 0; i < length; i++)
					{
						if(i != 0)
						{
							postJson += ",";
						}
						var sf:ServerFeature = ServerFeature.fromFeature(parameters.features[i]);
						if (parameters.editType == EditType.UPDATE)
						{
							//更新时，ID的个数和Feature的个数不一致更新就不起作用！
							if (parameters.IDs && parameters.IDs.length == length)
							{
								if(sf.geometry)//支持更新属性表
									sf.geometry.id = parameters.IDs[i];		
								else
									sf.id = parameters.IDs[i];
							}
						}
						postJson += ServerFeature.toJson(sf);
					}	
					postJson += "]";
				}				
			}		
			return postJson;
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			this._lastResult = EditFeaturesResult.fromJson(object);
			for each (responder in asyncToken.responders)
			{
				responder.result(this._lastResult);
			}
			this.dispatchEvent(new EditFeaturesEvent(EditFeaturesEvent.PROCESS_COMPLETE, this._lastResult, object));
		}
	}
}