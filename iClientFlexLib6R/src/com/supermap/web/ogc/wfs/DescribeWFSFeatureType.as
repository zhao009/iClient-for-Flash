package com.supermap.web.ogc.wfs
{
	import com.supermap.web.core.Credential;
	import com.supermap.web.events.WFSFeatureTypeEvent;
	import com.supermap.web.resources.SmResource;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import mx.resources.ResourceManager;
	import mx.rpc.AsyncResponder;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.mxml.HTTPService;


	/**
	 * ${ogc_wfs_GetWFSDescribeFeatureType_event_processComplete_D} 
	 */	
	[Event(name="processComplete", type="com.supermap.web.events.WFSFeatureTypeEvent")]
	/**
	 * ${ogc_wfs_GetWFSDescribeFeatureType_event_fault_D} 
	 */	
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${ogc_wfs_GetWFSDescribeFeatureType_Title}.
	 * <p>${ogc_wfs_GetWFSDescribeFeatureType_Description}</p> 
	 * 
	 */	
	public class DescribeWFSFeatureType extends WFSServiceBase
	{
		
		private var _mutiNamespacesLength:int = 0;
		private var _wfsObject:Object;
		private var gdftr:WFSFeatureTypeResult;
		/**
		 * ${ogc_wfs_GetWFSDescribeFeatureType_constructor_string_D} 
		 * @param url ${ogc_wfs_GetWFSDescribeFeatureType_constructor_string_param_url}
		 * 
		 */		
		public function DescribeWFSFeatureType(url:String = null)
		{
			super();
			this.url = url;
		}
		
		private var _typeNames:Array;
		
		/**
		 * ${ogc_wfs_GetWFSDescribeFeatureType_attribute_typeNames_D}
		 * @see FeatureType#name 
		 * @return 
		 * 
		 */		
		public function get typeNames():Array
		{
			return _typeNames;
		}
		
		public function set typeNames(value:Array):void
		{
			_typeNames = value;
		}
		
		/**
		 * @inheritDoc  
		 * @return 
		 * 
		 */		
		override protected function getFinalUrl():String
		{
			var extendUrl:String = "?SERVICE=WFS&REQUEST=DescribeFeatureType&VERSION=" + this.version + "&OUTPUTFORMAT=XMLSCHEMA";
			if(this._typeNames &&　this._typeNames.length)
				extendUrl += "&TYPENAME=" + this._typeNames.toString();
			if(Credential.CREDENTIAL)
			{
				extendUrl += "&" + Credential.CREDENTIAL.getUrlParameters();
			}
			return this.url + extendUrl;
		}
		
		private var nameDic:Dictionary = new Dictionary();
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */		
		
		private function getLayerTypePairHandler(wfsInfo:XML, singleNamespace:String, asyncToken:AsyncToken): void
		{
			var el:XMLList = wfsInfo.elements();
			
			for each(var elementItem:XML in el)　
			{
				if(elementItem.localName() == "element")
				{
					if(this._typeNames && this._typeNames.length)
					{
						for each(var typeName:String in this._typeNames)　
						{
							var stn:String = typeName.substr(typeName.lastIndexOf(":") + 1);
							if(elementItem.@name == stn)
								nameDic[typeName] = elementItem.@type;
						}
					}
					else
					{
						var strs:Array = elementItem.@type.toString().split(":");
						nameDic[strs[0] + ":" + elementItem.@name] = elementItem.@type;
					}
				}
			}
			var descriptionList:Array = [];
			for each(var complexTypeItem:XML in el)　
			{
				if(complexTypeItem.localName() == "complexType")
				{
					var lt:WFSFeatureDescription = new WFSFeatureDescription();
					
					for(var key:String in this.nameDic)　
					{
						var type:String = this.nameDic[key];
						var st:String = type.substr(type.lastIndexOf(":") + 1);
						
						if(complexTypeItem.@name == st)
							lt.typeName = key;
					}
					
					var elements:XMLList = complexTypeItem.elements().elements().elements().elements();
					for each(var elementItem1:XML in elements)　
					{
						if(elementItem1.localName() == "element")
						{
							if(elementItem1.@type.toString().substr(0,3) == "gml")
							{
								lt.spatialProperty = elementItem1.@name;
							}
							else
							{
								lt.properties.push(elementItem1.@name.toString());
							}
						}
					}
					descriptionList.push(lt);
				}
				
			}
		
			gdftr.featureDescriptions[singleNamespace] = descriptionList;
			gdftr.descriptionNamespaces.push(singleNamespace);
			singleNamespace = null;
			
			this._mutiNamespacesLength--;
			
			if(this._mutiNamespacesLength < 1)
			{
				var responder:IResponder;
				for each (responder in asyncToken.responders)
				{
					responder.result(gdftr);
				}
				
				var dfte:WFSFeatureTypeEvent = new WFSFeatureTypeEvent(WFSFeatureTypeEvent.PROCESS_COMPLETE, gdftr, this._wfsObject);
				this.dispatchEvent(dfte);
				this._wfsObject = null;
			}
		}
		/**
		 * @inheritDoc 
		 * @param event
		 * @param asyncToken
		 * 
		 */		
		override protected function getResultHandler(event:ResultEvent, asyncToken:AsyncToken) : void
		{
			if (event.result == "")
			{
				this.handleStringError(ResourceManager.getInstance().getString("SuperMapMessage",SmResource.RESULT_NULL), asyncToken);
			}
			else
			{
				var wfsInfo:XML = new XML(event.result);
				
				var el:XMLList = wfsInfo.elements();
				if((el.length() == 1) && (el.localName() == "ServiceException"))
				{
					this.handleStringError(el.toString(), asyncToken);
					return;
				}
				this._wfsObject = event.result;
				gdftr = new WFSFeatureTypeResult();
				var singleNamespace:String = wfsInfo.@targetNamespace;
				if(singleNamespace)
				{
					this.getLayerTypePairHandler(wfsInfo, singleNamespace, asyncToken);
				}
				else
				{
					//出现多个命名空间，及对应的url 链接，逐个访问，取其结果
					this._mutiNamespacesLength = el.length();
					var sl:String;
					for each(var elementItem:XML in el)　
					{
						singleNamespace = elementItem.@namespace;
						sl = elementItem.@schemaLocation;
						
						
						var httpService:HTTPService = new HTTPService();
						httpService.url = sl;
						httpService.resultFormat="e4x";
						
						var httpServiceAsyncToken:AsyncToken = httpService.send();
						httpServiceAsyncToken.addResponder(new AsyncResponder(
							function (event:ResultEvent,token:Object = null) : void
							{
								getMutiNamespaceResultHandler(event, asyncToken, singleNamespace);
							}
							,
							function (event:FaultEvent,token:Object = null) : void
							{
								getWFSResultErrorHandler(event, asyncToken);
							}));
					}
				}
			}
			
		}
		
		private function getMutiNamespaceResultHandler(event:ResultEvent, asyncToken:AsyncToken, namespace:String) : void
		{
			var wfsInfo:XML = event.result as XML;
			this.getLayerTypePairHandler(wfsInfo, namespace, asyncToken);
		}
		
		private function getWFSResultErrorHandler(event:FaultEvent, asyncToken:AsyncToken) : void
		{
			var responder:IResponder = null;
			for each (responder in asyncToken.responders)
			{	
				responder.fault(event);
			}
			dispatchEvent(event);
		}
		
	}
}