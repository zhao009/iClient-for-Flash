package com.supermap.web.iServerJava2.networkAnalystServices
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	/**
	 * ${iServer2_networkAnalystServices_PathGuideItem_Title}.
	 * <p>${iServer2_networkAnalystServices_PathGuideItem_Description}</p>
	 * 
	 * 
	 */
	public class PathGuideItem
	{
		//行驶导引对象子项的 ID
		private var _id:int;
		//行驶导引对象子项的名称
		private var _name:String;
		//行驶导引对象子项的序号
		private var _index:int;
		//行驶导引对象子项的权值，即行使导引对象子项的花费
		private var _weight:Number;
		//行驶导引对象子项为弧段时返回弧段的长度
		private var _length:Number;
		//站点到弧段的距离
		private var _distance:Number;
		//行驶方向。 共有五个方向，即东、南、西、北、无方向。当 isEdge 值为 false 时，行驶方向返回的类型为无方向
		private var _directionType:int;
		//转弯方向
		private var _turnType:int;
		//在路的左侧、右侧还是在路上
		private var _sideType:int;
		//转弯角度
		private var _turnAngle:Number;
		//是否是弧段
		private var _isEdge:Boolean
		//是否是站点。
		private var _isStop:Boolean;
		//返回对象的范围，对弧段而言，为弧段的外接矩形；对点而言，为点本身
		private var _bounds:Rectangle2D;
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_ID_D}  
		 * 
		 */
		public function get id():int
		{
			return this._id;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_name_D}
		 * 
		 */
		public function get name():String
		{
			return this._name;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_index_D}
		 * 
		 */
		public function get index():int
		{
			return this._index;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_weight_D}
		 * 
		 */
		public function get weight():Number
		{
			return this._weight;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_length_D}
		 * 
		 */
		public function get length():Number
		{
			return this._length;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_distance_D}.
		 * <p>${iServer2_networkAnalystServices_PathGuideItem_attribute_distance_remarks}</p>
		 * 
		 */
		public function get distance():Number
		{
			return this._distance;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_directionType_D}.
		 * <p>${iServer2_networkAnalystServices_PathGuideItem_attribute_directionType_remarks}</p>
		 * 
		 */
		public function get directionType():int
		{
			return this._directionType;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_turnType_D}
		 * @see TurnType
		 * 
		 */
		public function get turnType():int
		{
			return this._turnType;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_sideType_D}
		 * <p>${iServer2_networkAnalystServices_PathGuideItem_attribute_sideType_remarks}</p>
		 * @see SideType
		 * 
		 */
		public function get sideType():int
		{
			return this._sideType;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_turnAngle_D}
		 * 
		 */
		public function get turnAngle():int
		{
			return this._turnAngle;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_isEdge_D}
		 * 
		 */
		public function get isEdge():Boolean
		{
			return this._isEdge;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_isStop_D}.
		 * <p>${iServer2_networkAnalystServices_PathGuideItem_attribute_isStop_remarks}</p>
		 * 
		 */
		public function get isStop():Boolean
		{
			return this._isStop;
		}
		
		/**
		 * ${iServer2_networkAnalystServices_PathGuideItem_attribute_bounds_D}.
		 * <p>${iServer2_networkAnalystServices_PathGuideItem_attribute_bounds_remarks}</p>
		 * 
		 */
		public function get bounds():Rectangle2D
		{
			return this._bounds;
		}
		
		sm_internal static function toPathGuideItem(object:Object):PathGuideItem
		{
			var pathGuideItem:PathGuideItem;
			if(object)
			{
				pathGuideItem = new PathGuideItem();
				pathGuideItem._id = object.id;
				pathGuideItem._name = object.name;
				pathGuideItem._index = object.index;
				pathGuideItem._weight = object.weight;
				pathGuideItem._length = object.length;
				pathGuideItem._distance = object.distance;
				pathGuideItem._directionType = object.directionType;
				pathGuideItem._turnType = object.turnType;
				pathGuideItem._sideType = object.sideType;
				
				pathGuideItem._turnAngle = object.turnAngle;
				pathGuideItem._isEdge = object.isEdge; 
				pathGuideItem._isStop = object.isStop;
				pathGuideItem._bounds = new Rectangle2D(object.bounds.leftBottom.x, object.bounds.leftBottom.y, object.bounds.rightTop.x, object.bounds.rightTop.y);			
				
			}
			return pathGuideItem;
		}
	}
}