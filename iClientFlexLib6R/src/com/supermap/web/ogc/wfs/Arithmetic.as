package com.supermap.web.ogc.wfs
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${ogc_wfs_Arithmetic_Title}.
	 * <p>${ogc_wfs_Arithmetic_Description}</p> 
	 * @see GetWFSFeature
	 * 
	 */	
	public class Arithmetic extends Filter
	{
		private var _type:String;
		private var _propertyNames:Array;
		private var _value:String;
		private var _expressions:Array;
		
		/**
		 * ${ogc_wfs_Arithmetic_constructor_string_D} 
		 * 
		 */		
		public function Arithmetic()
		{
			super();
		}
		
		/**
		 * ${ogc_wfs_Arithmetic_attribute_expressions_D} 
		 * @return 
		 * 
		 */		
		public function get expressions():Array
		{
			return _expressions;
		}
		
		public function set expressions(value:Array):void
		{
			_expressions = value;
		}
		
		/**
		 * ${ogc_wfs_Arithmetic_attribute_value_D} 
		 * @return 
		 * 
		 */		
		public function get value():String
		{
			return _value;
		}
		
		public function set value(value:String):void
		{
			_value = value;
		}
		
		/**
		 * ${ogc_wfs_Arithmetic_attribute_type_D} 
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
		 * ${ogc_wfs_Arithmetic_attribute_propertyNames_D} 
		 * @return 
		 * 
		 */		
		public function get propertyNames():Array
		{
			return _propertyNames;
		}
		
		public function set propertyNames(value:Array):void
		{
			_propertyNames = value;
		}
		
		override sm_internal function toXML():XML
		{
			var xmlNode:XML = new XML("<" + this._type +">" + "</" + this._type + ">");
			if(this._propertyNames && this._propertyNames.length > 1)
			{
				var pl:int = this._propertyNames.length;
				for(var i:int = 0; i < pl; i++)
				{
					if(i > 1)
						break;
					var subXMLNode0:XML = new XML("<PropertyName>" + this._propertyNames[i] + "</PropertyName>");
					xmlNode.appendChild(subXMLNode0);
				}
				return xmlNode;
			}
			else if(this._propertyNames && this._propertyNames.length == 1)
			{
				var subXMLNode1:XML = new XML("<PropertyName>" + this._propertyNames[0] + "</PropertyName>");
				xmlNode.appendChild(subXMLNode1);
				if(this._expressions && this._expressions.length)
				{
					var subXMLNode2:XML = this._expressions[0].toXML();
					if(subXMLNode2)
						xmlNode.appendChild(subXMLNode2);
				}
				else
				{
					var subXMLNode3:XML = new XML("<Literal>" + this._value + "</Literal>");
					xmlNode.appendChild(subXMLNode3);
				}
				return xmlNode;
			}
			else
			{
				if(this._expressions && this._expressions.length > 1)
				{
					var el:int = this._expressions.length;
					for(var i1:int = 0; i1 < el; i1++)
					{
						if(i1 > 1)
							break;
						
						var subXMLNode4:XML = this._expressions[i1].toXML();
						if(subXMLNode4)
							xmlNode.appendChild(subXMLNode4);
						
					}
				}
				else if(this._expressions && this._expressions.length == 1)
				{
					var subXMLNode5:XML = this._expressions[0].toXML();
					if(subXMLNode5)
						xmlNode.appendChild(subXMLNode5);
					xmlNode.appendChild(new XML("<Literal>" + this._value + "</Literal>"));
				}
				else
				{
					return new XML("<Literal>" + this._value + "</Literal>");
				}
				
				return xmlNode;
			}
			
			return null;
			
		}

	}
}