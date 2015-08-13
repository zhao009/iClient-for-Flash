package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.iServerJava2.JoinItem;
	import com.supermap.web.iServerJava2.ParametersBase;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.service.ServiceBase;
	import com.supermap.web.sm_internal;
	
	import flash.net.URLVariables;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeService_Title}.
	 * <p>${iServer2_themeServices_ThemeService_Description}</p> 
	 * 
	 * 
	 */
	public class ThemeService extends ServiceBase
	{
		private var _themeResult:ThemeResult;
		
		/**
		 * ${iServer2_themeServices_ThemeService_constructor_String_param_url} 
		 * @param url ${iServer2_themeServices_ThemeService_constructor_String_param_url}
		 * 
		 */		
		public function ThemeService(url:String=null)
		{
			super(url);
		}
		
		/**
		 * ${iServer2_themeServices_ThemeService_method_execute_D} 
		 * @param responder ${iServer2_themeServices_ThemeService_method_execute_param_responder}
		 * @param parameters ${iServer2_themeServices_ThemeService_method_execute_param_parameters}
		 * @return ${iServer2_themeServices_ThemeService_method_execute_return_AsyncToken_D}
		 * 
		 */		
		public function execute(responder:IResponder, parameters:ThemeParameters):AsyncToken
		{
			if(!parameters)
			{
				throw new SmError(SmResource.NONE_PARAMETERS);
			}
			
			var reqVar:URLVariables = new URLVariables();
			reqVar.mapName = parameters.mapName;
			var joinItemsJSON:Array = new Array();
			if(parameters.joinItems&&parameters.joinItems.length>0){
				reqVar.method = "addThemeByJoinItem";
				for each(var joinItem:JoinItem in parameters.joinItems){
					joinItemsJSON.push(JoinItem.toJson(joinItem));
				}
			}else{
				reqVar.method = "addTheme";
			}	
			var themeStr:String;
			
			reqVar.params = "<uis>" + 
				"<command>" + 
				"<name>" + reqVar.method+ "</name>" +
				"<parameter>" +
				"<mapName>" + parameters.mapName + "</mapName>" +
				"<layerName>" + parameters.layerName + "</layerName>" +
				"<themeType>" + parameters.theme.themeType + "</themeType>";
			if(parameters.theme.themeType == ThemeType.UNIQUE) 
				themeStr =  (ThemeUnique)(parameters.theme).toJSON();
			else if(parameters.theme.themeType == ThemeType.RANGE) 
				themeStr =  (ThemeRange)(parameters.theme).toJSON();
			else if(parameters.theme.themeType == ThemeType.GRAPH)
				themeStr =  (ThemeGraph)(parameters.theme).toJSON();
			else if(parameters.theme.themeType == ThemeType.DOT_DENSITY)
				themeStr =  (ThemeDotDensity)(parameters.theme).toJSON();
			else if(parameters.theme.themeType == ThemeType.LABEL)
				themeStr =  (ThemeLabel)(parameters.theme).toJSON();
			else if(parameters.theme.themeType == ThemeType.GRADUATED_SYMBOL)
				themeStr =  (ThemeGraduatedSymbol)(parameters.theme).toJSON();
			reqVar.params += "<theme>" + themeStr + "</theme>" +
				"<index>" + parameters.index +"</index>"+
				"<joinItems>["+joinItemsJSON+
				"]</joinItems>"+
				"<customParam></customParam>" +
				"</parameter>" + 
				"</command>" + 
				"</uis>";
//			trace(reqVar);
			return sendURL("/commonhandler", reqVar, responder, this.handleDecodedObject);	
			
		}
		
		private function handleDecodedObject(object:Object, asyncToken:AsyncToken):void
		{
			var responder:IResponder;
			if(object)
				this._themeResult = ThemeResult.toThemeResult(object);
			for each (responder in asyncToken.responders)
			{
				responder.result(this._themeResult);
			}
		}
		
		/**
		 * ${iServer2_themeServices_ThemeService_attribute_themeResult_D} 
		 * @return 
		 * 
		 */		
		public function get themeResult():ThemeResult
		{
			return this._themeResult;
		}
		
	}
}