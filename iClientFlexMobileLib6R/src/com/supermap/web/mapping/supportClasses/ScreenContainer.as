package com.supermap.web.mapping.supportClasses
{
	import com.supermap.web.mapping.Map;
	import com.supermap.web.sm_internal;
	
	import flash.events.*;
	import flash.net.*;
	
	import mx.core.*;
	
	import spark.components.Group;
	import spark.components.Image;

	use namespace sm_internal;
	/**
	 * @private 
	 * 
	 */	
	public class ScreenContainer extends Group
	{
		private var _map:Map;
		private var _length:Number;
		private var _width:Number;
		private var _color:uint;
		private var _alpha:Number;
		private var _images:Array;
		private var _panArrowsVisible:Boolean = false;
		private var _panArrowsVisibleChanged:Boolean = false;

		
		public function ScreenContainer(map:Map)
		{
			mouseEnabled = false;
			mouseEnabledWhereTransparent = false;
			percentWidth = 100;
			percentHeight = 100;
			this._map = map;
		}
		
		override protected function createChildren() : void
		{
			super.createChildren();
		}
		
		sm_internal function get panArrowsVisible() : Boolean
		{
			return this._panArrowsVisible;
		}
		
		sm_internal function set panArrowsVisible(value:Boolean) : void
		{
			if (this._panArrowsVisible !== value)
			{
				this._panArrowsVisible = value;
				this._panArrowsVisibleChanged = true;
				invalidateProperties();
			}
		}
		
		sm_internal function showPanArrows() : void
		{
			if (!this._images && UIComponentGlobals.designMode)
			{
				return;
			}
			this._images = [];
			var offset:* = this._map.getStyle("panSkinOffset") as Number;
			var dSkin:* = this._map.getStyle("panDownSkin");
			var dImg:* = new Image();
			dImg.source = dSkin;
			dImg.setStyle("bottom", offset);
			dImg.setStyle("horizontalCenter", 0);
			dImg.buttonMode = true;
			dImg.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
			{
				event.stopPropagation();
				//this._map.panDown();
			}
			);
			addElement(dImg);
			this._images.push(dImg);
			var lSkin:* = this._map.getStyle("panLeftSkin");
			var lImg:* = new Image();
			lImg.source = lSkin;
			lImg.setStyle("left", offset);
			lImg.setStyle("verticalCenter", 0);
			lImg.buttonMode = true;
			lImg.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
			{
				event.stopPropagation();
				//this._map.panLeft();
			}
			);
			addElement(lImg);
			this._images.push(lImg);
			var llSkin:* = this._map.getStyle("panLowerLeftSkin");
			var llImg:* = new Image();
			llImg.source = llSkin;
			llImg.setStyle("bottom", offset);
			llImg.setStyle("left", offset);
			llImg.buttonMode = true;
			llImg.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
			{
				event.stopPropagation();
				//this._map.panLowerLeft();
			}
			);
			addElement(llImg);
			this._images.push(llImg);
			var lrSkin:* = this._map.getStyle("panLowerRightSkin");
			var lrImg:* = new Image();
			lrImg.source = lrSkin;
			lrImg.setStyle("bottom", offset);
			lrImg.setStyle("right", offset);
			lrImg.buttonMode = true;
			lrImg.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
			{
				event.stopPropagation();
				//this._map.panLowerRight();
			}
			);
			addElement(lrImg);
			this._images.push(lrImg);
			var rSkin:* = this._map.getStyle("panRightSkin");
			var rImg:* = new Image();
			rImg.source = rSkin;
			rImg.setStyle("right", offset);
			rImg.setStyle("verticalCenter", 0);
			rImg.buttonMode = true;
			rImg.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
			{
				event.stopPropagation();
				//this._map.panRight();
			}
			);
			addElement(rImg);
			this._images.push(rImg);
			var ulSkin:* = this._map.getStyle("panUpperLeftSkin");
			var ulImg:* = new Image();
			ulImg.source = ulSkin;
			ulImg.setStyle("top", offset);
			ulImg.setStyle("left", offset);
			ulImg.buttonMode = true;
			ulImg.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
			{
				event.stopPropagation();
				//this._map.panUpperLeft();
			}
			);
			addElement(ulImg);
			this._images.push(ulImg);
			var urSkin:* = this._map.getStyle("panUpperRightSkin");
			var urImg:* = new Image();
			urImg.source = urSkin;
			urImg.setStyle("top", offset);
			urImg.setStyle("right", offset);
			urImg.buttonMode = true;
			urImg.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
			{
				event.stopPropagation();
				//this._map.panUpperRight();
			}
			);
			addElement(urImg);
			this._images.push(urImg);
			var uSkin:* = this._map.getStyle("panUpSkin");
			var uImg:* = new Image();
			uImg.source = uSkin;
			uImg.setStyle("top", offset);
			uImg.setStyle("horizontalCenter", 0);
			uImg.buttonMode = true;
			uImg.addEventListener(MouseEvent.CLICK, function (event:MouseEvent) : void
			{
				event.stopPropagation();
//				this._map.panUp();
				return;
			}
			);
			addElement(uImg);
			this._images.push(uImg);
		}
		
		sm_internal function hidePanArrows() : void
		{
			var img:Image = null;
			if (this._images)
			{
				for each (img in this._images)
				{
					
					removeElement(img);
				}
				this._images = null;
			}
		}

		
		override protected function commitProperties() : void
		{
			super.commitProperties();
			this._length = this._map.getStyle("crosshairLength") as Number;
			this._width = this._map.getStyle("crosshairWidth") as Number;
			this._color = this._map.getStyle("crosshairColor") as uint;
			this._alpha = this._map.getStyle("crosshairAlpha") as Number;
			if (this._panArrowsVisibleChanged)
			{
				this._panArrowsVisibleChanged = false;
				if (this.panArrowsVisible)
				{
					this.showPanArrows();
				}
				else
				{
					this.hidePanArrows();
				}
			}
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number) : void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			graphics.clear();
		}
	}
}