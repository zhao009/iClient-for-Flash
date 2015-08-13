package com.supermap.web.iServerJava6R.mapServices
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.service.supportClasses.PrjCoordSys;
	import com.supermap.web.service.supportClasses.UserInfo;
	import com.supermap.web.sm_internal;
	import com.supermap.web.utils.JsonUtil;
	
	import flash.geom.Rectangle;

	use namespace sm_internal;

	/**
	 * ${iServerJava6R_GetMapStatusResult_Title}.
	 * <p>${iServerJava6R_GetMapStatusResult_Description}</p> 
	 * 
	 */	
	public class GetMapStatusResult
	{  
		//-----------------------------------------------------------------------------------
		//
		//	获取地图的信息结果类
		//
		//-----------------------------------------------------------------------------------
		
		private var _name:String;
		private var _center:Point2D;
		private var _scale:Number;
		private var _maxScale:Number;
		private var _minScale:Number;
		
		private var _bounds:Rectangle2D;
		private var _viewBounds:Rectangle2D;
		private var _viewer:Rectangle;
		private var _prjCoordSys:PrjCoordSys;
		private var _isCacheEnabled:Boolean;
		
		private var _customParams:String;
		private var _userToken:UserInfo;
		private var _clipRegion:ServerGeometry;
		private var _isClipRegionEnabled:Boolean;
		private var _customEntireBounds:Rectangle2D; 
		
		private var _isCustomEntireBoundsEnabled:Boolean;
		private var _angle:Number; 
		private var _antialias:Boolean;
		private var _backgroundStyle:ServerStyle;
		private var _colorMode:String;
		
		private var _coordUnit:String;
		private var _distanceUnit:String;
		private var _description:String;
		private var _isDynamicProjection:Boolean;
		private var _isMarkerAngleFixed:Boolean;
		
		private var _maxVisibleTextSize:Number;
		private var _maxVisibleVertex:int;
		private var _minVisibleTextSize:Number;
		private var _isOverlapDisplayed:Boolean;
		private var _isPaintBackground:Boolean;
		
		private var _isTextAngleFixed:Boolean;
		private var _isTextOrientationFixed:Boolean;
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_constructor_D} 
		 * 
		 */		
		public function GetMapStatusResult()
		{
		}
		
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_IsTextOrientationFixed_D} 
		 * @return 
		 * 
		 */		
		public function get isTextOrientationFixed():Boolean
		{
			return _isTextOrientationFixed;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_IsTextAngleFixed_D} 
		 * @return 
		 * 
		 */		
		public function get isTextAngleFixed():Boolean
		{
			return _isTextAngleFixed;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_IsPaintBackground_D} 
		 * @return 
		 * 
		 */		
		public function get isPaintBackground():Boolean
		{
			return _isPaintBackground;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_IsOverlapDisplayed_D} 
		 * @return 
		 * 
		 */		
		public function get isOverlapDisplayed():Boolean
		{
			return _isOverlapDisplayed;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_MinVisibleTextSize_D} 
		 * @return 
		 * 
		 */		
		public function get minVisibleTextSize():Number
		{
			return _minVisibleTextSize;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_MaxVisibleVertex_D} 
		 * @return 
		 * 
		 */		
		public function get maxVisibleVertex():int
		{
			return _maxVisibleVertex;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_MaxVisibleTextSize_D} 
		 * @return 
		 * 
		 */		
		public function get maxVisibleTextSize():Number
		{
			return _maxVisibleTextSize;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_IsMarkerAngleFixed_D} 
		 * @return 
		 * 
		 */		
		public function get isMarkerAngleFixed():Boolean
		{
			return _isMarkerAngleFixed;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_IsDynamicProjection_D} 
		 * @return 
		 * 
		 */		
		public function get isDynamicProjection():Boolean
		{
			return _isDynamicProjection;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_Description_D} 
		 * @return 
		 * 
		 */		
		public function get description():String
		{
			return _description;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_DistanceUnit_D} 
		 * @return 
		 * 
		 */		
		public function get distanceUnit():String
		{
			return _distanceUnit;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_CoordUnit_D} 
		 * @return 
		 * 
		 */		
		public function get coordUnit():String
		{
			return _coordUnit;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_ColorMode_D} 
		 * @return 
		 * 
		 */		
		public function get colorMode():String
		{
			return _colorMode;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_BackgroundStyle_D} 
		 * @return 
		 * 
		 */		
		public function get backgroundStyle():ServerStyle
		{
			return _backgroundStyle;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_Antialias_D}.
		 * <p>${iServerJava6R_GetMapStatusResult_attribute_Antialias_remarks}</p> 
		 * @return 
		 * 
		 */		
		public function get antialias():Boolean
		{
			return _antialias;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_Angle_D} 
		 * @return 
		 * 
		 */		
		public function get angle():Number
		{
			return _angle;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_IsCustomEntireBoundsEnabled_D} 
		 * @return 
		 * 
		 */		
		public function get isCustomEntireBoundsEnabled():Boolean
		{
			return _isCustomEntireBoundsEnabled;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_CustomEntireBounds_D} 
		 * @return 
		 * 
		 */		
		public function get customEntireBounds():Rectangle2D
		{
			return _customEntireBounds;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_IsClipRegionEnabled_D} 
		 * @return 
		 * 
		 */		
		public function get isClipRegionEnabled():Boolean
		{
			return _isClipRegionEnabled;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_ClipRegion_D} 
		 * @return 
		 * 
		 */		
		public function get clipRegion():ServerGeometry
		{
			return _clipRegion;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_UserToken_D} 
		 * @return 
		 * 
		 */		
		public function get userToken():UserInfo
		{
			return _userToken;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_CustomParams_D} 
		 * @return 
		 * 
		 */		
		public function get customParams():String
		{
			return _customParams;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_IsCacheEnabled_D} 
		 * @return 
		 * 
		 */		
		public function get isCacheEnabled():Boolean
		{
			return _isCacheEnabled;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_PrjCoordSys_D} 
		 * @return 
		 * 
		 */		
		public function get prjCoordSys():PrjCoordSys
		{
			return _prjCoordSys;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_Viewer_D} 
		 * @return 
		 * 
		 */		
		public function get viewer():Rectangle
		{
			return _viewer;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_ViewBounds_D} 
		 * @return 
		 * 
		 */		
		public function get viewBounds():Rectangle2D
		{
			return _viewBounds;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_Bounds_D} 
		 * @return 
		 * 
		 */		
		public function get bounds():Rectangle2D
		{
			return _bounds;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_MinScale_D} 
		 * @return 
		 * 
		 */		
		public function get minScale():Number
		{
			return _minScale;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_MaxScale_D} 
		 * @return 
		 * 
		 */		
		public function get maxScale():Number
		{
			return _maxScale;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_Scale_D} 
		 * @return 
		 * 
		 */		
		public function get scale():Number
		{
			return _scale;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_Center_D} 
		 * @return 
		 * 
		 */		
		public function get center():Point2D
		{
			return _center;
		}
 
		/**
		 * ${iServerJava6R_GetMapStatusResult_attribute_Name_D} 
		 * @return 
		 * 
		 */		
		public function get name():String
		{
			return _name;
		}
 
		sm_internal static function fromJson(json:Object):GetMapStatusResult
		{
			if(json == null)
				return null;
			var result:GetMapStatusResult = new GetMapStatusResult();
			result._angle = json.angle;
			result._antialias = json.antialias;
			result._backgroundStyle = ServerStyle.fromJson(json.backgroundStyle);
			result._bounds = JsonUtil.toRectangle2D(json.bounds);
			result._isCacheEnabled = json.isCacheEnabled;
			result._center = JsonUtil.toPoint2D(json.center);
			result._clipRegion = ServerGeometry.fromJson(json.clipRegion);
			result._isClipRegionEnabled = json.clipRegionEnabled;
			if(json.colorMode)
			{
				result._colorMode = json.colorMode;
			}
			if(json.coordUnit)
			{
				result._coordUnit = json.coordUnit;
			}
			result._customEntireBounds = JsonUtil.toRectangle2D(json.customEntireBounds);
			result._isCustomEntireBoundsEnabled = json.customEntireBoundsEnabled;
			result._customParams = json.customParams;
			result._description = json.description;
			if(json.distanceUnit)
			{
				result._distanceUnit = json.distanceUnit;
			}
			result._isDynamicProjection = json.dynamicProjection;
			result._isMarkerAngleFixed = json.markerAngleFixed;
			result._maxScale = json.maxScale;
			result._maxVisibleTextSize = json.maxVisibleTextSize;
			result._maxVisibleVertex = json.maxVisibleVertex;
			result._minScale = json.minScale;
			result._minVisibleTextSize = json.minVisibleTextSize;
			result._name = json.name;
			result._isOverlapDisplayed = json.overlapDisplayed;
			result._isPaintBackground = json.paintBackground;
			result._prjCoordSys = PrjCoordSys.fromJson(json.prjCoordSys);
			result._scale = json.scale;
			result._isTextAngleFixed = json.textAngleFixed;
			result._isTextOrientationFixed = json.textOrientationFixed;
			result._userToken = UserInfo.fromJson(json.userToken);
			result._viewBounds = JsonUtil.toRectangle2D(json.viewBounds);
			result._viewer = JsonUtil.toRectangle(json.viewer);
			
			return result;
		} 
	}
}