package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.sm_internal;
	

	use namespace sm_internal;
	
	/**
	 * ${iServer6R_themeServices_ThemeGraph_Title}.
	 * <p>${iServer6R_themeServices_ThemeGraph_Description}</p> 
	 * 
	 */	
	public class ThemeGraph extends Theme
	{
		private var _barWidth:Number = 0;
		private var _graduatedMode:String = GraduatedMode.CONSTANT;
		private var _graphSizeFixed:Boolean = false;
		private var _graphText:ThemeGraphText = new ThemeGraphText();
		private var _graphType:String = ThemeGraphType.AREA;
		private var _graphAxesTextDisplayMode:String = ThemeGraphAxesTextDisplayMode.NONE;
		private var _items:Array = new Array();
		private var _graphSize:ThemeGraphSize = new ThemeGraphSize();
		private var _offset:ThemeOffset = new ThemeOffset();
		private var _overlapAvoided:Boolean = true;
		private var _roseAngle:Number = 0;
		private var _startAngle:Number = 0;
		private var _graphAxes:ThemeGraphAxes = new ThemeGraphAxes();
		private var _negativeDisplayed:Boolean = true;
		private var _memoryKeys:Array;
		/**
		 * ${iServerJava6R_ThemeGraph_constructor_D} 
		 * 
		 */		
		public function ThemeGraph()
		{
		}

		/**
		 * ${iServerJava6R_ThemeGraph_attribute_memoryKeys_D}.
		 * <p>${iServerJava6R_ThemeGraph_attribute_memoryKeys_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get memoryKeys():Array
		{
			return _memoryKeys;
		}

		public function set memoryKeys(value:Array):void
		{
			_memoryKeys = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraph_attribute_negativeDisplayed_D} 
		 * @return 
		 * 
		 */		
		public function get negativeDisplayed():Boolean
		{
			return _negativeDisplayed;
		}

		public function set negativeDisplayed(value:Boolean):void
		{
			_negativeDisplayed = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraph_attribute_graphAxes_D} 
		 * @return 
		 * 
		 */		
		public function get graphAxes():ThemeGraphAxes
		{
			return _graphAxes;
		}

		public function set graphAxes(value:ThemeGraphAxes):void
		{
			_graphAxes = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraph_attribute_startAngle_D}.
		 * <p>${iServerJava6R_ThemeGraph_attribute_startAngle_remarks}</p> 
		 * @return 
		 * 
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
		 * ${iServerJava6R_ThemeGraph_attribute_roseAngle_D}.
		 * <p>${iServerJava6R_ThemeGraph_attribute_roseAngle_remarks}</p> 
		 * @return 
		 * 
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
		 * ${iServerJava6R_ThemeGraph_attribute_overlapAvoided_D}.
		 * <p>${iServerJava6R_ThemeGraph_attribute_overlapAvoided_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get overlapAvoided():Boolean
		{
			return _overlapAvoided;
		}

		public function set overlapAvoided(value:Boolean):void
		{
			_overlapAvoided = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraph_attribute_offset_D} 
		 * @return 
		 * 
		 */		
		public function get offset():ThemeOffset
		{
			return _offset;
		}

		public function set offset(value:ThemeOffset):void
		{
			_offset = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraph_attribute_graphSize_D} 
		 * @return 
		 * 
		 */		
		public function get graphSize():ThemeGraphSize
		{
			return _graphSize;
		}

		public function set graphSize(value:ThemeGraphSize):void
		{
			_graphSize = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraph_attribute_items_D}.
		 * <p>${iServerJava6R_ThemeGraph_attribute_items_remarks}</p> 
		 * @see ThemeGraphItem
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
		 * ${iServerJava6R_ThemeGraph_attribute_graphType_D}.
		 * <p>${iServerJava6R_ThemeGraph_attribute_graphType_remarks}</p> 
		 * @default ThemeGraphType.AREA
		 * @see ThemeGraphType
		 * @return 
		 * 
		 */		
		public function get graphType():String
		{
			return _graphType;
		}

		public function set graphType(value:String):void
		{
			_graphType = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraph_attribute_graphAxesTextDisplayMode_D}.
		 * <p>${iServerJava6R_ThemeGraph_attribute_graphAxesTextDisplayMode_remarks}</p> 
		 * @default ThemeGraphAxesTextDisplayMode.NONE
		 * @see ThemeGraphAxesTextDisplayMode
		 * @return 
		 * 
		 */		
		public function get graphAxesTextDisplayMode():String
		{
			return _graphAxesTextDisplayMode;
		}
		
		public function set graphAxesTextDisplayMode(value:String):void
		{
			_graphAxesTextDisplayMode = value;
		}
		
		/**
		 * ${iServerJava6R_ThemeGraph_attribute_graphText_D} 
		 * @return 
		 * 
		 */		
		public function get graphText():ThemeGraphText
		{
			return _graphText;
		}

		public function set graphText(value:ThemeGraphText):void
		{
			_graphText = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraph_attribute_graphSizeFixed_D} 
		 * @default false
		 * @return 
		 * 
		 */		
		public function get graphSizeFixed():Boolean
		{
			return _graphSizeFixed;
		}

		public function set graphSizeFixed(value:Boolean):void
		{
			_graphSizeFixed = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraph_attribute_graduatedMode_D}
		 * @default GraduatedMode.Constant 
		 * @see GraduatedMode
		 * @return 
		 * 
		 */		
		public function get graduatedMode():String
		{
			return _graduatedMode;
		}

		public function set graduatedMode(value:String):void
		{
			_graduatedMode = value;
		}

		/**
		 * ${iServerJava6R_ThemeGraph_attribute_barWidth_D}.
		 * <p>${iServerJava6R_ThemeGraph_attribute_barWidth_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get barWidth():Number
		{
			return _barWidth;
		}

		public function set barWidth(value:Number):void
		{
			_barWidth = value;
		}
		
		sm_internal function toJSON():String
		{
			var json:String = "";
			if(this.items)
			{
				if(this.items.length > 0)
				{
					var tempItems:Array = new Array();
					var itemLength:int = this.items.length;
					for(var i:int = 0; i < itemLength; i++)
					{
						tempItems.push(ThemeGraphItem.toJSON(this.items[i]));
					}
					json += "\"items\":" + "[" + tempItems.join(",") + "]" + ",";
				}
			}
			else
				json += "\"items\":" + "[]" + ",";
			
			if(this.graphAxes)
				
				json += this.graphAxes.toJSON() + "," ;	
			
			if(this.graphSize)
				
				json += this.graphSize.toJSON() + ",";
			
			if(this.graphText)
				
				json += this.graphText.toJSON() + ",";
			
			if(this.memoryKeys && this.memoryKeys.length > 0)				
				json += "\"memoryKeys\":" + "[" + this.memoryKeys + "]" + ",";
			else
				json += "\"memoryKeys\":" + "null" + ",";
			
			json += this.offset.toJSON() + ",";
			
			json += "\"barWidth\":" + this.barWidth +"," ;	
			
			json += "\"graduatedMode\":" + "\"" + this.graduatedMode + "\""+ "," ;
			
			json += "\"negativeDisplayed\":" + "\"" + this.negativeDisplayed + "\""+ ",";
			
			json += "\"graphSizeFixed\":" + this.graphSizeFixed + "," ;	
			
			json += "\"graphType\":" + "\"" + this.graphType + "\"" +",";
			
			json += "\"graphAxesTextDisplayMode\":" + "\"" + this.graphAxesTextDisplayMode + "\"" +",";
			
			json += "\"overlapAvoided\":" +  this.overlapAvoided + ",";
			
			json += "\"roseAngle\":" + this.roseAngle + ",";
			
			json += "\"startAngle\":" + this.startAngle + ",";
			
			json += "\"memoryData\":" + "null" + ",";
			
			json += "\"type\":" +  "\""  + "GRAPH" + "\"" + ",";
			
			json += "\"matrixCells\":" + "null" ;
			
			json = "{" + json + "}";	
			
			return json;		

		}
		
		sm_internal static function fromJson(object:Object):ThemeGraph
		{
			var themeGraph:ThemeGraph;
			if(object)
			{
				themeGraph = new ThemeGraph();
				themeGraph.barWidth
				themeGraph.graduatedMode
				themeGraph.graphSizeFixed
				themeGraph.graphType
				themeGraph.graphAxesTextDisplayMode
				themeGraph.overlapAvoided
				themeGraph.roseAngle
				themeGraph.startAngle
				themeGraph.offset = ThemeOffset.fromJson(object.offset);
				themeGraph.graphAxes = ThemeGraphAxes.fromJson(object.graphAxes);
				themeGraph.graphSize = ThemeGraphSize.fromJson(object.graphSize);
				themeGraph.graphText = ThemeGraphText.fromJson(object.graphText);
				
				if(object.items)
				{
					var tempItmes:Array = object.items;
					themeGraph.items = new Array();
					for(var i:int = 0; i < tempItmes.length; i++)
					{
						themeGraph.items.push(ThemeGraphItem.fromJson(tempItmes[i]));
					}
				}
			}
			
			return themeGraph;
		}
 	}
}