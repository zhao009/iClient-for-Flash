package com.supermap.web.iServerJava6R.themeServices
{
	import com.supermap.web.sm_internal;	
	use namespace sm_internal;
	/**
	 * 标签专题图沿线标注(可以创建)
	 */
	/**
	 * ${iServerJava6R_ThemeLabelAlongLine_Title}.
	 * <p>${iServerJava6R_ThemeLabelAlongLine_Description}</p> 
	 * 
	 */	
	public class ThemeLabelAlongLine
	{
		private var _alongLine:Boolean = false;
		private var _alongLineDirection:String = AlongLineDirection.LB_TO_RT;
		private var _angleFixed:Boolean = false;
		private var _repeatedLabelAvoided:Boolean = false;
		private var _repeatIntervalFixed:Boolean = false;
		private var _labelRepeatInterval:Number = 0;
		private var _isLabelRepeated:Boolean = false;
		
		/**
		 * ${iServerJava6R_ThemeLabelAlongLine_constructor_D} 
		 * 
		 */		
		public function ThemeLabelAlongLine()
		{
		}
		
		/**
		 * 在沿线标注时是否进行循环标注 该属性只有当标签沿线标注时有效
		 */
		/**
		 * ${iServerJava6R_ThemeLabelAlongLine_attribute_isLabelRepeated_D}.
		 * <p>${iServerJava6R_ThemeLabelAlongLine_attribute_isLabelRepeated_remarks}</p> 
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
		 * 在沿线标注时循环标注的间隔 只有设定 isLabelRepeated 为 true 的时候，labelRepeatInterval 属性才有效。
		 */
		/**
		 * ${iServerJava6R_ThemeLabelAlongLine_attribute_labelRepeatInterval_D}.
		 * <p>${iServerJava6R_ThemeLabelAlongLine_attribute_labelRepeatInterval_remarks}</p> 
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
		 * 循环标注间隔是否固定。true 表示使用固定循环标注间隔
		 */
		/**
		 * ${iServerJava6R_ThemeLabelAlongLine_attribute_repeatIntervalFixed_D}.
		 * <p>${iServerJava6R_ThemeLabelAlongLine_attribute_repeatIntervalFixed_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get repeatIntervalFixed():Boolean
		{
			return _repeatIntervalFixed;
		}

		public function set repeatIntervalFixed(value:Boolean):void
		{
			_repeatIntervalFixed = value;
		}

		/**
		 * ${iServerJava6R_ThemeLabelAlongLine_attribute_repeatedLabelAvoided_D}.
		 * <p>${iServerJava6R_ThemeLabelAlongLine_attribute_repeatedLabelAvoided_remarks}</p>
		 */
		public function get repeatedLabelAvoided():Boolean
		{
			return _repeatedLabelAvoided;
		}
		public function set repeatedLabelAvoided(value:Boolean):void
		{
			_repeatedLabelAvoided = value;
		}

		/**
		 * 当沿线显示文本时，是否将文本角度固定。true 表示按固定文本角度显示文本
		 */
		/**
		 * ${iServerJava6R_ThemeLabelAlongLine_attribute_angleFixed_D}.
		 * <p>${iServerJava6R_ThemeLabelAlongLine_attribute_angleFixed_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get angleFixed():Boolean
		{
			return _angleFixed;
		}
		public function set angleFixed(value:Boolean):void
		{
			_angleFixed = value;
		}

		/**
		 * 标签沿线标注方向。详细的标注方向类型请查看 AlongLineDirection 类。
		 */
		/**
		 * ${iServerJava6R_ThemeLabelAlongLine_attribute_alongLineDirection_D} 
		 * @return 
		 * 
		 */		
		public function get alongLineDirection():String
		{
			return _alongLineDirection;
		}
		public function set alongLineDirection(value:String):void
		{
			_alongLineDirection = value;
		}

		/**
		 * 是否沿线显示文本。true 表示沿线显示文本，false 表示正常显示文本。默认为 false。沿线标注属性只适用于线数据集专题图。
		 */
		/**
		 * ${iServerJava6R_ThemeLabelAlongLine_attribute_isAlongLine_D} 
		 * @return 
		 * 
		 */		
		public function get alongLine():Boolean
		{
			return _alongLine;
		}

		public function set alongLine(value:Boolean):void
		{
			_alongLine = value;
		}

		sm_internal function toJSON():String
		{
			var json:String = "";
			
			json += "\"alongLine\":" + this.alongLine + "," ;
			
			json += "\"alongLineDirection\":" + "\"" + this.alongLineDirection + "\"" + "," ;
			
			json += "\"angleFixed\":" + this.angleFixed + "," ;
			
			json += "\"repeatedLabelAvoided\":" + this.repeatedLabelAvoided + "," ;
			
			json += "\"repeatIntervalFixed\":" + this.repeatIntervalFixed + ",";
			
			json += "\"labelRepeatInterval\":" + this.labelRepeatInterval ;
			
			//json += "\"isLabelRepeated\":" + this.isLabelRepeated + ",";			
			//if(json.length > 0)
				//json = "{" + json + "}";
			return json;
		}

	}
}