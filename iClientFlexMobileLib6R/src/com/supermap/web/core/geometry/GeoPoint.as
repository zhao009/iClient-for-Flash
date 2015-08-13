package com.supermap.web.core.geometry
{
	import com.supermap.web.core.*;
	import com.supermap.web.core.styles.PredefinedMarkerStyle;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.sm_internal;
	use namespace sm_internal; 
	/**
	 * ${core_GeoPoint_Title}.
	 * <p>${core_GeoPoint_Description}</p>
	 * 
	 * 
	 */	
	public class GeoPoint extends Geometry
	{
		private var _x:Number = 0;
		private var _y:Number = 0;
		sm_internal var tempIconRec:Array;

		/**
		 * ${core_GeoPoint_constructor_D} 
		 * @param x ${core_GeoPoint_constructor_param_x}
		 * @param y ${core_GeoPoint_constructor_param_y}
		 * 
		 */		
		public function GeoPoint(x:Number = 0, y:Number = 0){
			if(!isNaN(x)&&!isNaN(y))
			{
			   this._x=x;
			   this._y=y;	
			}
		}
	

		override public function get center():Point2D
		{
			if(!_center)
			{
				 _center = new Point2D(this._x, this._y);
			}
			return _center;
		}
		sm_internal function setCenter(vaule:Point2D):void
		{
			_center = vaule;
		}
		/**
		 * ${core_GeoPoint_attribute_y_D} 
		 * @return 
		 * 
		 */		
		public function get y():Number
		{
			return _y;
		}

		public function set y(value:Number):void
		{
			if(!isNaN(y))
			   _y = value;
		}

		/**
		 * ${core_GeoPoint_attribute_x_D} 
		 * @return 
		 * 
		 */		
		public function get x():Number
		{
			return _x;
		}

		public function set x(value:Number):void
		{
			if(!isNaN(x))
			  _x = value;
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * @see Geometry
		 * 
		 */		
		override public  function get type():String
		{
			if(super.type == "TEXT")
				return "TEXT";
			return Geometry.GEOPOINT;
		}
	
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override public  function get bounds():Rectangle2D
		{
			var rect:Rectangle2D=null;
			rect=new Rectangle2D(this._x,this._y,this._x,this._y);
			return rect;			
		}
		
		/**
		 * @inheritDoc 
		 * @param geometry
		 * @return 
		 * 
		 */		
		override public  function equals(geometry:Geometry):Boolean
		{
			var bEquals:Boolean = false;
			if (geometry != null && geometry is GeoPoint)
			{
				var point:GeoPoint = GeoPoint(geometry);				
			    bEquals = (this.x == point.x) && (this.y == point.y);
				
			}
			return bEquals;
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override public  function clone():Geometry
		{
			var geoPoint:GeoPoint=new GeoPoint(this._x,this._y);			
			return geoPoint;
		}
		
		/**
		 * @inheritDoc 
		 * @return 
		 * 
		 */		
		override public  function get defaultStyle():Style
		{
			return PredefinedMarkerStyle.defaultStyle;
		}
		
		/*override public  function toString():String
		{
			var strXY:String="";
			strXY="("+this._x.toString()+","+this._y.toString()+")";
			return strXY;
		}*/
		
//		override sm_internal function toJSON():String
//		{
//			return "{\"x\":" + this.x + ", \"y\":" + this.y + "}";
//		}
		
		//TODO:defaultStyle()
		//TODO:toJson()
		
			

	}
}