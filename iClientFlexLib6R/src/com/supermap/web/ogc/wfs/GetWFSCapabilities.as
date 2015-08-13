package com.supermap.web.ogc.wfs
{
	import com.supermap.web.utils.CoordinateReferenceSystem;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.events.WFSCapabilitiesEvent;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	import flash.events.Event;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.resources.ResourceManager;
	import com.supermap.web.resources.SmResource;
	
	/**
	 * ${ogc_wfs_GetWFSCapabilities_event_processComplete_D} 
	 */	
	[Event(name="processComplete", type="com.supermap.web.events.WFSCapabilitiesEvent")]
	
	/**
	 * ${ogc_wfs_GetWFSCapabilities_event_fault_D} 
	 */	
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	

	/**
	 * ${ogc_wfs_GetWFSCapabilities_Title}.
	 * <p>${ogc_wfs_GetWFSCapabilities_Description}</p> 
	 * 
	 */	
	public class GetWFSCapabilities extends WFSServiceBase
	{
		/**
		 * ${ogc_wfs_GetWFSCapabilities_constructor_string_D} 
		 * @param url ${ogc_wfs_GetWFSCapabilities_constructor_string_param_url}
		 * 
		 */		
		public function GetWFSCapabilities(url:String = null)
		{
			super();
			this.url = url;
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override protected function getFinalUrl():String
		{
			var extendUrl:String = "?SERVICE=WFS&REQUEST=GetCapabilities";
			if(this.version != "" && this.version != null)
				extendUrl += "&VERSION=" + this.version;
			
			return this.url + extendUrl;
		}
		
		/**
		 * @inheritDoc 
		 * @return 
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
				var ftl:XMLList = wfsInfo.elements();
				if((ftl.length() == 1) && (ftl.localName() == "ServiceException"))
				{
					this.handleStringError(ftl.toString(), asyncToken);
					return;
				}
				
				var featureTypeList:Array = [];
				for each(var typeListItem:XML in ftl)　
				{
					if(typeListItem.localName() == "FeatureTypeList")
					{
						var ft:XMLList = typeListItem.elements();
						for each(var typeItem:XML in ft)　
						{
							if(typeItem.localName() == "FeatureType")
							{
								var featureType:WFSFeatureType = new WFSFeatureType();
								
								for each(var item:XML in typeItem.elements())　
								{
									if(item.localName() == "Name")
										featureType.typeName = item.toString();
									else if(item.localName() == "Title")
										featureType.title = item.toString();
									else if(item.localName() == "SRS")
									{
										var wkid:String = item.toString().split(":")[1];
										featureType.SRS = new CoordinateReferenceSystem(int(wkid));
									}
									else if(item.localName() == "LatLongBoundingBox")
										featureType.bounds = new Rectangle2D(item.@minx, item.@miny, item.@maxx, item.@miny);
								}
								featureTypeList.push(featureType);
							}
						}
					}
				}
				
				var gcr:WFSCapabilitiesResult = new WFSCapabilitiesResult();
				gcr.setFeatureTypes(featureTypeList);
				
				var responder:IResponder;
				for each (responder in asyncToken.responders)
				{
					responder.result(gcr);
				}
				
				var ce:WFSCapabilitiesEvent = new WFSCapabilitiesEvent(WFSCapabilitiesEvent.PROCESS_COMPLETE, gcr, event.result);
				this.dispatchEvent(ce);
			}
		}
	}
}