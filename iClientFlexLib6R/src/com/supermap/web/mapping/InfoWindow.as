package com.supermap.web.mapping
{
	import com.supermap.web.core.Point2D;
	import com.supermap.web.events.InfoPlacementEvent;
	import com.supermap.web.events.PanEvent;
	import com.supermap.web.events.ViewBoundsEvent;
	import com.supermap.web.events.ZoomEvent;
	import com.supermap.web.mapping.supportClasses.InfoContainer;
	import com.supermap.web.mapping.supportClasses.InfoWindowCloseButton;
	import com.supermap.web.mapping.supportClasses.InfoWindowLabel;
	import com.supermap.web.mapping.supportClasses.InfowindowCloseButtonSkin;
	import com.supermap.web.sm_internal;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.controls.Image;
	import mx.controls.Spacer;
	import mx.core.Container;
	import mx.core.UIComponent;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	
	import spark.components.Button;
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.components.VGroup;
	
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
	 * ${mapping_InfoWindow_attribute_backgroundColor_D} 
	 */	
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no")]
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
        private var _hbox:HGroup;
        private var _infoWindowLabel:Label;
        private var _closeButton:Button;
        private var _labelVisible:Boolean = true;
        private var _closeButtonVisible:Boolean = true;
        private var _addedViewBoundsChangeListener:Boolean = false; 
        private var _mapPointX:Number;
        private var _mapPointY:Number;
		private var _offsetX:Number;
		private var _offsetY:Number;
        private var _listeningForEvents:Boolean = false;
        private var _anchorX:Number;
        private var _anchorY:Number;
        private var _isLabelChanged:Boolean = false;
		private var _isDisplayedOnCluster:Boolean = false;
		private var _customCloseRect:Rectangle;
		private var __showShadow:Boolean=false;
		private var _infoWindowShadow:VGroup;
		//将图片打包成为二进制
		//E:/SuperMapiClient60/01_SourceCode/trunk/YIPMan6/iClientFlexLib6R
		[Embed(source = "/../assets/images/component/infowindow/shadow-popup-subject.png")]
		private var ima:Class;
		private var image:Image;
		//指示当前的infoWindow是否可见
		private var _isVisible:Boolean = false;
		/**
		 * @private
		 * @param map
		 * 
		 */		
        public function InfoWindow(map:Map)
        {
            super(map);
            visible = false;
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			this._infoWindowShadow=new VGroup();
			this._infoWindowShadow.visible = false;
			this._infoWindowShadow.enabled=false;
			this._infoWindowShadow.includeInLayout = false;
			image=new Image();
			image.source = ima;
			this._infoWindowShadow.addElement(image);
        }
		
		sm_internal function get infoWindowShadow():VGroup
		{
			return _infoWindowShadow;
		}
		
		/**
		 * ${mapping_InfoWindow_attribute__showShadow_D}
		 * @default false 
		 * @return 
		 * 
		 */		
		public function get showShadow():Boolean
		{
			return this.__showShadow;
		}
		
		public function set showShadow(value:Boolean):void
		{
			if (value)
			{
				this.__showShadow=value;
				if(this._isVisible)
				{
					this._infoWindowShadow.visible=true;
				}
				
				this.setStyle("infoPlacementMode", "none");	
				this.setStyle("infoPlacement", InfoPlacement.UPPERRIGHT);	
				this.setStyle("backgroundAlpha", 1);			
				this.setStyle("upperLeftRadius", 5);			
				this.setStyle("upperRightRadius", 5);			
				this.setStyle("lowerLeftRadius", 5);
				this.setStyle("lowerRightRadius", 5);			
				this.setStyle("infoOffsetX", 12);			
				this.setStyle("infoOffsetY", 12);			
				this.setStyle("infoOffsetW", 10);		
			}
		}
		//此处通过实际的图片大小计算
		private function updateInfoWindowShadow():void
		{
			this._infoWindowShadow.x = anchorX;
			this._infoWindowShadow.y = anchorY - this.height*2/3+3;
			image.width=this.width*1.5;
			image.height=image.width*350/1187;
			image.scaleY=2*this.height/(3*image.height);
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
			this._hbox.addElement(this._infoWindowLabel);
			
			var spacer:Spacer = new Spacer();
			spacer.percentWidth = 100;
			spacer.mouseEnabled = false;
			this._hbox.addElement(spacer);
			
			if(!this._closeButton)
				this._closeButton = new InfoWindowCloseButton();
			var buttonStyleName:Object = this.getStyle("closeButtonStyleName");
			if(buttonStyleName)
			{
				this._closeButton.styleName = buttonStyleName;
			}
			this._closeButton.addEventListener(MouseEvent.CLICK, this.closeButtonClickHandler);
			this._hbox.addElement(this._closeButton);
		}

		/**
		 * @private 
		 * 
		 */		
        override protected function createChildren():void
        {
			super.createChildren();
			this._hbox = new HGroup();
			this._hbox.percentWidth = 100;
			this._hbox.setStyle("horizontalGap", 0);
			this._hbox.setStyle("verticalAlign", "middle");
			this._hbox.setStyle("paddingTop",5);
			this._hbox.setStyle("paddingLeft",5);
			this._hbox.setStyle("paddingRight",5);
			this.updateHboxContent();
			addElement(this._hbox);
			
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
            var displayObject:DisplayObject = null;
            super.commitProperties();
            
            if(this._contentChanged)
            {
                this._contentChanged = false;
                if (numChildren == 2)
                {
                    displayObject = getChildAt(1);
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
			
			if (label)
			{
				this._infoWindowLabel.text = label;
			}
			else if (this._content is Container)
			{
				this._infoWindowLabel.text = Container(this._content).label;
			}
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
//				this._hbox.visible = this._closeButtonVisible;
//				this._hbox.includeInLayout = this._hbox.visible;
//			}
			if(this._labelVisible || this._closeButtonVisible)
			{
				this._hbox.visible = true;
				this._hbox.includeInLayout = this._hbox.visible;
			}
			else
			{
				this._hbox.visible = false;
				this._hbox.includeInLayout = this._hbox.visible;
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
			if(this.__showShadow){
				updateInfoWindowShadow();
			}
        }
        
		/**
		 * ${mapping_InfoWindow_attribute_show_D} 
		 * @param point2D ${mapping_InfoWindow_attribute_show_param_point2D}
		 * @param offset ${mapping_InfoWindow_attribute_show_param_offset}	 
		 * 
		 */		
        public function show(point2D:Point2D,offset:Point=null):void
        {
			this._isVisible = true;
            this._mapPointX = point2D.x;
            this._mapPointY = point2D.y;
			if(offset==null)
			{
				offset=new Point(0,0);			
			}
			this._offsetX=offset.x;
			this._offsetY=offset.y;
			
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
            	this.showInfoWindow(this._map.mapToScreenX(this._mapPointX)+this._offsetX, this.map.mapToScreenY(this._mapPointY)+this._offsetY);

			}
			
        }

        private function viewBoundsChangeHandler(event:ViewBoundsEvent):void
        {
            this._map.removeEventListener(ViewBoundsEvent.VIEW_BOUNDS_CHANGE, this.viewBoundsChangeHandler);
			this.showInfoWindow(this._map.mapToScreenX(this._mapPointX)+this._offsetX, this.map.mapToScreenY(this._mapPointY)+this._offsetY);
            this._addedViewBoundsChangeListener = false;
        }
        
		/**
		 * ${mapping_InfoWindow_attribute_hide_D} 
		 * 
		 */		
        public function hide():void
        {
			this._isVisible = false;
            if (visible)
            {
                visible = false;
                includeInLayout = false;
				this._infoWindowShadow.visible = false;
                this.removeMapListeners();
                dispatchEvent(new Event(Event.CLOSE));
            }
        }

        private function showInfoWindow(pixelX:Number, pixelY:Number) : void
        {
            anchorX = pixelX;
            anchorY = pixelY;
			if(this._isVisible)
			{
				visible = true;
			}
            
            includeInLayout = true;
            this.addMapListeners();
			if(this.__showShadow){
				this._infoWindowShadow.visible=true;
			}
			
			
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
            anchorX = this._map.mapToScreenX(this._mapPointX)+this._offsetX;
            anchorY = this._map.mapToScreenY(this._mapPointY)+this._offsetY;
			
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
			this._infoWindowShadow.visible = false;
        }

        private function zoomEndHandler(event:ZoomEvent) : void
        {
            this._map.removeEventListener(ZoomEvent.ZOOM_END, this.zoomEndHandler);
			//必须要_idVisible为ture是才能显示，这里本来是做一个动画效果，但是如果在动画过程中用户调用了hide()后，那么就不再显示infoWindow
			if(this._isVisible)
			{
				visible = true;
				includeInLayout = true;
				
				
				if(this._isDisplayedOnCluster)
				{
					visible = false;
					includeInLayout = false;
					this._infoWindowShadow.visible = false;
				}
				if(this.__showShadow){
					this._infoWindowShadow.visible = true;
				}
			}
            
        }
		
		private function closeButtonChangeHandler(newButton:Button):void
		{
			if(this._hbox.contains(this._closeButton))
			{
				this._closeButton.removeEventListener(MouseEvent.CLICK, this.closeButtonClickHandler);
				this._hbox.removeElement(this._closeButton);
				
			}
			this._closeButton = newButton;
			this._hbox.addElement(this._closeButton);
			this._closeButton.addEventListener(MouseEvent.CLICK, this.closeButtonClickHandler);
			invalidateProperties();
		}
		
		private function infoWindowLabelChangeHandler(newLabel:Label):void
		{
			this._hbox.removeAllElements();
			this._infoWindowLabel = newLabel;
			this._isLabelChanged = true;
			invalidateProperties();
		}
		private function mouseOverHandler(event:MouseEvent):void
		{
			if(this._isVisible)
			{
				this.visible = true;
			}
		}
    }
}
