package com.supermap.web.ogc.wfs
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${ogc_wfs_Logical_Title}.
	 * <p>${ogc_wfs_Logical_Description}</p> 
	 * @see GetWFSFeature
	 * @see #filters
	 * 
	 */	
	public class Logical extends Filter
	{
		private var _filters:Array;
		private var _type:String;
		/**
		 * ${ogc_wfs_Logical_constructor_string_D} 
		 * 
		 */		
		public function Logical()
		{
			super();
		}
		/**
		 * ${ogc_wfs_Logical_attribute_type_D}
		 * @see LogicalType 
		 * @return 
		 * 
		 */		
		public function get type():String
		{
			return _type;
		}

		public function set type(value:String):void
		{
			_type = value;
		}

		/**
		 * ${ogc_wfs_Logical_attribute_filters_D}.
		 * <p>${ogc_wfs_Logical_attribute_filters_remarks}</p> 
		 * @see Filter
		 * @see Arithmetic
		 * @see Comparison
		 * @see Logical
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
		
		override sm_internal function toXML():XML
		{
			if(this._filters)
			{
				var xmlNode:XML = new XML("<" + this._type +">" + "</" + this._type + ">");
				
				if((this._type == LogicalType.AND) || (this._type == LogicalType.OR))
				{
					if(this._filters.length > 1)
					{
						for(var i:int = 0; i < this._filters.length; i++)
						{
							if(i > 1)
								break;
							var subXMLNode:XML = (this._filters[i] as Filter).toXML();
							if(subXMLNode)
							{
								xmlNode.appendChild(subXMLNode);
							}
						}
					}
				}
				else if(this._type == LogicalType.NOT)
				{
					for(var i0:int = 0; i0 < this._filters.length; i0++)
					{
						var subXMLNode0:XML = (this._filters[i0] as Filter).toXML();
						if(subXMLNode0)
						{
							xmlNode.appendChild(subXMLNode0);
							break;
						}
					}
				}
				return xmlNode;
			}
			return null;
		}

	}
}