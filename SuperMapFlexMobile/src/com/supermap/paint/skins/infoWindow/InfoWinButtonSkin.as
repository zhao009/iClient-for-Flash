package com.supermap.paint.skins.infoWindow
{
	import com.supermap.paint.skins.mobile160.Button_down;
	import com.supermap.paint.skins.mobile160.Button_up;
	
	import mx.core.DPIClassification;
	
	import spark.skins.mobile.ButtonSkin;
	
	public class InfoWinButtonSkin extends ButtonSkin
	{
		public function InfoWinButtonSkin()
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
					upBorderSkin = Button_up;
					downBorderSkin = Button_down;
					
					layoutGap = 5;
					layoutCornerEllipseSize = 10;
					layoutPaddingLeft = 10;
					layoutPaddingRight = 10;
					layoutPaddingTop = 10;
					layoutPaddingBottom = 10;
					layoutBorderSize = 1;
					measuredDefaultWidth = 32;
					measuredDefaultHeight = 43;
					
					break;
				}
			}
		}
	}
}