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
	 * ${actions_DrawPolygon_Title}.
	 * <p>${actions_DrawPolygon_Deccription}</p> 
	 * 
	 * 
	 */	
	public class DrawPolygon extends DrawAction
	{
		private var _point2Ds:Array;
		private var _geoRegion:GeoRegion;
		
		/**
		 * ${actions_DrawPolygon_constructor_D}.
		 * @param map ${actions_DrawPolygon_constructor_param_map}
		 * 
		 */		
		public function DrawPolygon(map:Map)
		{
			super(map); 
			this.style = new PredefinedFillStyle();
		}
		
		override sm_internal function removeMapListeners():void
		{
			super.removeMapListeners();
			map.layerHolder.removeEventListener(MouseEvent.CLICK, this.onMouseNextClick)
		}
		
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */
		override protected function onMouseClick(event:MouseEvent):void
		{
			_point2Ds = [];
			this.actionStarted = true;
			this.map.setFocus();
			map.layerHolder.removeEventListener(MouseEvent.CLICK, this.onMouseClick);
			map.layerHolder.addEventListener(MouseEvent.CLICK, this.onMouseNextClick);
			
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			this.tempFeature = new Feature();
			startDraw(point2D);
			this._geoRegion = new GeoRegion();
			
			this._point2Ds.push(point2D, point2D);
			this._geoRegion.parts.push(this._point2Ds);
			
			this.tempFeature.style = this.style;
			this.tempFeature.geometry = this._geoRegion;
			this.tempLayer.addFeature(this.tempFeature);
		}
		
		private function onMouseNextClick(event:MouseEvent):void
		{
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			
			this._point2Ds.pop();
			this._point2Ds.push(point2D, point2D);
			
			this._geoRegion.parts = this._geoRegion.parts;
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
		
			
//			if(this._point2Ds.length > 2)
//				this._point2Ds.pop();
			this._point2Ds[(this._point2Ds.length - 1)] = point2D;
//			this._point2Ds.push(this._point2Ds[0]);
			
			
//			this._geoRegion.parts = this._geoRegion.parts;
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
			if(this._point2Ds.length <= 2)
			{
				return;
			}
			var endPoint:Point2D = this._point2Ds.pop();
			this._point2Ds.push(this._point2Ds[0]);

			//删除中间重复的点
			var startPoint:Point2D = this._point2Ds.shift();
			this._point2Ds.pop();
			var ary:Array = [];
			ary.push(startPoint);
			var len:int = this._point2Ds.length;
			for(var i:int = 0; i < int(len * .5); i++)
			{
				ary.push(this._point2Ds[2*i]);
			}
			this._point2Ds = ary;
			this._geoRegion.parts = [ary];
			//删除完毕
			
			this.actionStarted = false;
			this._point2Ds = [];
			map.layerHolder.removeEventListener(MouseEvent.CLICK, this.onMouseNextClick);
			map.layerHolder.addEventListener(MouseEvent.CLICK, this.onMouseClick);
			
			this.endDraw(endPoint);
		}
	}
}