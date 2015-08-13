package com.supermap.components.skins
{
	import com.supermap.components.skins.mobile160.Button_down_content;
	import com.supermap.components.skins.mobile160.Button_up_content;
	
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	import mx.core.DPIClassification;
	import mx.utils.ColorUtil;
	
	import spark.skins.mobile.ButtonSkin;
	

	public class ContentButtonSkin extends ButtonSkin
	{
		public function ContentButtonSkin()
		{
			super();
			switch (applicationDPI)
			{
				case DPIClassification.DPI_320:
				{
					break;
				}
				case DPIClassification.DPI_240:
				{
					break;
				}
				default:
				{
					// default DPI_160
					upBorderSkin = Button_up_content;
					downBorderSkin = Button_down_content;
					
					layoutGap = 5;
					layoutCornerEllipseSize = 10;
					layoutPaddingLeft = 6;
					layoutPaddingRight = 6;
					layoutPaddingTop = 3;
					layoutPaddingBottom = 3;
					layoutBorderSize = 1;
					measuredDefaultWidth = 32;
					measuredDefaultHeight = 32;
					
					break;
				}
			}
		}

		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
		}
	}
}
