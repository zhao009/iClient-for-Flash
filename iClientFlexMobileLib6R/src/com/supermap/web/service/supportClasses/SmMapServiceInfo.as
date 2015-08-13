package com.supermap.web.service.supportClasses
{
	import com.supermap.web.utils.JsonUtil;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.utils.serverTypes.ServerGeometry;
	import com.supermap.web.utils.serverTypes.ServerStyle;
	import com.supermap.web.utils.serverTypes.MapColorMode;
	import com.supermap.web.sm_internal;
	
	import flash.geom.Rectangle;
	import com.supermap.web.service.supportClasses.PrjCoordSys;
	
	
	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */
	public class SmMapServiceInfo
	{
		private var _name:String;
		private var _center:Point2D;
		private var _scale:Number;
		private var _maxScale:Number;
		private var _minScale:Number;
		private var _bounds:Rectangle2D;
		private var _viewer:Rectangle;
		private var _viewBounds:Rectangle2D;
		private var _prjCoordSys:PrjCoordSys;
		private var _acheEnabled:Boolean;
		private var _customParams:String;
		private var _userToken:UserInfo;	
		private var _clipRegion:ServerGeometry;	
		private var _clipRegionEnabled:Boolean;	
		private var _customEntireBounds:Rectangle2D ;	
		private var _customEntireBoundsEnabled:Boolean ;	
		private var _angle:Number;	
		private var _antialias:Boolean ;	
		private var _backgroundStyle:ServerStyle;		
		private var _colorMode:String;		
		private var _coordUnit:String;		
		private var _cistanceUnit:String;	
		private var _description:String;	
		private var _dynamicProjection:Boolean ;	
		private var _markerAngleFixed:Boolean;	
		private var _maxVisibleTextSize:Number ;	
		private var _maxVisibleVertex:Number;	
		private var _minVisibleTextSize:Number;	
		private var _overlapDisplayed:Boolean;	
		private var _paintBackground:Boolean;	
		private var _textAngleFixed:Boolean;	
		private var _textOrientationFixed:Boolean;
		private var _cacheEnabled:Boolean;
		private var _distanceUnit:String;
		private var _visibleScalesEnabled:Boolean;
		private var _visibleScales:Array;

		public function SmMapServiceInfo()
		{
		}
		
		public function get visibleScalesEnabled():Boolean
		{
			return _visibleScalesEnabled;
		}
		
		public function set visibleScalesEnabled(value:Boolean):void
		{
			_visibleScalesEnabled = value;
		}
		
		public function get visibleScales():Array
		{
			return _visibleScales;
		}
		
		public function set visibleScales(value:Array):void
		{
			_visibleScales = value;
		}
		
		public function get viewBounds():Rectangle2D
		{
			return _viewBounds;
		}

		public function set viewBounds(value:Rectangle2D):void
		{
			_viewBounds = value;
		}

		public function get distanceUnit():String
		{
			return _distanceUnit;
		}

		public function set distanceUnit(value:String):void
		{
			_distanceUnit = value;
		}

		public function get cacheEnabled():Boolean
		{
			return _cacheEnabled;
		}

		public function set cacheEnabled(value:Boolean):void
		{
			_cacheEnabled = value;
		}

		public function get textOrientationFixed():Boolean
		{
			return _textOrientationFixed;
		}

		public function set textOrientationFixed(value:Boolean):void
		{
			_textOrientationFixed = value;
		}

		public function get textAngleFixed():Boolean
		{
			return _textAngleFixed;
		}

		public function set textAngleFixed(value:Boolean):void
		{
			_textAngleFixed = value;
		}

		public function get paintBackground():Boolean
		{
			return _paintBackground;
		}

		public function set paintBackground(value:Boolean):void
		{
			_paintBackground = value;
		}

		public function get overlapDisplayed():Boolean
		{
			return _overlapDisplayed;
		}

		public function set overlapDisplayed(value:Boolean):void
		{
			_overlapDisplayed = value;
		}

		public function get minVisibleTextSize():Number
		{
			return _minVisibleTextSize;
		}

		public function set minVisibleTextSize(value:Number):void
		{
			_minVisibleTextSize = value;
		}

		public function get maxVisibleVertex():Number
		{
			return _maxVisibleVertex;
		}

		public function set maxVisibleVertex(value:Number):void
		{
			_maxVisibleVertex = value;
		}

		public function get maxVisibleTextSize():Number
		{
			return _maxVisibleTextSize;
		}

		public function set maxVisibleTextSize(value:Number):void
		{
			_maxVisibleTextSize = value;
		}

		public function get markerAngleFixed():Boolean
		{
			return _markerAngleFixed;
		}

		public function set markerAngleFixed(value:Boolean):void
		{
			_markerAngleFixed = value;
		}

		public function get dynamicProjection():Boolean
		{
			return _dynamicProjection;
		}

		public function set dynamicProjection(value:Boolean):void
		{
			_dynamicProjection = value;
		}

		public function get description():String
		{
			return _description;
		}

		public function set description(value:String):void
		{
			_description = value;
		}

		public function get cistanceUnit():String
		{
			return _cistanceUnit;
		}

		public function set cistanceUnit(value:String):void
		{
			_cistanceUnit = value;
		}

		public function get coordUnit():String
		{
			return _coordUnit;
		}

		public function set coordUnit(value:String):void
		{
			_coordUnit = value;
		}

		public function get colorMode():String
		{
			return _colorMode;
		}

		public function set colorMode(value:String):void
		{
			_colorMode = value;
		}

		public function get backgroundStyle():ServerStyle
		{
			return _backgroundStyle;
		}

		public function set backgroundStyle(value:ServerStyle):void
		{
			_backgroundStyle = value;
		}

		public function get antialias():Boolean
		{
			return _antialias;
		}

		public function set antialias(value:Boolean):void
		{
			_antialias = value;
		}

		public function get angle():Number
		{
			return _angle;
		}

		public function set angle(value:Number):void
		{
			_angle = value;
		}

		public function get customEntireBoundsEnabled():Boolean
		{
			return _customEntireBoundsEnabled;
		}

		public function set customEntireBoundsEnabled(value:Boolean):void
		{
			_customEntireBoundsEnabled = value;
		}

		public function get customEntireBounds():Rectangle2D
		{
			return _customEntireBounds;
		}

		public function set customEntireBounds(value:Rectangle2D):void
		{
			_customEntireBounds = value;
		}

		public function get clipRegionEnabled():Boolean
		{
			return _clipRegionEnabled;
		}

		public function set clipRegionEnabled(value:Boolean):void
		{
			_clipRegionEnabled = value;
		}

		public function get clipRegion():ServerGeometry
		{
			return _clipRegion;
		}

		public function set clipRegion(value:ServerGeometry):void
		{
			_clipRegion = value;
		}

		public function get userToken():UserInfo
		{
			return _userToken;
		}

		public function set userToken(value:UserInfo):void
		{
			_userToken = value;
		}

		public function get customParams():String
		{
			return _customParams;
		}

		public function set customParams(value:String):void
		{
			_customParams = value;
		}

		public function get acheEnabled():Boolean
		{
			return _acheEnabled;
		}

		public function set acheEnabled(value:Boolean):void
		{
			_acheEnabled = value;
		}

		public function get prjCoordSys():PrjCoordSys
		{
			return _prjCoordSys;
		}

		public function set prjCoordSys(value:PrjCoordSys):void
		{
			_prjCoordSys = value;
		}

		public function get viewer():Rectangle
		{
			return _viewer;
		}

		public function set viewer(value:Rectangle):void
		{
			_viewer = value;
		}

		public function get bounds():Rectangle2D
		{
			return _bounds;
		}

		public function set bounds(value:Rectangle2D):void
		{
			_bounds = value;
		}

		public function get minScale():Number
		{
			return _minScale;
		}

		public function set minScale(value:Number):void
		{
			_minScale = value;
		}

		public function get maxScale():Number
		{
			return _maxScale;
		}

		public function set maxScale(value:Number):void
		{
			_maxScale = value;
		}

		public function get scale():Number
		{
			return _scale;
		}

		public function set scale(value:Number):void
		{
			_scale = value;
		}

		public function get center():Point2D
		{
			return _center;
		}

		public function set center(value:Point2D):void
		{
			_center = value;
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		sm_internal static function fromJson(json:Object ):SmMapServiceInfo
		{
			if (json == null) 
			{		
				return null;
			}
			//防止json为失败信息！
			if (!json.hasOwnProperty("name") || !json.hasOwnProperty("bounds")) 
			{
				return null;
			}
				
			var info:SmMapServiceInfo = new SmMapServiceInfo();
			info.name = json.name;
			info.angle = json.angle;
			info.antialias = json.antialias;
			info.backgroundStyle = ServerStyle.fromJson(json.backgroundStyle);
			info.bounds = JsonUtil.toRectangle2D(json.bounds);
			info.cacheEnabled = json.cacheEnabled;
			info.center = JsonUtil.toPoint2D(json.center);
			info.clipRegion = ServerGeometry.fromJson(json.clipRegion);
			info.clipRegionEnabled = json.clipRegionEnabled;
			info.colorMode = json.colorMode;
			info.coordUnit = json.coordUnit;
			info.customEntireBounds = JsonUtil.toRectangle2D(json.customEntireBounds);
			info.customEntireBoundsEnabled = json.customEntireBoundsEnabled;
			info.customParams = json.customParams;
			info.description = json.description;
			info.distanceUnit = json.distanceUnit;
			info.dynamicProjection = json.dynamicProjection;
			info.viewBounds = JsonUtil.toRectangle2D(json.viewBounds);
			info.markerAngleFixed = json.markerAngleFixed;
			info.maxScale = json.maxScale;
			info.maxVisibleTextSize = json.maxVisibleTextSize;
			info.maxVisibleVertex = json.maxVisibleVertex;
			info.minScale = json.minScale;
			info.minVisibleTextSize = json.minVisibleTextSize;
			info.overlapDisplayed = json.overlapDisplayed;
			info.paintBackground = json.paintBackground;
			info.prjCoordSys = PrjCoordSys.fromJson(json.prjCoordSys);
			info.scale = json.scale;
			info.textAngleFixed = json.textAngleFixed;
			info.textOrientationFixed = json.textOrientationFixed;
			info.userToken = UserInfo.fromJson(json.userToken);
			info.viewer = JsonUtil.toRectangle(json.viewer);
			info.visibleScalesEnabled = json.visibleScalesEnabled;
			info.visibleScales=json.visibleScales;
			
			return info;
		}
	}
}