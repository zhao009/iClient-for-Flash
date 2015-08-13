package com.supermap.web.ogc.wfs
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.events.WFSTransactionEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.Dictionary;
	
	import mx.controls.Alert;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;

	use namespace sm_internal;
	
	/**
	 * ${ogc_wfs_WFSTransaction_Title}. 
	 * <p>${ogc_wfs_WFSTransaction_Description}</p>
	 * 
	 */	
	public class WFSTransaction extends WFSServiceBase
	{
		private var _updateParams:Array;
		private var _insertParams:Array;
		private var _deleteParams:Array;
		
		private var _featureNS:String;
		
		private var loader:URLLoader;
		
		/**
		 * ${ogc_wfs_WFSTransaction_constructor_string_D} 
		 * @param url ${ogc_wfs_WFSTransaction_constructor_string_param_url}
		 * 
		 */		
		public function WFSTransaction(url:String = null)
		{
			super();
			this.loader = new URLLoader();
			this.url = url;
		}
		
		/**
		 * ${ogc_wfs_WFSTransaction_attribute_deleteParams_D} 
		 * @see WFSTDeleteParam
		 * @return 
		 * 
		 */		
		public function get deleteParams():Array
		{
			return _deleteParams;
		}

		public function set deleteParams(value:Array):void
		{
			_deleteParams = value;
		}

		
		/**
		 * ${ogc_wfs_WFSTransaction_attribute_updateParams_D} 
		 * @see WFSTUpdateParam
		 * @return 
		 * 
		 */
		public function get updateParams():Array
		{
			return _updateParams;
		}

		public function set updateParams(value:Array):void
		{
			_updateParams = value;
		}

		/**
		 * ${ogc_wfs_WFSTransaction_attribute_insertParam_D} 
		 * @see WFSTInsertParam
		 * @return 
		 * 
		 */	
		public function get insertParams():Array
		{
			return _insertParams;
		}
		
		public function set insertParams(value:Array):void
		{
			_insertParams = value;
		}

		/**
		 * ${ogc_wfs_WFSTransaction_attribute_ns_D} 
		 * @return 
		 * 
		 */		
		public function get featureNS():String
		{
			return _featureNS;
		}
		
		public function set featureNS(value:String):void
		{
			_featureNS = value;
		}

		/**
		 * @inheritDoc 
		 * 
		 */		
		override public function processAsync(responder:IResponder = null):void{
			var urlRequst:URLRequest = new URLRequest();
			
			urlRequst.url = this.url + "?request=Transaction&version=" + this.version;
			urlRequst.method = URLRequestMethod.POST;
			urlRequst.contentType = "e4x";
			urlRequst.data = getRequestBody();
			
			loader.addEventListener(Event.COMPLETE, loadCompletedHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loadErrHandler);
			loader.load(urlRequst);
		}
	
		private function getRequestBody():XML{
			var ogcNS:Namespace = new Namespace("ogc", "http://www.opengis.net/ogc");
			var xsiNS:Namespace = new Namespace("xsi", "http://www.w3.org/2001/XMLSchema-instance"); 
			var wfsNS:Namespace = new Namespace("wfs", "http://www.opengis.net/wfs");
			
			var content:XML =new XML("<Transaction></Transaction>");
			content.setNamespace(wfsNS);
			content.addNamespace(ogcNS);
			content.addNamespace(xsiNS);
			content.@service = "WFS";
			content.@version = this.version;
			var featureNS:Namespace;
//			content.@schemaLocation = schemaLocation;
			for each(var insertParam:WFSTInsertParam in insertParams)
			{
				this.checkTypeName(insertParam.typeName);
				featureNS = new Namespace(insertParam.typeName.split(":")[0], this._featureNS);
				var insert:XML = new XML("<Insert></Insert>");
				insert.setNamespace(wfsNS);
				var features:Array = insertParam.features;
				for each(var feature:Feature in features)
				{
					var featureXml:XML = new XML("<" + insertParam.typeName.split(":")[1] + " />");
					featureXml.setNamespace(featureNS);
					var geom:XML = new XML("<" + insertParam.spatialProperty +" />");
					geom.setNamespace(featureNS);
					var spatialGeometry:SpatialGeometry = new SpatialGeometry();
					spatialGeometry.value = feature.geometry;
					var gml:XML =  spatialGeometry.toXML();
					featureXml.appendChild(geom.appendChild(gml));
					//attributes
					var attributes:Object = feature.attributes;
					if(attributes != null)
					{
						for (var field:String in attributes)
						{
							var fieldXml:XML = new XML("<" + field + ">" + attributes[field] + "</" + field + ">"); 
							featureXml.appendChild(fieldXml);
						}
					}
					insert.appendChild(featureXml);
				}
				content.appendChild(insert);
			}
			for each(var updateParam:WFSTUpdateParam in updateParams)
			{
				this.checkTypeName(updateParam.typeName);
				featureNS = new Namespace(updateParam.typeName.split(":")[0], this._featureNS);
				var update:XML = new XML("<Update />");
				update.setNamespace(wfsNS);
				update.@typeName = updateParam.typeName;	
				update.addNamespace(featureNS);
				
				var filterXml:XML = new XML("<Filter />");
				filterXml.setNamespace(ogcNS);
				
				// filter
				if(updateParam.featureIDs)
				{
					for each(var featureID:String in updateParam.featureIDs)
					{
						var featureIdXml:XML = new XML("<FeatureId />");
						featureIdXml.setNamespace(ogcNS);
						featureIdXml.@fid = featureID;
						filterXml.appendChild(featureIdXml);
					}
				}
				else
				{
					if(updateParam.filter)
					{
						var updateFilter:Filter = updateParam.filter;
						var filterContent:XML = updateFilter.toXML();
						filterXml.appendChild(filterContent);
					}	
				}
				//attributes and Geometry
				var feature2:Feature = updateParam.modifyFeature;
				var geometry:Geometry;
				if(feature2){
					var property:XML;
					geometry = feature2.geometry;
					var object:Object = feature2.attributes;
					for(var key:Object in object)
					{
						property = new XML("<Property />");
						property.setNamespace(wfsNS);
						var name:XML = new XML("<Name>" + key + "</Name>");
						name.setNamespace(wfsNS);
						var value:XML = new XML("<Value>" + object[key] + "</Value>");
						value.setNamespace(wfsNS);
						property.appendChild(name).appendChild(value);
						update.appendChild(property);
					}
					if(geometry)
					{
						property = new XML("<Property />");
						var nameXml:XML = new XML("<Name>" + updateParam.spatialProperty + "</Name>");
						nameXml.setNamespace(wfsNS);
						var valueXml:XML = new XML("<Value />");
						valueXml.setNamespace(wfsNS);
						var spaGeo:SpatialGeometry = new SpatialGeometry();
						spaGeo.value = geometry;
						var gmlXml:XML = spaGeo.toXML();
						property.appendChild(nameXml).appendChild(valueXml.appendChild(gmlXml));
						update.appendChild(property);
					}
				}
				content.appendChild(update.appendChild(filterXml));
			}
			for each(var deleteParam:WFSTDeleteParam in deleteParams)
			{
				this.checkTypeName(deleteParam.typeName);
				featureNS = new Namespace(deleteParam.typeName.split(":")[0], this._featureNS);
				var deleteXml:XML = new XML("<Delete></Delete>");
				deleteXml.@typeName = deleteParam.typeName;
				deleteXml.setNamespace(wfsNS);
				deleteXml.addNamespace(featureNS);
				var filterXml2:XML = new XML("<Filter></Filter>");
				filterXml2.setNamespace(ogcNS);
				
				var featureIDs:Array = deleteParam.featureIDs;
				if(featureIDs)
				{
					for each(var fid:String in featureIDs)
					{
						var featureIdXml2:XML = new XML("<FeatureId></FeatureId>");
						featureIdXml2.@fid = fid;
						featureIdXml2.setNamespace(ogcNS);
						filterXml2.appendChild(featureIdXml2)
					}
				}
				else
				{
					var filter:Filter = deleteParam.filter;
					if(filter)
					{
						var filterContent2:XML = filter.toXML();
						filterXml2.appendChild(filterContent2);
					}
				}
				deleteXml.appendChild(filterXml2);
				content.appendChild(deleteXml);
			}
			
			return content;
		}
		private function checkTypeName(typeName:String):void
		{
			if(typeName == null)
			{
				throw new SmError(SmResource.TYPENAME_IS_NULL);//110923bywm
			}
		}
		private function loadCompletedHandler(event:Event):void
		{
			var urlLoader:URLLoader = event.currentTarget as URLLoader;
			var data:String = urlLoader.data as String;
			var resultInfo:XML = XML(data.substring(data.indexOf(">")+1));
			
			var fids:Array = [];
			var status:String;
			if(resultInfo.localName() == "WFS_TransactionResponse" || resultInfo.localName() == "TransactionResponse")
			{
				var list:XMLList = resultInfo.elements() as XMLList;
				for each(var item:XML in list)
				{
					if(item.localName() == "InsertResult")
					{
						var insertList:XMLList = item.elements().@fid;
						for each(var fid:XML in insertList)
						{
							fids.push(fid.toString());
						}
					}
					if(item.localName() == "TransactionResult")
					{
						status = item.elements().elements().localName();
					}
				}
			}
			
			var wfsResult:WFSTransactionResult = new WFSTransactionResult();
			wfsResult.status = status;
			wfsResult.message = data;
			wfsResult.featureIDs = fids;
			var eve2:WFSTransactionEvent=new WFSTransactionEvent(WFSTransactionEvent.PROCESS_COMPLETE, event.currentTarget, wfsResult);
			this.dispatchEvent(eve2);
		}
		
		private function loadErrHandler(event:IOErrorEvent):void
		{
			this.handleStringError(event.currentTarget.data, null);
		}
	}
}