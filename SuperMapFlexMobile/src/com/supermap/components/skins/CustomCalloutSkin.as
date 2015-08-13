
package com.supermap.components.skins
{
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;

	import mx.core.DPIClassification;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.EffectEvent;
	import mx.events.FlexEvent;
	import mx.utils.ColorUtil;

	import spark.components.ArrowDirection;
	import spark.components.Callout;
	import spark.components.ContentBackgroundAppearance;
	import spark.components.Group;
	import spark.core.SpriteVisualElement;
	import spark.effects.Fade;
	import spark.primitives.RectangularDropShadow;
	import spark.skins.mobile.CalloutSkin;
	import spark.skins.mobile.supportClasses.MobileSkin;
	import spark.skins.mobile160.assets.CalloutContentBackground;
	import spark.skins.mobile240.assets.CalloutContentBackground;
	import spark.skins.mobile320.assets.CalloutContentBackground;

	use namespace mx_internal;

	public class CustomCalloutSkin extends CalloutSkin
	{
		mx_internal static const BACKGROUND_GRADIENT_BRIGHTNESS_TOP:int = 15;

		mx_internal static const BACKGROUND_GRADIENT_BRIGHTNESS_BOTTOM:int = -60;

		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------

		/**
		 *  Constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion AIR 3
		 *  @productversion Flex 4.6
		 */
		public function CustomCalloutSkin()
		{
			super();

			dropShadowAlpha = 0.7;

			switch(applicationDPI)
			{
				case DPIClassification.DPI_320:
				{
					backgroundCornerRadius = 16;
					contentBackgroundInsetClass = spark.skins.mobile320.assets.CalloutContentBackground;
					backgroundGradientHeight = 220;
					frameThickness = 16;
					arrowWidth = 104;
					arrowHeight = 52;
					contentCornerRadius = 10;
					dropShadowBlurX = 32;
					dropShadowBlurY = 32;
					dropShadowDistance = 6;
					highlightWeight = 2;

					break;
				}
				case DPIClassification.DPI_240:
				{
					backgroundCornerRadius = 12;
					contentBackgroundInsetClass = spark.skins.mobile240.assets.CalloutContentBackground;
					backgroundGradientHeight = 165;
					frameThickness = 12;
					arrowWidth = 78;
					arrowHeight = 39;
					contentCornerRadius = 7;
					dropShadowBlurX = 24;
					dropShadowBlurY = 24;
					dropShadowDistance = 4;
					highlightWeight = 1;

					break;
				}
				default:
				{
					// default DPI_160
					backgroundCornerRadius = 8;
					contentBackgroundInsetClass = spark.skins.mobile160.assets.CalloutContentBackground;
					backgroundGradientHeight = 110;
					frameThickness = 8;
					arrowWidth = 52;
					arrowHeight = 26;
					contentCornerRadius = 5;
					dropShadowBlurX = 16;
					dropShadowBlurY = 16;
					dropShadowDistance = 3;
					highlightWeight = 1;

					break;
				}
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------

		private var backgroundGradientHeight:Number;

		private var contentMask:Sprite;

		private var backgroundFill:SpriteVisualElement;

		private var dropShadow:RectangularDropShadow;

		private var dropShadowBlurX:Number;

		private var dropShadowBlurY:Number;

		private var dropShadowDistance:Number;

		private var dropShadowAlpha:Number;

		private var fade:Fade;

		private var highlightWeight:Number;

		//--------------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//--------------------------------------------------------------------------

		/**
		 * @private
		 */
		override protected function createChildren():void
		{
//			super.createChildren();

			if(dropShadowVisible)
			{
				dropShadow = new RectangularDropShadow();
				dropShadow.angle = 90;
				dropShadow.distance = dropShadowDistance;
				dropShadow.blurX = dropShadowBlurX;
				dropShadow.blurY = dropShadowBlurY;
				dropShadow.tlRadius = dropShadow.trRadius = dropShadow.blRadius = dropShadow.brRadius = backgroundCornerRadius;
				dropShadow.mouseEnabled = false;
				dropShadow.alpha = dropShadowAlpha;
				addChild(dropShadow);
			}

			// background fill placed above the drop shadow
			backgroundFill = new SpriteVisualElement();
			addChild(backgroundFill);

			// arrow
			if(!arrow)
			{
				arrow = new CalloutArrow();
				arrow.id = "arrow";
				arrow.styleName = this;
				addChild(arrow);
			}

			// contentGroup
			if(!contentGroup)
			{
				contentGroup = new Group();
				contentGroup.id = "contentGroup";
				addChild(contentGroup);
			}
		}

		/**
		 * @private
		 */
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
//			super.drawBackground(unscaledWidth, unscaledHeight);

			var frameEllipseSize:Number = backgroundCornerRadius * 2;

			// account for borderThickness center stroke alignment
			var showBorder:Boolean = !isNaN(borderThickness);
			var borderWeight:Number = showBorder ? borderThickness : 0;

			// contentBackgroundGraphic already accounts for the arrow position
			// use it's positioning instead of recalculating based on unscaledWidth
			// and unscaledHeight
			var frameX:Number = Math.floor(contentGroup.getLayoutBoundsX() - frameThickness) - (borderWeight / 2);
			var frameY:Number = Math.floor(contentGroup.getLayoutBoundsY() - frameThickness) - (borderWeight / 2);
			var frameWidth:Number = contentGroup.getLayoutBoundsWidth() + (frameThickness * 2) + borderWeight;
			var frameHeight:Number = contentGroup.getLayoutBoundsHeight() + (frameThickness * 2) + borderWeight;

			var backgroundColor:Number = getStyle("backgroundColor");
			var backgroundAlpha:Number = 1;

			var bgFill:Graphics = this.graphics;
			bgFill.clear();

			if(showBorder)
				bgFill.lineStyle(borderThickness, borderColor, 1, true);

			if(useBackgroundGradient)
			{
				// top color is brighter if arrowDirection == ArrowDirection.UP
				var backgroundColorTop:Number = ColorUtil.adjustBrightness2(backgroundColor, BACKGROUND_GRADIENT_BRIGHTNESS_TOP);
				var backgroundColorBottom:Number = ColorUtil.adjustBrightness2(backgroundColor, BACKGROUND_GRADIENT_BRIGHTNESS_BOTTOM);

				// max gradient height = backgroundGradientHeight
				colorMatrix.createGradientBox(unscaledWidth, backgroundGradientHeight, Math.PI / 2, 0, 0);

				bgFill.beginGradientFill(GradientType.LINEAR, 
					[0xc0d9b8, 0x7a9982, 0x628c6d, 0x627a6c], 
					[1, 1, 1, 1], [0, 120, 120, 255], 
					colorMatrix);
			}
			else
			{
				bgFill.beginFill(backgroundColor, backgroundAlpha);
			}

			bgFill.drawRoundRect(frameX, frameY, frameWidth, frameHeight, frameEllipseSize, frameEllipseSize);
			bgFill.endFill();

			// draw content background styles
			var contentBackgroundAppearance:String = getStyle("contentBackgroundAppearance");

			if(contentBackgroundAppearance != ContentBackgroundAppearance.NONE)
			{
				var contentEllipseSize:Number = contentCornerRadius * 2;
				var contentBackgroundAlpha:Number = getStyle("contentBackgroundAlpha");
				var contentWidth:Number = contentGroup.getLayoutBoundsWidth();
				var contentHeight:Number = contentGroup.getLayoutBoundsHeight();

				// all appearance values except for "none" use a mask
				if(!contentMask)
					contentMask = new SpriteVisualElement();

				contentGroup.mask = contentMask;

				// draw contentMask in contentGroup coordinate space
				var maskGraphics:Graphics = contentMask.graphics;
				maskGraphics.clear();
				maskGraphics.beginFill(0, 1);
				maskGraphics.drawRoundRect(0, 0, contentWidth, contentHeight, contentEllipseSize, contentEllipseSize);
				maskGraphics.endFill();

				// reset line style to none
				if(showBorder)
					bgFill.lineStyle(NaN);

				// draw the contentBackgroundColor
				bgFill.beginFill(getStyle("contentBackgroundColor"), contentBackgroundAlpha);
				bgFill.drawRoundRect(contentGroup.getLayoutBoundsX(), contentGroup.getLayoutBoundsY(), contentWidth, contentHeight, contentEllipseSize, contentEllipseSize);
				bgFill.endFill();

				if(contentBackgroundGraphic)
					contentBackgroundGraphic.alpha = contentBackgroundAlpha;
			}
			else // if (contentBackgroundAppearance == CalloutContentBackgroundAppearance.NONE))
			{
				// remove the mask
				if(contentMask)
				{
					contentGroup.mask = null;
					contentMask = null;
				}
			}

			// draw highlight in the callout when the arrow is hidden
			if(useBackgroundGradient && !isArrowHorizontal && !isArrowVertical)
			{
				// highlight width spans the callout width minus the corner radius
				var highlightWidth:Number = frameWidth - frameEllipseSize;
				var highlightX:Number = frameX + backgroundCornerRadius;
				var highlightOffset:Number = (highlightWeight * 1.5);

				// straight line across the top
				bgFill.lineStyle(highlightWeight, 0xFFFFFF, 0.2 * backgroundAlpha);
				bgFill.moveTo(highlightX, highlightOffset);
				bgFill.lineTo(highlightX + highlightWidth, highlightOffset);
			}
		}

		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
//			super.layoutContents(unscaledWidth, unscaledHeight);

			// pad the arrow so that the edges are within the background corner radius
			if(isArrowHorizontal)
			{
				arrow.width = arrowHeight;
				arrow.height = arrowWidth + (backgroundCornerRadius * 2);
			}
			else if(isArrowVertical)
			{
				arrow.width = arrowWidth + (backgroundCornerRadius * 2);
				arrow.height = arrowHeight;
			}

			setElementSize(backgroundFill, unscaledWidth, unscaledHeight);
			setElementPosition(backgroundFill, 0, 0);

			var frameX:Number = 0;
			var frameY:Number = 0;
			var frameWidth:Number = unscaledWidth;
			var frameHeight:Number = unscaledHeight;

			switch(hostComponent.arrowDirection)
			{
				case ArrowDirection.UP:
					frameY = arrow.height;
					frameHeight -= arrow.height;
					break;
				case ArrowDirection.DOWN:
					frameHeight -= arrow.height;
					break;
				case ArrowDirection.LEFT:
					frameX = arrow.width;
					frameWidth -= arrow.width;
					break;
				case ArrowDirection.RIGHT:
					frameWidth -= arrow.width;
					break;
				default:
					// no arrow, content takes all available space
					break;
			}

			if(dropShadow)
			{
				setElementSize(dropShadow, frameWidth, frameHeight);
				setElementPosition(dropShadow, frameX, frameY);
			}

			// Show frameThickness by inset of contentGroup
			var borderWeight:Number = isNaN(borderThickness) ? 0 : borderThickness;
			var contentBackgroundAdjustment:Number = frameThickness + borderWeight;

			var contentBackgroundX:Number = frameX + contentBackgroundAdjustment;
			var contentBackgroundY:Number = frameY + contentBackgroundAdjustment;

			contentBackgroundAdjustment = contentBackgroundAdjustment * 2;
			var contentBackgroundWidth:Number = frameWidth - contentBackgroundAdjustment;
			var contentBackgroundHeight:Number = frameHeight - contentBackgroundAdjustment;

			if(contentBackgroundGraphic)
			{
				setElementSize(contentBackgroundGraphic, contentBackgroundWidth, contentBackgroundHeight);
				setElementPosition(contentBackgroundGraphic, contentBackgroundX, contentBackgroundY);
			}

			setElementSize(contentGroup, contentBackgroundWidth, contentBackgroundHeight);
			setElementPosition(contentGroup, contentBackgroundX, contentBackgroundY);

			// mask position is in the contentGroup coordinate space
			if(contentMask)
				setElementSize(contentMask, contentBackgroundWidth, contentBackgroundHeight);
		}

		//--------------------------------------------------------------------------
		//
		//  Event handlers
		//
		//--------------------------------------------------------------------------

		private function stateChangeComplete(event:Event = null):void
		{
			if(fade && event)
				fade.removeEventListener(EffectEvent.EFFECT_END, stateChangeComplete);

			// SkinnablePopUpContainer relies on state changes for open and close
			dispatchEvent(new FlexEvent(FlexEvent.STATE_CHANGE_COMPLETE));
		}
	}
}
