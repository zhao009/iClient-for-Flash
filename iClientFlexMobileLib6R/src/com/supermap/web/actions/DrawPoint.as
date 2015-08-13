package com.supermap.web.actions
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.geometry.GeoPoint;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.core.styles.MarkerStyle;
	import com.supermap.web.core.styles.PredefinedMarkerStyle;
	import com.supermap.web.events.DrawEvent;
	import com.supermap.web.events.ActionEvent;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	use namespace sm_internal;
	
	/**
	 * ${actions_DrawPoint_Title}.
	 * <p>${actions_DrawPoint_Deccription}</p> 
	 * 
	 * 
	 */	
	public class DrawPoint extends Pan
	{
		private var _startPoint:Point;
		private var _style:Style;
		
		/**
		 * ${actions_DrawAction_protected_field_actionStarted_D} 
		 */		
		protected var actionStarted:Boolean = false;
		
		private var _enableMapDoubleCLK:Boolean;
		
		/**
		 * ${actions_DrawAction_attribute_style_D} 
		 * @return 
		 * 
		 */		
		public function get style():Style
		{
			return _style;
		}
		
		public function set style(value:Style):void
		{
			_style = value;
		}
		/**
		 * ${actions_DrawPoint_constructor_D} 
		 * @param map ${actions_DrawPoint_constructor_param_map}
		 * 
		 */		
		public function DrawPoint(map:Map)
		{
			super(map);  
			this.style = new PredefinedMarkerStyle(); 
		}
		
		override sm_internal function addMapListeners():void
		{
			super.addMapListeners();
		}
		
		override sm_internal function removeMapListeners():void
		{
			super.removeMapListeners();
			switchActionHandle();
		}
		
		/**
		 * ${actions_DrawAction_method_Protected_switchActionHandle_D} 
		 * 
		 */		
		protected function switchActionHandle() : void
		{
			if(this.actionStarted)
			{
				dispatchEvent(new DrawEvent(DrawEvent.DRAW_CANCEL));
				this.actionStarted = false;
			}
		}
		
		/**
		 * ${actions_DrawAction_method_Protected_startDraw_D} 
		 * 
		 */		
		protected function startDraw(startPoint:Point2D = null) : void
		{
			this._enableMapDoubleCLK = this.map.doubleClickZoomEnabled;
			this.map.doubleClickZoomEnabled = false;
			
			dispatchEvent(new DrawEvent(DrawEvent.DRAW_START, null, startPoint));
		}
		
		
		
		/**
		 * @inheritDoc 
		 * @param event
		 * 
		 */
		override protected function onMouseDown(event:MouseEvent):void
		{
			super.onMouseDown(event);
			if(this.actionStarted)
				return;
			
			this.actionStarted = true;	
			this.map.setFocus();
			
			var point2D:Point2D = this.map.stageToMap(new Point(event.stageX, event.stageY));
			this._startPoint = new Point(event.stageX, event.stageY);
			
			startDraw(point2D);
			
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
			
			this.endDraw(new Point(event.stageX, event.stageY));
			this.actionStarted = false;
		}
		
		/**
		 * ${actions_DrawAction_method_Protected_endDraw_D}
		 * 
		 */		
		protected function endDraw(endPoint:Point = null) : void
		{
			if(Math.abs(endPoint.x-this._startPoint.x)<=2&&Math.abs(endPoint.y-this._startPoint.y)<=2){
				var point2D:Point2D = this.map.stageToMap(endPoint);
				var geoPoint:GeoPoint = new GeoPoint(point2D.x, point2D.y);
				
				var drawFeature:Feature  = new Feature(geoPoint, this.style);
				
				dispatchEvent(new DrawEvent(DrawEvent.DRAW_END, drawFeature, null, point2D));
			}
			
			this.map.doubleClickZoomEnabled = this._enableMapDoubleCLK;
		}
		
	}
}