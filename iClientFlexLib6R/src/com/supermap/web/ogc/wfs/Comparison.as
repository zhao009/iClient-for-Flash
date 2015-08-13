package com.supermap.web.ogc.wfs
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	/**
	 * ${ogc_wfs_Comparison_Title}.
	 * <p>${ogc_wfs_Comparison_Description}</p>
	 * @see GetWFSFeature#filters 
	 * 
	 */	
	public class Comparison extends Filter
	{
		private var _type:String;
		private var _propertyNames:Array;
		private var _value:String;
		private var _expressions:Array;
		
		/**
		 * ${ogc_wfs_Comparison_constructor_string_D} 
		 * 
		 */		
		public function Comparison()
		{
			super();
		}
		
		/**
		 * ${ogc_wfs_Comparison_attribute_expressions_D} 
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
		 * ${ogc_wfs_Comparison_attribute_value_D} 
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
		 * ${ogc_wfs_Comparison_attribute_propertyNames_D} 
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

		/**
		 * ${ogc_wfs_Comparison_attribute_type_D} 
		 * @see ComparisonType
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
		
		override sm_internal function toXML():XML
		{
			var ogcNamespace:Namespace = new Namespace("ogc", "http://www.opengis.net/ogc");
			var xmlNode:XML = new XML("<" + this._type +">" + "</" + this._type + ">");
			xmlNode.setNamespace(ogcNamespace);
			switch(this._type)
			{
				case ComparisonType.EQUAL_TO:
				case ComparisonType.NOT_EQUAL_TO:
				case ComparisonType.LESS_THAN:
				case ComparisonType.GREATER_THAN:
				case ComparisonType.LESS_THAN_OR_EQUAL_TO:
				case ComparisonType.GREATER_THAN_OR_EQUAL_TO:
				{
					if(this._propertyNames && this._propertyNames.length > 1)
					{
						var pl:int = this._propertyNames.length;
						for(var i:int = 0; i < pl; i++)
						{
							if(i > 1)
								break;
							var subXMLNode0:XML = new XML("<PropertyName>" + this._propertyNames[i] + "</PropertyName>");
							subXMLNode0.setNamespace(ogcNamespace);
							xmlNode.appendChild(subXMLNode0);
						}
						return xmlNode;
					}
					else if(this._propertyNames && this._propertyNames.length == 1)
					{
						var subXMLNode1:XML = new XML("<PropertyName>" + this._propertyNames[0] + "</PropertyName>");
						subXMLNode1.setNamespace(ogcNamespace);
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
							subXMLNode3.setNamespace(ogcNamespace);
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
							var subXMLNode6:XML = new XML("<Literal>" + this._value + "</Literal>");
							subXMLNode6.setNamespace(ogcNamespace);
							xmlNode.appendChild(subXMLNode6);
						}
						return xmlNode;
					}
					
					break;
				}
				case ComparisonType.LIKE:
				{
					xmlNode.@wildCard = "*";
					xmlNode.@singleChar = ".";
					xmlNode.@escape = "!";
					
					if(this._propertyNames && this._propertyNames.length)
					{
						var subXMLProperty:XML = new XML("<PropertyName>" + this._propertyNames[0] + "</PropertyName>");
						subXMLProperty.setNamespace(ogcNamespace);
						var subXMLLiteral:XML = new XML("<Literal>" + this._value + "</Literal>");
						subXMLLiteral.setNamespace(ogcNamespace);
						xmlNode.appendChild(subXMLProperty);
						xmlNode.appendChild(subXMLLiteral);
						return xmlNode;
					}
					break;
				}
				case ComparisonType.NULL:
				{
					if(this._propertyNames && this._propertyNames.length)
					{
						var subXML:XML = new XML("<PropertyName>" + this._propertyNames[0] + "</PropertyName>");
						subXML.setNamespace(ogcNamespace);
						xmlNode.appendChild(subXML);
						return xmlNode;
					}
					break;
				}
				case ComparisonType.BETWEEN:
				{
					if(this._propertyNames && this._propertyNames.length)
					{
						if(this._expressions && this._expressions.length)
						{
							var lower:XML = new XML("<LowerBoundary/>");
							lower.setNamespace(ogcNamespace);
							var exp1:XML = this._expressions[0].toXML();
							if(exp1)
							{
								lower.appendChild(exp1);
							}
							else
								return null;
							
							var upper:XML = new XML("<UpperBoundary/>");
							upper.setNamespace(ogcNamespace);
							var exp2:XML = this._expressions[1].toXML();
							if(exp2)
							{
								upper.appendChild(exp2);
							}
							else
								return null;
							
							xmlNode.appendChild(lower);
							xmlNode.appendChild(upper);
						}
//						xmlNode.appendChild(new XML("<Property>11</Property>"));
						var propertyNameXml:XML = new XML("<PropertyName>" + this._propertyNames[0] + "</PropertyName>");
						propertyNameXml.setNamespace(ogcNamespace);
						xmlNode.appendChild(propertyNameXml);

						return xmlNode;
					}
					else if((!this._propertyNames) || (this._propertyNames && this._propertyNames.length == 0))
					{
						if(this._expressions && this._expressions.length > 2)
						{
							var exp21:XML = this._expressions[0].toXML();
							if(exp21)
							{
								xmlNode.appendChild(exp21);
							}
							else
								return null;
							
							
							var lower2:XML = new XML("<LowerBoundary/>");
							lower2.setNamespace(ogcNamespace);
							var exp22:XML = this._expressions[1].toXML();
							if(exp22)
							{
								lower2.appendChild(exp22);
							}
							else
								return null;
							
							var upper2:XML = new XML("<UpperBoundary/>");
							upper2.setNamespace(ogcNamespace);
							var exp23:XML = this._expressions[2].toXML();
							if(exp23)
							{
								upper2.appendChild(exp23);
							}
							else
								return null;
							
							xmlNode.appendChild(lower2);
							xmlNode.appendChild(upper2);
						}
						
						return xmlNode;
					}
					break;
				}
			}
			
			return null;
		}

	}
}