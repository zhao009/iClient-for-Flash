package com.supermap.web.mapping.supportClasses
{
    import com.supermap.web.core.Point2D;
    import com.supermap.web.core.geometry.GeoPoint;
    import com.supermap.web.events.ViewBoundsEvent;
    import com.supermap.web.mapping.InfoPlacement;
    import com.supermap.web.mapping.Map;
    import com.supermap.web.sm_internal;
    
    import flash.events.*;
    
    import mx.core.FlexGlobals;
    import mx.styles.CSSStyleDeclaration;
    import mx.styles.IStyleManager2;
	
	use namespace sm_internal;
	
	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
    public class InfoStyleContainer extends InfoContainer
    {

		sm_internal var geoPoint:GeoPoint;
        public function InfoStyleContainer(map:Map, styleName:String)
        {
            super(map);
			this.styleName = styleName;
            map.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.mapViewBoundsChangeHandler);
            this.addEventListener(Event.REMOVED, this.removedHandler);

        }
		
        private function removedHandler(event:Event):void
        {
            if (event.target === this)
            {
                this._map.removeEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.mapViewBoundsChangeHandler);
            }
        }

        private function mapViewBoundsChangeHandler(event:ViewBoundsEvent):void
        {
			if(map.viewBounds.containsPoint(new Point2D(geoPoint.x, geoPoint.y)))
			{
				invalidateDisplayList();
			}
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            adjustPlacement( x - this._map.layerContainer.scrollRect.x,  y - this._map.layerContainer.scrollRect.y, unscaledWidth, unscaledHeight, this._map);
        }

    }
}
