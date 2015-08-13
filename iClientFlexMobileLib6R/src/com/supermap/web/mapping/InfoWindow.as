package com.supermap.web.mapping
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.events.*;
	import com.supermap.web.mapping.supportClasses.*;
	import com.supermap.web.sm_internal;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	
	import mx.containers.*;
	import mx.controls.Spacer;
	import mx.core.*;
	import mx.events.*;
	
	import spark.components.*;
	
	use namespace sm_internal;
	/**
	 * ${mapping_InfoWindow_attribute_borderThickness_D} 
	 */
	[Style(name="borderThickness", type="Number", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_borderColor_D} 
	 */
	[Style(name="borderColor", type="uint", format="Color", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_borderAlpha_D} 
	 */	
	[Style(name="borderAlpha", type="Number", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_infoPlacementMode_D} 
	 */	
	[Style(name="infoPlacementMode", type="String", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_infoPlacement_D} 
	 * @see com.supermap.web.mapping.InfoPlacement
	 */	
	[Style(name="infoPlacement", type="String", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_infoOffsetX_D} 
	 */
	[Style(name="infoOffsetX", type="Number", format="Length", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_infoOffsetY_D} 
	 */
	[Style(name="infoOffsetY", type="Number", format="Length", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_infoOffsetW_D}
	 */
	[Style(name="infoOffsetW", type="Number", format="Length", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_shadowAlpha_D} 
	 */	
	[Style(name="shadowAlpha", type="Number", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_shadowAngle_D} 
	 */	
	[Style(name="shadowAngle", type="Number", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_shadowColor_D} 
	 */	
	[Style(name="shadowColor", type="uint", format="Color", inherit="yes")]
	 /**
	  * ${mapping_InfoWindow_attribute_shadowDistance_D} 
	  */	 
	[Style(name="shadowDistance", type="Number", format="Length", inherit="no", theme="halo, spark")]
	/**
	 * ${mapping_InfoWindow_attribute_upperLeftRadius_D} 
	 */	
	[Style(name="upperLeftRadius", type="Number", format="Length", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_lowerLeftRadius_D} 
	 */	
	[Style(name="lowerLeftRadius", type="Number", format="Length", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_upperRightRadius_D} 
	 */
	[Style(name="upperRightRadius",type="Number", format="Length", inherit="no")]
	/**
	 * ${mapping_InfoWindow_attribute_lowerRightRadius_D} 
	 */
	[Style(name="lowerRightRadius", type="Number", format="Length", inherit="no")]
		
	
	/**
	 * ${mapping_InfoWindow_Title}.
	 * <p>${mapping_InfoWindow_Description}</p> 
	 * 
	 * 
	 */	
    public class InfoWindow extends InfoContainer
    {
        private var _content:UIComponent;
        private var _contentChanged:Boolean = false;
        private var _hGroup:HGroup;
        private var _infoWindowLabel:Label;
        private var _closeButton:Button;
        private var _labelVisible:Boolean = false;
        private var _closeButtonVisible:Boolean = false;
        private var _addedViewBoundsChangeListener:Boolean = false; 
        private var _mapPointX:Number;
        private var _mapPointY:Number;
        private var _listeningForEvents:Boolean = false;
        private var _anchorX:Number;
        private var _anchorY:Number;
        private var _isLabelChanged:Boolean = false;
		private var _isDisplayedOnCluster:Boolean = false;
		private var _customCloseRect:Rectangle;

		/**
		 * @private
		 * @param map
		 * 
		 */		
        public function InfoWindow(map:Map)
        {
            super(map);
            visible = false;
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOver_handler);
        }
		protected function mouseOver_handler(event:MouseEvent):void
		{
			visible = true;
		}
		//用户自定义关闭区域，默认为null
		/**
		 * ${mapping_InfoWindow_attribute_customCloseRect_D} 
		 * @return 
		 * 
		 */		
		public function get customCloseRect():Rectangle
		{
			return _customCloseRect;
		}
		public function set customCloseRect(value:Rectangle):void
		{
			var old_value:Rectangle = this.customCloseRect;
			if (old_value !== value)
			{
				if((this._customCloseRect = value) && this._content)
				{
					this._content.addEventListener(MouseEvent.CLICK, this.contentClickHandler, false, 0, true);
				}
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isDisplayedOnCluster", old_value, value));
				}
			}
		}

		/**
		 * ${mapping_InfoWindow_attribute_isDisplayedOnCluster_D} 
		 * @default false
		 * 
		 */		
		public function get isDisplayedOnCluster():Boolean
		{
			return this._isDisplayedOnCluster;
		}
			
		public function set isDisplayedOnCluster(value:Boolean):void
		{
			var old_value:Boolean = this._isDisplayedOnCluster;
			if (old_value !== value)
			{
				this._isDisplayedOnCluster = value;
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "isDisplayedOnCluster", old_value, value));
				}
			}
		}
		
		/**
		 * ${mapping_InfoWindow_attribute_closeButton_D} 
		 * @return 
		 * 
		 */		
		public function get closeButton() : Button
		{
			return this._closeButton;
		}
		public function set closeButton(value:Button) : void
		{
			var old_value:Button = this._closeButton;
			if (old_value !== value)
			{
				this.closeButtonChangeHandler(value);
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "closeButton", old_value, value));
				}
			}
		}
		
		/**
		 * ${mapping_InfoWindow_attribute_infoWindowLabel_D} 
		 * @return 
		 * 
		 */		
		public function get infoWindowLabel() : Label
		{
			return this._infoWindowLabel;
		}
		
		public function set infoWindowLabel(value:Label) : void
		{
			var old_value:Label = this._infoWindowLabel;
			if (old_value !== value)
			{
				this.infoWindowLabelChangeHandler(value);
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "infoWindowLabel", old_value, value));
				}
			}
		}
		
		/**
		 * ${mapping_InfoWindow_attribute_content_D}.
		 * ${mapping_InfoWindow_attribute_content_remarks_D}
		 * @return 
		 * 
		 */		
        public function get content():UIComponent
        {
            return this._content;
        }
		public function set content(value:UIComponent):void
		{
			var oldContent:UIComponent = this._content;
			if (oldContent !== value)
			{
				this._content = value;
				with(this._content)
				{
					top = this._hGroup.height + 3;
					bottom = 3;
					left = 3;
					right = 3;
				}
				this._contentChanged = true;
				this.invalidateProperties();
				invalidateSize();
				invalidateDisplayList();
				if (this.hasEventListener("propertyChange"))
				{
					this.dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "content", oldContent, value));
				}
			}
		}
		
		/**
		 * ${mapping_InfoWindow_attribute_labelVisible_D}
		 * @default true 
		 * @return 
		 * 
		 */		
        public function get infoWindowLabelVisible():Boolean
        {
            return this._labelVisible;
        }

        public function set infoWindowLabelVisible(value:Boolean):void
        {
            this._labelVisible = value;
            invalidateProperties();
        }

		/**
		 * ${mapping_InfoWindow_attribute_closeButtonVisible_D}
		 * @default true 
		 * @return 
		 * 
		 */		
        public function get closeButtonVisible():Boolean
        {
            return this._closeButtonVisible;
        }

        public function set closeButtonVisible(value:Boolean):void
        {
            this._closeButtonVisible = value;
            invalidateProperties();
        }
		
		private function updateHboxContent():void
		{
			if(!this._infoWindowLabel)
				this._infoWindowLabel = new InfoWindowLabel();
			var labelStyleName:Object = this.getStyle("infoWindowLabelStyleName");
			if(labelStyleName)
			{
				this._infoWindowLabel.styleName = labelStyleName;
			}
			this._infoWindowLabel.alpha = 1;
			this._hGroup.addElement(this._infoWindowLabel);
			
			var spacer:Spacer = new Spacer();
			spacer.percentWidth = 100;
			spacer.mouseEnabled = false;
			this._hGroup.addElement(spacer);
			
			if(!this._closeButton)
				this._closeButton = new InfoWindowCloseButton();
			var buttonStyleName:Object = this.getStyle("closeButtonStyleName");
			if(buttonStyleName)
			{
				this._closeButton.styleName = buttonStyleName;
			}
			this._closeButton.addEventListener(MouseEvent.CLICK, this.closeButtonClickHandler);
			this._hGroup.addElement(this._closeButton);
		}

		/**
		 * @private 
		 * 
		 */		
        override protected function createChildren():void
        {
			super.createChildren();
			this._hGroup = new HGroup();
			this._hGroup.percentWidth = 100;
			this._hGroup.setStyle("horizontalGap", 0);
			this._hGroup.setStyle("verticalAlign", "middle");
			this._hGroup.setStyle("paddingTop",5);
			this._hGroup.setStyle("paddingLeft",5);
			this._hGroup.setStyle("paddingRight",5);
			this.updateHboxContent();
			addElement(this._hGroup);

        }

        private function closeButtonClickHandler(event:Event):void
        {
            this.hide();
        }
		
		private function contentClickHandler(event:MouseEvent):void
		{
			if(this._customCloseRect && this.customCloseRect.contains(event.localX, event.localY))
			{
				this.hide();
			}	
		}
		

		/**
		 * @private 
		 * 
		 */		
        override protected function commitProperties():void
        {
            var displayObject:IVisualElement = null;
            super.commitProperties();
            
            if(this._contentChanged)
            {
                this._contentChanged = false;
                if (this.numElements == 2)
                {
                    displayObject = getElementAt(1);
                    displayObject.removeEventListener(Event.CLOSE, this.closeButtonClickHandler);
                    this.removeElementAt(1);
                }
                if(this._content)
                {
					this._content.addEventListener(Event.CLOSE, this.closeButtonClickHandler);
					addElement(this._content);
                }
            }
			
			if(this._isLabelChanged)
			{
				this.updateHboxContent();
				this._isLabelChanged = false;
			}
			
			if (_infoWindowLabel.text)
			{
//				this._infoWindowLabel.text = label;
			}
//			else if (this._content is Container)//暂不支持container
//			{
//				this._infoWindowLabel.text = Container(this._content).label;
//			}
			else
			{
				if (data && data.label)
				{
					this._infoWindowLabel.text = data.label.toString();
				}
				else
				{
					this._infoWindowLabel.text = "";
				}
			}
			this._infoWindowLabel.visible = this._labelVisible;
			this._closeButton.visible = this._closeButtonVisible;
//			if (!this._labelVisible)
//			{
//				this._hGroup.visible = this._closeButtonVisible;
//				this._hGroup.includeInLayout = this._hGroup.visible;
//			}
			
			if(this._labelVisible || this._closeButtonVisible)
			{
				this._hGroup.visible = true;
				this._hGroup.includeInLayout = true;
			}
			else
			{
				this._hGroup.visible = false;
				this._hGroup.includeInLayout = false;
			}
        }

		/**
		 * @private 
		 * @param unscaledWidth
		 * @param unscaledHeight
		 * 
		 */		
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            adjustPlacement(x, y, unscaledWidth, unscaledHeight, map);
        }
        
		/**
		 * ${mapping_InfoWindow_attribute_show_D} 
		 * @param point2D ${mapping_InfoWindow_attribute_show_param_point2D}
		 * 
		 */		
        public function show(point2D:Point2D):void
        {
            this._mapPointX = point2D.x;
            this._mapPointY = point2D.y;
            
            if(this._map.isTweening || this._map.isPanning)
            {
            	if (this._addedViewBoundsChangeListener === false)
                {
                    this._map.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.viewBoundsChangeHandler);
                    this._addedViewBoundsChangeListener = true;
                }
            }
            else
            {
            	this.showInfoWindow(this._map.mapToScreenX(this._mapPointX), this.map.mapToScreenY(this._mapPointY));
            }
        }

        private function viewBoundsChangeHandler(event:ViewBoundsEvent):void
        {
            this._map.removeEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.viewBoundsChangeHandler);
            this.showInfoWindow(this._map.mapToScreenX(this._mapPointX), this._map.mapToScreenY(this._mapPointY));
            this._addedViewBoundsChangeListener = false;
        }
        
		/**
		 * ${mapping_InfoWindow_attribute_hide_D} 
		 * 
		 */		
        public function hide():void
        {
            if (visible)
            {
                visible = false;
                includeInLayout = false;
                this.removeMapListeners();
                dispatchEvent(new Event(Event.CLOSE));
            }
        }
		
        private function showInfoWindow(pixelX:Number, pixelY:Number) : void
        {
            anchorX = pixelX;
            anchorY = pixelY;
            visible = true;
            includeInLayout = true;
            this.addMapListeners();
        }

        private function addMapListeners():void
        {
            if(this._listeningForEvents == false)
            {
                this._map.addEventListener(PanEvent.PAN_START, this.panStartHandler);
                this._map.addEventListener(PanEvent.PAN_UPDATE, this.panUpdateHandler);
                this._map.addEventListener(ZoomEvent.ZOOM_START, this.zoomStartHandler);
                this._map.addEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.mapViewBoundsChangeHandler);
                this._listeningForEvents = true;
            }
        }

        private function removeMapListeners():void
        {
            this._map.removeEventListener(PanEvent.PAN_START, this.panStartHandler);
            this._map.removeEventListener(PanEvent.PAN_UPDATE, this.panUpdateHandler);
            this._map.removeEventListener(ZoomEvent.ZOOM_START, this.zoomStartHandler);
            this._map.removeEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.mapViewBoundsChangeHandler);
            this._listeningForEvents = false;
        }

        private function mapViewBoundsChangeHandler(event:ViewBoundsEvent):void
        {
            anchorX = this._map.mapToScreenX(this._mapPointX);
            anchorY = this._map.mapToScreenY(this._mapPointY);
        }

        private function panStartHandler(event:PanEvent):void
        {
            this._anchorX = anchorX;
            this._anchorY = anchorY;
        }

        private function panUpdateHandler(event:PanEvent):void
        {
            anchorX = this._anchorX + event.point.x;
            anchorY = this._anchorY + event.point.y;
        }

        private function zoomStartHandler(event:ZoomEvent) : void
        {
            this._map.addEventListener(ZoomEvent.ZOOM_END, this.zoomEndHandler);
            visible = false;
            includeInLayout = false;
        }

        private function zoomEndHandler(event:ZoomEvent) : void
        {
            this._map.removeEventListener(ZoomEvent.ZOOM_END, this.zoomEndHandler);
            visible = true;
            includeInLayout = true;
			if(this._isDisplayedOnCluster)
			{
				visible = false;
				includeInLayout = false;
			}
        }
		
		private function closeButtonChangeHandler(newButton:Button):void
		{
			if(this._hGroup.contains(this._closeButton))
			{
				this._closeButton.removeEventListener(MouseEvent.CLICK, this.closeButtonClickHandler);
				this._hGroup.removeElement(this._closeButton);
				
			}
			this._closeButton = newButton;
			this._hGroup.addElement(this._closeButton);
			this._closeButton.addEventListener(MouseEvent.CLICK, this.closeButtonClickHandler);
			invalidateProperties();
		}
		
		private function infoWindowLabelChangeHandler(newLabel:Label):void
		{
			this._hGroup.removeAllElements();
			this._infoWindowLabel = newLabel;
			this._isLabelChanged = true;
			invalidateProperties();
		}
    }
}
