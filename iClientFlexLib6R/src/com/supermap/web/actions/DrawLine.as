package com.supermap.web.actions
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.styles.LineStyle;
	import com.supermap.web.core.styles.PredefinedLineStyle;
	import com.supermap.web.events.ActionEvent;
	import com.supermap.web.events.DrawEvent;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.events.DragEvent;
	
	use namespace sm_internal;
	
	/**
	 * ${actions_DrawLine_Title}.
	 * <p>${actions_DrawLine_Deccription}</p> 
	 * 
	 * 
	 */	
	public class DrawLine extends DrawAction
	{
		private var _point2Ds:Array;
		private var _geoLine:GeoLine;
		private var _isFirstClick:Boolean = false;
		
		/**
		 * ${actions_DrawLine_constructor_D} 
		 * @param map ${actions_DrawLine_constructor_param_map}
		 * 
		 */		
		public function DrawLine(map:Map)
		{
			super(map); 
			this.style = new PredefinedLineStyle();	
		}
		
		override sm_internal function removeMapListeners():void
		{
			super.removeMapListeners();
			map.layerHolder.removeEventListener(MouseEvent.CLICK, this.onMouseNextClick);
		}
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */
		override protected function onMouseClick(event:MouseEvent):void
		{
			_point2Ds = [];
			this.map.setFocus();
			map.layerHolder.removeEventListener(MouseEvent.CLICK, onMouseClick);
			this.actionStarted = true;
			this._isFirstClick = true;
			map.layerHolder.addEventListener(MouseEvent.CLICK, this.onMouseNextClick);
			
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			this._point2Ds.push(point2D, point2D);
			
			this.tempFeature = new Feature();
			startDraw(point2D);
			this._geoLine = new GeoLine();
			this._geoLine.parts.push(this._point2Ds);
			this.tempFeature.style = this.style;
			this.tempFeature.geometry = this._geoLine;
			this.tempLayer.addFeature(this.tempFeature);
		}
		
		
		private function onMouseNextClick(event:MouseEvent):void
		{
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			this._point2Ds.pop();
			this._point2Ds.push(point2D, point2D);
			
			this._geoLine.parts = this._geoLine.parts;	
			this.tempFeature.refresh();
			dispatchEvent(new DrawEvent(DrawEvent.DRAW_UPDATE, this.tempFeature));
			
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
			this._point2Ds[this._point2Ds.length - 1] = point2D;
			
			this._geoLine.parts = this._geoLine.parts;		
			this.tempFeature.refresh();
		}
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */
		override protected function onMouseDoubleClick(event:MouseEvent):void
		{
			if (!this.actionStarted)
			{
				return;
			}
			var endPoint:Point2D = this._point2Ds.pop();
//			this._point2Ds.pop();
			this._geoLine.parts = this._geoLine.parts;	
			
			this.actionStarted = false;
			this._point2Ds = [];
			event.stopPropagation();
			map.layerHolder.removeEventListener(MouseEvent.CLICK, this.onMouseNextClick);
			map.layerHolder.addEventListener(MouseEvent.CLICK, this.onMouseClick);
			this.endDraw(endPoint);
		}
	}
}