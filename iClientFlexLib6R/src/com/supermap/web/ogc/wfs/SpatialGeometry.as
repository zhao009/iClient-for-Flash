package com.supermap.web.ogc.wfs
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.GeoPoint;

	/**
	 * ${ogc_wfs_SpatialGeometry_Title}.
	 * <p>${ogc_wfs_SpatialGeometry_Description}</p> 
	 * @see GetWFSFeature#filters
	 * @see SpatialType#BBOX
	 * @see Spatial#type
	 * 
	 */	
	public class SpatialGeometry extends Spatial
	{
		private var _value:Geometry;
		
		private var _distance:Number;
		
		/**
		 * ${ogc_wfs_SpatialGeometry_constructor_string_D} 
		 * 
		 */		
		public function SpatialGeometry()
		{
			super();
		}
		
		/**
		 * ${ogc_wfs_SpatialGeometry_attribute_distance_D} 
		 * @return 
		 * 
		 */		
		public function get distance():Number
		{
			return _distance;
		}

		public function set distance(value:Number):void
		{
			_distance = value;
		}

		/**
		 * ${ogc_wfs_SpatialGeometry_attribute_value_D} 
		 * @return 
		 * 
		 */		
		public function get value():Geometry
		{
			return _value;
		}

		public function set value(value:Geometry):void
		{
			_value = value;
		}
		
		override sm_internal function toXML():XML
		{
			if(this.type)
			{
				var ogcNamespace:Namespace = new Namespace("ogc", "http://www.opengis.net/ogc");
				
				var xmlNode:XML = new XML("<" + this.type +">" + "</" + this.type + ">");
				xmlNode.setNamespace(ogcNamespace);
				
				var propertyXml:XML = new XML("<PropertyName>" + this.propertyName + "</PropertyName>");
				propertyXml.setNamespace(ogcNamespace);
				xmlNode.appendChild(propertyXml);
				
				xmlNode.appendChild(getValueXml());
				if(this.type == SpatialType.BEYOND || this.type == SpatialType.DWITHIN)
				{
					var distanceXMLNode:XML = new XML("<Distance>" + this._distance + "</Distance>");
					distanceXMLNode.setNamespace(ogcNamespace);
					xmlNode.appendChild(distanceXMLNode);
				}
				
				return xmlNode;
			}
			else
			{
				return getValueXml();
			}
		}
		
		private function getValueXml():XML
		{
			if(this._value)
			{
				var gml:String = "http://www.opengis.net/gml";
				var gmlNamespace:Namespace = new Namespace("gml", gml);
				
				if(this._value is GeoPoint)
				{
					var geoPoint:GeoPoint = this._value as GeoPoint;
					var coorStr:String = this.GetSinglePointStr(new Point2D(geoPoint.x, geoPoint.y));
					var coorXMLNode:XML = new XML("<coordinates>" + coorStr + "</coordinates>");
					coorXMLNode.setNamespace(gmlNamespace);
					
					var pointXMLNode:XML = new XML("<Point/>");
					pointXMLNode.appendChild(coorXMLNode);
					
					pointXMLNode.setNamespace(gmlNamespace);
					return pointXMLNode;
				}
				else if(this._value is GeoLine)
				{
					var geoLine:GeoLine = this._value as GeoLine;
					var lineStrNodes:Array = [];
					for each(var p:Array in geoLine.parts)
					{
						var coorStr2:String = this.GetPointsStr(p);
						var coorXMLNode2:XML = new XML("<coordinates>" + coorStr2 + "</coordinates>");
						coorXMLNode2.setNamespace(gmlNamespace);
						
						var lineStrXMLNode:XML = new XML("<LineString/>");
						lineStrXMLNode.appendChild(coorXMLNode2);
						lineStrXMLNode.setNamespace(gmlNamespace);
						
						var lineStringMemberNode:XML = new XML("<lineStringMember/>");
						lineStringMemberNode.appendChild(lineStrXMLNode);
						lineStringMemberNode.setNamespace(gmlNamespace);
						
						lineStrNodes.push(lineStringMemberNode);
					}
					var mutiLineStringNode:XML = new XML("<MultiLineString>" + lineStrNodes.toString() + "</MultiLineString>");
					mutiLineStringNode.setNamespace(gmlNamespace);
					
					return mutiLineStringNode;
				}
				else if(this._value is GeoRegion)
				{
					var geoRegion:GeoRegion = this._value as GeoRegion;
					var polygonNodes:Array = [];
					for each(var p3:Array in geoRegion.parts)
					{
						var coorStr3:String = this.GetPointsStr(p3);
						var coorXMLNode3:XML = new XML("<coordinates>" + coorStr3 + "</coordinates>");
						coorXMLNode3.setNamespace(gmlNamespace);
						
						var linearRingXMLNode:XML = new XML("<LinearRing/>");
						linearRingXMLNode.appendChild(coorXMLNode3);
						linearRingXMLNode.setNamespace(gmlNamespace);
						
						var outBoundaryXMLNode:XML = new XML("<outerBoundaryIs/>");
						outBoundaryXMLNode.appendChild(linearRingXMLNode);
						outBoundaryXMLNode.setNamespace(gmlNamespace);
						
						var polygonXMLNode:XML = new XML("<Polygon/>");
						polygonXMLNode.appendChild(outBoundaryXMLNode);
						polygonXMLNode.setNamespace(gmlNamespace);
						
						var polygonMemberNode:XML = new XML("<polygonMember/>")
						polygonMemberNode.appendChild(polygonXMLNode);
						polygonMemberNode.setNamespace(gmlNamespace);
						
						polygonNodes.push(polygonMemberNode);
					}
					
					var mutiPolygonNode:XML = new XML("<MultiPolygon>" + polygonNodes.toString() + "</MultiPolygon>")
					mutiPolygonNode.setNamespace(gmlNamespace);
					return mutiPolygonNode;
				}
			}
			return null;
		}
	}
}