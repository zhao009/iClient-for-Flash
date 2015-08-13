package com.supermap.web.actions
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoLine;
	import com.supermap.web.core.styles.LineStyle;
	import com.supermap.web.core.styles.PredefinedLineStyle;
	import com.supermap.web.events.DrawEvent;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	import com.supermap.web.events.ActionEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	use namespace sm_internal;
	
	/**
	 * ${actions_DrawFreeLine_Title}.
	 * <p>${actions_DrawFreeLine_Deccription}</p> 
	 * @see com.supermap.web.core.styles.PredefinedLineStyle 
	 * @see com.supermap.web.core.styles.LineStyle
	 * 
	 * 
	 */	
	public class DrawFreeLine extends DrawAction
	{
		private var _point2Ds:Array;
		private var _geoLine:GeoLine;
		
		/**
		 * ${actions_DrawFreeLine_constructor_D}
		 * @param map ${actions_DrawFreeLine_constructor_param_map}
		 * 
		 */		
		public function DrawFreeLine(map:Map)
		{
			super(map); 
			this.style = new PredefinedLineStyle();
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
			this._geoLine = new GeoLine();
			
			this._point2Ds.push(point2D);
			
			this._geoLine.parts.push(this._point2Ds);
			this.tempFeature.style = this.style;
			this.tempFeature.geometry = this._geoLine;
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
			this._point2Ds.push(point2D);
			
			this._geoLine.parts = this._geoLine.parts;		
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
			this.endDraw(this._point2Ds[this._point2Ds.length - 1]);
			
			this.actionStarted = false;
			this._point2Ds = [];
		}
		
	}
}