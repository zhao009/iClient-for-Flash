package com.supermap.web.samples.clientTheme
{
	import com.supermap.web.core.Element;
	import com.supermap.web.core.Rectangle2D;
	
	import flash.display.DisplayObject;
	
	import flashx.textLayout.tlf_internal;
	
	import mx.charts.AreaChart;
	import mx.charts.BubbleChart;
	import mx.charts.CategoryAxis;
	import mx.charts.ChartItem;
	import mx.charts.ColumnChart;
	import mx.charts.HitData;
	import mx.charts.LineChart;
	import mx.charts.PieChart;
	import mx.charts.PlotChart;
	import mx.charts.chartClasses.ChartBase;
	import mx.charts.effects.SeriesEffect;
	import mx.charts.effects.SeriesInterpolate;
	import mx.charts.effects.SeriesSlide;
	import mx.charts.effects.SeriesZoom;
	import mx.charts.events.ChartItemEvent;
	import mx.charts.series.AreaSeries;
	import mx.charts.series.BubbleSeries;
	import mx.charts.series.ColumnSeries;
	import mx.charts.series.LineSeries;
	import mx.charts.series.PieSeries;
	import mx.charts.series.PlotSeries;
	import mx.charts.series.items.AreaSeriesItem;
	import mx.charts.series.items.BubbleSeriesItem;
	import mx.charts.series.items.ColumnSeriesItem;
	import mx.charts.series.items.LineSeriesItem;
	import mx.charts.series.items.PieSeriesItem;
	import mx.charts.series.items.PlotSeriesItem;
	import mx.collections.ArrayCollection;
	import mx.graphics.IFill;
	import mx.graphics.SolidColor;

	public class ClientThemeGraph extends Element
	{
		
		public static const COLUMN:String  ="COLUMN";         //柱状图。
		public static const LINE:String ="LINE";              //折线图。
		public static const PIE:String ="PIE";                //饼图。
		public static const PLOT:String ="PLOT";              //点图
		public static const AREA:String ="AREA";              //面图
		
		private var _width:Number = 100;
		private var _height:Number = 100;
		private var _alpha:Number = 1;
		private var _items:Array;
		private var _showDataEffect:SeriesEffect = new SeriesZoom();
		private var _seriesInterpolate:SeriesInterpolate = new SeriesInterpolate();
		
		private var baseChart:ChartBase;

		/** 修改数据 */
		public function set dataProvider(newItems:Array):void{
			baseChart.dataProvider = getDataProvider(newItems);
		}
		/** 修改字体大小 */
		public function set fontSize(size:Number):void{
			baseChart.setStyle("fontSize",size);
		}
		
		public function ClientThemeGraph(items:Array, graphType:String = PIE, bounds:Rectangle2D = null)
		{
			_showDataEffect.duration = 1500;
			_seriesInterpolate.duration = 1500;
			this._items = items;
			this.bounds = bounds;
			switch(graphType)
			{
				case "PIE":
					this.component = this.getPieChart(items);
					break;
				case "COLUMN":
					this.component = this.getColumnChart(items);
					break;
				case "LINE":
					this.component = this.getLineChart(items);
					break;
				case "PLOT":
					this.component = this.getPlotChart(items);
					break;
				case "AREA":
					this.component = this.getAreaChart(items);
					break;
			}
		}
	
		public function get alpha():Number
		{
			return _alpha;
		}

		public function set alpha(value:Number):void
		{
			_alpha = value;
			if(this.component)
				this.component.alpha = value;
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
			if(this.component)
				this.component.height = value;
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
			if(this.component)
				this.component.width = value;
		}
		
		private function getPlotChart(items:Array):PlotChart
		{
			var plotSeries1:PlotSeries = new PlotSeries();
			plotSeries1.xField = "name";
			plotSeries1.yField = "value";
			plotSeries1.displayName = "人数";
			plotSeries1.setStyle("showDataEffect",this._showDataEffect);
			
			var categoryAxis:CategoryAxis = new CategoryAxis();
			categoryAxis.categoryField = "name";
			
			baseChart = new PlotChart();
			baseChart.series = [plotSeries1];
			baseChart.height = this._height;
			baseChart.width = this._width;
			baseChart.dataProvider = getDataProvider(items);
			baseChart.dataTipFunction = plotChart_dataTipFunction;
			
			(baseChart as PlotChart).horizontalAxis = categoryAxis;
			baseChart.showDataTips = true;
			baseChart.alpha = _alpha;
			
			return baseChart as PlotChart;
		}
		
		private function getAreaChart(items:Array):AreaChart
		{
			var areaSeries:AreaSeries = new AreaSeries();
			areaSeries.xField = "name";
			areaSeries.yField = "value";
			areaSeries.displayName = "人数";		
			
			areaSeries.setStyle("showDataEffect",_seriesInterpolate);
			baseChart = new AreaChart();
			baseChart.series = [areaSeries];
			baseChart.height = this._height;
			baseChart.width = this._width;
			baseChart.dataProvider = getDataProvider(items);
			baseChart.dataTipFunction = areaChart_dataTipFunction;
			
			var categoryAxis:CategoryAxis = new CategoryAxis();
			categoryAxis.categoryField = "name";
			(baseChart as AreaChart).horizontalAxis = categoryAxis;
			baseChart.showDataTips = true;
			baseChart.alpha = _alpha;

			return baseChart as AreaChart ;
		}
		
		
		private function getLineChart(items:Array):LineChart
		{
			if(items.length == 0)
				return null;
			
			var lineSeries:LineSeries = new LineSeries();
			lineSeries.xField="name";
			lineSeries.yField="value";
			lineSeries.displayName = "人数";
			
			var seriesInterpolate:SeriesInterpolate=new SeriesInterpolate();
			seriesInterpolate.duration=1000;
			lineSeries.setStyle("showDataEffect",seriesInterpolate);
			
			baseChart = new LineChart();
			baseChart.series = [lineSeries];
			baseChart.width = this._width;
			baseChart.height = this._height;
			baseChart.dataProvider = getDataProvider(items);
			baseChart.dataTipFunction = lineChart_dataTipFunction;
			var categoryAxis:CategoryAxis = new CategoryAxis();
			categoryAxis.categoryField = "name";
			(baseChart as LineChart).horizontalAxis = categoryAxis;
			baseChart.showDataTips = true;
			baseChart.alpha = _alpha;
			
			return baseChart as LineChart;
		}
		private function getPieChart(items:Array):PieChart
		{
			if(items.length == 0)
				return null;
					
		    /**SeriesZoom 为FelxChart动态显示数据类，当数据发生变化时，触发showDataEffect，表现动画效果*/
			var seriesZoom:SeriesZoom = new SeriesZoom();
			seriesZoom.horizontalFocus = "center";
			seriesZoom.relativeTo = "chart";
			seriesZoom.duration = 1000;
						
			var seriesInterpolate:SeriesInterpolate=new SeriesInterpolate();
			seriesInterpolate.duration=1000;
			
			var pieSeries:PieSeries = new PieSeries();
			pieSeries.nameField ="name";
			pieSeries.field = "value";
			pieSeries.setStyle("labelPosition","inside");
	        pieSeries.setStyle("showDataEffect",seriesInterpolate);
			pieSeries.labelFunction=getDisplayInfo;
			baseChart=new PieChart();
			baseChart.dataTipFunction = pieChart_dataTipFunction;
			baseChart.addEventListener(ChartItemEvent.ITEM_CLICK,pieChart_itemClick);
			baseChart.dataProvider = getDataProvider(items);
			baseChart.width = this._width;
			baseChart.height = this._height;
			baseChart.series = new Array(pieSeries);
			baseChart.showDataTips = true;
			baseChart.alpha = _alpha;
			return baseChart as PieChart;
		}
		private function pieChart_itemClick(event:ChartItemEvent):void{
			var item:Object=event.hitData.item;
			var index:int = -1;
			for (var i:int=0; i < this._items.length && index == -1; i++)
			{
				if (this._items[i].label == item.name)
					index = i;
			}
			var explodeData:Array = [];
			explodeData[index] = 0.15;
			baseChart.series[0].perWedgeExplodeRadius = explodeData;
		}
		private function getColumnChart(items:Array):ColumnChart
		{
			if(items.length==0)
				return null;
			
			var seriesSlide:SeriesSlide = new SeriesSlide();
			seriesSlide.duration = 1500;
			seriesSlide.direction = "up";
			
			var columnSeries:ColumnSeries = new ColumnSeries();
			
			columnSeries.xField="name";
			columnSeries.yField="value";
			columnSeries.displayName = "人数";
			
			columnSeries.setStyle("showDataEffect",seriesSlide);
			
			baseChart = new ColumnChart();         
			baseChart.dataTipFunction = columnChart_dataTipFunction;     
			baseChart.dataProvider = getDataProvider(items);
			baseChart.width = this.height;
			baseChart.height = this._height;
			baseChart.series = [columnSeries];
			var categoryAxis:CategoryAxis = new CategoryAxis();
			categoryAxis.categoryField="name";
			(baseChart as ColumnChart).horizontalAxis = categoryAxis;
			baseChart.showDataTips=true;
			baseChart.alpha = _alpha;
			return baseChart as ColumnChart;
		}
		
		private function getDataProvider(items:Array):Array{
			var dataSet:Array=[];
			for each(var item:ClientThemeGraphItem in items){
				dataSet.push({name:item.label,value:item.value})
			}
			return dataSet;
		}
		
		private function getDisplayInfo(data:Object, field:String, index:Number, percentValue:Number):String
		{
			var temp:String= (" " + percentValue).substr(0,6);
			return data.name  + data.value  + "例: "+ '\n' + temp + "%";
		}
		
		private function pieChart_dataTipFunction(item:HitData):String
		{
			var pSI:PieSeriesItem = item.chartItem as PieSeriesItem;
			return "<font size = '19'><b>"+pSI.item.name+"</b><br/>"+
				pSI.item.value+"(<i>"+pSI.percentValue.toFixed(2)+"%</i>)</font>";
		}
		
		private function columnChart_dataTipFunction(item:HitData):String
		{
			var cSI:ColumnSeriesItem = item.chartItem as ColumnSeriesItem;
			return "<font size = '19'><b>"+cSI.item.name+"</b><br/>"+
				cSI.item.value+"</font>";
		}
		
		private function lineChart_dataTipFunction(item:HitData):String
		{
			var lSI:LineSeriesItem = item.chartItem as LineSeriesItem;
			return "<font size = '19'><b>"+lSI.item.name+"</b><br/>"+
				lSI.item.value+"</font>";
		}
		
		private function plotChart_dataTipFunction(item:HitData):String
		{
			var plSI:PlotSeriesItem = item.chartItem as PlotSeriesItem;
			return "<font size = '15'><b>"+plSI.item.name+"</b><br/>"+
				plSI.item.value+"</font>";
		}
		
		private function areaChart_dataTipFunction(item:HitData):String
		{
			var arSI:AreaSeriesItem = item.chartItem as AreaSeriesItem;
			return "<font size = '15'><b>"+arSI.item.name+"</b><br/>"+
				arSI.item.value+"</font>";
		}
		
		private function bubbleChart_dataTipFunction(item:HitData):String
		{
			var bbSI:BubbleSeriesItem = item.chartItem as BubbleSeriesItem;
			return "<font size = '15'><b>"+bbSI.item.name+"</b><br/>"+
				bbSI.item.value+"</font>";
		}
	}
}