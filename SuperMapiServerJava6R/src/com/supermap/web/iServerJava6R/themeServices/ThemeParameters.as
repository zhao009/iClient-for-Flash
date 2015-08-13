package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.iServerJava6R.queryServices.JoinItem;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	/**
	 * ${iServer6R_themeServices_ThemeParameters_Title}.
	 * <p>${iServer6R_themeServices_ThemeParameters_Description}</p> 
	 * 
	 */	
	public class ThemeParameters
	{
		private var _themes:Array;
		private var _dataSourceNames:Array;
		private var _datasetNames:Array;
		private var _joinItems:Array;
		private var _displayFilters:Array;
		
		/**
		 * ${iServer6R_themeServices_ThemeParameters_constructor_D} 
		 * 
		 */		
		public function ThemeParameters()
		{
		}

		/**
		 * ${iServer6R_themeServices_ThemeParameters_attribute_displayFilters_D}
		 * @see #themes 
		 * @return 
		 * 
		 */		
		public function get displayFilters():Array
		{
			return _displayFilters;
		}

		public function set displayFilters(value:Array):void
		{
			_displayFilters = value;
		}

		/**
		 * ${iServer6R_themeServices_ThemeParameters_attribute_dataSourceNames_D}.
		 * <p>${iServer6R_themeServices_ThemeParameters_attribute_dataSourceNames_remarks}</p> 
		 * @see #themes
		 * @return 
		 * 
		 */	
		public function get dataSourceNames():Array
		{
			return _dataSourceNames;
		}

		public function set dataSourceNames(value:Array):void
		{
			_dataSourceNames = value;
		}

		/**
		 * ${iServer6R_themeServices_ThemeParameters_attribute_datasetNames_D}.
		 * <p>${iServer6R_themeServices_ThemeParameters_attribute_datasetNames_remarks}</p> 
		 * @see #themes
		 * @return 
		 * 
		 */
		public function get datasetNames():Array
		{
			return _datasetNames;
		}

		public function set datasetNames(value:Array):void
		{
			_datasetNames = value;
		}

		/**
		 * ${iServer6R_themeServices_ThemeParameters_attribute_joinItems_D} 
		 * @see com.supermap.web.iServerJava6R.queryServices.JoinItem
		 * @return 
		 * 
		 */		
		public function get joinItems():Array
		{
			return _joinItems;
		}

		public function set joinItems(value:Array):void
		{
			_joinItems = value;
		}
				
		/**
		 * ${iServer6R_themeServices_ThemeParameters_attribute_themes_D} 
		 * @return 
		 * 
		 */		
		public function get themes():Array
		{
			return _themes;
		}

		public function set themes(value:Array):void
		{
			_themes = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String ="{";			
			json += "\"layers\":[";
			if (this.themes != null && this.themes.length > 0)
			{
				for (var i:int = 0; i<this.themes.length; i++)
				{
					var item:Theme = this.themes[i];
					if(item is ThemeLabel)
					{
						var themeLabel:ThemeLabel = item as ThemeLabel;
						json += "{" + "\"theme\":" + themeLabel.toJSON() + ",";
					}	
					else if(item is ThemeUnique)
					{
						var themeunique:ThemeUnique = item as ThemeUnique;
						json += "{" + "\"theme\":" + themeunique.toJSON() + ",";
					}
					else if(item is ThemeGridUnique)
					{
						var themeGridUnique:ThemeGridUnique = item as ThemeGridUnique;
						json += "{" + "\"theme\":" + themeGridUnique.toJSON() + ",";
					}
					else if(item is ThemeDotDensity)
					{
						var themeDotDensity:ThemeDotDensity = item as ThemeDotDensity;
						json += "{" + "\"theme\":" + themeDotDensity.toJSON() + ",";
					}
					else if(item is ThemeGraduatedSymbol)
					{
						var themeGraduatedSymbol:ThemeGraduatedSymbol = item as ThemeGraduatedSymbol;
						json += "{" + "\"theme\":" + themeGraduatedSymbol.toJSON() + ",";
					}
					else if(item is ThemeRange)
					{
						var themeRange:ThemeRange = item as ThemeRange;
						json += "{" + "\"theme\":" + themeRange.toJSON() + ",";
					}
					else if(item is ThemeGridRange)
					{
						var themeGridRange:ThemeGridRange = item as ThemeGridRange;
						json += "{" + "\"theme\":" + themeGridRange.toJSON()+",";
					}
					else if(item is ThemeGraph)
					{
						var themeGraph:ThemeGraph = item as ThemeGraph;
						json += "{" + "\"theme\":" + themeGraph.toJSON() + ",";
					}
					
					json += "\"type\":" + "\"UGC\""  + ",";
					json += "\"ugcLayerType\":" + "\"THEME\"" + ",";
					
					if(this.displayFilters && this.displayFilters.length > 0)
					{
						if(this.displayFilters.length == 1)
							json += "\"displayFilter\":" + "\"" + this.displayFilters[0]+"\"" + ",";
						else
						{
							if(this.displayFilters[i])
								json += "\"displayFilter\":" + "\"" + this.displayFilters[i]+"\"" + ",";
						}
					}
					else
						json += "\"displayFilter\":" + "\"" +"\"" + ",";

					json += "\"datasetInfo\":" + "{";
					
					//数据集
					if(this.datasetNames && this.datasetNames.length > 0)
					{
						if(this.datasetNames.length == 1)
							json += "\"name\":" + "\"" + this.datasetNames+"\"" + ",";
						else
						{
							if(this.datasetNames[i])
								json += "\"name\":" + "\"" + this.datasetNames[i]+"\"" + ",";
							//存在但length为0
							/*else
								json += "\"name\":" + "\"" + ""+"\"" + ",";*/
						}
					}
					else
						json += "\"name\":" + "\"" + ""+"\"" + ",";
					
					
					//数据源
					if(this.dataSourceNames && this.dataSourceNames.length > 0)
					{
						if(this.dataSourceNames.length == 1)
							json += "\"dataSourceName\":" + "\"" + this.dataSourceNames + "\"" + "}";
						else
						{
							if(this.dataSourceNames[i])
								json += "\"dataSourceName\":" + "\"" + this.dataSourceNames[i] + "\"" + "}";
							//存在但length为0
							/*else
								json += "\"dataSourceName\":" + "\"" + "" + "\"" + "},";*/
						}
					}
					else
						json += "\"dataSourceName\":" + "\"" + "" + "\"" + "}";
					
					//外部关联表
					if(this.joinItems)
					{
						if(this.joinItems.length > 0)
						{
							if(this.joinItems[i])
							{
								var tempJoinItems:Array = this.joinItems[i];
								if(tempJoinItems.length > 0)
								{
									var tempItems:Array = new Array();
									var itemLength:int = tempJoinItems.length;
									json += ",";
									for(var j:int = 0; j < itemLength; j++)
									{
										tempItems.push(JoinItem.toJson(tempJoinItems[j]));
									}
									json += "\"joinItems\":" + "[" + tempItems.join(",") + "]";
								}
							}
						}
					}
					//最后一个末尾就不要加逗号了
					if(i==this.themes.length-1)
					{
						json += "}";
					}
					else
					{
						json += "},";
					}
				}
			}	
		    json += "]";
			json += "}";
			
			return json;
		}

	}
}