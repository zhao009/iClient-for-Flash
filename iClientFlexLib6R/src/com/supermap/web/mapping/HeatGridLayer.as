package com.supermap.web.mapping
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.core.styles.TextStyle;
	import com.supermap.web.events.FeatureLayerEvent;
	import com.supermap.web.events.HeatGridLayerEvent;
	import com.supermap.web.events.ZoomEvent;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayCollection;
	
	use namespace sm_internal;
	/**
	 * ${mapping_HeatGridLayer_Event_clickGrid_D} 
	 */	
	[Event(name="clickGrid", type="flash.events.HeatGridLayerEvent")]
	/**
	 * ${mapping_HeatGridLayer_Event_mouseoverGrid_D} 
	 */	
	[Event(name="mouseoverGrid", type="flash.events.HeatGridLayerEvent")]
	/**
	 * ${mapping_HeatGridLayer_Event_mouseoutGrid_D} 
	 */
	[Event(name="mouseoutGrid", type="flash.events.HeatGridLayerEvent")]
	/**
	 * ${mapping_HeatGridLayer_Title}. 
	 * <p>${mapping_HeatGridLayer_Description}</p>
	 * 
	 */
	public class HeatGridLayer extends FeaturesLayer
	{
		/**
		 * ${mapping_HeatGridLayerEvent_field_LABELMODE_NUMBER_D}
		 */
		public static const LABELMODE_NUMBER:Number = 0;
		/**
		 * ${mapping_HeatGridLayerEvent_field_LABELMODE_MEAN_D}
		 */
		public static const LABELMODE_MEAN:Number = 1;
		/**
		 * ${mapping_HeatGridLayerEvent_field_LABELMODE_MAX_D}
		 */
		public static const LABELMODE_MAX:Number = 2;
		/**
		 * ${mapping_HeatGridLayerEvent_field_LABELMODE_MIN_D}
		 */
		public static const LABELMODE_MIN:Number = 3;
		/**
		 * ${mapping_HeatGridLayerEvent_field_LABELMODE_MODE_D}
		 */
		public static const LABELMODE_MODE:Number = 4;
		/**
		 * ${mapping_HeatGridLayerEvent_field_LABELMODE_MEDIAM_D}
		 */
		public static const LABELMODE_MEDIAM:Number = 5;
		/**
		 * ${mapping_HeatGridLayerEvent_field_LABELMODE_STANDARD_DEVIATION_D}
		 */
		public static const LABELMODE_STANDARD_DEVIATION:Number = 6;
		
		//label显示数字代表的含义
		private var _labelMode:Number = 0;
		//每个网格的宽（像素单位）
		private var _gridWidth:Number = 50;
		//每个网格的高（像素单位）
		private var _gridHeight:Number = 50;
		
		//存储所有点要素的数组，此数组内部的feature.geometry只能是点，不能是线或面
		private var _pointFeatures:ArrayCollection = new ArrayCollection();
		//仅用于getFeatureByID方法
		private var _pointHashFeatures:Hashtable = new Hashtable();
		//用于存储存储计算生成的网格
		private var _gridFeatures:Hashtable = new Hashtable();
		//用于存储计算生成的网格的中心点
		private var _labelFeatures:Hashtable = new Hashtable();
		//存储格网的分段
		private var _items:Array = [];
		//记录点击格网时是否进行缩放
		private var _isZoomIn:Boolean = true;
		//记录点击格网时放大几级
		private var _zoomInNumber:int = 1;
		//记录地图放大到第几级时进行扩散
		private var _spreadZoom:int = 3;
		//记录是否显示label
		private var _isShowLabel:Boolean = true;
		//记录feature.attributes上的某字段名称，会根据此名称去获取数据
		private var _dataField:String;
		//记录label的精确位数
		private var _definition:int = 2;
		
		[IconFile("/designIcon/HeatGridLayer.png")]
		/**
		 * ${mapping_HeatGridLayer_constructor_None_D} 
		 * 
		 */	
		public function HeatGridLayer()
		{
			super();
			this.isPanEnableOnFeature = true;
			
		}
		/**
		 * ${mapping_HeatGridLayer_attribute_definition_D} 
		 * @return 
		 * 
		 */	
		public function get definition():int
		{
			return _definition;
		}
		
		public function set definition(value:int):void
		{
			_definition = value;
		}
		/**
		 * ${mapping_HeatGridLayer_attribute_dataField_D} 
		 * @return 
		 * 
		 */	
		public function get dataField():String
		{
			return _dataField;
		}
		
		public function set dataField(value:String):void
		{
			_dataField = value;
		}
		/**
		 * ${mapping_HeatGridLayer_attribute_isShowLabel_D} 
		 * @return 
		 * 
		 */	
		public function get isShowLabel():Boolean
		{
			return _isShowLabel;
		}
		
		public function set isShowLabel(value:Boolean):void
		{
			if(this._isShowLabel != value)
			{
				_isShowLabel = value;
				if(this._pointFeatures.length>0)
				{
					super.features = this.calculateFeatures(this._pointFeatures);
				}
			}
		}
		/**
		 * ${mapping_HeatGridLayer_attribute_spreadZoom_D} 
		 * @return 
		 * 
		 */	
		public function get spreadZoom():int
		{
			return _spreadZoom;
		}
		
		public function set spreadZoom(value:int):void
		{
			_spreadZoom = value;
		}
		/**
		 * ${mapping_HeatGridLayer_attribute_zoomInNumber_D} 
		 * @return 
		 * 
		 */	
		public function get zoomInNumber():int
		{
			return _zoomInNumber;
		}
		
		public function set zoomInNumber(value:int):void
		{
			_zoomInNumber = value;
		}
		/**
		 * ${mapping_HeatGridLayer_attribute_isZoomIn_D} 
		 * @return 
		 * 
		 */	
		public function get isZoomIn():Boolean
		{
			return _isZoomIn;
		}
		
		public function set isZoomIn(value:Boolean):void
		{
			_isZoomIn = value;
		}
		
		/**
		 * 默认为true
		 * ${mapping_HeatGridLayer_attribute_isPanEnableOnFeature_D} 
		 * @return 
		 * 
		 */	
		override public function get isPanEnableOnFeature():Boolean
		{
			return super.isPanEnableOnFeature;
		}
		override public function set isPanEnableOnFeature(value:Boolean):void
		{
			super.isPanEnableOnFeature = value;
		}
		
		/**
		 * ${mapping_HeatGridLayer_attribute_items_D}. 
		 * <p>${mapping_HeatGridLayer_attribute_items_remarks}</p> 
		 * @return 
		 * 
		 */	
		public function get items():Array
		{
			return _items;
		}
		
		public function set items(value:Array):void
		{
			_items = value;
			if(this._pointFeatures.length>0)
			{
				super.features = this.calculateFeatures(this._pointFeatures);
			}
		}
		/**
		 * ${mapping_HeatGridLayer_attribute_labelMode_D} 
		 * @return 
		 * 
		 */	
		public function get labelMode():Number
		{
			return _labelMode;
		}
		
		public function set labelMode(value:Number):void
		{
			_labelMode = value;
		}
		/**
		 * ${mapping_HeatGridLayer_attribute_gridWidth_D} 
		 * @return 
		 * 
		 */	
		public function get gridWidth():Number
		{
			return _gridWidth;
		}
		
		public function set gridWidth(value:Number):void
		{
			_gridWidth = value;
		}
		/**
		 * ${mapping_HeatGridLayer_attribute_gridHeight_D} 
		 * @return 
		 * 
		 */	
		public function get gridHeight():Number
		{
			return _gridHeight;
		}
		
		public function set gridHeight(value:Number):void
		{
			_gridHeight = value;
		}
		
		/**
		 * ${mapping_HeatGridLayer_attribute_features_D} 
		 * @return 
		 * 
		 */	
		override public function get features():Object
		{
			return this._pointFeatures;
		}
		override public function set features(value:Object):void
		{
			if(value)
			{
				if (value is Array)
				{
					this._pointFeatures = new ArrayCollection(value as Array);
				}
				else if (value is ArrayCollection)
				{
					this._pointFeatures = value as ArrayCollection;
				}
				else
				{
					var features:Array = [];
					if (value != null)
					{
						features.push(value);
					}
					this._pointFeatures = new ArrayCollection(features);
				}
				var wrapper:Feature;
				for each (wrapper in this._pointFeatures.toArray())
				{				
					this.addHashTableIDs(wrapper);
				}
				//直接设置父类的features可以达到刷新效果，不需要手动去清除
				super.features = this.calculateFeatures(this._pointFeatures);
			}
		}
		
		sm_internal override function setMap(map:Map) : void
		{
			super.setMap(map);
			super.features = this.calculateFeatures(this._pointFeatures);
		}
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */	
		override protected function zoomStartHandler(event:ZoomEvent):void
		{
			if(!map)
				return;
			//放大缩小前清空
			super.features = null;
			super.zoomStartHandler(event);
		}
		/**
		 * @inheritDoc 
		 * 
		 */	
		override protected function zoomEndHandler(event:ZoomEvent):void
		{
			if(!map)
				return;
			super.zoomStartHandler(event);
			//放大缩小之后再赋值上去
			super.features = this.calculateFeatures(this._pointFeatures);
		}
		
		/**
		 * ${mapping_HeatGridLayer_method_addFeature_D} 
		 * @param feature ${mapping_HeatGridLayer_method_addFeature_param_feature}
		 * @see #isFront
		 * @return ${mapping_HeatGridLayer_method_addFeature_return}
		 * 
		 */	
		override public function addFeature(feature:Feature,isfront:Boolean = true):String
		{
			isfront = this.isFront;
			if(this._pointFeatures.contains(feature))
			{	
				return null;
			}
			if(isfront)
				this._pointFeatures.addItem(feature);
			else
				this._pointFeatures.addItemAt(feature,0);
			this.addHashTableIDs(feature);
			this.calculateFeature(feature,"add");
			
			if(this.hasEventListener(FeatureLayerEvent.FEATURE_ADD))
			{
				dispatchEvent(new FeatureLayerEvent(FeatureLayerEvent.FEATURE_ADD,feature));
			}
			return feature.id;	
		}	
		/**
		 * ${mapping_HeatGridLayer_method_addFeatureAt_D} 
		 * @param feature ${mapping_HeatGridLayer_method_addFeatureAt_param_feature}
		 * @param index ${mapping_HeatGridLayer_method_addFeatureAt_param_index}
		 * @return ${mapping_HeatGridLayer_method_addFeatureAt_return}
		 * @see features
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */	
		override public function addFeatureAt(feature:Feature, index:int):String
		{
			try
			{
				this._pointFeatures.addItemAt(feature,index);
			}
			catch(error:Error)
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}
			this.addHashTableIDs(feature);
			this.calculateFeature(feature,"add");
			if(this.hasEventListener(FeatureLayerEvent.FEATURE_ADD))
			{
				dispatchEvent(new FeatureLayerEvent(FeatureLayerEvent.FEATURE_ADD,feature));
			}
			return feature.id;	
		}
		/**
		 * ${mapping_HeatGridLayer_method_getFeatureIndex_D} 
		 * @param feature ${mapping_HeatGridLayer_method_getFeatureIndex_param_feature}
		 * @return ${mapping_HeatGridLayer_method_getFeatureIndex_return}
		 * 
		 */	
		override public function getFeatureIndex(feature:Feature):int
		{
			var featureIndex:int = -1;
			if(this._pointFeatures && feature)
			{
				featureIndex = this._pointFeatures.getItemIndex(feature);
			}
			return featureIndex;
		}
		/**
		 * ${mapping_HeatGridLayer_method_getFeatureAt_D} 
		 * @param index ${mapping_HeatGridLayer_method_getFeatureAt_param_index}
		 * @return ${mapping_HeatGridLayer_method_getFeatureAt_return}
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */	
		override public function getFeatureAt(index:int):Feature
		{
			var feature:Feature = null;
			if(this._pointFeatures)
			{
				try
				{
					var object:Object = this._pointFeatures.getItemAt(index);
					feature = object ? (object as Feature) : null;
				}
				catch(error:Error)
				{
					throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
				}
			}
			return feature;
		}
		/**
		 * ${mapping_HeatGridLayer_method_getFeatureById_D} 
		 * @param Id ${mapping_HeatGridLayer_method_getFeatureById_id}
		 * @return ${mapping_HeatGridLayer_method_getFeatureById_Feature}
		 * 
		 */		
		override public function getFeatureByID(id:String):Feature
		{
			var feature:Feature = null;
			if(id && this._pointHashFeatures.containsKey(id))
			{
				feature = this._pointHashFeatures.find(id) as Feature;
				if(feature.id == id)
				{
					return feature;
				}		
				else 
					feature = null;
			}
			return feature;
		}
		/**
		 * ${mapping_HeatGridLayer_method_removeFeature_D} 
		 * @param feature ${mapping_HeatGridLayer_method_removeFeature_param_feature}
		 * @return ${mapping_HeatGridLayer_method_removeFeature_return}
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */	
		override public function removeFeature(feature:Feature):Feature
		{				
			return this.removeFeatureAt(getFeatureIndex(feature));
		}
		/**
		 * ${mapping_HeatGridLayer_method_removeFeatureAt_D} 
		 * @param featureIndex ${mapping_HeatGridLayer_method_removeFeatureAt_param_featureIndex}
		 * @return $[mapping_HeatGridLayer_method_removeFeatureAt_return}
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */	
		override public function removeFeatureAt(index:int):Feature
		{			
			var feature:Feature = null;
			if(this._pointFeatures)
			{
				try
				{				
					var object:Object = this._pointFeatures.removeItemAt(index);
					feature = object ? (object as Feature) : null;
					if(this.hasEventListener(FeatureLayerEvent.FEATURE_REMOVE))
					{
						dispatchEvent(new FeatureLayerEvent(FeatureLayerEvent.FEATURE_REMOVE, feature));
					}
				}
				catch(error:Error)
				{
					throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
				}
				this.removeHashTableIDs(feature);
				this.calculateFeature(feature,"remove");
			}
			return feature;
			
		}
		/**
		 * ${mapping_HeatGridLayer_method_moveFeature_D} 
		 * @param feature ${mapping_HeatGridLayer_method_moveFeature_param_feature}
		 * @param index ${mapping_HeatGridLayer_method_moveFeature_param_index}
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */	
		override public function moveFeature(feature:Feature, index:int):void
		{			
			try
			{
				this._pointFeatures.removeItemAt(this.getFeatureIndex(feature));
				this._pointFeatures.addItemAt(feature, index);
			}
			catch(error:SmError)			
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}			
		}
		/**
		 * ${mapping_HeatGridLayer_method_moveFeatureAt_D} 
		 * @param featureIndex ${mapping_HeatGridLayer_method_moveFeatureAt_param_featureIndex}
		 * @param index ${mapping_HeatGridLayer_method_moveFeatureAt_param_index}
		 * @see com.supermap.web.resources.SmResource
		 * 
		 */	
		override public function moveFeatureAt(fromIndex:int, toIndex:int):void
		{			
			try
			{
				var object:Object = this._pointFeatures.removeItemAt(fromIndex);
				var feature:Feature = object ? (object as Feature) : null;
				this._pointFeatures.addItemAt(feature, toIndex);
			}
			catch(error:SmError)			
			{
				throw new SmError(SmResource.OUT_OF_ARRAY_RANGE);
			}		
		}
		/**
		 * ${mapping_HeatGridLayer_method_moveToTop_D} 
		 * @param feature ${mapping_HeatGridLayer_method_moveToTop_param_feature}
		 * 
		 */
		override public function moveToTop(feature:Feature):void
		{
			
		}
		/**
		 * ${mapping_HeatGridLayer_method_clear_D} 
		 * 
		 */	
		override public function clear():void
		{
			if(this._pointFeatures)
			{
				this._pointFeatures.removeAll();	
				this._gridFeatures.clear();
				this._labelFeatures.clear();
				super.clear();
			}
		}
		//重写重绘方法，主要用于当设置了一些属性后没有立即显示出效果时调用
		override public function refresh():void
		{
			if(this._pointFeatures.length>0)
			{
				super.features = this.calculateFeatures(this._pointFeatures);
			}
		}
		
		
		//增加id键值对到哈希表
		private function addHashTableIDs(feature:Feature):void
		{
			var featureID:String = feature.id;
			if(featureID && !this._pointHashFeatures.containsKey(featureID))
			{
				this._pointHashFeatures.add(featureID, feature);
			}
		}
		
		//移除id键值对从哈希表
		private function removeHashTableIDs(feature:Feature):void
		{
			var featureID:String = feature.id;
			if(featureID && this._pointHashFeatures.containsKey(featureID))
			{
				this._pointHashFeatures.remove(featureID);
			}
		}	
		
		private function calculateFeature(feature:Feature,action:String):Object
		{
			if(this.map)
			{
				if(this.map.level>this.spreadZoom)
				{
					return features;
				}
				else
				{
					if(
						(this._labelMode == HeatGridLayer.LABELMODE_NUMBER) || 
						(this._labelMode == HeatGridLayer.LABELMODE_MEAN) || 
						(this._labelMode == HeatGridLayer.LABELMODE_MAX) || 
						(this._labelMode == HeatGridLayer.LABELMODE_MIN)
					)
					{
						
						return this.calculateNumber(feature,action);
					}
						//			else if(this._labelMode == HeatGridLayer.LABELMODE_MODE)
						//			{
						//			}
						//			else if(this._labelMode == HeatGridLayer.LABELMODE_MEDIAM)
						//			{
						//			}
						//			else if(this._labelMode == HeatGridLayer.LABELMODE_STANDARD_DEVIATION)
						//			{
						//			}
					else
					{
						return feature;
					}
				}
			}
			else
			{
				return null;
			}
		}
		private function calculateNumber(feature:Feature,action:String):Object
		{
			var gridWidth:Number =this._gridWidth*this.map.resolution;
			var gridHeight:Number = this._gridHeight*this.map.resolution;
			var geometry:Geometry = feature.geometry;
			var result:Object = {
				gridFeature:null,
				labelFeature:null
			};
			//必须只能是点，飞点直接排除
			if(geometry is GeoPoint)
			{
				var point:GeoPoint = geometry as GeoPoint;
				var xyz:Object = this.calculateXYZ(point.x,point.y,this.map.level,gridWidth,gridHeight);
				var strXYZ:String = xyz.x+"_"+xyz.y+"_"+xyz.z;
				//只有增加才可能进入
				if(!this._gridFeatures.containsKey(strXYZ))
				{
					//添加网格
					var points:Array =[new Point2D(xyz.x*gridWidth,xyz.y*gridHeight),
						new Point2D(xyz.x*gridWidth,xyz.y*gridHeight+gridHeight),
						new Point2D(xyz.x*gridWidth+gridWidth,xyz.y*gridHeight+gridHeight),
						new Point2D(xyz.x*gridWidth+gridWidth,xyz.y*gridHeight),
						new Point2D(xyz.x*gridWidth,xyz.y*gridHeight)
					];
					var geoRegion:GeoRegion = new GeoRegion();
					geoRegion.addPart(points);
					var feaGrid:Feature = new Feature(geoRegion);
					//存储网格
					this._gridFeatures.add(strXYZ,feaGrid);
					result.gridFeature = feaGrid;
					//创建网格中心点并存储
					var geoPoint:GeoPoint = new GeoPoint(geoRegion.center.x,geoRegion.center.y);
					var feaLabel:Feature = new Feature(geoPoint);
					this._labelFeatures.add(strXYZ,feaLabel);
					result.labelFeature = feaLabel;
					//在网格内保存他包含的点
					feaGrid.childFeatrues.addItem(feature);
					if(this._dataField)
					{
						feaGrid.target = feature.attributes[this._dataField];
					} 
					
					
					//为网格和label添加style
					this.calculateStyle(feaGrid,feaLabel);
					
					
					
					feaGrid.addEventListener(MouseEvent.CLICK,clickGrid);
					feaGrid.addEventListener(MouseEvent.MOUSE_OVER,mouseoverGrid);
					feaGrid.addEventListener(MouseEvent.MOUSE_OUT,mouseoutGrid);
					
					(super.features as ArrayCollection).addItem(feaGrid);
					if(this.isShowLabel)
					{
						(super.features as ArrayCollection).addItem(feaLabel);
					}
					
				}
				else
				{
					if(action == "add")
					{
						var feaGrid1:Feature = this._gridFeatures.find(strXYZ) as Feature;
						feaGrid1.childFeatrues.addItem(feature);
						var geaLabel1:Feature = this._labelFeatures.find(strXYZ) as Feature;
						
						if(this.labelMode == HeatGridLayer.LABELMODE_NUMBER)
						{
						}
						else if(this.labelMode == HeatGridLayer.LABELMODE_MEAN)
						{
							feaGrid1.target = ((feaGrid1.target as Number)*(feaGrid1.childFeatrues.length - 1) + (feature.attributes[this._dataField] as Number))/feaGrid1.childFeatrues.length;
						}
						else if(this.labelMode == HeatGridLayer.LABELMODE_MAX)
						{
							feaGrid1.target = (feaGrid1.target as Number)>(feature.attributes[this._dataField] as Number)?(feaGrid1.target as Number):(feature.attributes[this._dataField] as Number);
						}
						else if(this.labelMode == HeatGridLayer.LABELMODE_MIN)
						{
							feaGrid1.target = (feaGrid1.target as Number)<(feature.attributes[this._dataField] as Number)?(feaGrid1.target as Number):(feature.attributes[this._dataField] as Number);
						}
						//为网格和label添加style
						this.calculateStyle(feaGrid1,geaLabel1);
						result.gridFeature = feaGrid1;
						result.labelFeature = geaLabel1;
					}
					else if(action == "remove")
					{
						var feaGrid2:Feature = this._gridFeatures.find(strXYZ) as Feature;
						feaGrid2.childFeatrues.removeItemAt(feaGrid2.childFeatrues.getItemIndex(feature));
						
						var geaLabel2:Feature = this._labelFeatures.find(strXYZ) as Feature;
						if(feaGrid2.childFeatrues.length>0)
						{
							if(this.labelMode == HeatGridLayer.LABELMODE_NUMBER)
							{
							}
							else if(this.labelMode == HeatGridLayer.LABELMODE_MEAN)
							{
								feaGrid2.target = ((feaGrid2.target as Number)*(feaGrid2.childFeatrues.length - 1) + (feature.attributes[this._dataField] as Number))/feaGrid2.childFeatrues.length;
							}
							else if(this.labelMode == HeatGridLayer.LABELMODE_MAX)
							{
								feaGrid2.target = (feaGrid2.target as Number)>(feature.attributes[this._dataField] as Number)?(feaGrid2.target as Number):(feature.attributes[this._dataField] as Number);
							}
							else if(this.labelMode == HeatGridLayer.LABELMODE_MIN)
							{
								feaGrid2.target = (feaGrid2.target as Number)<(feature.attributes[this._dataField] as Number)?(feaGrid2.target as Number):(feature.attributes[this._dataField] as Number);
							}
							//为网格和label添加style
							this.calculateStyle(feaGrid2,geaLabel2);
						}
						else
						{
							feaGrid2.removeEventListener(MouseEvent.CLICK,clickGrid);
							feaGrid2.removeEventListener(MouseEvent.MOUSE_OVER,mouseoverGrid);
							feaGrid2.removeEventListener(MouseEvent.MOUSE_OUT,mouseoutGrid);
							
							(super.features as ArrayCollection).removeItemAt((super.features as ArrayCollection).getItemIndex(feaGrid2));
							(super.features as ArrayCollection).removeItemAt((super.features as ArrayCollection).getItemIndex(geaLabel2));
						}
						result.gridFeature = feaGrid2;
						result.labelFeature = geaLabel2;
					}
				}
			}
			else
			{
			}
			return result;
		}
		
		
		
		
		/**
		 * 完全重新计算网格，只会在初始化setMap、以及运行过程中set features 或者放大缩小地图才会全部重新计算
		 * @param features 待计算的feature数组，一般情况应该是点数组
		 * return 返回计算完毕后生成的网格集合
		 */
		private function calculateFeatures(features:ArrayCollection):ArrayCollection
		{
			if(this.map && features.length>0)
			{
				if(this.map.level>this.spreadZoom)
				{
					return new ArrayCollection(features.toArray());
				}
				else
				{
					if(
						(this._labelMode == HeatGridLayer.LABELMODE_NUMBER) ||
						(this._labelMode == HeatGridLayer.LABELMODE_MEAN) || 
						(this._labelMode == HeatGridLayer.LABELMODE_MAX) ||
						(this._labelMode == HeatGridLayer.LABELMODE_MIN)
					)
					{
						return this.calculateNumbers(features);
					}
						//			else if(this._labelMode == HeatGridLayer.LABELMODE_MODE)
						//			{
						//			}
						//			else if(this._labelMode == HeatGridLayer.LABELMODE_MEDIAM)
						//			{
						//			}
						//			else if(this._labelMode == HeatGridLayer.LABELMODE_STANDARD_DEVIATION)
						//			{
						//			}
					else
					{
						return new ArrayCollection(features.toArray());
					}
				}
			}
			else
			{
				return null;
			}
			
		}
		/**
		 * 计算网格，计算时重点计算每个网格代表的数量
		 * @param features 待计算的feature数组，一般情况应该是点数组
		 * return 返回计算完毕后生成的网格集合
		 */
		private function calculateNumbers(features:ArrayCollection):ArrayCollection
		{
			var gridWidth:Number =this._gridWidth*this.sm_internal::map.resolution;
			var gridHeight:Number = this._gridHeight*this.sm_internal::map.resolution;
			//需要清空之前的网格
			this._gridFeatures.clear();
			this._labelFeatures.clear();
			for(var i:Number = 0;i<features.length;i++)
			{
				var geometry:Geometry = (features[i] as Feature).geometry;
				//必须只能是点，飞点直接排除
				if(geometry is GeoPoint)
				{
					var point:GeoPoint = geometry as GeoPoint;
					var xyz:Object = this.calculateXYZ(point.x,point.y,this.map.level,gridWidth,gridHeight);
					var strXYZ:String = xyz.x+"_"+xyz.y+"_"+xyz.z;
					if(!this._gridFeatures.containsKey(strXYZ))
					{
						//添加网格
						var points:Array =[new Point2D(xyz.x*gridWidth,xyz.y*gridHeight),
							new Point2D(xyz.x*gridWidth,xyz.y*gridHeight+gridHeight),
							new Point2D(xyz.x*gridWidth+gridWidth,xyz.y*gridHeight+gridHeight),
							new Point2D(xyz.x*gridWidth+gridWidth,xyz.y*gridHeight),
							new Point2D(xyz.x*gridWidth,xyz.y*gridHeight)
						];
						var geoRegion:GeoRegion = new GeoRegion();
						geoRegion.addPart(points);
						var feaGrid:Feature = new Feature(geoRegion);
						//存储网格
						this._gridFeatures.add(strXYZ,feaGrid);
						//创建网格中心点并存储
						var geoPoint:GeoPoint = new GeoPoint(geoRegion.center.x,geoRegion.center.y);
						var feaLabel:Feature = new Feature(geoPoint);
						this._labelFeatures.add(strXYZ,feaLabel);
						//在网格内保存他包含的点
						feaGrid.childFeatrues.addItem(features[i]);
						//无论哪种模式，网格第一个先记录下它的数据
						if(this._dataField)
						{
							feaGrid.target = parseFloat(features[i].attributes[this._dataField] as String);
						} 
						feaGrid.addEventListener(MouseEvent.CLICK,clickGrid);
						feaGrid.addEventListener(MouseEvent.MOUSE_OVER,mouseoverGrid);
						feaGrid.addEventListener(MouseEvent.MOUSE_OUT,mouseoutGrid);
					}
					else
					{
						var feaGrid2:Feature = this._gridFeatures.find(strXYZ) as Feature;
						feaGrid2.childFeatrues.addItem(features[i]);
						if(this.labelMode == HeatGridLayer.LABELMODE_NUMBER)
						{
						}
						else if(this.labelMode == HeatGridLayer.LABELMODE_MEAN)
						{
							feaGrid2.target = ((feaGrid2.target as Number)*(feaGrid2.childFeatrues.length - 1) + parseFloat(features[i].attributes[this._dataField] as String))/feaGrid2.childFeatrues.length;
						}
						else if(this.labelMode == HeatGridLayer.LABELMODE_MAX)
						{
							feaGrid2.target = (feaGrid2.target as Number)>parseFloat(features[i].attributes[this._dataField] as String)?(feaGrid2.target as Number):parseFloat(features[i].attributes[this._dataField] as String);
						}
						else if(this.labelMode == HeatGridLayer.LABELMODE_MIN)
						{
							feaGrid2.target = (feaGrid2.target as Number)<parseFloat(features[i].attributes[this._dataField] as String)?(feaGrid2.target as Number):parseFloat(features[i].attributes[this._dataField] as String);
						}
					}
				}
				else
				{
					
				}
			}
			var keys:Array = this._gridFeatures.getKeySet();
			for(var j:int = 0;j<keys.length;j++)
			{
				var gridFeature:Feature = this._gridFeatures.find(keys[j]) as Feature;
				var labelFeature:Feature = this._labelFeatures.find(keys[j]) as Feature;
				//为网格和label添加style
				this.calculateStyle(gridFeature,labelFeature);
			}
			var result:Array = this._gridFeatures.toArray();
			//控制是否显示label
			if(this._isShowLabel)
			{
				result = result.concat(this._labelFeatures.toArray());
			}
			return new ArrayCollection(result);
			
		}
		
		
		
		private function clickGrid(event:MouseEvent):void
		{
			if(this._isZoomIn)
			{
				var feature:Feature = event.target as Feature;
				var oldLonlat:Point2D = (feature.geometry as GeoRegion).center;
				var oldPortPx:Point = this.map.mapToScreen(oldLonlat);
				
				var oldCenterLonlat:Point2D = this.map.center;
				var oldCenterPortPx:Point = this.map.mapToScreen(oldCenterLonlat);
				
				var res:Number = this.map.resolutions[this.map.level+1];
				var lonlat:Point2D = new Point2D(oldLonlat.x - (oldPortPx.x-oldCenterPortPx.x)*res,oldLonlat.y + (oldPortPx.y-oldCenterPortPx.y)*res);
				
				this.map.zoomToLevel(this.map.level+this._zoomInNumber,lonlat);
				
			}
			dispatchEvent(new HeatGridLayerEvent(HeatGridLayerEvent.CLICK_GRID,event.target as Feature));
		}
		private function mouseoverGrid(event:MouseEvent):void
		{
			dispatchEvent(new HeatGridLayerEvent(HeatGridLayerEvent.MOUSEOVER_GRID,event.target as Feature));
		}
		private function mouseoutGrid(event:MouseEvent):void
		{
			dispatchEvent(new HeatGridLayerEvent(HeatGridLayerEvent.MOUSEOUT_GRID,event.target as Feature));
		}
		
		/**
		 * 根据点和网格大小计算点所在的网格的xy位置
		 * @param x 点的横坐标
		 * @param y 点的纵坐标
		 * @param y 当前的地图缩放级别
		 * @param gridWidth 网格的宽
		 * @param gridHeight 网格的高
		 * return 返回一个对象  形如:{x:10,y:14,z:0}
		 */
		private function calculateXYZ(x:Number,y:Number,z:Number,gridWidth:Number,gridHeight:Number):Object
		{
			var _x:Number;
			var _y:Number;
			var _z:Number = z;
			if(x >=0)
			{
				_x = (x - x%gridWidth)/gridWidth;
			}
			else
			{
				_x = (x - (gridWidth + x%gridWidth))/gridWidth;
			}
			if(y >=0)
			{
				_y = (y - y%gridHeight)/gridHeight;
			}
			else
			{
				_y = (y - (gridHeight + y%gridHeight))/gridHeight;
			}
			return {
				x:_x,
				y:_y,
				z:_z
			};
		}
		/**
		 * 给网格和中心点匹配上style
		 * 
		 */
		private function calculateStyle(gridFeature:Feature,labelFeature:Feature):void
		{
			var multiple:Number = Math.pow(10,this.definition);
			if(this.items && this.items.length>0)
			{
				for(var k:int = 0;k<this.items.length;k++)
				{
					if(this.items[k].start!=null && this.items[k].end!=null)
					{
						
						if(this.labelMode == HeatGridLayer.LABELMODE_NUMBER)
						{
							if(this.items[k].start<=gridFeature.childFeatrues.length && gridFeature.childFeatrues.length<this.items[k].end)
							{
								gridFeature.style = this.items[k].gridStyle as Style;
								
								var textStyle1:TextStyle = (this.items[k].textStyle as TextStyle).clone() as TextStyle;
								textStyle1.text = gridFeature.childFeatrues.length.toString();
								labelFeature.style = textStyle1;
							}
						}
						else if(
							(this.labelMode == HeatGridLayer.LABELMODE_MEAN) ||
							(this._labelMode == HeatGridLayer.LABELMODE_MAX) ||
							(this._labelMode == HeatGridLayer.LABELMODE_MIN)
						)
						{
							if(this.items[k].start<=(gridFeature.target as Number) && (gridFeature.target as Number)<this.items[k].end)
							{
								gridFeature.style = this.items[k].gridStyle as Style;
								
								var textStyle2:TextStyle = (this.items[k].textStyle as TextStyle).clone() as TextStyle;
								if(this.definition<0)
								{
									textStyle2.text = (gridFeature.target as Number).toString();
								}
								else
								{
									textStyle2.text = (parseInt(((gridFeature.target as Number)*multiple).toString())/multiple).toString();
								}
								labelFeature.style = textStyle2;
							}
						}
						
					}
					
					
				}
			}
			else
			{
				//附一个默认值给label，格网不用设置
				if(this.labelMode == HeatGridLayer.LABELMODE_NUMBER)
				{
						var textStyle3:TextStyle = new TextStyle();
						textStyle3.text = gridFeature.childFeatrues.length.toString();
						labelFeature.style = textStyle3;
				}
				else if(
					(this.labelMode == HeatGridLayer.LABELMODE_MEAN) ||
					(this._labelMode == HeatGridLayer.LABELMODE_MAX) ||
					(this._labelMode == HeatGridLayer.LABELMODE_MIN)
				)
				{
						var textStyle4:TextStyle = new TextStyle();
						if(this.definition<0)
						{
							textStyle4.text = (gridFeature.target as Number).toString();
						}
						else
						{
							textStyle4.text = (parseInt(((gridFeature.target as Number)*multiple).toString())/multiple).toString();
						}
						labelFeature.style = textStyle4;
					
				}
			}
			
		}
	}
	
}