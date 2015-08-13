package com.supermap.web.ogc.wfs
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.styles.PredefinedFillStyle;
	import com.supermap.web.core.styles.PredefinedLineStyle;
	import com.supermap.web.core.styles.PredefinedMarkerStyle;
	import com.supermap.web.events.WFSFeatureEvent;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	
	import mx.resources.ResourceManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;

	use namespace sm_internal;
	
	/**
	 * ${ogc_wfs_GetWFSFeature_event_processComplete_D} 
	 */	
	[Event(name="processComplete", type="com.supermap.web.events.WFSFeatureEvent")]
	/**
	 * ${ogc_wfs_GetWFSFeature_event_fault_D} 
	 */	
	[Event(name="fault", type="mx.rpc.events.FaultEvent")]
	
	/**
	 * ${ogc_wfs_GetWFSFeature_Title}.
	 * <p>${ogc_wfs_GetWFSFeature_Description}</p> 
	 * 
	 */	
	public class GetWFSFeature extends WFSServiceBase
	{
		private var GEOTYPE_POINT:String = "Point";
		private var GEOTYPE_LINE_STRING:String = "LineString";
		private var GEOTYPE_POLYGON:String = "Polygon";
		private var GEOTYPE_MULTI_POINT:String = "MultiPoint";
		private var GEOTYPE_MULTI_LINE_STRING:String = "MultiLineString";
		private var GEOTYPE_MULTI_POLYGON:String = "MultiPolygon";
		
		private var _maxFeatures:int;
		private var _featureDescriptions:Array;
		private var _featureIDs:Array;
		private var _filters:Array;
		
		private var _geometryName:String;
		
		
		/**
		 * ${ogc_wfs_GetWFSFeature_attribute_geometryName_D} 
		 * @return 
		 * 
		 */	
		public function get geometryName():String
		{
			return _geometryName;
		}

		public function set geometryName(value:String):void
		{
			_geometryName = value;
		}

		/**
		 * ${ogc_wfs_GetWFSFeature_attribute_filters_D} 
		 * @see Filter
		 * @see #featureIDs
		 * @return 
		 * 
		 */		
		public function get filters():Array
		{
			return _filters;
		}

		public function set filters(value:Array):void
		{
			_filters = value;
		}

		/**
		 * ${ogc_wfs_GetWFSFeature_constructor_string_D} 
		 * @param url ${ogc_wfs_GetWFSFeature_constructor_string_param_url}
		 * 
		 */		
		public function GetWFSFeature(url:String = null)
		{
			super();
			this.url = url;
		}
		
		/**
		 * ${ogc_wfs_GetWFSFeature_attribute_featureIDs_D} 
		 * @see #filters
		 * @return 
		 * 
		 */		
		public function get featureIDs():Array
		{
			return _featureIDs;
		}

		public function set featureIDs(value:Array):void
		{
			_featureIDs = value;
		}

		/**
		 * ${ogc_wfs_GetWFSFeature_method_featureDescriptions_D} 
		 * @return 
		 * 
		 */		
		public function get featureDescriptions():Array
		{
			return _featureDescriptions;
		}

		public function set featureDescriptions(value:Array):void
		{
			_featureDescriptions = value;
		}

		/**
		 * ${ogc_wfs_GetWFSFeature_method_maxFeatures_D}
		 * @return 
		 * 
		 */		
		public function get maxFeatures():int
		{
			return _maxFeatures;
		}

		public function set maxFeatures(value:int):void
		{
			_maxFeatures = value;
		}
		
		private function getFullPropertyName(layerType:WFSFeatureDescription):Array
		{
			var typeNames:Array = [];
			if(layerType.properties && layerType.properties.length)
			{
				var lpns:Array = layerType.properties;
				for each(var pn:String in lpns)　
				{
					typeNames.push(pn);
//					typeNames.push(layerType.typeName + "/" + pn);
				}
				if(layerType.spatialProperty)
					typeNames.push(layerType.spatialProperty);
//				typeNames.push(layerType.typeName + "/" + layerType.spatialProperty);
			}
			
			return typeNames;
		}

		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override protected function getFinalUrl():String
		{
			var gml:String = "http://www.opengis.net/gml";
			var ogc:String = "http://www.opengis.net/ogc";
			
			var extendUrl:String = "?SERVICE=WFS&VERSION=" + this.version + "&REQUEST=GetFeature";
			
			var typeNames:Array = [];
			var proNames:Array = [];
			
			if(_featureDescriptions && _featureDescriptions.length)
			{
				for each(var layerType:WFSFeatureDescription in _featureDescriptions)　
				{
					if(layerType)
					{
						typeNames.push(layerType.typeName);
						var tempProNames:Array = this.getFullPropertyName(layerType);
						if(tempProNames && tempProNames.length)
						{
							proNames.push("(" + tempProNames.join(",") +　")");
						}
					}
				}
				extendUrl += "&TYPENAME=" + typeNames.join(",");
			}
			
			if(this._maxFeatures > 0)
			{
				extendUrl += "&MAXFEATURES=" + this._maxFeatures;
			}
			
			if(proNames.length)
			{
				extendUrl += "&PROPERTYNAME=" + proNames.join("");  
			}
			
			if(this._filters && this._filters.length)
			{
				var filterStrs:Array = [];
				for each(var filter:Filter in _filters)　
				{
					var singleFilterValue:XML = filter.toXML();
					var rootXMLNode:XML = new XML("<Filter/>");
					var gmlNameSpace:Namespace = new Namespace("gml", gml);
//					var ogcNameSpace:Namespace = new Namespace("ogc", ogc);
					rootXMLNode.@xmlns = ogc;
					rootXMLNode.addNamespace(gmlNameSpace);
//					rootXMLNode.addNamespace(ogcNameSpace);
					if(singleFilterValue)
						rootXMLNode.appendChild(singleFilterValue);
					
					filterStrs.push(rootXMLNode.toXMLString());
					
				}
				
				var filterStr:String = "(" + filterStrs.join("") + ")";
				extendUrl += "&Filter=" + filterStr;
				
			}
			else
			{
				if(this._featureIDs && this._featureIDs.length)
				{
					extendUrl += "&FEATUREID=" + _featureIDs.join(",");  
				}
			}
			
			
			return this.url + extendUrl;
		}
		
		/**
		 * @inheritDoc 
		 * @param event
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
				
				var gfr:WFSFeatureResult = new WFSFeatureResult();
				for each(var item:XML in el)　
				{
					if(item.localName() == "boundedBy")
					{
						var bs:String = item.elements().elements().toString();
						if(bs)
						{
							var bvs:Array = bs.split(" ");
							if(bvs.length)
							{
								var lb:Array = bvs[0].toString().split(",");
								var rt:Array = bvs[1].toString().split(",");
							}
							gfr.setBounds(new Rectangle2D(lb[0],lb[1],rt[0],rt[1]));
						}
					}
					else if(item.localName() == "featureMember")
					{
						var firstNode:XMLList = item.elements();
						var typeName:String = firstNode.namespace().prefix + ":" + firstNode.localName(); // World:Captails
						
//						var spatialPropertyName:String;
//						
//						for each(var lt:WFSFeatureDescription in this._featureDescriptions)
//						{
//							if(lt.typeName == typeName)
//							{
//								if(lt.spatialProperty)
//									spatialPropertyName = lt.spatialProperty;
//								break;
//							}
//						}
//						
//						if(!spatialPropertyName)
//							spatialPropertyName = "the_geom";
						
//						var feature:Feature = this.getFeature(firstNode, spatialPropertyName);
						var feature:Feature = this.getFeature(firstNode);
						if(!(gfr.features[typeName]))
						{
							gfr.features[typeName] = [feature];
							
						}
						else
						{
							(gfr.features[typeName] as Array).push(feature);
						}
					}
				}
				
				
				var responder:IResponder;
				for each (responder in asyncToken.responders)
				{
					responder.result(gfr);
				}
				
				var fe:WFSFeatureEvent = new WFSFeatureEvent(WFSFeatureEvent.PROCESS_COMPLETE, gfr, event.result);
				this.dispatchEvent(fe);
				
			}
			
		}
		
		private function getFeature(item:XMLList):Feature//, spatialPropertyName:String
		{
			var feature:Feature = new Feature();
			var featureItem:XMLList = item.elements();
			var geoItem:XMLList;
			var proObject:Object = new Object();
			for each(var featurePro:XML in featureItem)　
			{
				var proName:String = featurePro.localName().toString();
				if( proName == "the_geom"||proName == "Shape"||proName == "GEOMETRY" || proName == this.geometryName)//proName != spatialPropertyName
				{
					geoItem = featurePro.elements();
					var geoTypeName:String = geoItem.localName();
					if(geoTypeName == this.GEOTYPE_POINT)
					{
						var pointStrArray:Array = geoItem.elements().toString().split(",");
						var geoPoint:GeoPoint = new GeoPoint(pointStrArray[0], pointStrArray[1]);
						feature.geometry = geoPoint;
						feature.style = new PredefinedMarkerStyle();
						
					}
					else if(geoTypeName == this.GEOTYPE_LINE_STRING)
					{
						this.parseLineString(geoItem, feature);
						feature.style = new PredefinedLineStyle();
					}
						
					else if(geoTypeName == this.GEOTYPE_POLYGON)
					{
						this.parsePolygon(geoItem, feature);
						feature.style = new PredefinedFillStyle();
						
					}
					else if(geoTypeName == this.GEOTYPE_MULTI_LINE_STRING)
					{
						this.parseMutiLineString(geoItem, feature);
						feature.style = new PredefinedLineStyle();
						
					}
					else if(geoTypeName == this.GEOTYPE_MULTI_POLYGON)
					{
						this.parseMutiPolygon(geoItem, feature);
						feature.style = new PredefinedFillStyle();
						
					}
					else if(geoTypeName == this.GEOTYPE_MULTI_POINT)
					{
					}
				}
				else
				{
					proObject[proName] =  featurePro.toString();
				}
			}
			feature.attributes = proObject;
			return feature;
			
		}
		
		private function parseLineString(geoItem:XMLList, feature:Feature):void
		{
			var pointStrArray:Array = geoItem.elements().toString().split(" ");
			var psal:int = pointStrArray.length;
			
			var geoPoints:Array = [];
			for(var i:int = 0; i < psal; i++)
			{
				var singlePoint:Array = pointStrArray[i].toString().split(",");
				var geoPoint:Point2D = new Point2D(singlePoint[0], singlePoint[1]);
				geoPoints.push(geoPoint);
			}
			
			var geoLine:GeoLine = new GeoLine();
			geoLine.addPart(geoPoints);
			
			feature.geometry = geoLine;
			
		}
		
		private function parsePolygon(geoItem:XMLList, feature:Feature):void
		{
			var pointStrArray:Array = geoItem.elements().elements().elements().toString().split(" ");
			var psal:int = pointStrArray.length;
			
			var geoPoints:Array = [];
			for(var i:int = 0; i < psal; i++)
			{
				var singlePoint:Array = pointStrArray[i].toString().split(",");
				var geoPoint:Point2D = new Point2D(singlePoint[0], singlePoint[1]);
				geoPoints.push(geoPoint);
			}
			
			var geoRegion:GeoRegion = new GeoRegion();
			geoRegion.addPart(geoPoints);
			
			feature.geometry = geoRegion;
			
		}
		
		
		private function parseMutiLineString(geoItem:XMLList, feature:Feature):void
		{
			var lineMembers:XMLList = geoItem.elements();
			
			var geoLine:GeoLine = new GeoLine();
			for each(var lineMemberItem:XML in lineMembers)　
			{
				var pointStrArray:Array = lineMemberItem.elements().elements().toString().split(" ");
				var psal:int = pointStrArray.length;
				
				var geoPoints:Array = [];
				for(var i:int = 0; i < psal; i++)
				{
					var singlePoint:Array = pointStrArray[i].toString().split(",");
					var geoPoint:Point2D = new Point2D(singlePoint[0], singlePoint[1]);
					geoPoints.push(geoPoint);
				}
				geoLine.addPart(geoPoints);
			}
			
			feature.geometry = geoLine;
			
		}
		
		private function parseMutiPolygon(geoItem:XMLList, feature:Feature):void
		{
			var polygonMembers:XMLList = geoItem.elements();
			
			var geoRegion:GeoRegion = new GeoRegion();
			
			for each(var polygonMemberItem:XML in polygonMembers)　
			{
				var xmlEles:XMLList = polygonMemberItem.elements().elements().elements().elements();
				for each(var xmlEle:XML in xmlEles)
				{//对于有innerBounds的Polygon，将innerBounds处理为GeoRegion的一个或多个parts
					var pointStrArray:Array = xmlEle.toString().split(" ");
					var psal:int = pointStrArray.length;
					
					var geoPoints:Array = [];
					for(var i:int = 0; i < psal; i++)
					{
						var singlePoint:Array = pointStrArray[i].toString().split(",");
						var geoPoint:Point2D = new Point2D(singlePoint[0], singlePoint[1]);
						geoPoints.push(geoPoint);
					}
					geoRegion.addPart(geoPoints);
				}	
			}
			feature.geometry = geoRegion;
		}
		
	}
}