package com.supermap.web.actions
{
	import com.supermap.web.core.Feature;
	import com.supermap.web.core.Point2D;
	import com.supermap.web.core.styles.Style;
	import com.supermap.web.events.DrawEvent;
	import com.supermap.web.mapping.FeaturesLayer;
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	  
	use namespace sm_internal;
	/**
	 * ${actions_DrawAction_Title}.
	 * <p>${actions_DrawAction_Deccription}</p> 
	 * 
	 */	
	public class DrawAction extends MapAction
	{
		/**
		 * ${actions_DrawAction_protected_field_drawFeature_D} 
		 */		
		protected var drawFeature:Feature = null;
		/**
		 * ${actions_DrawAction_protected_field_actionStarted_D} 
		 */		
		protected var actionStarted:Boolean = false;
		/**
		 * ${actions_DrawAction_method_Protected_tempLayer_D}.
		 * <p>${actions_DrawAction_method_Protected_tempLayer_remarks}</p> 
		 */		
		protected var tempLayer:FeaturesLayer;
		
		/**
		 * ${actions_DrawAction_method_Protected_tempFeature_D} 
		 */		
		protected var tempFeature:Feature = null;
		
		private var _enableMapDoubleCLK:Boolean;
		
		private var _style:Style;
		
		/**
		 * ${actions_DrawAction_constructor_D} 
		 * @param map ${actions_DrawAction_constructor_param_map}
		 * 
		 */	
		public function DrawAction(map:Map)
		{
			super(map);  
		}
			
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

		override sm_internal function addMapListeners():void
		{
			super.addMapListeners();
			this.tempLayer = new FeaturesLayer();
			this.map.addLayer(this.tempLayer);
		}
			
		override sm_internal function removeMapListeners():void
		{
			super.removeMapListeners();
			switchActionHandle();
		}	
		
		/**
		 * ${actions_DrawAction_method_Protected_startDraw_D} 
		 * 
		 */		
		protected function startDraw(startPoint:Point2D = null) : void
		{
			this._enableMapDoubleCLK = this.map.doubleClickZoomEnabled;
			this.map.doubleClickZoomEnabled = false;
			
			dispatchEvent(new DrawEvent(DrawEvent.DRAW_START, this.tempFeature, startPoint));
		}
		
		/**
		 * ${actions_DrawAction_method_Protected_endDraw_D}
		 * 
		 */		
		protected function endDraw(endPoint:Point2D = null) : void
		{
			if(this.tempFeature)
			{
				this.drawFeature  = new Feature(this.tempFeature.geometry, this.tempFeature.style);
				this.drawFeature.removeStyleChangeListener();
				this.drawFeature.attributes = this.tempFeature.attributes;
				this.drawFeature.width = this.tempFeature.width;
				this.drawFeature.height = this.tempFeature.height;
			}
			
			dispatchEvent(new DrawEvent(DrawEvent.DRAW_END, this.drawFeature, null, endPoint));
			
			this.tempFeature = null;
			this.tempLayer.clear();
			this.map.doubleClickZoomEnabled = this._enableMapDoubleCLK;
		}
		
		/**
		 * ${actions_DrawAction_method_Protected_switchActionHandle_D} 
		 * 
		 */		
		protected function switchActionHandle() : void
		{
			if(this.actionStarted)
			{
				dispatchEvent(new DrawEvent(DrawEvent.DRAW_CANCEL, this.tempFeature));
				this.tempLayer.clear();
				this.tempFeature = null;
				this.actionStarted = false;
			}
			this.map.removeLayer(this.tempLayer);
			
		} 
	}
	
}