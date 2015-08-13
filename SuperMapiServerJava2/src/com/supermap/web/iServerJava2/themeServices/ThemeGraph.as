package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeGraph_Title}.
	 * <p>${iServer2_themeServices_ThemeGraph_Description}</p> 
	 * 
	 * 
	 */	
	public class ThemeGraph extends Theme
	{
		
		private var _items:Array;
		//统计图的水平偏移量或者表达偏移量的字段(该字段必须为数值型字段)表达式
		private var _offsetX:String = "0.0"
		//统计图的垂直偏移量或者表达偏移量的字段(该字段必须为数值型字段)表达式
		private var _offsetY:String = "0.0";
		//统计专题图类型
		private var _graphType:int = GraphType.PIE;
		//柱状专题图中每一个柱的宽度。使用地图坐标单位
		private var _barWidth:Number = 0;
		//饼状统计图的起始角度，默认以水平方向为正向。单位为度，精确到0.1度
		private var _startAngle:Number = 0;
		//统计图中玫瑰图或三维玫瑰图分片的角度，单位为度，精确到0.1度
		private var _roseAngle:Number = 0;
		//专题图的渲染风格是否流动显示
		private var _isFlowEnabled:Boolean = false;
		//统计图与其表示对象之间牵引线的风格
		private var _leaderLineStyle:ServerStyle = new ServerStyle();
		//是否显示统计图和它所表示的对象之间的牵引线
		private var _isLeaderLineDisplayed:Boolean = false;
		//专题图中是否显示属性为负值的数据
		private var _isNegativeDisplayed:Boolean = false;
		// 坐标轴颜色
		private var _axesColor:ServerColor = new ServerColor(0, 0, 0);
		//统计图坐标轴文本的风格
		private var _axesTextStyle:ServerTextStyle = null;
		//是否显示坐标轴
		private var _isAxesDisplayed:Boolean = false;
		//是否显示坐标轴的文本标注
		private var _isAxesTextDisplayed:Boolean = false;
		// 是否在统计图坐标轴上显示网格
		private var _isAxesGridDisplayed:Boolean = false;
		//统计图上的文字标注风格
		private var _graphTextStyle:ServerTextStyle = null;
		//统计专题图文本显示格式，如百分数、真实数值、标题、标题+百分数、标题+真实数值
		private var _graphTextFormat:int = GraphTextFormat.VALUE;
		// 是否显示统计图上的文本标注
		private var _isGraphTextDisplayed:Boolean = false;
		//统计图表专题图最小图表的尺寸，单位为像素。在最大和最小图表之间采用逐渐变化
		private var _minGraphSize:Number = 40;
		//统计图表专题图最大的图表大小，单位为像素。在最大和最小图表之间采用逐渐变化
		private var _maxGraphSize:Number = 60;
		// 一个布尔值指定在放大或者缩小地图时统计图是否固定大小
		private var _isGraphSizeFixed:Boolean = false;
		//统计图中地理要素的值与图表尺寸间的映射关系（常数，对数，平方根），即分级方式
		private var _graduatedMode:int = GraduatedMode.CONSTANT;
		
		
		/**
		 * ${iServer2_themeServices_ThemeGraph_constructor_None_D_as} 
		 * 
		 */
		public function ThemeGraph()
		{
			super();
			this.themeType = ThemeType.GRAPH;
		}
		
		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_graduatedMode_D}
		 * @default GraduatedMode.CONSTANT
		 * @see GraduatedMode 
		 */
		public function get graduatedMode():int
		{
			return _graduatedMode;
		}

		public function set graduatedMode(value:int):void
		{
			_graduatedMode = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_isGraphSizeFixed_D} 
		 * @default false
		 */
		public function get isGraphSizeFixed():Boolean
		{
			return _isGraphSizeFixed;
		}

		public function set isGraphSizeFixed(value:Boolean):void
		{
			_isGraphSizeFixed = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_maxGraphSize_D}.
		 * <p>${iServer2_themeServices_ThemeGraph_attribute_maxGraphSize_remarks}</p>
		 * @default 60
		 */
		public function get maxGraphSize():Number
		{
			return _maxGraphSize;
		}

		public function set maxGraphSize(value:Number):void
		{
			_maxGraphSize = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_minGraphSize_D}.
		 * <p>${iServer2_themeServices_ThemeGraph_attribute_minGraphSize_remarks}</p> 
		 * @default 40
		 */
		public function get minGraphSize():Number
		{
			return _minGraphSize;
		}

		public function set minGraphSize(value:Number):void
		{
			_minGraphSize = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_isGraphTextDisplayed_D}
		 * @default false 
		 */
		public function get isGraphTextDisplayed():Boolean
		{
			return _isGraphTextDisplayed;
		}

		public function set isGraphTextDisplayed(value:Boolean):void
		{
			_isGraphTextDisplayed = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_graphTextFormat_D} 
		 * @see GraphTextFormat
		 */
		public function get graphTextFormat():int
		{
			return _graphTextFormat;
		}

		public function set graphTextFormat(value:int):void
		{
			_graphTextFormat = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_graphTextStyle_D} 
		 */
		public function get graphTextStyle():ServerTextStyle
		{
			return _graphTextStyle;
		}

		public function set graphTextStyle(value:ServerTextStyle):void
		{
			_graphTextStyle = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_isAxesGridDisplayed_D}
		 * @default false 
		 */
		public function get isAxesGridDisplayed():Boolean
		{
			return _isAxesGridDisplayed;
		}

		public function set isAxesGridDisplayed(value:Boolean):void
		{
			_isAxesGridDisplayed = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_isAxesTextDisplayed_D}
		 * @default false 
		 */
		public function get isAxesTextDisplayed():Boolean
		{
			return _isAxesTextDisplayed;
		}

		public function set isAxesTextDisplayed(value:Boolean):void
		{
			_isAxesTextDisplayed = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_isAxesDisplayed_D}.
		 * <p>${iServer2_themeServices_ThemeGraph_attribute_isAxesDisplayed_remarks}</p>
		 * @default false 
		 */
		public function get isAxesDisplayed():Boolean
		{
			return _isAxesDisplayed;
		}

		public function set isAxesDisplayed(value:Boolean):void
		{
			_isAxesDisplayed = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_axesTextStyle_D} 
		 */
		public function get axesTextStyle():ServerTextStyle
		{
			return _axesTextStyle;
		}

		public function set axesTextStyle(value:ServerTextStyle):void
		{
			_axesTextStyle = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_axesColor_D}
		 * @default (0,0,0) 
		 */
		public function get axesColor():ServerColor
		{
			return _axesColor;
		}

		public function set axesColor(value:ServerColor):void
		{
			_axesColor = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_isNegativeDisplayed_D}
		 * @default false 
		 */
		public function get isNegativeDisplayed():Boolean
		{
			return _isNegativeDisplayed;
		}

		public function set isNegativeDisplayed(value:Boolean):void
		{
			_isNegativeDisplayed = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_isLeaderLineDisplayed_D}.
		 * <p>${iServer2_themeServices_ThemeGraph_attribute_isLeaderLineDisplayed_remarks}</p> 
		 * @see #isFlowEnabled
		 */
		public function get isLeaderLineDisplayed():Boolean
		{
			return _isLeaderLineDisplayed;
		}

		public function set isLeaderLineDisplayed(value:Boolean):void
		{
			_isLeaderLineDisplayed = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_leaderLineStyle_D}.
		 * ${iServer2_themeServices_ThemeGraph_attribute_leaderLineStyle_remarks} 
		 */
		public function get leaderLineStyle():ServerStyle
		{
			return _leaderLineStyle;
		}

		public function set leaderLineStyle(value:ServerStyle):void
		{
			_leaderLineStyle = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_isFlowEnabled_D} 
		 */
		public function get isFlowEnabled():Boolean
		{
			return _isFlowEnabled;
		}

		public function set isFlowEnabled(value:Boolean):void
		{
			_isFlowEnabled = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_roseAngle_D}.
		 * <p>${iServer2_themeServices_ThemeGraph_attribute_roseAngle_remarks}</p> 
		 */
		public function get roseAngle():Number
		{
			return _roseAngle;
		}

		public function set roseAngle(value:Number):void
		{
			_roseAngle = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_startAngle_D} 
		 * @default 0
		 */
		public function get startAngle():Number
		{
			return _startAngle;
		}

		public function set startAngle(value:Number):void
		{
			_startAngle = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_barWidth_D}.
		 * <p>${iServer2_themeServices_ThemeGraph_attribute_barWidth_remarks}</p>
		 * @default 0 
		 */
		public function get barWidth():Number
		{
			return _barWidth;
		}

		public function set barWidth(value:Number):void
		{
			_barWidth = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_graphType_D}.
		 * <p>${iServer2_themeServices_ThemeGraph_attribute_graphType_remarks}</p> 
		 * @see GraphType 
		 */
		public function get graphType():int
		{
			return _graphType;
		}

		public function set graphType(value:int):void
		{
			_graphType = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_offsetY_D}
		 * @default 0.0 
		 */
		public function get offsetY():String
		{
			return _offsetY;
		}

		public function set offsetY(value:String):void
		{
			_offsetY = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_offsetX_D} 
		 * @default 0.0
		 */
		public function get offsetX():String
		{
			return _offsetX;
		}

		public function set offsetX(value:String):void
		{
			_offsetX = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeGraph_attribute_items_D}.
		 * <p>${iServer2_themeServices_ThemeGraph_attribute_items_remarks}</p> 
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
		}

		/**
		 * @private 
		 * @return 
		 * 
		 */
		sm_internal function toJSON():String
		{
			var json:String = "";
			if(this.items)
			{
				if(this.items.length > 0)
				{
					var tempItems:Array = new Array();
					
					for(var i:int = 0; i < this.items.length; i++)
					{
						tempItems.push(ThemeGraphItem.toJSON(this.items[i]));
					}
					json += "\"items\":" + "[" + tempItems.join(",") + "]" + ",";
				}
			}
			else
				json += "\"items\":" + "[]" + ",";
			
			json += "\"offsetX\":" + "\"" + this.offsetX + "\",";
			
			json += "\"offsetY\":" + "\"" + this.offsetY + "\",";
			
			json += "\"graphType\":" + this.graphType + "," ;
			
			json += "\"barWidth\":" + this.barWidth + ",";
			
			json += "\"startAngle\":" + this.startAngle + "," ;
			
			json += "\"roseAngle\":" + this.roseAngle + "," ;
			
			json += "\"isFlowEnabled\":" + this.isFlowEnabled + ",";
			
			
			if(this.leaderLineStyle)
				json += "\"leaderLineStyle\":" + this.leaderLineStyle.toJSON() + ",";
			
			if(this.isFlowEnabled == false)
				this.isLeaderLineDisplayed = false;
			
			json += "\"isLeaderLineDisplayed\":" + this.isLeaderLineDisplayed + ",";
			
			json += "\"isNegativeDisplayed\":" + this.isNegativeDisplayed + ",";
			
			json += "\"isAxesDisplayed\":" + this.isAxesDisplayed + ",";	
			
			if(this.isAxesDisplayed && this.axesTextStyle == null)
				this.axesTextStyle = new ServerTextStyle();
			
			if(this.axesTextStyle)
				json += "\"axesTextStyle\":" + this.axesTextStyle.toJSON() + ",";
			
			json += "\"axesColor\":" + this.axesColor.toJSON() + ",";
			
			json += "\"isAxesTextDisplayed\":" + this.isAxesTextDisplayed + ",";	
			
			json += "\"isAxesGridDisplayed\":" + this.isAxesGridDisplayed + ",";
			
			json += "\"isGraphTextDisplayed\":" + this.isGraphTextDisplayed + ",";
			
			if(this.isGraphTextDisplayed && this.graphTextStyle == null)
				this.graphTextStyle = new ServerTextStyle();
			
			if(this.graphTextStyle)
				json += "\"graphTextStyle\":" + this.graphTextStyle.toJSON() + ",";
			
			json += "\"graphTextFormat\":" + this.graphTextFormat + ",";
			
			
			json += "\"minGraphSize\":" + this.minGraphSize + ",";
			
			json += "\"maxGraphSize\":" + this.maxGraphSize + ",";
			
			json += "\"isGraphSizeFixed\":" + this.isGraphSizeFixed + ",";
			
			json += "\"graduatedMode\":" + this.graduatedMode + ",";
			
			json += "\"themeType\":" + this.themeType;
			
			
			if(json.length > 0)
				json = "{" + json + "}";
			return json;
		}
		
		sm_internal static function toThemeGraph(object:Object):ThemeGraph
		{
			var themeGraph:ThemeGraph;
			if(object)
			{
				themeGraph = new ThemeGraph();
				themeGraph.axesColor = ServerColor.toServerColor(object.axesColor);
				
				themeGraph.axesTextStyle = ServerTextStyle.toServerTextStyle(object.axesTextStyle);
				
				themeGraph.barWidth = object.barWidth;
				
				themeGraph.graduatedMode = object.graduatedMode;
				
				themeGraph.graphTextFormat = object.graphTextFormat;
				
				themeGraph.graphTextStyle = ServerTextStyle.toServerTextStyle(object.graphTextStyle)
				
				themeGraph.graphType = object.graphType;
				
				themeGraph.isAxesDisplayed = object.isAxesDisplayed;
				
				themeGraph.isAxesGridDisplayed = object.isAxesGridDisplayed;
				
				themeGraph.isAxesTextDisplayed = object.isAxesTextDisplayed;
				
				themeGraph.isFlowEnabled = object.isFlowEnabled;
				
				themeGraph.isGraphSizeFixed = object.isGraphSizeFixed;
				
				themeGraph.isGraphTextDisplayed = object.isGraphTextDisplayed;
				
				themeGraph.isLeaderLineDisplayed = object.isLeaderLineDisplayed;
				
				themeGraph.isNegativeDisplayed = object.isNegativeDisplayed;
				
				if(object.items)
				{
					var temeItmes:Array = object.items;
					themeGraph.items = new Array();
					for(var i:int = 0; i < temeItmes.length; i++)
					{
						themeGraph.items.push(ThemeGraphItem.toThemeGraphItem(temeItmes[i]));
					}
				}
				
				themeGraph.leaderLineStyle = ServerStyle.toServerStyle(object.leaderLineStyle);
				
				themeGraph.maxGraphSize = object.maxGraphSize;
				
				themeGraph.minGraphSize = object.minGraphSize;
				
				themeGraph.offsetX = object.offsetX;
				
				themeGraph.offsetY = object.offsetY;
				
				themeGraph.roseAngle = object.roseAngle;
				
				themeGraph.startAngle = object.startAngle;
				
				themeGraph.themeType = object.themeType;
			}
			return themeGraph;
		}
	}
}