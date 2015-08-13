package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.utils.serverTypes.ServerTextStyle;
	import com.supermap.web.sm_internal;
	
	import flash.text.engine.TabAlignment;	
	use namespace sm_internal;
	
	/**
	 * ${iServerJava6R_ThemeLabel_Title}.
	 * <p>${iServerJava6R_ThemeLabel_Description}</p> 
	 * 
	 */	
	public class ThemeLabel extends Theme
	{		
		private var _alongLine:ThemeLabelAlongLine = new ThemeLabelAlongLine();
		private var _offset:ThemeOffset = new ThemeOffset();
		private var _background:ThemeLabelBackground = new ThemeLabelBackground();
		//private var _backStyle:ServerStyle = new ServerStyle();
		//private var _uniformStyle:ServerTextStyle = new ServerTextStyle();	
		private var _text:ThemeLabelText = new ThemeLabelText();
		private var _labelOverLengthMode:String = LabelOverLengthMode.NONE;
		private var _maxLabelLength:Number = 256;
		private var _smallGeometryLabeled:Boolean = false;
		private var _rangeExpression:String = "";
		private var _numericPrecision:int = 0;
		private var _items:Array;
		private var _labelEexpression:String = "";
		private var _overlapAvoided:Boolean = false;
		private var _matrixCells:Array;
		
		/**
		 * ${iServerJava6R_ThemeLabel_constructor_D} 
		 * 
		 */		
		public function ThemeLabel()
		{
			
		}

//		public function get uniformStyle():ServerTextStyle
//		{
//			return _uniformStyle;
//		}
//
//		public function set uniformStyle(value:ServerTextStyle):void
//		{
//			_uniformStyle = value;
//		}

//		public function get leaderLineStyle():ServerStyle
//		{
//			return _leaderLineStyle;
//		}
//
//		public function set leaderLineStyle(value:ServerStyle):void
//		{
//			_leaderLineStyle = value;
//		}

		/**
		 * ${iServerJava6R_ThemeLabel_attribute_matrixCells_D}.
		 * <p>${iServerJava6R_ThemeLabel_attribute_matrixCells_remarks}</p> 
		 * @see LabelSymbolCell
	     * @see LabelThemeCell
	     * @see LabelImageCell
		 * @return 
		 * 
		 */		
		public function get matrixCells():Array
		{
			return _matrixCells;
		}

		public function set matrixCells(value:Array):void
		{
			_matrixCells = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabel_attribute_background_D} 
		 * @return 
		 * 
		 */		
		public function get background():ThemeLabelBackground
		{
			return _background;
		}

		public function set background(value:ThemeLabelBackground):void
		{
			_background = value;
		}

//		public function get backStyle():ServerStyle
//		{
//			return _backStyle;
//		}
//
//		public function set backStyle(value:ServerStyle):void
//		{
//			_backStyle = value;
//		}

		/**
		 * ${iServerJava6R_ThemeLabel_attribute_overlapAvoided_D}.
		 * <p>${iServerJava6R_ThemeLabel_attribute_overlapAvoided_remarks}</p> 
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
		 * ${iServerJava6R_ThemeLabel_attribute_labelExpression_D} 
		 * @return 
		 * 
		 */		
		public function get labelEexpression():String
		{
			return _labelEexpression;
		}

		public function set labelEexpression(value:String):void
		{
			_labelEexpression = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabel_attribute_items_D} 
		 * @return ${iServerJava6R_ThemeLabel_attribute_items_remarks}
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
		 * ${iServerJava6R_ThemeLabel_attribute_numericPrecision_D}.
		 * <p>${iServerJava6R_ThemeLabel_attribute_numericPrecision_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get numericPrecision():int
		{
			return _numericPrecision;
		}

		public function set numericPrecision(value:int):void
		{
			_numericPrecision = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabel_attribute_rangeExpression_D}.
		 * <p>${iServerJava6R_ThemeLabel_attribute_rangeExpression_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get rangeExpression():String
		{
			return _rangeExpression;
		}

		public function set rangeExpression(value:String):void
		{
			_rangeExpression = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabel_attribute_smallGeometryLabeled_D}.
		 * <p>${iServerJava6R_ThemeLabel_attribute_smallGeometryLabeled_remarks}</p> 
		 * @see LabelOverLengthMode
		 * @return 
		 * 
		 */		
		public function get smallGeometryLabeled():Boolean
		{
			return _smallGeometryLabeled;
		}

		public function set smallGeometryLabeled(value:Boolean):void
		{
			_smallGeometryLabeled = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabel_attribute_maxLabelLength_D}.
		 * <p>${iServerJava6R_ThemeLabel_attribute_maxLabelLength_remarks}</p> 
		 * @default 256
		 * @return 
		 * 
		 */		
		public function get maxLabelLength():Number
		{
			return _maxLabelLength;
		}

		public function set maxLabelLength(value:Number):void
		{
			_maxLabelLength = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabel_attribute_labelOverLengthMode_D}.
		 * <p>${iServerJava6R_ThemeLabel_attribute_labelOverLengthMode_remarks}</p> 
		 * @see #maxLabelLength
		 * @return 
		 * 
		 */		
		public function get labelOverLengthMode():String
		{
			return _labelOverLengthMode;
		}

		public function set labelOverLengthMode(value:String):void
		{
			_labelOverLengthMode = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabel_attribute_text_D} 
		 * @return 
		 * 
		 */		
		public function get text():ThemeLabelText
		{
			return _text;
		}

		public function set text(value:ThemeLabelText):void
		{
			_text = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabel_attribute_offset_D} 
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
		 * ${iServerJava6R_ThemeLabel_attribute_alongLine_D}.
		 * <p>${iServerJava6R_ThemeLabel_attribute_alongLine_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get alongLine():ThemeLabelAlongLine
		{
			return _alongLine;
		}

		public function set alongLine(value:ThemeLabelAlongLine):void
		{
			_alongLine = value;
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
						tempItems.push(ThemeLabelItem.toJSON(this.items[i]));
					}
					json += "\"items\":" + "[" + tempItems.join(",") + "]" + ",";
				}
			}
			else
				json += "\"items\":" + "[]" + ",";
			if(this.background)
				json += this.background.toJSON() + "," ;	
		
			if(this.text)
				json += this.text.toJSON() + ",";
			if(this.alongLine)
				json += this.alongLine.toJSON() + "," ;
			
			json += this.offset.toJSON() + ",";
			
			json += "\"labelOverLengthMode\":" + "\"" + this.labelOverLengthMode + "\""+ "," ;	
			
			json += "\"overlapAvoided\":" + this.overlapAvoided + "," ;
			
			json += "\"labelExpression\":" + "\"" + this.labelEexpression + "\",";
			
			json += "\"rangeExpression\":" + "\"" + this.rangeExpression + "\",";
			
			json += "\"smallGeometryLabeled\":" +  this.smallGeometryLabeled + ",";
			
			json += "\"numericPrecision\":" + this.numericPrecision + ",";
			
			json += "\"maxLabelLength\":" + this.maxLabelLength + ",";
			
			if(this._matrixCells && this._matrixCells.length)
			{
				var matrixLength:int = this._matrixCells.length;
				var matrixJsons:Array = [];
				var maxMatrixColumnLength:int = (this._matrixCells[0] as Array).length;
				
				for (var row:int = 1; row < matrixLength; row++)
				{
					if((this._matrixCells[row] as Array).length > maxMatrixColumnLength)
						maxMatrixColumnLength = (this._matrixCells[row] as Array).length;
				}
				
				for(var col:int = 0; col < maxMatrixColumnLength; col++)
				{
					var matrixColumnJsons:Array = [];
					for (var row2:int = 0; row2 < matrixLength; row2++)
					{
						var curMatrix:LabelMatrixCell = this._matrixCells[row2][col];
						if(curMatrix)
						{
							if(curMatrix is LabelImageCell)
								matrixColumnJsons.push((curMatrix as LabelImageCell).toJson());
							else if(curMatrix is LabelSymbolCell)
								matrixColumnJsons.push((curMatrix as LabelSymbolCell).toJson());
							else
								matrixColumnJsons.push((curMatrix as LabelThemeCell).toJson());	
						}
						else
						{
							matrixColumnJsons.push("null");
						}
					}
					matrixJsons.push("[" + matrixColumnJsons.join(",") + "]");
				}
				json += "\"matrixCells\":" +  "["  + matrixJsons.join(",")  + "],";
				
			}
			else
				json += "\"matrixCells\":null,";
			
			json += "\"type\":" +  "\""  + "LABEL" + "\"" + ",";
			
			if(super.themeMemoryData){
				json += "\"memoryData\":" + super.themeMemoryData.toJSON();
			}else{
				json += "\"memoryData\":" + "null";
			}
			json = "{" + json + "}";
			
			return json;
		}		
		
		sm_internal static function fromJson(object:Object):ThemeLabel
		{
			var themeLabel:ThemeLabel;
			if(object)
			{
				themeLabel = new ThemeLabel();
				themeLabel.background = ThemeLabelBackground.fromJson(object.background);
				
				themeLabel.labelOverLengthMode = object.labelOverLengthMode;
				
				themeLabel.overlapAvoided = object.overlapAvoided;
				
				themeLabel.labelEexpression = object.labelEexpression;
				
				themeLabel.rangeExpression = object.rangeExpression;
				
				themeLabel.smallGeometryLabeled = object.smallGeometryLabeled;
				
				themeLabel.numericPrecision = object.numericPrecision;
				
				themeLabel.maxLabelLength = object.maxLabelLength;
				
				if(object.items)
				{
					var tempItmes:Array = object.items;
					themeLabel.items = new Array();
					for(var i:int = 0; i < tempItmes.length; i++)
					{
						themeLabel.items.push(ThemeLabelItem.fromJson(tempItmes[i]));
					}
				}
			}
			return themeLabel;
		}

	}
}