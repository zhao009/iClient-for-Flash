package com.supermap.web.actions
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoRegion;
	import com.supermap.web.core.styles.PredefinedFillStyle;
	import com.supermap.web.events.DrawEvent;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	use namespace sm_internal;

	/**
	 * ${actions_DrawCircle_Title}. 
	 * <p>${actions_DrawCircle_Deccription}</p>
	 * 
	 */	
	public class DrawCircle extends DrawAction
	{
		
		private var _point2Ds:Array;
		private var _geoRegion:GeoRegion;
		private var _centerPoint:Point2D;
		
		/**
		 * ${actions_DrawCircle_constructor_D} 
		 * @param map ${actions_DrawCircle_constructor_param_map}
		 * 
		 */		
		public function DrawCircle(map:Map)
		{
			super(map); 
			this.style = new PredefinedFillStyle(); 
		}
		
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */		
		override protected function onMouseDown(event:MouseEvent):void
		{
			if(this.actionStarted)
				return;
			super.onMouseDown(event);
			_point2Ds = [];
			this.actionStarted = true;
			this.map.setFocus();
			this._centerPoint = this.map.stageToMap(new Point(event.stageX, event.stageY));
			this.tempFeature = new Feature();
			startDraw(_centerPoint);
			this._geoRegion = new GeoRegion();
			
			this._point2Ds.push(this._centerPoint);
			this._geoRegion.parts.push(this._point2Ds);
			this.tempFeature.style = this.style;
			this.tempFeature.geometry = this._geoRegion;
			this.tempLayer.addFeature(this.tempFeature);
			
		}
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */		
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
			
			var radius:Number = Math.sqrt((point2D.x - this._centerPoint.x) * (point2D.x - this._centerPoint.x) + 
								(point2D.y - this._centerPoint.y) * (point2D.y - this._centerPoint.y));
			
			for(var i:int = 0; i < 360; i++)
			{
				var radians:Number = (i + 1) * Math.PI / 180;
				var circlePoint:Point2D = new Point2D(Math.cos(radians) * radius + this._centerPoint.x, Math.sin(radians) * radius + this._centerPoint.y);
				this._point2Ds[i] = circlePoint;
			}
			if(this._point2Ds[360])
			{
				this._point2Ds.splice(-1,1);
			}
			this._geoRegion.parts = this._geoRegion.parts;
			this.tempFeature.refresh();
			dispatchEvent(new DrawEvent(DrawEvent.DRAW_UPDATE, this.tempFeature));
		}
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */		
		override protected function onMouseUp(event:MouseEvent):void
		{
			if (!this.actionStarted)
			{
				return;
			}
			
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			this._geoRegion.parts = this._geoRegion.parts;
			this.endDraw(point2D);
			this._centerPoint = null;
			this._point2Ds = [];
			this.actionStarted = false;
		}
		
	}
}