package com.supermap.web.actions
{
 	import com.supermap.web.core.Feature;
 	import com.supermap.web.core.Point2D;
 	import com.supermap.web.core.geometry.GeoRegion;
 	import com.supermap.web.core.styles.FillStyle;
 	import com.supermap.web.core.styles.PredefinedFillStyle;
 	import com.supermap.web.events.DrawEvent;
 	import com.supermap.web.mapping.Map;
 	import com.supermap.web.sm_internal;
 	
 	import flash.events.MouseEvent;
 	import flash.geom.Point;

	use namespace sm_internal;
	
	/**
	 * ${actions_DrawFreePolygon_Title}.
	 * <p>${actions_DrawFreePolygon_Deccription}</p>
	 * @see com.supermap.web.core.styles.PredefinedFillStyle 
	 * @see com.supermap.web.core.styles.FillStyle
	 * 
	 */	
	public class DrawFreePolygon extends DrawAction
	{
		private var _point2Ds:Array;
		private var _geoRegion:GeoRegion;
		private var _fillStyle:FillStyle;
		  
		/**
		 * ${actions_DrawFreePolygon_constructor_D} 
		 * @param map ${actions_DrawFreePolygon_constructor_param_map}
		 * 
		 */		
		public function DrawFreePolygon(map:Map)
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
            
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			this.tempFeature = new Feature();
			startDraw(point2D);
			this._geoRegion = new GeoRegion();
			
			this._point2Ds.push(point2D);
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
			if(this._point2Ds.length > 2)
			{
				this._point2Ds.splice(-1,1);
			}
			this._point2Ds.push(point2D);
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
			var endPoint:Point2D = this._point2Ds[this._point2Ds.length - 1];
			this._point2Ds.push(this._point2Ds[0]);
			this._geoRegion.parts = this._geoRegion.parts;
			
			this.endDraw(endPoint);
			this.actionStarted = false;
			this._point2Ds = [];
		}
	}
}