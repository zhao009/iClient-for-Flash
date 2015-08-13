package com.supermap.web.iServerJava6R.layerServices
{ 
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.iServerJava6R.queryServices.JoinItem;
	import com.supermap.web.utils.serverTypes.ServerColor;
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.iServerJava6R.themeServices.ThemeDotDensity;
	import com.supermap.web.iServerJava6R.themeServices.ThemeGraduatedSymbol;
	import com.supermap.web.iServerJava6R.themeServices.ThemeGraph;
	import com.supermap.web.iServerJava6R.themeServices.ThemeLabel;
	import com.supermap.web.iServerJava6R.themeServices.ThemeRange;
	import com.supermap.web.iServerJava6R.themeServices.ThemeUnique;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	use namespace sm_internal;
	/**
	 * ${iServerJava6R_ServerLayer_Title}.
	 * <p>${iServerJava6R_ServerLayer_Description}</p> 
	 * 
	 */	
	public class ServerLayer
	{ 
		private var _bounds:Rectangle2D;
		private var _caption:String;
		private var _name:String;
		private var _description:String;
		private var _isQueryable:Boolean; 
		 
		private var _isVisible:Boolean; 
		private var _isCompleteLineSymbolDisplayed:Boolean;
		private var _maxScale:Number;
		private var _minScale:Number;
		private var _minVisibleGeometrySize:Number;
		 
		private var _opaqueRate:Number;  
		private var _isSymbolScalable:Boolean;
		private var _symbolScale:Number; 
		private var _datasetInfo:DatasetInfo;
		private var _displayFilter:String;
		 
		private var _joinItmes:Array; 
		private var _representationField:String;
		private var _ugcLayerType:String;
		private var _ugcLayer:UGCLayer;//这个属性需要由jsonObject组装
		
		/**
		 * ${iServerJava6R_ServerLayer_constructor_D} 
		 * 
		 */		
		public function ServerLayer()
		{
		}
		
		/**
		 * ${iServerJava6R_ServerLayer_attribute_UGCLayer_D} 
		 * @return 
		 * 
		 */		
		public function get ugcLayer():UGCLayer
		{
			return _ugcLayer;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_UGCLayerType_D} 
		 * @return 
		 * 
		 */		
		public function get ugcLayerType():String
		{
			return _ugcLayerType;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_RepresentationField_D} 
		 * @return 
		 * 
		 */		
		public function get representationField():String
		{
			return _representationField;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_JoinItems_D} 
		 * @return 
		 * 
		 */		
		public function get joinItmes():Array
		{
			return _joinItmes;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_DisplayFilter_D}.
		 * <p>${iServerJava6R_ServerLayer_attribute_DisplayFilter_remarks}</p>
		 * @return 
		 * 
		 */		
		public function get displayFilter():String
		{
			return _displayFilter;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_DatasetInfo_D} 
		 * @return 
		 * 
		 */		
		public function get datasetInfo():DatasetInfo
		{
			return _datasetInfo;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_SymbolScale_D} 
		 * @see isSymbolScalable
		 * @return 
		 * 
		 */		
		public function get symbolScale():Number
		{
			return _symbolScale;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_IsSymbolScalable_D} 
		 * @return 
		 * 
		 */		
		public function get isSymbolScalable():Boolean
		{
			return _isSymbolScalable;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_OpaqueRate_D} 
		 * @return 
		 * 
		 */		
		public function get opaqueRate():Number
		{
			return _opaqueRate;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_MinVisibleGeometrySize_D} 
		 * @return 
		 * 
		 */		
		public function get minVisibleGeometrySize():Number
		{
			return _minVisibleGeometrySize;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_minScale_D} 
		 * @return 
		 * 
		 */		
		public function get minScale():Number
		{
			return _minScale;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_MaxScale_D} 
		 * @return 
		 * 
		 */		
		public function get maxScale():Number
		{
			return _maxScale;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_IsCompleteLineSymbolDisplayed_D} 
		 * @return 
		 * 
		 */		
		public function get isCompleteLineSymbolDisplayed():Boolean
		{
			return _isCompleteLineSymbolDisplayed;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_IsVisible_D} 
		 * @return 
		 * 
		 */		
		public function get isVisible():Boolean
		{
			return _isVisible;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_IsQueryable_D} 
		 * @return 
		 * 
		 */		
		public function get isQueryable():Boolean
		{
			return _isQueryable;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_Description_D}
		 * @return 
		 * 
		 */		
		public function get description():String
		{
			return _description;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_Name_D}.
		 * <p>${iServerJava6R_ServerLayer_attribute_Name_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get name():String
		{
			return _name;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_caption_D}.
		 * <p>${iServerJava6R_ServerLayer_attribute_caption_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get caption():String
		{
			return _caption;
		}
 
		/**
		 * ${iServerJava6R_ServerLayer_attribute_Bounds_D} 
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}
 
		sm_internal static function toServerLayer(json:Object):ServerLayer
		{
			var layer:ServerLayer;
			if(json)
			{
				layer = new ServerLayer();
				
				if(json.caption)
				{
					layer._caption = json.caption;
				}
			    if(json.visible)
				{
					layer._isVisible = json.visible;
				}
				if(json.symbolScalable)
				{
					layer._isSymbolScalable = json.symbolScalable;
				}
				if(json.symbolScale)
				{
					layer._symbolScale = json.symbolScale;
				}
				if(json.representationField)
				{
					layer._representationField = json.representationField;
				}
				if(json.ugcLayerType)
				{
					layer._ugcLayerType = json.ugcLayerType;
				}
				if(json.completeLineSymbolDisplayed)
				{
					layer._isCompleteLineSymbolDisplayed = json.completeLineSymbolDisplayed;
				}
				if(json.opaqueRate)
				{
					layer._opaqueRate = json.opaqueRate;
				}
				if(json.bounds)
				{
					layer._bounds = JsonUtil.toRectangle2D(json.bounds);
				} 
				
				if(json.minScale)
				{
					layer._minScale = json.minScale; 
				}
				if(json.displayFilter)
				{
					layer._displayFilter = json.displayFilter;
				}
				if(json.description)
				{
					layer._description = json.description;
				}
				if(json.name)
				{
					layer._name = json.name;
				}
				
				if(json.datasetInfo)
				{
					layer._datasetInfo = DatasetInfo.fromJson(json.datasetInfo);
				}
				if(json.minVisibleGeometrySize)
				{
					layer._minVisibleGeometrySize = json.minVisibleGeometrySize;
				}
				if(json.maxScale)
				{
					layer._maxScale = json.maxScale;
				}
				if(json.queryable)
				{
					layer._isQueryable = json.queryable; 
				}
				if(json.joinItmes)
				{
					var joinItems:Array = new Array();
					for each(var item:Object in json.joinItmes)
					{ 
						joinItems.push(JoinItem.fromJson(item));
					}
					layer._joinItmes = joinItems;
				}
				
				if(json.ugcLayerType == SuperMapLayerType.GRID)
				{
					var ugcGridLayer:UGCGridLayer = new UGCGridLayer();
					var colors:Array = new Array();
					for each(var colorItem:Object in json.colors)
					{
						colors.push(ServerColor.fromJson(colorItem));
					}
					ugcGridLayer.colors = colors;
					
					if(json.dashStyle)
					{
						ugcGridLayer.dashStyle = ServerStyle.fromJson(json.dashStyle);
					}
					if(json.gridType)
					{
						ugcGridLayer.gridType = json.gridType;
					} 
					
					ugcGridLayer.horizontalSpacing = json.horizontalSpacing;
					ugcGridLayer.sizeFixed = json.sizeFixed;
					
					if(json.solidStyle)
					{
						ugcGridLayer.solidStyle = ServerStyle.fromJson(json.solidStyle);
					}
					if(json.specialColor)
					{
						ugcGridLayer.specialColor = ServerColor.fromJson(json.specialColor);
					}
					ugcGridLayer.specialValue = json.specialValue;
					ugcGridLayer.verticalSpacing = json.verticalSpacing;
					layer._ugcLayer = ugcGridLayer;
				}
					
				else if(json.ugcLayerType == SuperMapLayerType.IMAGE)
				{
					var ugcImageLayer:UGCImageLayer = new UGCImageLayer();
					ugcImageLayer.brightness = json.brightness;
					if(json.colorSpaceType)
					{
						ugcImageLayer.colorSpaceType = json.colorSpaceType;
					}
					ugcImageLayer.contrast = json.contrast;
					var bandIndexes:Array = new Array();
					if(json.displayBandIndexes && (json.displayBandIndexes as Array).length > 0)
					{
						for each(var displayBandIndexes:int in json.displayBandIndexes)
						{
							bandIndexes.push(displayBandIndexes);
						} 
						ugcImageLayer.displayBandIndexes = bandIndexes;
					}
					ugcImageLayer.transparent = json.transparent;
					ugcImageLayer.transparentColor = ServerColor.fromJson(json.transparentColor);
					layer._ugcLayer = ugcImageLayer;
				}
					
				else if(json.ugcLayerType == SuperMapLayerType.THEME)
				{
					var ugcThemeLayer:UGCThemeLayer = new UGCThemeLayer();
					if(json.theme && json.theme.type)
					{
						if(json.theme.type == "UNIQUE")
						{
							ugcThemeLayer.theme = ThemeUnique.fromJson(json.theme);
						}
						else if(json.theme.type == "RANGE")
						{ 
							ugcThemeLayer.theme = ThemeRange.fromJson(json.theme);
						}
						else if(json.theme.type == "LABEL")
						{
							ugcThemeLayer.theme = ThemeLabel.fromJson(json.theme);
						}
						else if(json.theme.type == "GRAPH")
						{
							ugcThemeLayer.theme = ThemeGraph.fromJson(json.theme);
						}
						else if(json.theme.type == "DOTDENSITY")
						{
							ugcThemeLayer.theme = ThemeDotDensity.fromJson(json.theme);
						}
						else if(json.theme.type == "GRADUATEDSYMBOL")
						{
							ugcThemeLayer.theme = ThemeGraduatedSymbol.fromJson(json.theme);
						}
						ugcThemeLayer.themeType = json.theme.type;
					}
					layer._ugcLayer = ugcThemeLayer;
				}
					
				else if(json.ugcLayerType == SuperMapLayerType.VECTOR && json.style)
				{
					layer._ugcLayer = UGCVectorLayer.fromJson(json.style);
				}
				else
				{
					layer._ugcLayer = new UGCLayer();
				}
				if(json.ugcLayerType)
				{
					layer._ugcLayerType = json.ugcLayerType;
				} 
				
			}
			return layer;
		}
 
	}
}