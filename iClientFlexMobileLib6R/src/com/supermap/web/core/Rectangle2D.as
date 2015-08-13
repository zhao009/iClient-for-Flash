package com.supermap.web.core
{
	import com.supermap.web.resources.SmError;
	import com.supermap.web.resources.SmResource;

	//rectangle2D
	/**
	 * ${core_Rectangle2D_Title}.
	 * <p>${core_Rectangle2D_Description}</p> 
	 * 
	 * 
	 */	
	public class Rectangle2D
	{
		private var _x:Number = 0.0;
		private var _y:Number = 0.0;
		private var _width:Number = 0.0;
		private var _height:Number = 0.0;
		
		//rectangle2D
		/**
		 * ${core_Rectangle2D_constructor_D}.
		 * ${core_Rectangle2D_constructor_remarks_D}
		 * 
		 */		
		public function Rectangle2D(left:Number = 0.0, bottom:Number = 0.0, right:Number = 0.0, top:Number = 0.0)
		{
			this.fromXYWidthHeight(left, bottom, right - left, top - bottom);		
		}
		
		//属性
		/**
		 * ${core_Rectangle2D_attribute_bbox_D} 
		 * @return 
		 * 
		 */		
		public function get bbox():String
		{
			return this.left.toString() +"," + this.bottom.toString() + "," +
					this.right.toString() + "," + this.top.toString();
		}
		public function set bbox(bbox:String):void
		{
			if(bbox != null)
			{
				var bboxArray:Array = bbox.split(",",4);
				this.fromXYWidthHeight(bboxArray[0], bboxArray[1], bboxArray[2] - bboxArray[0], bboxArray[3] - bboxArray[1]);	
			}
		}
		
		/**
		 * ${core_Rectangle2D_attribute_left_D} 
		 * @return 
		 * 
		 */		
		public function get left():Number
		{
			return this._x;
		}
		
		/**
		 * ${core_Rectangle2D_attribute_bottom_D} 
		 * @return 
		 * 
		 */		
		public function get bottom():Number
		{
			return this._y;
		}
		
		/**
		 * ${core_Rectangle2D_attribute_right_D} 
		 * @return 
		 * 
		 */		
		public function get right():Number
		{
			return this._x + this._width;
		}
		
		/**
		 * ${core_Rectangle2D_attribute_top_D} 
		 * @return 
		 * 
		 */		
		public function get top():Number
		{
			return this._y + this._height;
		}
		
		/**
		 * ${core_Rectangle2D_attribute_width_D} 
		 * @return 
		 * 
		 */		
		public function get width():Number
		{
			return this._width;
		}
		
		/**
		 * ${core_Rectangle2D_attribute_height_D} 
		 * @return 
		 * 
		 */		
		public function get height():Number
		{
			return this._height;
		}
		
		/**
		 * ${core_Rectangle2D_attribute_center_D} 
		 * @return 
		 * 
		 */		
		public function get center():Point2D
		{		
			return new Point2D((this.right + this.left) / 2, (this.top + this.bottom) / 2);
		}
		
		/**
		 * ${core_Rectangle2D_attribute_topRight_D} 
		 * @return 
		 * 
		 */		
		public function get topRight():Point2D
		{
			return new Point2D(this.right, this.top);
		}
		
		/**
		 * ${core_Rectangle2D_attribute_bottomLeft_D} 
		 * @return 
		 * 
		 */		
		public function get bottomLeft():Point2D
		{
			return new Point2D(this.left, this.bottom);
		}
		//end 属性
		
		
		//public方法
		/**
		 * ${core_Rectangle2D_method_update_D} 
		 * @param left ${core_Rectangle2D_method_update_param_left}
		 * @param bottom ${core_Rectangle2D_method_update_param_bottom}
		 * @param right ${core_Rectangle2D_method_update_param_right}
		 * @param top ${core_Rectangle2D_method_update_param_top}
		 * 
		 */		
		public function update(left:Number, bottom:Number, right:Number, top:Number) : void
		{
			var width:Number = right - left;
			var height:Number = top - bottom;
			this.fromXYWidthHeight(left, bottom, width, height);
		}
		
		/**
		 * ${core_Rectangle2D_method_isEmpty_D} 
		 * @return ${core_Rectangle2D_method_isEmpty_return}
		 * 
		 */		
		public function isEmpty():Boolean
		{
			return (this.width < 0) || (this.height < 0) || (this.width == 0 && this.height == 0);
		}
	
		/**
		 * ${core_Rectangle2D_method_clone_D}.
		 * ${core_Rectangle2D_method_clone_remarks_D} 
		 * @return ${core_Rectangle2D_method_isEmpty_return}
		 * 
		 */		
		public function clone():Rectangle2D 
		{
			return new Rectangle2D(this.left, this.bottom, this.right, this.top);
		}
		
		/**
		 * ${core_Rectangle2D_method_equals_D} 
		 * @param rect2D ${core_Rectangle2D_method_equals_param_rect2D}
		 * @return ${core_Rectangle2D_method_equals_return}
		 * 
		 */		
		public function equals(rect2D:Rectangle2D):Boolean
		{
			if(rect2D != null && !rect2D.isEmpty())
			{
				return (this.left == rect2D.left) && (this.bottom == rect2D.bottom) && 
				         (this.right == rect2D.right) && (this.top == rect2D.top);
			}
			return false;
		}
		
		/**
		 * ${core_Rectangle2D_method_toString_D} 
		 * @return ${core_Rectangle2D_method_toString_return}
		 * 
		 */		
		public function toString():String
		{
			//修改为（l,b,r,t）跟iserver的bounds的表述形式保持一致
			
			return "(" + this.left + "," + this.bottom + "," + this.right + "," + this.top + ")";
		}
		
		
		/**
		 * ${core_Rectangle2D_method_centerAt_D} 
		 * @param x ${core_Rectangle2D_method_centerAt_param_x}
		 * @param y ${core_Rectangle2D_method_centerAt_param_y}
		 * @return ${core_Rectangle2D_method_centerAt_return}
		 * 
		 */		
		public function centerAt(x:Number, y:Number):Rectangle2D
		{
			var offsetX:Number = x - this.center.x;
			var offsetY:Number = y - this.center.y;
			return this.offset(offsetX, offsetY);
		}
		
		/**
		 * ${core_Rectangle2D_method_centerAtPoint_D} 
		 * @param pnt2D ${core_Rectangle2D_method_centerAtPoint_param_pnt2D}
		 * @return ${core_Rectangle2D_method_centerAtPoint_return}
		 * 
		 */		
		public function centerAtPoint(pnt2D:Point2D):Rectangle2D
		{
			if(pnt2D != null)
			{		
				return this.centerAt(pnt2D.x, pnt2D.y);		
			}
			return null;
		}
		
		/**
		 * ${core_Rectangle2D_method_offset_D} 
		 * @param dx ${core_Rectangle2D_method_offset_param_dx}
		 * @param dy ${core_Rectangle2D_method_offset_param_dy}
		 * @return ${core_Rectangle2D_method_offset_return}
		 * 
		 */		
		public function offset(dx:Number, dy:Number):Rectangle2D
		{
			return new Rectangle2D(this.left + dx, this.bottom + dy, this.right + dx, this.top + dy);
		}
		
		/**
		 * ${core_Rectangle2D_method_offsetPoint_D} 
		 * @param pnt2D ${core_Rectangle2D_method_offsetPoint_param_pnt2D}
		 * @return ${core_Rectangle2D_method_offsetPoint_return}
		 * 
		 */		
		public function offsetPoint(pnt2D:Point2D):Rectangle2D
		{
			if(pnt2D != null)
			{
				return this.offset(pnt2D.x, pnt2D.y);	
			}
			return null;
		}
		
		/**
		 * ${core_Rectangle2D_method_inflate_D} 
		 * @param dx ${core_Rectangle2D_method_inflate_param_dx}
		 * @param dy ${core_Rectangle2D_method_inflate_param_dy}
		 * @return ${core_Rectangle2D_method_inflate_return}
		 * 
		 */		
		public function inflate(dx:Number, dy:Number):Rectangle2D
		{
			return new Rectangle2D(this.left - dx, this.bottom - dy, this.right + dx, this.top + dy);
		}
		
		/**
		 * ${core_Rectangle2D_method_inflatePoint_D} 
		 * @param pnt2D ${core_Rectangle2D_method_inflatePoint_param_pnt2D}
		 * @return ${core_Rectangle2D_method_inflatePoint_return}
		 * 
		 */		
		public function inflatePoint(pnt2D:Point2D):Rectangle2D
		{
			if(pnt2D != null)
			{
				return this.inflate(pnt2D.x, pnt2D.y);	
			}	
			return null;
		}
		
		/**
		 * ${core_Rectangle2D_method_expand_D} 
		 * @param factor ${core_Rectangle2D_method_expand_param_factor}
		 * @return ${core_Rectangle2D_method_expand_return}
		 * 
		 */		
		public function expand(factor:Number):Rectangle2D
		{
			var expandFactor:Number = (1 - factor) * 0.5;
			var expandX:Number = this._width * expandFactor;
			var expandY:Number = this._height * expandFactor;
			return new Rectangle2D(this.left + expandX, this.bottom + expandY, this.right - expandX, this.top - expandY);
		}
		
		/**
		 * ${core_Rectangle2D_method_intersects_D} 
		 * @param rect2D ${core_Rectangle2D_method_intersects_param_rect2D}
		 * @return ${core_Rectangle2D_method_intersects_return}
		 * 
		 */		
		public function intersects(rect2D:Rectangle2D):Boolean
		{
			if(rect2D == null || rect2D.isEmpty())
			{
				return false;	
			}
			return (rect2D.left <= this.right) && (rect2D.right >= this.left) && (rect2D.bottom <= this.top) && (rect2D.top >= this.bottom);
		}
		
		/**
		 * ${core_Rectangle2D_method_intersection_D}.
		 * ${core_Rectangle2D_method_intersection_image_D} 
		 * @param rect2D ${core_Rectangle2D_method_intersection_param_rect2D}
		 * @return ${core_Rectangle2D_method_intersection_return}
		 * 
		 */		
		public function intersection(rect2D:Rectangle2D):Rectangle2D
		{
			if(rect2D)
			{
				var rtnRect:Rectangle2D = new Rectangle2D();
				if (this.intersects(rect2D))
				{				
					var left:Number = Math.max(this.left, rect2D.left);
					var right:Number = Math.min(this.right, rect2D.right);
					var top:Number = Math.min(this.top, rect2D.top);
					var bottom:Number = Math.max(this.bottom, rect2D.bottom);
					rtnRect.update(left, bottom, right, top);
				}
				return rtnRect;		
			}
			return null;
			
		}
		
		/**
		 * ${core_Rectangle2D_method_union_D}.
		 * ${core_Rectangle2D_method_union_image_D} 
		 * @param rect2D ${core_Rectangle2D_method_union_param_rect2D}
		 * @return ${core_Rectangle2D_method_union_return}
		 * 
		 */		
		public function union(rect2D:Rectangle2D):Rectangle2D
		{
			if(rect2D)
			{
				if(this.isEmpty())
				{
					return rect2D;
				}
				var rtnRect:Rectangle2D = this.clone();
				if (!rect2D.isEmpty())
				{
					var left:Number = Math.min(this.left, rect2D.left);
					var right:Number = Math.max(this.right, rect2D.right);
					var top:Number = Math.max(this.top, rect2D.top);
					var bottom:Number = Math.min(this.bottom, rect2D.bottom);
					rtnRect.update(left, bottom, right, top);
				}
				return rtnRect;
			}	
			return null;
		}
		
		/**
		 * ${core_Rectangle2D_method_unionXY_D}.
		 * <p>${core_Rectangle2D_method_unionXY_image_D}</p> 
		 * @param x ${core_Rectangle2D_method_unionXY_param_x}
		 * @param y ${core_Rectangle2D_method_unionXY_param_y}
		 * @return ${core_Rectangle2D_method_unionXY_return}
		 * 
		 */		
		public function unionXY(x:Number, y:Number) : Rectangle2D
		{
			var rtnRect:Rectangle2D = this.clone();
			var left:Number = Math.min(this.left, x);
			var bottom:Number = Math.min(this.bottom, y);
			var right:Number = Math.max(this.right, x);
			var top:Number = Math.max(this.top, y);
			rtnRect.update(left, bottom, right, top);
			return rtnRect;
		}
		
		/**
		 * ${core_Rectangle2D_method_unionPoint_D}.
		 * <p>${core_Rectangle2D_method_unionPoint_image_D}</p>
		 * @param pnt2D ${core_Rectangle2D_method_unionPoint_param_pnt2D}
		 * @return ${core_Rectangle2D_method_unionPoint_return}
		 * 
		 */		
		public function unionPoint(pnt2D:Point2D):Rectangle2D
		{
			if (pnt2D)
			{
				return this.unionXY(pnt2D.x, pnt2D.y);
			}
			return null;
		}
		
		/**
		 * ${core_Rectangle2D_method_contains_D} 
		 * @param dx ${core_Rectangle2D_method_contains_param_dx}
		 * @param dy ${core_Rectangle2D_method_contains_param_dy}
		 * @return ${core_Rectangle2D_method_contains_return}
		 * 
		 */		
		public function contains(dx:Number, dy:Number):Boolean
		{
			if(this.isEmpty())
			{
				return false;
			}
			return (this.left <= dx) && (dx <= this.right) && (this.bottom <= dy) && (dy <= this.top);			
		}
		
		/**
		 * ${core_Rectangle2D_method_containsPoint_D} 
		 * @param pnt2D ${core_Rectangle2D_method_containsPoint_param_pnt2D}
		 * @return ${core_Rectangle2D_method_containsPoint_return}
		 * 
		 */		
		public function containsPoint(pnt2D:Point2D):Boolean
		{
			if(pnt2D == null || this.isEmpty())
			{
				return false;
			}

			return this.contains(pnt2D.x, pnt2D.y); 			
		}
		
		/**
		 * ${core_Rectangle2D_method_containsRect_D} 
		 * @param rect2D ${core_Rectangle2D_method_containsPoint_param_rect2D}
		 * @return ${core_Rectangle2D_method_containsPoint_return} 
		 * 
		 */		
		public function containsRect(rect2D:Rectangle2D):Boolean
		{
			if(rect2D == null || rect2D.isEmpty() || this.isEmpty())
			{
				return false;
			}
	
			return (this.left <= rect2D.left) && (rect2D.right <= this.right) && 
				    (this.bottom <= rect2D.bottom) && (rect2D.top <= this.top);
		
		}
		
		/**
		 * ${core_Rectangle2D_method_within_D} 
		 * @param rect2D ${core_Rectangle2D_method_within_param_rect2D}
		 * @return ${core_Rectangle2D_method_within_return}
		 * 
		 */		
		public function within(rect2D:Rectangle2D ):Boolean
		{
			if(rect2D == null || rect2D.isEmpty() || this.isEmpty())
			{
				return false;
			}
			return (this.left >= rect2D.left) && (this.right <= rect2D.right) && (this.bottom >= rect2D.bottom) && (this.top <= rect2D.top);
		}
		//end public方法
		
		//static
		/**
		 * ${core_Rectangle2D_method_createFromXYWidthHeight_D} 
		 * @param x ${core_Rectangle2D_method_createFromXYWidthHeight_param_x}
		 * @param y ${core_Rectangle2D_method_createFromXYWidthHeight_param_y}
		 * @param width ${core_Rectangle2D_method_createFromXYWidthHeight_param_width}
		 * @param height ${core_Rectangle2D_method_createFromXYWidthHeight_param_height}
		 * @return ${core_Rectangle2D_method_createFromXYWidthHeight_return}
		 * 
		 */		
		public static function createFromXYWidthHeight(x:Number, y:Number, width:Number, height:Number) : Rectangle2D
		{
			return new Rectangle2D(x, y, x + width, y + height);
		}
		
		//private
		private function fromXYWidthHeight(x:Number, y:Number, width:Number, height:Number) : void
		{
			if (isNaN(width) || width < 0.0)
			{
				throw new SmError(SmResource.WIDTH_LESSTHAN_ZERO);
			}
			if (isNaN(height) || height < 0.0)
			{
				throw new SmError(SmResource.HEIGHT_LESSTHAN_ZERO);
			}
			this._x = x;
			this._y = y;
			this._width = width;
			this._height = height;
		}
	}
}