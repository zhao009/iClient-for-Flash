package com.supermap.web.actions
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.Rectangle2D;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.styles.FillStyle;
	import com.supermap.web.core.styles.PredefinedFillStyle;
	import com.supermap.web.core.styles.PredefinedLineStyle;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	use namespace sm_internal;
	
	//此类不向用户公开
	/**
	 * @private 
	 * 
	 */	
	internal class ZoomAction extends DrawAction
	{
		private var _point2Ds:Array;
		private var _geoRegion:GeoRegion;
		protected var zoomType:String;
		
		public function ZoomAction(map:Map)
		{
			super(map); 
			this.style = new PredefinedFillStyle();	 
		}
		
		
//		override protected function onMouseOver(event:MouseEvent):void
//		{
//			this.addZoomCursor();
//		}
//		
//		override protected function onMouseOut(event:MouseEvent):void
//		{
//			this.removeZoomCursor();
//		}
//		
//		protected function addZoomCursor():void
//		{
//		}
//		
//		protected function removeZoomCursor():void
//		{
//		}
		
		override protected function onMouseDown(event:MouseEvent):void
		{
			
			if ((this.map.isTweening && !this.map.isPanning) || MapAction.targetHasEventListener(event) || !this.map.viewBounds)
			{
				return;
			}
			if(this.tempFeature)
				return;
			_point2Ds = [];
			this.actionStarted = true;
			this.map.setFocus();
			map.layerHolder.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			this.tempFeature = new Feature();
			this.startDraw(point2D);
			this._geoRegion = new GeoRegion();
			this._point2Ds.push(point2D, point2D, point2D, point2D, point2D);
			this._geoRegion.parts.push(this._point2Ds);
			this.tempFeature.style = this.style;
			this.tempFeature.geometry = this._geoRegion;
			this.tempLayer.addFeature(this.tempFeature);
		}
		
		override protected function onMouseMove(event:MouseEvent):void
		{
			if (!this.actionStarted)
			{
				return;
			}
			
			if (this.map.isTweening || this.map.isPanning)
			{
				return;
			}
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			this._point2Ds[2] = point2D;
			var firstPoint:Point2D = this._point2Ds[0];
			this._point2Ds[1] = new Point2D(point2D.x, firstPoint.y);
			this._point2Ds[3] = new Point2D(firstPoint.x, point2D.y);
			this._geoRegion.parts = this._geoRegion.parts;
			this.tempFeature.refresh();
		}
		
		override protected function onMouseUp(event:MouseEvent):void
		{
			if (!this.actionStarted)
			{
				return;
			}
			
			var startMousePoint:Point = this.map.mapToScreen(this._point2Ds[0]);
			var endMousePoint:Point = this.map.mapToScreen(this._point2Ds[2]);
			
			this.endDraw(this._point2Ds[2]);
			this._point2Ds = [];
			this.actionStarted = false;
			map.layerHolder.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			// 鼠标没有拖拽，只是单击，则缩小地图，移除事件注册
			if((startMousePoint.x == endMousePoint.x) && (startMousePoint.y == endMousePoint.y))
			{
				onMouseZoomClick(event);
				return;
			}
			
//			map.layerHolder.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			var width:Number = Math.abs(endMousePoint.x - startMousePoint.x);
			var height:Number = Math.abs(endMousePoint.y - startMousePoint.y);
			var widthRatio:Number;
			var heightRatio:Number;
			
			if(this.zoomType == "zoomIn")
			{
				widthRatio = this.map.width / width;
				heightRatio = this.map.height / height;
				
				if (event.shiftKey)
				{
					widthRatio = width / this.map.width;
					heightRatio = height / this.map.height;
				}
			}
			else
			{
				widthRatio = width / this.map.width;
				heightRatio = height / this.map.height;
				if (event.shiftKey)
				{
					widthRatio = this.map.width / width;
					heightRatio = this.map.height / height;
				}
			}
			
			var curRatio:Number = widthRatio;
			if (heightRatio < widthRatio)
			{
				curRatio = heightRatio;
			}
			if (curRatio == 0)
			{
				this.actionStarted=false;
				return;
			}
			var viewCenterX:Number = (endMousePoint.x + startMousePoint.x) * 0.5;
			var viewCenterY:Number = (endMousePoint.y + startMousePoint.y) * 0.5;
			var geoCenter:Point2D = this.map.screenToMap(new Point(viewCenterX, viewCenterY));
			this.map.zoomToResolution(this.map.resolution / curRatio, geoCenter);
		}
		
		private function onMouseZoomClick(event:MouseEvent):void
		{
			var pnt:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			var zoomFactor:Number;
			if(this.zoomType == "zoomIn")
			{
				zoomFactor = 0.5;
				if (event.shiftKey)
				{
					zoomFactor = 2;
				}
			}
			else
			{
				zoomFactor = 2;
				if (event.shiftKey)
				{
					zoomFactor = 0.5;
				}
			}
			var bounds:Rectangle2D  = this.map.viewBounds;
			bounds = bounds.centerAtPoint(pnt);
			bounds = bounds.expand(zoomFactor);
			this.map.viewBounds = bounds;
		}
		
	}
}