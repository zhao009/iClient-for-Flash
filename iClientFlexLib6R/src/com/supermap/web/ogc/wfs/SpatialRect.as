package com.supermap.web.ogc.wfs
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	
	/**
	 * ${ogc_wfs_SpatialRect_Title}.
	 * <p>${ogc_wfs_SpatialRect_Description}</p> 
	 * @see GetWFSFeature#filters
	 * @see SpatialType#BBOX
	 * @see #type
	 */	
	public class SpatialRect extends Spatial
	{
		private var _value:Rectangle2D;
		
		/**
		 * ${ogc_wfs_SpatialRect_constructor_string_D} 
		 * 
		 */			
		public function SpatialRect()
		{
			super();
		}
		
		/**
		 * ${ogc_wfs_SpatialRect_attribute_value_D} 
		 * @return 
		 * 
		 */		
		public function get value():Rectangle2D
		{
			return _value;
		}

		public function set value(value:Rectangle2D):void
		{
			_value = value;
		}

		override sm_internal function toXML():XML
		{
			if(this.type)
			{
				var gml:String = "http://www.opengis.net/gml";
				var gmlNamespace:Namespace = new Namespace("gml", gml);
				var xmlNode:XML = new XML("<" + this.type +">" + "</" + this.type + ">");
				xmlNode.appendChild(new XML("<PropertyName>" + this.propertyName + "</PropertyName>"));
				var coorStr:String = null;
				if(this._value)
				{
					coorStr = this.GetPointPairStr(this._value.bottomLeft, this._value.topRight);
				}
				var coorXMLNode:XML = new XML("<coordinates>" + coorStr + "</coordinates>");
				coorXMLNode.setNamespace(gmlNamespace);
				
				var boxXMLNode:XML = new XML("<Box/>");
				boxXMLNode.appendChild(coorXMLNode);
				
				boxXMLNode.setNamespace(gmlNamespace);
				
				xmlNode.appendChild(boxXMLNode);
				
				return xmlNode;
			}
			return null;
		}
	}
}