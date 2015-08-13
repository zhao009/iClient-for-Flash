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
	
	import com.supermap.web.core.Graphic;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.mapping.GraphicsLayer;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import mx.controls.DataGrid;
	import mx.events.DataGridEvent;
	import com.supermap.web.core.styles.graphicStyles.GraphicMarkerStyle;
	import com.supermap.web.core.styles.graphicStyles.GraphicLineStyle;
	import com.supermap.web.core.styles.graphicStyles.GraphicFillStyle;
	import com.supermap.web.events.GraphicDataGridEvent;
	import mx.core.mx_internal;
	
	/**
	 * ${controls_GraphicDataGrid_Event_graphicSelected_D}
	 */
	[Event(name="graphicSelected", type="com.supermap.web.events.GraphicDataGridEvent")]
	/**
	 * ${controls_GraphicDataGrid_Event_graphicClick_D}
	 */
	[Event(name="graphicClick", type="com.supermap.web.events.GraphicDataGridEvent")]
	/**
	 * ${controls_GraphicDataGrid_Event_graphicDelete_D}
	 */
	[Event(name="graphicDelete", type="com.supermap.web.events.GraphicDataGridEvent")]
	
	//控件图片FeatureDataGrid.png得改成GraphicDataGrid.png，找美工做
	[IconFile("/designIcon/GraphicDataGrid.png")]
	/**
	 * ${controls_GraphicDataGrid_Title}. 
	 * <p>${controls_GraphicDataGrid_Description}</p>
	 * 
	 */	
	public class GraphicDataGrid extends DataGrid
	{
		private var _graphicItems:Array;
		
		private var _captions:Array; 
		private var _fields:Array;
		private var _graphicsLayer:GraphicsLayer;
		private var _lastSelectedGraphic:Graphic;
		private var _currentGraphic:Graphic;
		private var _highLightStyle:Style;
		private var _normalStyle:Style;
		//表格的父级容器，此处只是为了捕获父级容器关闭时来触发列表关闭，用户使用时还是需要手动的将此列表添加进父级容器
		private var _parentContainer:DisplayObject;
		//设置是否需要表格和图形的互交互事件
		private var _isHighLight:Boolean = true;
		//记录当前是否添加了表格和图形的互交互事件
		private var _isAddGraphicListener:Boolean = false;
		
		private var _isGraphicsLayerReset:Boolean = false;
		private var _isGraphicsChange:Boolean = false;
		private var _isShowCaptions:Boolean = false;
		private var _sortField:Object;//排序字段 
		//用于累加给_graphicItems设定唯一的id
		private var _idCount:int = 0;
		
		use namespace sm_internal;
		/**
		 * ${controls_GraphicDataGrid_constructor_D} 
		 * @param graphicsLayer ${controls_GraphicDataGrid_constructor_param_graphicsLayer}
		 * @param graphics ${controls_GraphicDataGrid_constructor_param_graphics}
		 * @param parentContainer ${controls_GraphicDataGrid_constructor_param_parentContainer} 
		 * 
		 */	
		public function GraphicDataGrid(graphicsLayer:GraphicsLayer = null, graphics:Array = null, parentContainer:DisplayObject = null)
		{
			this.doubleClickEnabled = true;
			this.addEventListener(DataGridEvent.HEADER_RELEASE, headerReleaseHandler);  
			//注册双击列表的事件，后续会进行删除graphic的操作
			this.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClickHandler); 
			this.addEventListener(MouseEvent.MOUSE_DOWN, stopDragHandler);
			//注册点击列表的事件
			this.addEventListener(ListEvent.CHANGE, gridChangeHandler);
			this.graphicsLayer = graphicsLayer;//在这里调用接口 
			this.graphicItems = graphics;
			this.isHighLight = true;
			if(this.graphicItems)
			{
				this.parentContainer = parentContainer; 
			} 
		}
		
		//--------------------------------------------------------------------------------
		//      属性
		//--------------------------------------------------------------------------------
		
		
		/**
		 * ${controls_GraphicDataGrid_attribute_captions_D} 
		 * @return 
		 * 
		 */	
		public function get captions():Array
		{
			return _captions;
		}
		
		public function set captions(value:Array):void
		{
			if(value)
			{
				this._captions = value;
				this.initDataGrid();
				this.initGraphicsLayer();
			}
		}
		
		/**
		 * ${controls_GraphicDataGrid_attribute_fields_D} 
		 * @return 
		 * 
		 */
		public function get fields():Array
		{
			return this._fields;
		}
		
		public function set fields(value:Array):void
		{
			if(value)
			{
				this._fields = value;
				//如果没有设置captions属性则默认为fields
				if(!this._captions)
				{
					this.captions = this._fields;
				}
				this.initDataGrid();
				this.initGraphicsLayer();
			}
		}
		
		/**
		 * ${controls_GraphicDataGrid_attribute_graphicItems_D} 
		 * @return 
		 * 
		 */
		public function get graphicItems():Array
		{
			return _graphicItems;
		}
		
		public function set graphicItems(value:Array):void
		{
			
			if(value)
			{
				this._graphicItems = value;
				for(var i:int = 0;i<this._graphicItems.length;i++)
				{
					var graphic:Graphic = this._graphicItems[i] as Graphic;
					graphic.sm_internal::soleID = this._idCount++;
				}
				this.initDataGrid();
				this.initGraphicsLayer();
			}
		}
		
		
		/**
		 * ${controls_GraphicDataGrid_attribute_graphicsLayer_D} 
		 * @return 
		 * 
		 */
		public function get graphicsLayer():GraphicsLayer
		{
			return _graphicsLayer;
		}
		
		public function set graphicsLayer(value:GraphicsLayer):void
		{
			if(value)
			{
				this._graphicsLayer = value;
				this._isGraphicsLayerReset = true; 
				this.initDataGrid();
				this.initGraphicsLayer();
			}
		}
		
		
		/**
		 * ${controls_GraphicDataGrid_attribute_highLightStyle_D} 
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
		 * ${controls_GraphicDataGrid_attribute_isHighLight_D} 
		 * @return 
		 * 
		 */
		public function get isHighLight():Boolean
		{
			return _isHighLight;
		}
		
		public function set isHighLight(value:Boolean):void
		{
			this._isHighLight = value;
		}
		
		
		/**
		 * ${controls_GraphicDataGrid_attribute_parentContainer_D} 
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
		
		//覆盖基类的columns属性，添加排序的事件
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
		
		//--------------------------------------------------------------------------------
		//      公有方法
		//--------------------------------------------------------------------------------
		
		/**
		 * ${controls_GraphicDataGrid_method_clear_D} 
		 * 
		 */	
		public function clear():void
		{
			var len:int = this._graphicItems.length;
			if(this.graphicsLayer)
			{
				this.graphicsLayer.removeAll();
			} 
			this._graphicItems.length = 0;
			this.dataProvider = null;
			this._highLightStyle = null;
			this._normalStyle = null;
		}
		
		//--------------------------------------------------------------------------------
		//      涉及的事件处理函数
		//--------------------------------------------------------------------------------
		
		//在列表排序时触发的事件，根据如下规则进行排序
		private function sortByField(recordsOne:Object,recordsTwo:Object):int
		{  
			var strOne:String = recordsOne[this._sortField].toString();
			var strTwo:String = recordsTwo[this._sortField].toString();
			var numberOne:Number=Number(strOne);
			var numberTwo:Number=Number(strTwo);
			//数字
			if(numberOne.toString() != "NaN" && numberTwo.toString() != "NaN")
			{
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
			//非数字，就按照字符串的形式进行比较
			else
			{
				for(var i:int = 0;i<strOne.length;i++)
				{
					if(this.compareString(strOne.charAt(i),strTwo.charAt(i)) == 0)
					{
						continue;
					}
					else
					{
						return this.compareString(strOne.charAt(i),strTwo.charAt(i))
					}
				}
				return 1;
			}
		}
		//比较两个字母的先后顺序，是反的
		private function compareString(strOne:String,strTwo:String):int
		{
			if(strOne > strTwo)
			{
				return 1;
			}
			else if(strOne < strTwo)
			{
				return -1;
			}
			else
			{
				return 0;
			}
		}
		
		//构造函数里面注册的三个事件
		private function headerReleaseHandler(event:DataGridEvent):void
		{ 
			this._sortField = event.dataField;  
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
		
		private function stopDragHandler(event:MouseEvent):void
		{
			event.stopPropagation();
			this.stopDrag();
		}
		
		private function closeHandler(event:CloseEvent):void//模态对话框
		{
			if(event.detail == Alert.YES)
			{
				//删除双击的这一行
				this.deleteSelectedIndex();
			} 
		}
		
		private function targetContainerCloseHandler(event:CloseEvent):void//关闭
		{
			//移除事件
			if(this._lastSelectedGraphic)
			{
				this._lastSelectedGraphic.style = this._normalStyle;
			} 
			if(this._currentGraphic)
			{
				this._currentGraphic.style = this._normalStyle; 
			}
			this._graphicsLayer.refresh();
		}
		//注册选择列表的事件处理函数
		private function gridChangeHandler(event:ListEvent):void//用DataGrid选择
		{    
			if(this.selectedItem.SOLEID.valueOf() && this._graphicItems)
			{ 
				var graphic:Graphic = this.findGraphicBySelectedItem(); 
				
				this._currentGraphic = graphic; 
				//如果联动
				if(this.isHighLight)
				{
					this.changeGraphicStyle(graphic);
				}
				 
				//触发选择事件
				if (this.hasEventListener(GraphicDataGridEvent.GRAPHIC_SELECTED))
				{
					this.dispatchEvent(new GraphicDataGridEvent(GraphicDataGridEvent.GRAPHIC_SELECTED, graphic));
				}
			}
		} 
		
		private function graphicClickHandler(graphic:Graphic):void
		{    
			this._currentGraphic = graphic;
			
			
			if(this.isHighLight)
			{
				this.changeGraphicStyle(graphic);
				var i:int = this.findIndexByGraphic(graphic, this.graphicItems);
				if(i != -1)
				{
					this.selectedIndex = i;//对表进行操作
				} 
				this.scrollToIndex(this.selectedIndex);//DataGrid自动滚动将选中项显示出来 
			}
			this.refresh();
			if(graphic)
			{
				if (this.hasEventListener(GraphicDataGridEvent.GRAPHIC_CLICK))
				{
					this.dispatchEvent(new GraphicDataGridEvent(GraphicDataGridEvent.GRAPHIC_CLICK, graphic));
				}
			}
		} 
		
		
		
		//--------------------------------------------------------------------------------
		//      基本的私有方法
		//--------------------------------------------------------------------------------
		
		//刷新
		private function refresh():void
		{
			this.invalidateProperties();
		}
		
		//初始化图层，需要同时设置了graphicItems和graphicsLayer
		private function initGraphicsLayer():void
		{   
			if(this._graphicItems && this._graphicsLayer)
			{
				var len:int = this._graphicItems.length;
				this._graphicsLayer.removeAll();
				this._graphicsLayer.add(this._graphicItems);
				this._graphicsLayer.sm_internal::graphicItemClickHandler = graphicClickHandler;
				this.refresh();
			}
		}
		//初始化表格数据，需要同时设置了fields、captions和graphicItems
		private function initDataGrid():void
		{
			if(this._captions && this._fields && this._graphicItems)
			{
				this.columns = this.getColumns(this._captions,this._fields);   
				this.dataProvider = this.getDataProvider(this._graphicItems);
			}
		}
		
		//设置dataGrid的标题栏
		private function getColumns(captions:Array,fields:Array):Array
		{  
			if(!captions || !fields)
			{
				return null;
			}
			var columns:Array = new Array();
			var column:DataGridColumn;
			for(var i:int = 0; i < captions.length; i++)
			{
				var txt:String = captions[i];
				column = new DataGridColumn();
				column.dataField = fields[i];
				column.headerText = txt.toString();
				columns.push(column);
			} 
			return columns;
		}
		//设置dataGrid的数据源
		private function getDataProvider(graphics:Array):XMLList
		{ 
			if(!graphics)
			{
				return null;
			}
			
			var recordsXml:XML = new XML("<records></records>");
			var captions:Array = this._fields; 
			
			
			for(var i:int = 0; i < graphics.length; i++)
			{
				var recordXml:XML = new XML("<records></records>");  
				
				var graphic:Graphic = graphics[i] as Graphic;
				var obj:Object = graphic.attributes;
				
				for(var j:int = 0; j < captions.length; j++)
				{  
					recordXml.appendChild(<{captions[j]}>{obj[captions[j]]}</{captions[j]}>);
				}  
				recordXml.appendChild(<{"SOLEID"}>{graphic.sm_internal::soleID}</{"SOLEID"}>);
				recordsXml.appendChild(recordXml);
			}
			return recordsXml.children();
		}
		
		private function deleteSelectedIndex():void
		{
			var dataProvider:XMLListCollection = this.dataProvider as XMLListCollection;
			if(dataProvider.length > 0 && this.selectedIndex != -1)
			{
				dataProvider.disableAutoUpdate();
				dataProvider.removeItemAt(this.selectedIndex);  
				var graphic:Graphic = this.findGraphicBySelectedItem();
				if(this._graphicsLayer)
				{
					//删除没有成功，需要测试找到原因
					this._graphicsLayer.remove([graphic]);//删除指定的graphic
				}
				this.featuresSplice(graphic, this.graphicItems);
				
				dataProvider.enableAutoUpdate(); //自动更新
				//触发删除graphic的事件
				if(this.hasEventListener(GraphicDataGridEvent.GRAPHIC_DELETE))
				{
					this.dispatchEvent(new GraphicDataGridEvent(GraphicDataGridEvent.GRAPHIC_DELETE, graphic));
				}
			}
		}
		
		private function featuresSplice(graphic:Graphic, graphics:Array):void
		{
			var len:int = graphics.length;
			for(var i:int; i < len; i++)
			{
				if(graphic == graphics[i])//用dataProvider提供所选的item
				{
					graphics.splice(i, 1);
				}
			}  
		}
		
		private function findGraphicBySelectedItem():Graphic
		{
			var selectedItem:String = (this.selectedItem["SOLEID"] as XMLList).toString();
			
			for(var i:int; i < this._graphicItems.length; i++)
			{ 
				var graphic:Graphic = this._graphicItems[i];
				                                                                     
				if(graphic.sm_internal::soleID.toString() == selectedItem)
				{
					return graphic;
				}
				
			}
			return null;
		}
		
		private function changeGraphicStyle(graphic:Graphic):void
		{
			if(graphic)
			{
				if(!this._normalStyle)
				{
					if(graphic.style)
					{
						this._normalStyle = graphic.style;
					} 
				}
				if(!this._highLightStyle)//当高亮样式为空时，设置默认的样式
				{
					this.setDefaultHighLightStyle(graphic); 
				}  
				if(this._lastSelectedGraphic)
				{
					this._lastSelectedGraphic.style = _normalStyle; 
				}
				graphic.style = this._highLightStyle;
				this._lastSelectedGraphic = graphic; 
				this._graphicsLayer.refresh();
			}
		}
		
		private function setDefaultHighLightStyle(graphic:Graphic):void
		{
			if(!graphic)
			{
				return;
			}
			
			if(graphic.geometry is GeoPoint)	
			{
				var pointstyle:GraphicMarkerStyle = new GraphicMarkerStyle();
				if(Map.theme)
					pointstyle.color = Map.theme.hlPointColor;
				else
					pointstyle.color = 0xc2c2c2;
				this._highLightStyle = pointstyle; 
			}
			else if(graphic.geometry is GeoLine)
			{
				var lineStyle:GraphicLineStyle = new GraphicLineStyle();
				if(Map.theme)
					lineStyle.color = Map.theme.hlLineColor;
				else
					lineStyle.color = 0x0046d2;
				this._highLightStyle = lineStyle; 
			}
			else if(graphic.geometry is GeoRegion)
			{
				var lineStyle2:PredefinedLineStyle = new PredefinedLineStyle();
				if(Map.theme)
					lineStyle2.color = Map.theme.hlLineColor;
				else
					lineStyle2.color = 0x0046d2;
				var regionStyle:GraphicFillStyle = new GraphicFillStyle();
				regionStyle.border = lineStyle2;
				if(Map.theme)
					regionStyle.color = Map.theme.hlFillColor;
				else
					regionStyle.color = 0x33ff66;
				this._highLightStyle = regionStyle; 
			} 
		}
		
		
		private function findIndexByGraphic(graphic:Graphic, graphics:Array):int
		{
			if(!graphic || !graphics)
			{
				return -1;
			}
			
			for(var i:int; i < graphics.length; i++)
			{
				var value:String = (this.dataProvider[i]["SOLEID"] as XMLList).toString();
				
				if(graphic.sm_internal::soleID.toString() == value)
				{
					return i;
				}
			} 
			return -1;
		}
		
		
		
	}
}