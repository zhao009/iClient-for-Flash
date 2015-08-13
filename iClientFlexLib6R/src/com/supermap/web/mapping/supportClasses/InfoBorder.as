package com.supermap.web.mapping.supportClasses
{
    import com.supermap.web.mapping.InfoPlacement;
    
    import flash.display.*;
    import flash.filters.*;
    
    import mx.core.*;
    import mx.skins.*;

	/**
	 * @private 
	 * 
	 */	
    public class InfoBorder extends RectangularBorder
    {
        public function InfoBorder()
        {
            cacheAsBitmap = true;
        }

        override public function get borderMetrics():EdgeMetrics
        {
            return EdgeMetrics.EMPTY;
        }

        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
        {
            if (unscaledHeight == 0 && unscaledWidth == 0)
            {
                return;
            }
            
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            var upperLeft:Number = getStyle(InfoContainer.UPPER_LEFT_RADIUS);
            var lowerLeft:Number = getStyle(InfoContainer.LOWER_LEFT_RADIUS);
            var upperRight:Number = getStyle(InfoContainer.UPPER_RIGHT_RADIUS);
            var lowerRight:Number = getStyle(InfoContainer.LOWER_RIGHT_RADIUS);
            var offsetX:Number = getStyle(InfoContainer.INFO_OFFSET_X);
            var offsetY:Number = getStyle(InfoContainer.INFO_OFFSET_Y);
            var offsetW:Number = getStyle(InfoContainer.INFO_OFFSET_W);
            switch(this.infoPlacement)
            {
                case InfoPlacement.UPPERLEFT:
                {
                    this.drawUpperLeft(unscaledWidth, unscaledHeight, upperLeft, upperRight, lowerLeft, lowerRight, unscaledWidth, unscaledHeight - offsetW, unscaledWidth + offsetX, unscaledHeight + offsetY, unscaledWidth - offsetW, unscaledHeight);
                    break;
                }
                case InfoPlacement.LOWERRIGHT:
                {
                    this.drawLowerRight(unscaledWidth, unscaledHeight, 0, upperRight, lowerLeft, lowerRight, 0 + offsetW, 0, -offsetX, -offsetY, 0, 0 + offsetW);
                    break;
                }
                case InfoPlacement.LOWERLEFT:
                {
                    this.drawLowerLeft(unscaledWidth, unscaledHeight, upperLeft, 0, lowerLeft, lowerRight, unscaledWidth - offsetW, 0, unscaledWidth + offsetX, -offsetY, unscaledWidth, 0 + offsetW);
                    break;
                }
                case InfoPlacement.RIGHT:
                {
                    this.drawRight(unscaledWidth, unscaledHeight, upperLeft, upperRight, lowerLeft, lowerRight, 0, unscaledHeight / 2 - offsetW, -offsetX, unscaledHeight / 2, 0, unscaledHeight / 2 + offsetW);
                    break;
                }
                case InfoPlacement.LEFT:
                {
                    this.drawLeft(unscaledWidth, unscaledHeight, upperLeft, upperRight, lowerLeft, lowerRight, unscaledWidth, unscaledHeight / 2 - offsetW, unscaledWidth + offsetX, unscaledHeight / 2, unscaledWidth, unscaledHeight / 2 + offsetW);
                    break;
                }
                case InfoPlacement.BOTTOM:
                {
                    this.drawButtom(unscaledWidth, unscaledHeight, upperLeft, upperRight, lowerLeft, lowerRight, unscaledWidth / 2 - offsetW, 0, unscaledWidth / 2, -offsetY, unscaledWidth / 2 + offsetW, 0);
                    break;
                }
                case InfoPlacement.TOP:
                {
                    this.drawTop(unscaledWidth, unscaledHeight, upperLeft, upperRight, lowerLeft, lowerRight, unscaledWidth / 2 - offsetW, unscaledHeight, unscaledWidth / 2, unscaledHeight + offsetY, unscaledWidth / 2 + offsetW, unscaledHeight);
                    break;
                }
                case InfoPlacement.CENTER:
                {
                    this.drawRectBorder(unscaledWidth, unscaledHeight, upperLeft, lowerLeft, upperRight, lowerRight);
                    break;
                }
                default:
                {
                    this.drawUpperRight(unscaledWidth, unscaledHeight, upperLeft, upperRight, 0, lowerRight, 0, unscaledHeight - offsetW, -offsetX, unscaledHeight + offsetY, 0 + offsetW, unscaledHeight);
                    break;
                }
            }
            this.setFilters();
        }

        protected function setFilters():void
        {
            var shadowAngle:Number = NaN;
            var shadowColor:Number = NaN;
            var shadowAlpha:Number = NaN;
            var shadowDistance:Number = getStyle("shadowDistance");
            if (shadowDistance > 0)
            {
                shadowAngle = getStyle("shadowAngle");
                shadowColor = getStyle("shadowColor");
                shadowAlpha = getStyle("shadowAlpha");
                filters = [new DropShadowFilter(shadowDistance, shadowAngle, shadowColor, shadowAlpha)];
            }
			filters = [new DropShadowFilter(shadowDistance, shadowAngle, shadowColor, shadowAlpha)];
        }

        private function get infoPlacement():String
        {
            var borderPlacement:String = getStyle(InfoContainer.BORDER_PLACEMENT);
            if (borderPlacement)
            {
                return borderPlacement;
            }
            var infoPlacement:String= getStyle(InfoContainer.INFO_PLACEMENT);
            if (infoPlacement)
            {
                return infoPlacement;
            }
            return InfoPlacement.UPPERRIGHT;
        }

        private function beginFillLineStyle():void
        {
            graphics.beginFill(getStyle("backgroundColor"), getStyle("backgroundAlpha"));
            var borderThickness:Number = getStyle("borderThickness");
            if (borderThickness > 0)
            {
                graphics.lineStyle(borderThickness, getStyle("borderColor"), getStyle("borderAlpha"), true, LineScaleMode.NORMAL, null, JointStyle.ROUND);
            }
        }

        private function drawTop(width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number):void
        {
            graphics.clear();
            this.beginFillLineStyle();
            graphics.moveTo(cx, cy);
            graphics.lineTo(bx, by);
            graphics.lineTo(ax, ay);
            this.drawBottomLeftCorner(width, height, bottomLeftRadius);
            this.drawTopLeftCorner(width, width, topLeftRadius);
            this.drawTopRightCorner(width, height, topRightRadius);
            this.drawBottomRightCorner(width, height, bottomRightRadius);
            graphics.lineTo(cx, cy);
            graphics.endFill();
        }

        private function drawButtom(width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number) : void
        {
            graphics.clear();
            this.beginFillLineStyle();
            graphics.moveTo(ax, ay);
            graphics.lineTo(bx, by);
            graphics.lineTo(cx, cy);
            this.drawTopRightCorner(width, height, topRightRadius);
            this.drawBottomRightCorner(width, height, bottomRightRadius);
            this.drawBottomLeftCorner(width, height, bottomLeftRadius);
            this.drawTopLeftCorner(width, width, topLeftRadius);
            graphics.lineTo(ax, ay);
            graphics.endFill();
        }

        private function drawLeft(width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number):void
        {
            graphics.clear();
            this.beginFillLineStyle();
            graphics.moveTo(ax, ay);
            graphics.lineTo(bx, by);
            graphics.lineTo(cx, cy);
            this.drawBottomRightCorner(width, height, bottomRightRadius);
            this.drawBottomLeftCorner(width, height, bottomLeftRadius);
            this.drawTopLeftCorner(width, width, topLeftRadius);
            this.drawTopRightCorner(width, height, topRightRadius);
            graphics.lineTo(ax, ay);
            graphics.endFill();
            return;
        }

        private function drawRight(width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number):void
        {
            graphics.clear();
            this.beginFillLineStyle();
            graphics.moveTo(cx, cy);
            graphics.lineTo(bx, by);
            graphics.lineTo(ax, ay);
            this.drawTopLeftCorner(width, width, topLeftRadius);
            this.drawTopRightCorner(width, height, topRightRadius);
            this.drawBottomRightCorner(width, height, bottomRightRadius);
            this.drawBottomLeftCorner(width, height, bottomLeftRadius);
            graphics.lineTo(cx, cy);
            graphics.endFill();
            return;
        }

        private function drawRectBorder(unscaledWidth:Number, unscaledHeight:Number, r1:Number, r2:Number, r3:Number, r4:Number):void
        {
            graphics.clear();
            this.beginFillLineStyle();
            graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, r1, r2, r3, r4);
            graphics.endFill();
        }

        private function drawUpperLeft(width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number):void
        {
            graphics.clear();
            this.beginFillLineStyle();
            graphics.moveTo(ax, ay);
            graphics.lineTo(bx, by);
            graphics.lineTo(cx, cy);
            this.drawBottomLeftCorner(width, height, bottomLeftRadius);
            this.drawTopLeftCorner(width, height, topLeftRadius);
            this.drawTopRightCorner(width, height, topRightRadius);
            graphics.lineTo(ax, ay);
            graphics.endFill();
        }

        private function drawUpperRight(width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number):void
        {
            graphics.clear();
            this.beginFillLineStyle();
            graphics.moveTo(cx, cy);
            graphics.lineTo(bx, by);
            graphics.lineTo(ax, ay);
            this.drawTopLeftCorner(width, height, topLeftRadius);
            this.drawTopRightCorner(width, height, topRightRadius);
            this.drawBottomRightCorner(width, height, bottomRightRadius);
            graphics.lineTo(cx, cy);
            graphics.endFill();
        }

        private function drawLowerLeft(width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number):void
        {
            graphics.clear();
            this.beginFillLineStyle();
            graphics.moveTo(ax, ay);
            graphics.lineTo(bx, by);
            graphics.lineTo(cx, cy);
            this.drawBottomRightCorner(width, height, bottomRightRadius);
            this.drawBottomLeftCorner(width, height, bottomLeftRadius);
            this.drawTopLeftCorner(width, height, topLeftRadius);
            graphics.lineTo(ax, ay);
            graphics.endFill();
        }

        private function drawLowerRight(width:Number, height:Number, topLeftRadius:Number, topRightRadius:Number, bottomLeftRadius:Number, bottomRightRadius:Number, ax:Number, ay:Number, bx:Number, by:Number, cx:Number, cy:Number):void
        {
            graphics.clear();
            this.beginFillLineStyle();
            graphics.moveTo(cx, cy);
            graphics.lineTo(bx, by);
            graphics.lineTo(ax, ay);
            this.drawTopRightCorner(width, height, topRightRadius);
            this.drawBottomRightCorner(width, height, bottomRightRadius);
            this.drawBottomLeftCorner(width, height, bottomLeftRadius);
            graphics.lineTo(cx, cy);
            graphics.endFill();
        }

        private function drawTopLeftCorner(width:Number, height:Number, radius:Number):void
        {
            var controlPointDetaY:Number = radius * 0.292893;
            var controlPointDetaX:Number = radius * 0.585786;
            graphics.lineTo(0, 0 + radius);
            graphics.curveTo(0, controlPointDetaX, controlPointDetaY, controlPointDetaY);
            graphics.curveTo(controlPointDetaX, 0, radius, 0);
        }

        private function drawTopRightCorner(width:Number, height:Number, radius:Number):void
        {
            var controlPointDetaY:* = radius * 0.292893;
            var controlPointDetaX:* = radius * 0.585786;
            graphics.lineTo(width - radius, y);
            graphics.curveTo(width - controlPointDetaX, y, width - controlPointDetaY, y + controlPointDetaY);
            graphics.curveTo(width, y + controlPointDetaX, width, y + radius);
        }

        private function drawBottomLeftCorner(width:Number, height:Number, radius:Number):void
        {
            var controlPointDetaY:* = radius * 0.292893;
            var controlPointDetaX:* = radius * 0.585786;
            graphics.lineTo(radius, height);
            graphics.curveTo(controlPointDetaX, height, controlPointDetaY, height - controlPointDetaY);
            graphics.curveTo(0, height - controlPointDetaX, 0, height - radius);
        }

        private function drawBottomRightCorner(width:Number, height:Number, radius:Number):void
        {
            var controlPointDetaY:* = radius * 0.292893;
            var controlPointDetaX:* = radius * 0.585786;
            graphics.lineTo(width, height - radius);
            graphics.curveTo(width, height - controlPointDetaX, width - controlPointDetaY, height - controlPointDetaY);
            graphics.curveTo(width - controlPointDetaX, height, width - radius, height);
        }

    }
}
