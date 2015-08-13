package com.supermap.web.utils.serverTypes
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	
	public class OverlapDisplayedOptions
	{
		/**
		 *  点和点压盖时是否显示压盖的点对象。默认为true
		 */
		private var _allowPointOverlap:Boolean = true;
		/**
		 *  标签和相应普通图层上的点是否一起过滤显示,如果过滤显示，只以图层集合中对应数据集的索引最小的图层的点风格来绘制点。 
		 *  默认为true
		 */
		private var _allowPointWithTextDisplay:Boolean = true;
		/**
		 *  文本压盖时是否显示压盖的文本对象。 默认为false
		 */
		private var _allowTextOverlap:Boolean = false;
		/**
		 *  文本和点压盖时是否显示压盖的文本或点对象(此属性不处理文本之间的压盖和点之间的压盖)。默认为true
		 */
		private var _allowTextAndPointOverlap:Boolean = true;
		/**
		 *  等级符号元素压盖时是否显示压盖的等级符号元素。 默认为false
		 */
		private var _allowThemeGraduatedSymbolOverlap:Boolean = false;
		/**
		 *  统计专题图元素压盖时是否显示压盖的统计专题图元素。默认为false
		 */
		private var _allowThemeGraphOverlap:Boolean = false;
		/**
		 *  两个对象之间的横向压盖间距，单位为0.1毫米，跟 verticalOverlappedSpaceSize 结合使用， 
     	 *  当两个对象的横向间距小于该值，且纵向间距小于 verticalOverlappedSpaceSize 时认为压盖。
		 *  默认值为0
		 */
		private var _horizontalOverlappedSpaceSize:int = 0;
		/**
		 * 两个对象之间的纵向压盖间距，单位为0.1毫米，跟 horizontalOverlappedSpaceSize 结合使用，
		 * 当两个对象的纵向间距小于该值，且横向间距小于 horizontalOverlappedSpaceSize 时认为压盖。  
		 * 默认值为0
		 */
		private var _verticalOverlappedSpaceSize:int = 0;
		
		public function OverlapDisplayedOptions()
		{
		}
		
		public function get verticalOverlappedSpaceSize():int
		{
			return _verticalOverlappedSpaceSize;
		}

		public function set verticalOverlappedSpaceSize(value:int):void
		{
			_verticalOverlappedSpaceSize = value;
		}

		public function get horizontalOverlappedSpaceSize():int
		{
			return _horizontalOverlappedSpaceSize;
		}

		public function set horizontalOverlappedSpaceSize(value:int):void
		{
			_horizontalOverlappedSpaceSize = value;
		}

		public function get allowThemeGraphOverlap():Boolean
		{
			return _allowThemeGraphOverlap;
		}

		public function set allowThemeGraphOverlap(value:Boolean):void
		{
			_allowThemeGraphOverlap = value;
		}

		public function get allowThemeGraduatedSymbolOverlap():Boolean
		{
			return _allowThemeGraduatedSymbolOverlap;
		}

		public function set allowThemeGraduatedSymbolOverlap(value:Boolean):void
		{
			_allowThemeGraduatedSymbolOverlap = value;
		}

		public function get allowTextAndPointOverlap():Boolean
		{
			return _allowTextAndPointOverlap;
		}

		public function set allowTextAndPointOverlap(value:Boolean):void
		{
			_allowTextAndPointOverlap = value;
		}

		public function get allowTextOverlap():Boolean
		{
			return _allowTextOverlap;
		}

		public function set allowTextOverlap(value:Boolean):void
		{
			_allowTextOverlap = value;
		}

		public function get allowPointWithTextDisplay():Boolean
		{
			return _allowPointWithTextDisplay;
		}

		public function set allowPointWithTextDisplay(value:Boolean):void
		{
			_allowPointWithTextDisplay = value;
		}

		public function get allowPointOverlap():Boolean
		{
			return _allowPointOverlap;
		}

		public function set allowPointOverlap(value:Boolean):void
		{
			_allowPointOverlap = value;
		}

		public function toString():String
		{
			var str:String = "{";
			
			str += "\"allowPointOverlap\":" +  this.allowPointOverlap  + ",";
			str += "\"allowPointWithTextDisplay\":" +  this.allowPointWithTextDisplay  + ",";
			str += "\"allowTextAndPointOverlap\":" +  this.allowTextAndPointOverlap  + ",";
			str += "\"allowTextOverlap\":" +  this.allowTextOverlap  + ",";
			str += "\"allowThemeGraduatedSymbolOverlap\":" +  this.allowThemeGraduatedSymbolOverlap  + ",";
			str += "\"allowThemeGraphOverlap\":" +  this.allowThemeGraphOverlap  + ",";
			str += "\"horizontalOverlappedSpaceSize\":" +  this.horizontalOverlappedSpaceSize  + ",";
			str += "\"verticalOverlappedSpaceSize\":" +  this.verticalOverlappedSpaceSize  + ",";
			
			str += "}";
			return str;

		}
	}
}