package com.supermap.web.core
{
	import com.supermap.web.sm_internal;
	use namespace sm_internal;
	/**
	 * ${core_Point2D_Title}.
	 * <p>${core_Point2D_Description}</p> 
	 * 
	 * 
	 * 
	 */	
	public class Point2D
	{
		
		private var _x:Number = 0;
		private var _y:Number = 0; 
		private var _tag:Number;

		/**
		 * ${core_Point2D_constructor_D} 
		 * @param x ${core_Point2D_constructor_param_x}
		 * @param y ${core_Point2D_constructor_param_y}
		 * 
		 */		
		public function Point2D(x:Number=0, y:Number=0)
		{
			this.x = x;
			this.y = y;
		}

		/**
		 * ${core_Point2D_attribute_y_D} 
		 * @default 0
		 */
		public function get y():Number
		{
			return _y;
		}
		public function set y(value:Number):void
		{
			_y = value;
		}

		/**
		 * ${core_Point2D_attribute_x_D} 
		 * @default 0
		 * 
		 */		
		public function get x():Number
		{
			return _x;
		}
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		/**
		 * ${core_Point2D_attribute_tag_D} 
		 * @return
		 * 
		 */
		public function get tag():Number
		{
			return _tag;
		}
		public function set tag(value:Number):void
		{
			_tag = value;
		}
		/**
		 * ${core_Rectangle2D_method_offset_D} 
		 * @param dx ${core_Rectangle2D_method_offset_param_dx}
		 * @param dy ${core_Rectangle2D_method_offset_param_dy}
		 * @return ${core_Rectangle2D_method_offset_return}
		 * 
		 */		
		public function offset(dx:Number, dy:Number) : Point2D
		{
			return new Point2D(this.x + dx, this.y + dy);
		}	
		
		/**
		 * ${core_Point2D_method_clone_D}.
		 * ${core_Point2D_method_clone_remarks} 
		 * @return ${core_Point2D_method_clone_rerurn}
		 * 
		 */		
		public function clone():Point2D
		{
			return new Point2D(this.x, this.y);
		}
		
		/**
		 * ${core_Point2D_method_equals_D} 
		 * @param point2D ${core_Point2D_method_equals_param_point2D}
		 * @return ${core_Point2D_method_equals_rerurn}
		 * 
		 */		
		public function equals(point2D:Point2D):Boolean
		{
			var flag:Boolean = false;
			if (point2D != null)
			{
				flag = (this.x == point2D.x) && (this.y == point2D.y);
			}
			return flag;
		}
		
		/**
		 * ${core_Point2D_method_toString_D} 
		 * @return ${core_Point2D_method_toString_return}
		 * 
		 */		
		public function toString():String
		{
			return  "(" + this.x + "," + this.y + ")";
		}
		
		sm_internal function toJsonString():String
		{
			return "{\"y\":" + this.y + ", \"x\":" + this.x + "}";
		}
		sm_internal static function fromJson(str:String):Point2D
		{
			var point:Point2D = new Point2D();
			//不加g时可以使用括号多获取部分数据
			point.x = parseInt(str.match(/"x":([0-9]+)/)[1] as String);
			point.y = parseInt(str.match(/"y":([0-9]+)/)[1] as String);
			//使用了g则需要如下匹配
//			var strX:String = str.match(/"x":[0-9]+/g)[0] as String;
//			var strY:String = str.match(/"y":[0-9]+/g)[0] as String;
//			point.x = parseInt(strX.match(/[0-9]+/g)[0] as String);
//			point.y = parseInt(strY.match(/[0-9]+/g)[0] as String);
			return point;
		}
	}
}