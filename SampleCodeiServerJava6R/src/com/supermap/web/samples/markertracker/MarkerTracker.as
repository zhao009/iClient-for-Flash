package com.supermap.web.samples.markertracker
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.styles.PredefinedLineStyle;
	import com.supermap.web.core.styles.PredefinedMarkerStyle;
	import com.supermap.web.events.MapEvent;
	import com.supermap.web.events.MapMouseEvent;
	import com.supermap.web.events.PanEvent;
	import com.supermap.web.events.ZoomEvent;
	import com.supermap.web.mapping.FeaturesLayer;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.resources.SmError;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.Timer;
	
	import mx.effects.Glow;
	import mx.utils.ObjectUtil;
	
	import spark.components.Label;
	import spark.effects.Animate;
	import spark.effects.Resize;
	import spark.effects.animation.MotionPath;
	import spark.effects.animation.SimpleMotionPath;
		
		public class MarkerTracker
		{
			
			public static const DEFAULT_PADDING:Number = 25;
			public static const DEFAULT_ICON_SCALE:Number = 0.6;
			public static const DEFAULT_ARROW_COLOR:Number = 0xff0000;
			public static const DEFAULT_ARROW_WEIGHT:Number = 20;
			public static const DEFAULT_ARROW_LENGTH:Number = 20;
			public static const DEFAULT_ARROW_OPACITY:Number = 0.8;
			public static const DEFAULT_UPDATE_EVENT:String = PanEvent.PAN_UPDATE;
			public static const DEFAULT_CHANGED_EVENT:String = ZoomEvent.ZOOM_END;
			public static const DEFAULT_CLICK_EVENT:String = MouseEvent.CLICK;
			
			private var padding_:Number;
			private var color_:Number;
			private var weight_:Number;
			private var length_:Number;
			private var opacity_:Number;
			private var updateEvent_:String;
			private var changedEvent_:String;
			private var clickEvent_:String;
			
			private var babyMarker_:Feature;
			
			private var map_:Map;
			private var marker_:Feature;
			private var enabled_:Boolean = true;
			private var arrowDisplayed_:Boolean = false;
			private var arrow_:Feature;
			private var oldArrow_:Feature;
			private var control_:Object;
			private var markerLayer_:FeaturesLayer;
			private var _arrowStyle:PredefinedLineStyle;
			
			/**
			 * 给定map和marker以及跟踪箭头的一些参数，实例化marker跟踪类。
			 * @param {Marker} 
			 * @param {Map} 
			 * @param {MarkerTrackerOptions}
			 */
			
			public function MarkerTracker(marker:Feature, map:Map, opts:MarkerTrackerOptions)
			{				
				this.map_ = map;
				this.marker_ = marker;
				this.enabled_ = true;
				this.arrowDisplayed_ = false;
				this.arrow_ = null;
				this.oldArrow_ = null;
				this.control_ = null;
				this.markerLayer_ = new FeaturesLayer();
				this.map_.addLayer(	this.markerLayer_);
				
				opts = opts || new MarkerTrackerOptions();

				this.padding_ = MarkerTracker.DEFAULT_PADDING;
				if (opts.padding) {
					this.padding_ = opts.padding;
				}
				this.color_ = MarkerTracker.DEFAULT_ARROW_COLOR;
				if (opts.arrowColor) {
					this.color_ = opts.arrowColor;
				}
				this.weight_ = MarkerTracker.DEFAULT_ARROW_WEIGHT;
				if (opts.arrowWeight) {
					this.weight_ = opts.arrowWeight;
				}
				this.length_ = MarkerTracker.DEFAULT_ARROW_LENGTH;
				if (opts.arrowLength) {
					this.length_ = opts.arrowLength;
				}
				this.opacity_ = MarkerTracker.DEFAULT_ARROW_OPACITY;
				if (opts.arrowOpacity) {
					this.opacity_ = opts.arrowOpacity;
				}
				this.updateEvent_ = MarkerTracker.DEFAULT_UPDATE_EVENT;
				if (opts.updateEvent) {
					this.updateEvent_ = opts.updateEvent;
				}			
				this.changedEvent_ = MarkerTracker.DEFAULT_CHANGED_EVENT;
				if (opts.changedEvent) {
					this.changedEvent_ = opts.changedEvent;
				}			
				this.clickEvent_ = MarkerTracker.DEFAULT_CLICK_EVENT;
				if (opts.clickEvent) {
					this.clickEvent_ = opts.clickEvent;
				}
				this._arrowStyle = new PredefinedLineStyle("solid", this.color_, this.opacity_, this.weight_);
				this.babyMarker_ = new Feature(new GeoPoint(0, 0), this.marker_.style);		
				this.babyMarker_.isRealtimeRefresh = true;
				this.babyMarker_.toolTip = "点击返回至原点";
			 
				//绑定响应事件
				this.map_.addEventListener(this.updateEvent_, this.updateArrow_);
				this.map_.addEventListener(this.changedEvent_, this.updateArrow_);		
				this.marker_.addEventListener(Event.CHANGE, this.updateArrow_);
				this.babyMarker_.addEventListener(this.clickEvent_, this.panToMarker_);
				
				this.updateArrow_(null);
			}
		 
			
			private function mouseOutHandler(event:MouseEvent):void
			{ 
				
				this.babyMarker_.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler); 
			} 
			
			/**
			 *  注销marker tracker
			 */
			public function destroy():void 
			{
				this.disable();
				
				this.marker_.removeEventListener(Event.CHANGE, this.updateArrow_);
				this.map_.removeEventListener(this.updateEvent_, this.updateArrow_);
				this.map_.removeEventListener(this.changedEvent_, this.updateArrow_);
				
				this.babyMarker_ = null;
				this.markerLayer_ = null;
			}
			
			/**
			 *  关闭marker tracker.
			 */
			public function disable():void 
			{
				this.enabled_ = false;
				this.updateArrow_(null);
			}
			
			/**
			 *  打开marker tracker
			 */
			public function enable():void 
			{
				this.enabled_ = true;
				this.updateArrow_(null);
			}
			
			/**
			 * 重置
			 */
			public function reactivate():void
			{
				this.enabled_ = true;
				this.arrowDisplayed_ = false;
				this.arrow_ = null;
				this.oldArrow_ = null;
				this.control_ = null;
				
				this.babyMarker_ = new Feature(new GeoPoint(0, 0));
				this.babyMarker_.isRealtimeRefresh = true;

				this.babyMarker_.style = this.marker_.style;
		
				this.map_.addEventListener(this.updateEvent_, this.updateArrow_);
				this.map_.addEventListener(this.changedEvent_, this.updateArrow_);

				this.babyMarker_.addEventListener(this.clickEvent_, this.panToMarker_);
			
				this.updateArrow_(null);
			}
			
			
			/**
			 *  响应事件
			 */
			
			private function updateArrow_(event:Event):void 
			{
				if(this.marker_.geometry is GeoPoint)
				{
					var geoPnt:GeoPoint = this.marker_.geometry as GeoPoint;
					var viewBounds:Rectangle2D;
					if(event is PanEvent)
					{
						var panEvent:PanEvent = event as PanEvent;
						viewBounds = panEvent.viewBounds;
					}
					else
					{
						viewBounds = this.map_.viewBounds;
					}
					if(!viewBounds.contains(geoPnt.x, geoPnt.y) && this.enabled_) 
					{
						this.drawArrow_();
					} 
					else if(this.arrowDisplayed_) 
					{
						this.hideArrow_();
					}
				}			
			}
			
			
			
			/**
			 *  绘制箭头
			 */
			
			private function drawArrow_():void 
			{
				var geoPnt:GeoPoint = this.marker_.geometry as GeoPoint;
				
				var bounds:Rectangle2D = this.map_.viewBounds;
				var SW:Point = this.map_.mapToScreen(bounds.bottomLeft);
				var NE:Point = this.map_.mapToScreen(bounds.topRight);
				
				//把padding值算上
				var minX:Number =  SW.x + this.padding_;
				var minY:Number =  NE.y + this.padding_;
				var maxX:Number =  NE.x - this.padding_;
				var maxY:Number =  SW.y - this.padding_;
				
				var centerPoint:Point = this.map_.mapToScreen(this.map_.center);
				var locPoint:Point = this.map_.mapToScreen(new Point2D(geoPnt.x, geoPnt.y));
				
				var offsetX:Number = centerPoint.x - locPoint.x;
				var m:Number = NaN;
				var b:Number = NaN;
				if(offsetX)
				{
					m = (centerPoint.y - locPoint.y) / offsetX;
					b = (centerPoint.y - m * centerPoint.x);
				}			
				
				var x:Number = maxX;
				if ( locPoint.x < maxX && locPoint.x > minX ) 
				{
					x = locPoint.x;
				} 
				else if (centerPoint.x > locPoint.x) 
				{
					x = minX; 
				}
				
				var y:Number = maxY;
				var ang:Number = 0;

				if(isNaN(m))
				{
					x = locPoint.x;
					y = y > maxY ? maxY : minY;
				}
				else
				{
					y = m * x + b;
					if( y > maxY ) 
					{
						y = maxY;
						x = (y - b) / m;
					} 
					else if(y < minY) 
					{
						y = minY;
						x = (y - b) / m;
					}
					
					// 斜率
					ang = Math.atan(-m);
					if(x > centerPoint.x) 
					{
						ang = ang + Math.PI; 
					} 
				}		
				
				// 箭头的起始点			
				var arrowLoc:Point2D = this.map_.screenToMap(new Point(x, y));

				// marker的左边是 -1,1
				var arrowLeft:Point2D = this.map_.screenToMap(
					this.getRotatedPoint_(((-1) * this.length_), this.length_, ang, x, y) );

				// marker的右边是  -1,-1
				var arrowRight:Point2D = this.map_.screenToMap( 
					this.getRotatedPoint_(((-1)*this.length_), ((-1)*this.length_), ang, x, y));
				
				this.oldArrow_ = this.arrow_;
				var geoLine:GeoLine = new GeoLine();
				geoLine.addPart([arrowLeft, arrowLoc, arrowRight]);
				if(!this.arrow_)
				{
					this.arrow_ = new Feature(geoLine, this._arrowStyle);
					this.arrow_.isRealtimeRefresh = true;
				}
				this.arrow_.geometry = geoLine;			
				
				// 移动babyMarker 到 -1,0
				var babyPnt:Point2D = this.map_.screenToMap(this.getRotatedPoint_(((-2)*this.length_), 0, ang, x, y));
				this.babyMarker_.geometry = new GeoPoint(babyPnt.x, babyPnt.y);
				
				if (!this.arrowDisplayed_) 
				{
					this.markerLayer_.addFeature(this.babyMarker_);
					this.markerLayer_.addFeature(this.arrow_);
					this.arrowDisplayed_ = true;
				}			
			}
			
			/**
			 *  隐藏箭头
			 */
			
			private function hideArrow_():void 
			{		
				if(this.babyMarker_) 
				{
					this.markerLayer_.removeFeature(this.babyMarker_);
				}
				if(this.arrow_) 
				{
					this.markerLayer_.removeFeature(this.arrow_);
				}
				this.arrowDisplayed_ = false;	
						
			}
			
			/**
			 *  将Marker移动map的中心
			 */
			
			private function panToMarker_(event:Event):void 
			{
				var geoPnt:GeoPoint = this.marker_.geometry as GeoPoint;
				this.map_.panTo(new Point2D(geoPnt.x, geoPnt.y)); 
			}
			
			/**
			 *  算出与指定点旋转角度与偏移量的点
			 *  
			 * @param {Number} x 指定点的x
			 * @param {Number} y 指定点的y
			 * @param {Number} ang 逆时针旋转角度
			 * @param {Number} xoffset x方向偏移量
			 * @param {Number} yoffset y方向偏移量
			 * @return {Point} 旋转点
			 */
			
			private function getRotatedPoint_(x:Number, y:Number, ang:Number, xoffset:Number, yoffset:Number):Point 
			{
				var newx:Number = y * Math.sin(ang) - x * Math.cos(ang) + xoffset;
				var newy:Number = x * Math.sin(ang) + y * Math.cos(ang) + yoffset;
				return new Point(newx, newy);
			}
			
		}
}