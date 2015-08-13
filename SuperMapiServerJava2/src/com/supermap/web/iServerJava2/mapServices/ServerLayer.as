package com.supermap.web.iServerJava2.mapServices
{
	import com.supermap.web.sm_internal;
	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_getMapStatus_ServerLayer_Title}.
	 * <p>${iServer2_getMapStatus_ServerLayer_Description}</p> 
	 * 
	 * 
	 */	
	public class ServerLayer
	{
		private var _caption:String;
		
		private var _name:String;
		
		private var _isSymbolScalable:Boolean = false;
		
		private var _minScale:Number = 0;
		
		private var _minVisibleGeometrySize:Number = 0.4;
		
		private var _opaqueRate:int;
		
		private var _queryable:Boolean;
		
		private var _visible:Boolean;
		
		private var _description:String;
		
		private var _serverLayerSetting:ServerLayerSetting;
		
		//图层显示过滤参数。例如：displayFilter="SMID>20"
		private var _displayFilter:String;
		
		private var _maxScale:Number = 0;
		
		private var _serverSubLayers:Array;
		
		//内部变量
		private var _layerSettingType:int;

		sm_internal function get layerSettingType():int
		{
			return _layerSettingType;
		}

		sm_internal function set layerSettingType(value:int):void
		{
			_layerSettingType = value;
		}

		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_caption_D} 
		 * @return 
		 * 
		 */		
		public function get caption():String
		{
			return this._caption;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_name_D} 
		 * @return 
		 * 
		 */		
		public function get name():String
		{
			return this._name;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_isSymbolScalable_D}.
		 * ${iServer2_getMapStatus_ServerLayer_attribute_isSymbolScalable_remarks} 
		 * @return 
		 * 
		 */		
		public function get isSymbolScalable():Boolean
		{
			return this._isSymbolScalable;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_minScale_D}.
		 * ${iServer2_getMapStatus_ServerLayer_attribute_minScale_remarks}
		 * @return 
		 * 
		 */		
		public function get minScale():Number
		{
			return this._minScale;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_minVisibleGeometrySize_D}.
		 * ${iServer2_getMapStatus_ServerLayer_attribute_minVisibleGeometrySize_remarks} 
		 * @return 
		 * 
		 */		
		public function get minVisibleGeometrySize():Number
		{
			return this._minVisibleGeometrySize;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_opaqueRate_D} 
		 * @return 
		 * 
		 */		
		public function get opaqueRate():int
		{
			return this._opaqueRate;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_queryable_D} 
		 * @return 
		 * 
		 */		
		public function get queryable():Boolean
		{
			return this._queryable;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_visible_D} 
		 * @return 
		 * 
		 */		
		public function get visible():Boolean
		{
			return this._visible;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_description_D} 
		 * @return 
		 * 
		 */		
		public function get description():String
		{
			return this._description;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_serverLayerSetting_D} 
		 * @return 
		 * 
		 */		
		public function get serverLayerSetting():ServerLayerSetting
		{
			return this._serverLayerSetting;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_displayFilter_D} 
		 * @return 
		 * 
		 */		
		public function get displayFilter():String
		{
			return this._displayFilter;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_maxScale_D} 
		 * @return 
		 * 
		 */		
		public function get maxScale():Number
		{
			return this._maxScale;
		}
		
		/**
		 * ${iServer2_getMapStatus_ServerLayer_attribute_serverSubLayers_D} 
		 * @return 
		 * 
		 */		
		public function get serverSubLayers():Array
		{
			return this._serverSubLayers;
		}
		
		sm_internal static function toServerLayer(object:Object):ServerLayer
		{
			var serverLayer:ServerLayer;
			if(object)
			{
				serverLayer = new ServerLayer();
				
				serverLayer._caption = object.caption;
				
				serverLayer._description = object.description;
				
				serverLayer._displayFilter = object.displayFilter;
				
				serverLayer._isSymbolScalable = object.isSymbolScalable;
				
				serverLayer._maxScale = object.maxScale;
				
				serverLayer._minScale = object.minScale;
				
				serverLayer._minVisibleGeometrySize = object.minVisibleGeometrySize;
				if(serverLayer._minVisibleGeometrySize == 0)
					serverLayer._minVisibleGeometrySize = 0.4;
				
				serverLayer._name = object.name;
				
				serverLayer._opaqueRate = object.opaqueRate;
				
				serverLayer._queryable = object.queryable;
				
				serverLayer._visible = object.visible;
				
				if(object.layerSetting)
				{
					if(object.layerSetting.layerSettingType == ServerLayerSettingType.SUPER_MAP_COLLECTION)
					{
						serverLayer._serverLayerSetting = SuperMapCollectionLayerSetting.toSuperMapCollectionLayerSetting(object.layerSetting);
					}
					else if(object.layerSetting.layerSettingType == ServerLayerSettingType.SUPER_MAP)
					{
//						serverLayer._serverLayerSetting = SuperMapLayerSetting.toSuperMapLayerSetting(object.layerSetting);
					}
					else if(object.layerSetting.layerSettingType == ServerLayerSettingType.WMS)
					{
//						serverLayer._serverLayerSetting = WMSLayerSetting.toWMSLayerSetting(object.layerSetting);
					}
				}
				
				if(object.subLayers)
				{
					serverLayer._serverSubLayers = new Array();
					var tempServerLayers:Array = object.subLayers;
					
					for(var i:int = 0; i < tempServerLayers.length; i++)
					{
						var subLayer:ServerLayer = new ServerLayer();
						subLayer._caption = tempServerLayers[i].caption;
						subLayer._description = tempServerLayers[i].description;
						subLayer._displayFilter = tempServerLayers[i].displayFilter;
						subLayer._isSymbolScalable = tempServerLayers[i].isSymbolScalable;
						subLayer._maxScale = tempServerLayers[i].maxScale;
						subLayer._minScale = tempServerLayers[i].minScale;
						subLayer._minVisibleGeometrySize = tempServerLayers[i].minVisibleGeometrySize;
						subLayer._name = tempServerLayers[i].name;
						subLayer._opaqueRate = tempServerLayers[i].opaqueRate;
						subLayer._queryable = tempServerLayers[i].queryable;
						subLayer._visible = tempServerLayers[i].visible;
						if(tempServerLayers[i].layerSetting)
						{
							if(tempServerLayers[i].layerSetting.datasetInfo && tempServerLayers[i].layerSetting.datasetInfo.datasetType)
							{
								subLayer._layerSettingType = tempServerLayers[i].layerSetting.datasetInfo.datasetType;
							}
							if(tempServerLayers[i].layerSetting.layerSettingType == ServerLayerSettingType.SUPER_MAP_COLLECTION)
							{
								subLayer._serverLayerSetting = SuperMapCollectionLayerSetting.toSuperMapCollectionLayerSetting(tempServerLayers[i].layerSetting);
							}
							else if(tempServerLayers[i].layerSetting.layerSettingType == ServerLayerSettingType.SUPER_MAP)
							{
//								subLayer._serverLayerSetting = SuperMapLayerSetting.toSuperMapLayerSetting(tempServerLayers[i].layerSetting);
							}
							else if(tempServerLayers[i].layerSetting.layerSettingType == ServerLayerSettingType.WMS)
							{
//								subLayer._serverLayerSetting = WMSLayerSetting.toWMSLayerSetting(tempServerLayers[i].layerSetting);
							}
						}
						serverLayer._serverSubLayers.push(subLayer);
					}
				}
				
			}
			return serverLayer;
		}
		
		
	}
}