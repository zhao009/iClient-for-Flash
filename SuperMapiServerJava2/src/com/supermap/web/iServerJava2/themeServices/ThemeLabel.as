package com.supermap.web.iServerJava2.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	
	/**
	 * ${iServer2_themeServices_ThemeLable_Title}.
	 * <p>${iServer2_themeServices_ThemeLable_Description}</p> 
	 * 
	 * 
	 */	
	public class ThemeLabel extends Theme
	{
		private var _items:Array;		
		private var _backStyle:ServerStyle;		
		private var _leaderLineStyle:ServerStyle;		
		private var _uniformStyle:ServerTextStyle;		
		private var _labelBackShape:int = 0;		
		private var _overLengthLabelMode:int = 0;		
		private var _isAlongLine:Boolean = false;		
		private var _isAngleFixed:Boolean = false;		
		private var _isFlowEnabled:Boolean = false;		
		private var _isLabelRepeated:Boolean = false;		
		private var _isLeaderLineDisplayed:Boolean = false;		
		private var _isOverlapAvoided:Boolean = true;		
		private var _labelRepeatInterval:Number = 0;		
		private var _maxLabelLength:Number= 256;		
		private var _offsetX:String = "0";		
		private var _offsetY:String = "0";		
		private var _labelExpression:String;		
		private var _rangeExpression:String;
		
		/**
		 * ${iServer2_themeServices_ThemeLable_constructor_None_D} 
		 * 
		 */		
		public function ThemeLabel()
		{
			super();
			this.themeType = ThemeType.LABEL;
		}
		
		/**
		 * ${iServer2_themeServices_ThemeLable_attribute_rangeExpression_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_rangeExpression_remarks}</p> 
		 * @see #labelExpression
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
		 * ${iServer2_themeServices_ThemeLable_attribute_labelExpression_D} 
		 * @return 
		 * 
		 */		
		public function get labelExpression():String
		{
			return _labelExpression;
		}

		public function set labelExpression(value:String):void
		{
			_labelExpression = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeLable_attribute_offsetY_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_offsetY_remarks}</p> 
		 * @return 
		 * 
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
		 * ${iServer2_themeServices_ThemeLable_attribute_offsetX_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_offsetX_remarks}</p> 
		 * 
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
		 * ${iServer2_themeServices_ThemeLable_attribute_maxLabelLength_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_maxLabelLength_remarks}</p> 
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
		 * ${iServer2_themeServices_ThemeLable_attribute_labelRepeatInterval_D}
		 * @see #isLabelRepeated
		 * @return 
		 * 
		 */		
		public function get labelRepeatInterval():Number
		{
			return _labelRepeatInterval;
		}

		public function set labelRepeatInterval(value:Number):void
		{
			_labelRepeatInterval = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeLable_attribute_isOverlapAvoided_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_isOverlapAvoided_remarks}</p>
		 * @default true 
		 * @return 
		 * 
		 */		
		public function get isOverlapAvoided():Boolean
		{
			return _isOverlapAvoided;
		}

		public function set isOverlapAvoided(value:Boolean):void
		{
			_isOverlapAvoided = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeLable_attribute_isLeaderLineDisplayed_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_isLeaderLineDisplayed_remarks}</p>
		 * @default false
		 * @return 
		 * 
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
		 * ${iServer2_themeServices_ThemeLable_attribute_isLabelRepeated_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_isLabelRepeated_remarks}</p> 
		 * @default false
		 * @see #isAlongLine
		 * @return 
		 * 
		 */		
		public function get isLabelRepeated():Boolean
		{
			return _isLabelRepeated;
		}

		public function set isLabelRepeated(value:Boolean):void
		{
			_isLabelRepeated = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeLable_attribute_isFlowEnabled_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_isFlowEnabled_remarks}</p> 
		 * @default false
		 * @return 
		 * 
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
		 * ${iServer2_themeServices_ThemeLable_attribute_isAngleFixed_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get isAngleFixed():Boolean
		{
			return _isAngleFixed;
		}

		public function set isAngleFixed(value:Boolean):void
		{
			_isAngleFixed = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeLable_attribute_isAlongLine_D} 
		 * @return 
		 * 
		 */		
		public function get isAlongLine():Boolean
		{
			return _isAlongLine;
		}

		public function set isAlongLine(value:Boolean):void
		{
			_isAlongLine = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeLable_attribute_overLengthLabelMode_D}
		 * @see OverLengthLabelMode
		 * @see #maxLabelLength
		 * @default 0 
		 * @return 
		 * 
		 */		
		public function get overLengthLabelMode():int
		{
			return _overLengthLabelMode;
		}

		public function set overLengthLabelMode(value:int):void
		{
			_overLengthLabelMode = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeLable_attribute_labelBackShape_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_labelBackShape_remarks}</p> 
		 * @see LabelBackShape
		 * @return 
		 * 
		 */		
		public function get labelBackShape():int
		{
			return _labelBackShape;
		}

		public function set labelBackShape(value:int):void
		{
			_labelBackShape = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeLable_attribute_uniformStyle_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_uniformStyle_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get uniformStyle():ServerTextStyle
		{
			return _uniformStyle;
		}

		public function set uniformStyle(value:ServerTextStyle):void
		{
			_uniformStyle = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeLable_attribute_leaderLineStyle_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_leaderLineStyle_remarks}</p> 
		 * @return 
		 * 
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
		 * ${iServer2_themeServices_ThemeLable_attribute_backStyle_D}.
		 * <p>${iServer2_themeServices_ThemeLable_attribute_backStyle_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get backStyle():ServerStyle
		{
			return _backStyle;
		}

		public function set backStyle(value:ServerStyle):void
		{
			_backStyle = value;
		}

		/**
		 * ${iServer2_themeServices_ThemeLable_attribute_items_D}
		 * @see ThemeLableItem 
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
						tempItems.push(ThemeLabelItem.toJSON(this.items[i]));
					}
					json += "\"items\":" + "[" + tempItems.join(",") + "]" + ",";
				}
			}
			else
				json += "\"items\":" + "[]" + ",";
			
			if(this.backStyle)
				json += "\"backStyle\":" + this.backStyle.toJSON() + "," ;
			if(this.leaderLineStyle)
				json += "\"leaderLineStyle\":" + this.leaderLineStyle.toJSON() + ",";
			if(this.uniformStyle)
				json += "\"uniformStyle\":" + this.uniformStyle.toJSON() + "," ;
			
			json += "\"labelBackShape\":" + this.labelBackShape + "," ;
			
			json += "\"overLengthLabelMode\":" + this.overLengthLabelMode + "," ;
			
			json += "\"isAlongLine\":" + this.isAlongLine + "," ;
			
			json += "\"isAngleFixed\":" + this.isAngleFixed + "," ;
			
			json += "\"isFlowEnabled\":" + this.isFlowEnabled + "," ;
			
			json += "\"isLabelRepeated\":" + this.isLabelRepeated + "," ;
			
			if(this.isFlowEnabled == false)
				this.isLeaderLineDisplayed = false;
			
			json += "\"isLeaderLineDisplayed\":" + this.isLeaderLineDisplayed + "," ;
			
			json += "\"isOverlapAvoided\":" + this.isOverlapAvoided + "," ;
			
			json += "\"labelRepeatInterval\":" + this.labelRepeatInterval + "," ;
			
			json += "\"offsetX\":" + "\"" + this.offsetX + "\",";
			
			json += "\"offsetY\":" + "\"" + this.offsetY + "\",";
			
			if(this.labelExpression)
				json += "\"labelExpression\":" + "\"" + this.labelExpression + "\",";
			if(this.offsetY)
				json += "\"rangeExpression\":" + "\"" + this.rangeExpression + "\",";
			
			json += "\"maxLabelLength\":" + this.maxLabelLength + ",";
			
			json += "\"themeType\":" + this.themeType;
			
			if(json.length > 0)
				json = "{" + json + "}";
			
			return json;
		}
		
		sm_internal static function toThemeLabel(object:Object):ThemeLabel
		{
			var themeLabel:ThemeLabel;
			if(object)
			{
				themeLabel = new ThemeLabel();
				themeLabel.backStyle = ServerStyle.toServerStyle(object.backStyle);
				
				themeLabel.isAlongLine = object.isAlongLine;
				
				themeLabel.isAngleFixed = object.isAngleFixed;
				
				themeLabel.isFlowEnabled = object.isFlowEnabled;
				
				themeLabel.isLabelRepeated = object.isLabelRepeated;
				
				themeLabel.isLeaderLineDisplayed = object.isLeaderLineDisplayed;
				
				themeLabel.isOverlapAvoided = object.isOverlapAvoided;
				
				if(object.items)
				{
					var tempItmes:Array = object.items;
					themeLabel.items = new Array();
					for(var i:int = 0; i < tempItmes.length; i++)
					{
						themeLabel.items.push(ThemeLabelItem.toThemeLabelItem(tempItmes[i]));
					}
				}
				
				themeLabel.labelBackShape = object.labelBackShape;
				
				themeLabel.labelExpression = object.labelExpression;
				
				themeLabel.labelRepeatInterval = object.labelRepeatInterval;
				
				themeLabel.leaderLineStyle = ServerStyle.toServerStyle(object.leaderLineStyle);
				
				themeLabel.maxLabelLength = object.maxLabelLength;
				
				themeLabel.offsetX = object.offsetX;
				
				themeLabel.offsetY = object.offsetY;
				
				themeLabel.overLengthLabelMode = object.overLengthLabelMode;
				
				themeLabel.rangeExpression = object.rangeExpression;
				
				themeLabel.uniformStyle = ServerTextStyle.toServerTextStyle(object.uniformStyle);
				
				themeLabel.themeType = object.themeType;
			}
			return themeLabel;
		}
	}
}