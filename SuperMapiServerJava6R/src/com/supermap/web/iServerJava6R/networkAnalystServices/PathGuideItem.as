package com.supermap.web.iServerJava6R.networkAnalystServices
{
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.Geometry;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;

	use namespace sm_internal;
	/**
	 * ${iServerJava6R_PathGuideItem_Title}.
	 * <p>${iServerJava6R_PathGuideItem_Description}</p> 
	 * 
	 */	
	public class PathGuideItem
	{
		private var _bounds:Rectangle2D; 
		private var _distance:Number = 0;
		private var _id:int;
		private var _index:int;
		private var _isEdge:Boolean;
		private var _isStop:Boolean;
		private var _length:Number = 0;
		private var _name:String;
		private var _turnAngle:Number = 0;
		private var _description:String;
		private var _geometry:Geometry;
		private var _directionType:String;
		private var _sideType:String; 
		private var _turnType:String;
		
		private var _weight:Number = 0;
	    
		/**
		 * ${iServerJava6R_PathGuideItem_attribute_geometry_D} 
		 * @return 
		 * 
		 */		
		public function get geometry():Geometry
		{
			return _geometry;
		}

		public function set geometry(value:Geometry):void
		{
			_geometry = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_description_D} 
		 * @return 
		 * 
		 */		
		public function get description():String
		{
			return _description;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_bounds_D}.
		 * <p>${iServerJava6R_PathGuideItem_attribute_bounds_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}

		public function set bounds(value:Rectangle2D):void
		{
			_bounds = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_directionType_D}.
		 * <p>${iServerJava6R_PathGuideItem_attribute_directionType_remarks}</p>
		 * @return 
		 * 
		 */		
		public function get directionType():String
		{
			return _directionType;
		}

		public function set directionType(value:String):void
		{
			_directionType = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_distance_D}.
		 * <p>${iServerJava6R_PathGuideItem_attribute_distance_remaks}</p> 
		 * @return 
		 * 
		 */		
		public function get distance():Number
		{
			return _distance;
		}

		public function set distance(value:Number):void
		{
			_distance = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_ID_D}.
		 * <p>${iServerJava6R_PathGuideItem_attribute_ID_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get id():int
		{
			return _id;
		}

		public function set id(value:int):void
		{
			_id = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_index_D}.
		 * <p>${iServerJava6R_PathGuideItem_attribute_index_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get index():int
		{
			return _index;
		}

		public function set index(value:int):void
		{
			_index = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_isEdge_D} 
		 * @return 
		 * 
		 */		
		public function get isEdge():Boolean
		{
			return _isEdge;
		}

		public function set isEdge(value:Boolean):void
		{
			_isEdge = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_isStop_D}.
		 * <p>${iServerJava6R_PathGuideItem_attribute_isStop_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get isStop():Boolean
		{
			return _isStop;
		}

		public function set isStop(value:Boolean):void
		{
			_isStop = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_length_D} 
		 * @return 
		 * 
		 */		
		public function get length():Number
		{
			return _length;
		}

		public function set length(value:Number):void
		{
			_length = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_name_D} 
		 * @return 
		 * 
		 */		
		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_sideType_D}.
		 * <p>${iServerJava6R_PathGuideItem_attribute_sideType_remarks}</p> 
		 * @see SideType
		 * @return 
		 * 
		 */		
		public function get sideType():String
		{
			return _sideType;
		}

		public function set sideType(value:String):void
		{
			_sideType = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_turnAngle_D} 
		 * @return 
		 * 
		 */		
		public function get turnAngle():Number
		{
			return _turnAngle;
		}

		public function set turnAngle(value:Number):void
		{
			_turnAngle = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_turnType_D} 
		 * @see TurnType
		 * @return 
		 * 
		 */		
		public function get turnType():String
		{
			return _turnType;
		}

		public function set turnType(value:String):void
		{
			_turnType = value;
		}

		/**
		 * ${iServerJava6R_PathGuideItem_attribute_weight_D} 
		 * @return 
		 * 
		 */		
		public function get weight():Number
		{
			return _weight;
		}

		public function set weight(value:Number):void
		{
			_weight = value;
		}

		sm_internal static function formJson(json:Object):PathGuideItem
		{ 
			if(json)
			{
				var pathGuideItem:PathGuideItem = new PathGuideItem();
				pathGuideItem.bounds = JsonUtil.toRectangle2D(json.bounds); 
				pathGuideItem.distance = json.distance; 
				pathGuideItem.id = json.id;
				pathGuideItem.index = json.index;
				pathGuideItem.isEdge = json.isEdge;
				pathGuideItem.isStop = json.isStop;//0909byzyn
				pathGuideItem._description = json.description;//0909byzyn

				pathGuideItem._geometry = ServerGeometry.toGeometry(ServerGeometry.fromJson(json.geometry));
				pathGuideItem.length = json.length;
				pathGuideItem.name = json.name; 
				pathGuideItem.turnAngle = json.turnAngle; 
				pathGuideItem.weight = json.weight;
				
				pathGuideItem.directionType = json.directionType;
				pathGuideItem.turnType = json.turnType;
				pathGuideItem.sideType = json.sideType; 
				return pathGuideItem;
			}
			return null;
		}
	}
}