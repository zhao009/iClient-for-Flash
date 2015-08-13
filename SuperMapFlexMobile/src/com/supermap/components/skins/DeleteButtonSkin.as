package com.supermap.components.skins
{
	import flash.display.GradientType;
	import flash.geom.Matrix;

	import mx.utils.ColorUtil;

	import spark.skins.mobile.ButtonSkin;

	public class DeleteButtonSkin extends ButtonSkin
	{
		public function DeleteButtonSkin()
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
				graphics.beginFill(0xb3121f);
			}
			else
			{
				var colors:Array = [];
				colorMatrix.createGradientBox(unscaledWidth, unscaledHeight, Math.PI / 2, 0, 0);
				colors[0] = 0xb3121f;
				colors[1] = 0xb3121f;

				graphics.beginGradientFill(GradientType.LINEAR, colors, [1, 1], [0, 255], colorMatrix);
			}

			graphics.drawRoundRect(layoutBorderSize, layoutBorderSize, unscaledWidth - (layoutBorderSize * 2), unscaledHeight - (layoutBorderSize * 2), layoutCornerEllipseSize, layoutCornerEllipseSize);
			graphics.endFill();
		}
	}
}
