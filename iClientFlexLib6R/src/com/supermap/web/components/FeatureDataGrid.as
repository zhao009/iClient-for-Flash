package com.supermap.web.components
{  
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.styles.PredefinedFillStyle;
	import com.supermap.web.core.styles.PredefinedLineStyle;
	import com.supermap.web.core.styles.PredefinedMarkerStyle;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.events.FeatureDataGridEvent;
	import com.supermap.web.mapping.FeaturesLayer;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;
	import com.supermap.web.sm_internal;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.controls.Alert;
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.events.CloseEvent;
	import mx.events.DataGridEvent;
	import mx.events.ListEvent;
	import mx.messaging.messages.ErrorMessage;
	import mx.utils.StringUtil;
	  
	use namespace sm_internal;
	
	/**
	 * ${controls_FeatureDataGrid_Event_featureSelected_D}
	 */	
	[Event(name="featureSelected", type="com.supermap.web.events.FeatureDataGridEvent")]
	/**
	 * ${controls_FeatureDataGrid_Event_featureClick_D}
	 */
	[Event(name="featureClick", type="com.supermap.web.events.FeatureDataGridEvent")]
	/**
	 * ${controls_FeatureDataGrid_Event_featureDelete_D}
	 */
	[Event(name="featureDelete", type="com.supermap.web.events.FeatureDataGridEvent")]
	
	[IconFile("/designIcon/FeatureDataGrid.png")]
	/**
	 * ${controls_FeatureDataGrid_Title}. 
	 * <p>${controls_FeatureDataGrid_Description}</p>
	 * 
	 */	
	public class FeatureDataGrid extends DataGrid
	{ 
		private var _features:Array;
	 
		private var _captions:Array; 
		private var _showCaptions:Array;
		private var _featuresLayer:FeaturesLayer; 
		private var _lastSelectedFeature:Feature;
		private var _currentFeature:Feature;
		private var _highLightStyle:Style;
		private var _normalStyle:Style;
		private var _parentContainer:DisplayObject;
		private var _isHighLight:Boolean = true;
		private var _isAddFeatureListener:Boolean = false;
		
		private var _isFeaturesLayerReset:Boolean = false;
		private var _isFeaturesChange:Boolean = false;
		private var _isShowCaptions:Boolean = false;
		private var _sortField:Object;//排序字段  
		/**
		 * ${controls_FeatureDataGrid_constructor_D} 
		 * @param featuresLayer ${controls_FeatureDataGrid_constructor_param_featuresLayer}
		 * @param features ${controls_FeatureDataGrid_constructor_param_features}
		 * @param parentContainer ${controls_FeatureDataGrid_constructor_param_parentContainer} 
		 * 
		 */		
		public function FeatureDataGrid(featuresLayer:FeaturesLayer = null, features:Array = null, parentContainer:DisplayObject = null)
		{    	
			this.doubleClickEnabled = true;
			this.addEventListener(DataGridEvent.HEADER_RELEASE, headerReleaseHandler);  
			this.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler); 
			this.addEventListener(MouseEvent.MOUSE_DOWN, stopDragHandler);
			this._featuresLayer = featuresLayer;//在这里调用接口 
			this.features = features;
			this.isHighLight = true;
			if(this.features)
			{
				this.parentContainer = parentContainer; 
			} 
		} 
	 
		/**
		 * ${controls_FeatureDataGrid_field_captions_D} 
		 * @return 
		 * 
		 */		
		public function get captions():Array
		{
			return _captions;
		}

		public function set captions(value:Array):void
		{
			this._isShowCaptions = true;
			_captions = value; 
			if(this._features)
			{ 
				this.features = this.replaceFeaturesKeyValue(this._features, this._captions);  
				
			}
			this.invalidateProperties();
			this.initDataGrid();
		}
		
		/**
		 * ${controls_FeatureDataGrid_attribute_showCaptions_D} 
		 * @return 
		 * 
		 */
		public function get showCaptions():Array
		{
			return this._showCaptions;
		}
		
		public function set showCaptions(value:Array):void
		{
			if(value)
			{
				this._showCaptions = value;
				this.initDataGrid();
			}
		}
		
		private function stopDragHandler(event:MouseEvent):void
		{
			var dataGridColumn:DataGridColumn = this.columns[0] as DataGridColumn;
			if(dataGridColumn.draggable)
			{
				dataGridColumn.draggable = false;//第一列不允许拖拽 作为key列
			}
			event.stopPropagation();
			this.stopDrag();
		}
		
		//初始化表格数据，需要同时设置了showCaptions、captions和features
		private function initDataGrid():void
		{
			if(this._captions && this._showCaptions && this._features)
			{
				this.columns = this.getColumnsSF(this._showCaptions,this._captions);   
				this.dataProvider = this.getDataProvider(this._features);
			}
		}
		
		private function initFeaturesLayer(features:Array):void
		{   
			if(features)
			{
				var len:int = features.length;
				for(var i:int; i < len; i++)
				{
					var feature:Feature = features[i] as Feature;
					var isFeatureAdd:Boolean = this.isFeatureInArray(feature, this.featuresLayer.features as ArrayCollection);
					if(!isFeatureAdd)
					{
						this.featuresLayer.addFeature(feature);
//						this.featuresLayer.removeFeature(feature);
//						this.featuresLayer.refresh(); 
					}
//					this.featuresLayer.addFeature(feature);//图层添加要素
				} 
			}
		}
		
		private function isFeatureInArray(feature:Feature, features:ArrayCollection):Boolean
		{
			if(!feature || !features)
			{
				return false;
			}
			
			for each(var value:Feature in features)
			{
				if(value == feature)
				{ 
					return true;
				}
			}
			return false;//元素不在数组里
		}
		
		private function doubleClickHandler(event:MouseEvent):void
		{  
			try
			{
				event.target.data.records;
			}
			catch(error:Error)
			{
				return;
			}
			Alert.show("", resourceManager.getString("SuperMapMessage",SmResource.FD_DELETE), Alert.YES | Alert.NO, this, closeHandler);  
		}
		
		private function closeHandler(event:CloseEvent):void//模态对话框
		{
			if(event.detail == Alert.YES)
			{
				this.deleteSelectedIndex();
			} 
		}
		
		/**
		 * @private 
		 * @param value
		 * 
		 */		
		override public function set columns(value:Array):void
		{ 
			if(value)
			{
				super.columns = value;
				for each(var column:DataGridColumn in this.columns)
				{
					column.sortCompareFunction = this.sortByField;
				}
			}
		}
		
		private function headerReleaseHandler(event:DataGridEvent):void
		{ 
			this._sortField = event.dataField;  
		}
		
		public function sortByField(recordsOne:Object,recordsTwo:Object):int
		{  
			var numberOne:Number=Number(recordsOne[this._sortField].toString());
			var numberTwo:Number=Number(recordsTwo[this._sortField].toString());
			if(numberOne > numberTwo)
			{
				return 1;
			}
			else if(numberOne < numberTwo)
			{
				return -1;
			}
			else
			{
				return 0;
			}
		}
		
		private function featuresSplice(feature:Feature, features:Array):void
		{
			var len:int = features.length;
			for(var i:int; i < len; i++)
			{
				if(feature == features[i])//用dataProvider提供所选的item
				{
					features.splice(i, 1);
				}
			}  
		}
	    	
		private function deleteSelectedIndex():void
		{
			var dataProvider:XMLListCollection = this.dataProvider as XMLListCollection;
			if(dataProvider.length > 0 && this.selectedIndex != -1)
			{
				dataProvider.disableAutoUpdate();
				dataProvider.removeItemAt(this.selectedIndex);  
				var feature:Feature = this.findFeatureBySelectedItem();
				if(this.featuresLayer)
				{
					this.featuresLayer.removeFeature(feature);//删除指定的feature
				}
				this.featuresSplice(feature, this.features);
			 
				dataProvider.enableAutoUpdate(); //自动更新
				if(this.hasEventListener(FeatureDataGridEvent.FEATURE_DELETE))
				{
					this.dispatchEvent(new FeatureDataGridEvent(FeatureDataGridEvent.FEATURE_DELETE, feature));
				}
			}
		}
        
		/**
		 * ${controls_FeatureDataGrid_attribute_isHighLight_D} 
		 * @return 
		 * 
		 */		
		public function get isHighLight():Boolean
		{
			return _isHighLight;
		}
		
		public function set isHighLight(value:Boolean):void
		{
			_isHighLight = value;
			var feature:Feature;
			if(_isHighLight == false)
			{
				this.removeEventListener(ListEvent.CHANGE, gridChangeHandler);
				if(this._isAddFeatureListener == true)
				{
					for(var i:int; i < this._features.length; i++)
					{
						feature=  this._features[i]; 
						feature.removeEventListener(MouseEvent.CLICK, featureClickHandler);  
					}
					this._isAddFeatureListener = false;
				}
			}
			else
			{
				this.addEventListener(ListEvent.CHANGE, gridChangeHandler);
				if(this._isAddFeatureListener == false && this._features)
				{
					for(var j:int; j < this._features.length; j++)
					{
						feature =  this._features[i]; 
						feature.addEventListener(MouseEvent.CLICK, featureClickHandler);  
					}  
				}
			}
			this.refresh();
		}
		
		/**
		 * ${controls_FeatureDataGrid_attribute_parentContainer_D} 
		 * @return 
		 * 
		 */		
		public function get parentContainer():DisplayObject
		{
			return _parentContainer;
		}
		
		public function set parentContainer(value:DisplayObject):void
		{ 
			if(value != this._parentContainer)
			{
				this._parentContainer = value; 
				this._parentContainer.removeEventListener(CloseEvent.CLOSE, targetContainerCloseHandler);
				this._parentContainer.addEventListener(CloseEvent.CLOSE, targetContainerCloseHandler);
				this.refresh();
			} 
		}
		
		/**
		 * ${controls_FeatureDataGrid_attribute_featuresLayer_D} 
		 * @return 
		 * 
		 */		
		public function get featuresLayer():FeaturesLayer
		{
			return _featuresLayer;
		}
		
		public function set featuresLayer(value:FeaturesLayer):void
		{
			if(value)
			{
				this._featuresLayer = value;
				this._isFeaturesLayerReset = true; 
				this.refresh();
			}
		}
		
		/**
		 * ${controls_FeatureDataGrid_attribute_highLightStyle_D} 
		 * @return 
		 * 
		 */		
		public function get highLightStyle():Style
		{
			return _highLightStyle;
		}
		
		public function set highLightStyle(value:Style):void
		{
			if(value)
			{
				_highLightStyle = value;
				this.refresh();
			}
		}
		           
		/**
		 * ${controls_FeatureDataGrid_attribute_features_D} 
		 * @return 
		 * 
		 */		
		public function get features():Array
		{
			return _features;
		}
	 
		public function set features(value:Array):void
		{
		
			if(_features && this._normalStyle)
			{
				var len:int = this._features.length;
				for(var i:int; i < len; i++)
				{
					var feature:Feature =  this._features[i]; 
					feature.removeEventListener(MouseEvent.CLICK, featureClickHandler);  
				}  
				this._lastSelectedFeature.style = this._normalStyle; 
			}  
			if(value)
			{
				_features = value;
		 
				this._isFeaturesChange = true;
				
				if(value.length == 0)
				{ 
					return;
				}  
				if(this._captions)
				{ 
					this._features = this.replaceFeaturesKeyValue(value, this._captions); 
				}
				if(this._isHighLight)
				{
					for(i = 0; i < _features.length; i++)
					{
						var newFeature:Feature =  _features[i]; 
						if(!newFeature.style)//如果没有设置要素的风格，则默认一个
						{
							this.setStyles(newFeature);
						} 
						newFeature.addEventListener(MouseEvent.CLICK, featureClickHandler, false, 0, true);
					} 
					this._isAddFeatureListener = true;
				}  
				if(features && features.length > 0)
				{
					this._features = features;
					this.columns = this.getColumns(_features[0] as Feature);   
					this.dataProvider = this.getDataProvider(_features);
					try
					{
						if(this._featuresLayer)
						{
							this.initFeaturesLayer(_features); 
						}
					}
					catch(error:ErrorMessage)
					{
						throw new SmError(SmResource.WIDTH_LESSTHAN_ZERO);	
					}
				}  
			}
			this.refresh();
		}
	           
		private function refresh():void
		{
			this.invalidateProperties();
		}
		  
		/**
		 * ${controls_FeatureDataGrid_method_clear_D} 
		 * 
		 */		
		public function clear():void
		{
			var len:int = this._features.length;
			for(var i:int = 0; i < len; i++)
			{
				var feature:Feature = this._features[i]; 				
				if(this.featuresLayer)
				{
					this.featuresLayer.removeFeature(feature);//即使抛出错误 应该放在fl里处理
				} 
			} 
 			this._features.length = 0;
			this.dataProvider = null;
			this._highLightStyle = null;
			this._normalStyle = null;
		}
	        	
		
		private function setStyles(feature:Feature):void
		{ 
			if(feature)
			{			
				if(feature.geometry is GeoPoint)	
				{
					var pointstyle:PredefinedMarkerStyle = new PredefinedMarkerStyle();
					feature.style = pointstyle; 
				}
				else if(feature.geometry is GeoLine)
				{
					var lineStyle:PredefinedLineStyle = new PredefinedLineStyle();
					feature.style = lineStyle; 
				}
				else if(feature.geometry is GeoRegion)
				{
					var regionStyle:PredefinedFillStyle = new PredefinedFillStyle();
					feature.style = regionStyle; 
				}  
			}
		}
		       
		private function changeFeatureStyle(feature:Feature):void
		{
			if(feature)
			{
				if(!this._normalStyle)
				{
					if(feature.style)
					{
						this._normalStyle = feature.style;
					} 
				}
				if(!this._highLightStyle)//当高亮样式为空时，设置默认的样式
				{
					this.setDefaultHighLightStyle(feature); 
				}  
				if(this._lastSelectedFeature)
				{
					this._lastSelectedFeature.style = _normalStyle; 
				}
				this._normalStyle = feature.style;
				feature.style = this._highLightStyle;
				this._lastSelectedFeature = feature; 
			}
		}
		  
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(this._currentFeature)
			{ 
				if(this.isHighLight && this._isFeaturesChange == false)
				{
					this._currentFeature.style = this.highLightStyle;
				}
				else if(this._isFeaturesChange == true)
				{
					this._currentFeature.style = this._normalStyle;
					this._isFeaturesChange = false;
					this._currentFeature = null;
				}
				else
				{
					this._currentFeature.style = this._normalStyle;
				}
			}
			if(this._isFeaturesChange == true)//当_currentFeature为空时，将执行
			{ 
				this._isFeaturesChange = false;
				if(this._isShowCaptions && this._features)
				{  
					this._isShowCaptions = false; 
				}
			} 
			if(this._isFeaturesLayerReset == true)
			{
				this.initFeaturesLayer(this.features); 
				this._isFeaturesLayerReset = false;
			} 
			if(this._isShowCaptions)
			{ 
				if(this._features)
				{
					this._isShowCaptions = false;
				}
			}
		}
	             	    
		private function featureClickHandler(event:MouseEvent):void
		{    
			var feature:Feature = event.currentTarget as Feature; 
			this._currentFeature = feature;
			this.refresh();
			this.changeFeatureStyle(feature); 
			var i:int = this.findIndexByFeature(feature, this.features);
			if(i != -1)
			{
				this.selectedIndex = i;//对表进行操作
			} 
			this.scrollToIndex(this.selectedIndex);//DataGrid自动滚动将选中项显示出来 
			if(feature)
			{
				if (this.hasEventListener(FeatureDataGridEvent.FEATURE_CLICK))
				{
					var featureEvent:FeatureDataGridEvent = new FeatureDataGridEvent(FeatureDataGridEvent.FEATURE_CLICK, feature);
					this.dispatchEvent(featureEvent);
				}
    	    }
		} 
	    	
		private function findFeatureBySelectedItem():Feature
		{
			var column:Object = (this.columns[0] as DataGridColumn).dataField;
			var selectedItem:String = (this.selectedItem[column] as XMLList).toString();
			
			for(var i:int; i < this._features.length; i++)
			{ 
				var feature:Feature = this._features[i];
				if(feature.fields)
				{
					var fieldStr:String = feature.fields[0].value;
					if(StringUtil.trim(fieldStr) == StringUtil.trim(selectedItem))
					{
						return feature;
					} 
				}
				else
				{
					var obj:Object = feature.attributes;
					if(obj)
					{
						for each(var value:String in obj)
						{
							if(value == selectedItem)
							{
								return feature;
							}
						}
					}
				}
			}
			return null;
		}
		
		private function findIndexByFeature(feature:Feature, features:Array):int
		{
			if(!feature || !features)
			{
				return -1;
			}
			var column:Object = (this.columns[0] as DataGridColumn).dataField;//第1列
			for(var i:int; i < this.features.length; i++)
			{
				var value:String = (this.dataProvider[i][column] as XMLList).toString();				
				if(feature.fields && (value == feature.fields[0].value))//用dataProvider提供所选的item
				{
					return i;
				}
				else
				{
					var obj:Object = feature.attributes;
					if(obj)
					{
						for each(var str:String in obj)
						{
							if(value == str)
							{
								return i;
							}
						}
					}
				}
			} 
			return -1;
		}
		
		private function setDefaultHighLightStyle(feature:Feature):void
		{
			if(!feature)
			{
				return;
			}
	        
			if(feature.geometry is GeoPoint)	
			{
				var pointstyle:PredefinedMarkerStyle = new PredefinedMarkerStyle();
				if(Map.theme)
					pointstyle.color = Map.theme.hlPointColor;
				else
					pointstyle.color = 0xc2c2c2;
				this._highLightStyle = pointstyle; 
			}
			else if(feature.geometry is GeoLine)
			{
				var lineStyle:PredefinedLineStyle = new PredefinedLineStyle();
				if(Map.theme)
					lineStyle.color = Map.theme.hlLineColor;
				else
					lineStyle.color = 0x0046d2;
				this._highLightStyle = lineStyle; 
			}
			else if(feature.geometry is GeoRegion)
			{
				var lineStyle2:PredefinedLineStyle = new PredefinedLineStyle();
				if(Map.theme)
					lineStyle2.color = Map.theme.hlLineColor;
				else
					lineStyle2.color = 0x0046d2;
				var regionStyle:PredefinedFillStyle = new PredefinedFillStyle();
				regionStyle.border = lineStyle2;
				if(Map.theme)
					regionStyle.color = Map.theme.hlFillColor;
				else
					regionStyle.color = 0x33ff66;
				this._highLightStyle = regionStyle; 
			} 
		}
		
		private function targetContainerCloseHandler(event:CloseEvent):void//关闭
		{
			for(var i:int; i < this._features.length; i++)
			{
				var feature:Feature =  this._features[i];
				feature.removeEventListener(MouseEvent.CLICK, featureClickHandler);  
			} 
			if(this._lastSelectedFeature)
			{
				this._lastSelectedFeature.style = this._normalStyle;
			} 
			if(this._currentFeature)
			{
				this._currentFeature.style = this._normalStyle; 
			}
		}
 
		private function gridChangeHandler(event:ListEvent):void//用DataGrid选择
		{    
			if(this.selectedItem.SMID.valueOf() && this._features)
			{ 
				var feature:Feature = this.findFeatureBySelectedItem(); 
			 
				this._currentFeature = feature; 
				this.changeFeatureStyle(feature); 
				if (this.hasEventListener(FeatureDataGridEvent.FEATURE_SELECTED))
				{
					this.dispatchEvent(new FeatureDataGridEvent(FeatureDataGridEvent.FEATURE_SELECTED, feature));
			 	}
			}
		} 
	    
		//--------------------------------------------------------------------------------
		//      基本的方法
		//--------------------------------------------------------------------------------
		use namespace sm_internal;
		private function getCaptions(feature:Feature):Array  //TODO:这个方法重复执行了 要优化处理一下。。。
		{
			if(!feature)
			{
				return null;
			}
			var fields:Array;		
			var captions:Array = [];
			if(feature.fields)
			{
				fields = feature.fields;
				var len:int = fields.length;
				for(var i:int; i < len; i++)
				{
					var keyText:String = fields[i].key;
					setDataGridFormat(keyText, captions);				
				}
			}
			else
			{
				var obj:Object = feature.attributes;
				if(obj)
				{
					for(var key:String in obj)
					{
						captions.push(key);
					}
				}
			}
			return captions;
		}
		
		//设置dataGrid的标题栏
		private function getColumns(feature:Feature):Array
		{  
			if(!feature)
			{
				return null;
			}
			
			var captions:Array = this.getCaptions(feature); 
			var columns:Array = new Array();
			var column:DataGridColumn;
			for(var m:int = 0; m < captions.length; m++)
			{
				var txt:String = captions[m];
				column = new DataGridColumn();
				column.dataField = txt;
				
				if(txt.indexOf("_") != -1)
				{
					var str:String = txt.replace("_", ".");
					column.headerText = str;
				}
				else
					column.headerText = txt.toString();
				
				columns.push(column);
			} 
			return columns;
		}
		
		private function getColumnsSF(showCaptions:Array,captions:Array):Array
		{  
			if(!captions || !showCaptions)
			{
				return null;
			}
			var columns:Array = new Array();
			var column:DataGridColumn;
			for(var i:int = 0; i < showCaptions.length; i++)
			{
				var txt:String = showCaptions[i];
				column = new DataGridColumn();
				column.dataField = captions[i];
				column.headerText = txt.toString();
				columns.push(column);
			} 
			return columns;
		}
	        	
		//修改dataField带有"."这样的列名格式
		private function setDataGridFormat(dataField:String, captions:Array):Array
		{		
			var headerText:String = "";
			if(dataField.indexOf(".") != -1 )
			{
				var ary:Array= dataField.split(".");
				headerText = ary[0] + "_" + ary[1];
				captions.push(headerText);
//				captions.push(headerText.replace(".", "_"));
			}
			else
				captions.push(dataField);
			
			return captions;
		}
		
		private function getDataProvider(features:Array):XMLList//设置dataGrid的数据源
		{ 
			if(!features)
			{
				return null;
			}
			
			if(showCaptions && captions)
			{
				var recordsXmlSC:XML = new XML("<records></records>");
				var showCaptions:Array = this._captions;
				
				
				for(var i:int = 0; i < features.length; i++)
				{
					var recordXmlSC:XML = new XML("<records></records>");  
					
					var feature:Feature = features[i] as Feature;
					var objSF:Object = feature.attributes;
					
					for(var m:int = 0; m < showCaptions.length; m++)
					{  
						recordXmlSC.appendChild(<{showCaptions[m]}>{objSF[showCaptions[m]]}</{showCaptions[m]}>);
					}  
					recordsXmlSC.appendChild(recordXmlSC);
				}
				return recordsXmlSC.children();
			}
			else
			{
				var recordsXml:XML = new XML("<records></records>");
				var captions:Array = this.getCaptions(features[0] as Feature);  //获取标题栏 
				
				var values:Array = null;
				
				for(var j:int = 0; j < features.length; j++)//循环4次，则有四条记录
				{
					var recordXml:XML = new XML("<records></records>");  
					
					var field:Array;
					values = []; 
					var fea:Feature = features[j] as Feature;
					field = fea.fields; 
					if(field && field.length)
					{					
						for(var a:int = 0; a < field.length; a++)
						{
							var fieldValue:String = field[a].value;
							var obj:Object = fea.attributes;
							var key:String = field[a].key;
							if(!fieldValue)//处理为空的情况
							{
								for(var ss:String in obj)
								{
									if(ss == key)
									{
										values.push(obj[key]);
										field[a].value = obj[key];
									}
								}
							}
							else
								values.push(fieldValue);
						}
					}
					else
					{
						var obj2:Object = fea.attributes;
						if(obj)
						{
							for each(var value2:String in obj)
							{
								values.push(value2);
							}
						}
					}	
					
					for(var k:int = 0; k < captions.length; k++)//循环16次，则有16列
					{  
						recordXml.appendChild(<{captions[k]}>{values[k]}</{captions[k]}>);
					}  
					recordsXml.appendChild(recordXml);
				}
				return recordsXml.children();
			}
		}
		 
		private function replaceFeaturesKeyValue(features:Array, captions:Array):Array
		{ 
			var len:int = features.length;
			for(var i:int; i < len; i++)
			{ 
				var feature:Feature = features[i];
				feature.fields = this.replaceFieldKeyValue(feature.fields, captions);  
			}
			return features; 
		}	    	  
		
		private function replaceFieldKeyValue(fields:Array, captions:Array):Array
		{ 		
			var newKey:String;
			if(fields)
			{
				if(captions.length >= fields.length)
				{
					for(var i:int; i < fields.length; i++)
					{
						newKey = captions[i].toString();
						fields[i].key = newKey;
					} 
				}
				else if(captions.length < fields.length)
				{
					for(var j:int; j < captions.length; j++)
					{
						newKey = captions[j].toString();
						fields[j].key = newKey;
					} 
				}
			}
			else
			{				
				fields = [];				
				for(var n:int = 0; n < captions.length; n++)
				{
					fields.push(new Object());
				}				
				for(var m:int; m < captions.length; m++)
				{
					newKey = captions[m].toString();
					fields[m].key = newKey;
				} 
			}
			return fields;
		}
		
		// TODO:允许修改某一个字段名
		private function setCaption(oldCaption:String = "", caption:String = ""):void
		{
			var dataProvider:XMLListCollection = this.dataProvider as XMLListCollection;
			var len:int = dataProvider.length;
			if(len > 0)
			{
				for(var i:int = 0; i < len; i++)
				{
					var xml:XML = dataProvider.getItemAt(i) as XML;
					if(xml)
					{
						for each(var prop:XML in xml.children()) 
						{
							var nodeName:String = prop.name().toString();
							if(nodeName == oldCaption && oldCaption != caption)
							{
								prop.setName(caption);
//								dataProvider.enableAutoUpdate(); 
							}
						}
					}
				}
			}
			super.invalidateProperties();
		}
	}
}