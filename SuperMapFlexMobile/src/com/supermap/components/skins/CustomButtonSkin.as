package com.supermap.components.skins
{
	import flash.display.GradientType;
	import flash.geom.Matrix;

	import mx.utils.ColorUtil;

	import spark.skins.mobile.ButtonSkin;

	public class CustomButtonSkin extends ButtonSkin
	{
		public function CustomButtonSkin()
		{
			super();
		}

		private static var _colorMatrix:Matrix = new Matrix();

		private static function get colorMatrix():Matrix
		{
			if (!_colorMatrix)
				_colorMatrix = new Matrix();

			return _colorMatrix;
		}

		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.drawBackground(unscaledWidth, unscaledHeight);

			var chromeColor:uint = 0x5380ab;

			if (currentState == "down")
			{
				graphics.beginFill(chromeColor);
			}
			else
			{
				var colors:Array = [];
				colorMatrix.createGradientBox(unscaledWidth, unscaledHeight, Math.PI / 2, 0, 0);
				colors[0] = 0xb0caed;
				colors[1] = 0x688bb5;
				colors[2] = 0x597EAA;
				colors[3] = 0x597EAA;
				colors[4] = 0x5380ab;

				graphics.beginGradientFill(GradientType.LINEAR, colors, [1, 1, 1, 1, 1], [0, 125, 127, 130, 255], colorMatrix);
			}

			graphics.drawRoundRect(layoutBorderSize, layoutBorderSize, unscaledWidth - (layoutBorderSize * 2), unscaledHeight - (layoutBorderSize * 2), layoutCornerEllipseSize, layoutCornerEllipseSize);
			graphics.endFill();
		}
	}
}
