package com.supermap.maps.skins
{
	import com.supermap.maps.skins.mobile160.Button_down_in;
	import com.supermap.maps.skins.mobile160.Button_up_in;
	
	import mx.core.DPIClassification;
	
	import spark.skins.mobile.ButtonSkin;
	import spark.skins.mobile240.assets.Button_down;
	import spark.skins.mobile240.assets.Button_up;
	import spark.skins.mobile320.assets.Button_down;
	import spark.skins.mobile320.assets.Button_up;
	
	public class EnterIntoButtonSkin extends ButtonSkin
	{
		public function EnterIntoButtonSkin()
		{
			super();
			switch (applicationDPI)
			{
				case DPIClassification.DPI_320:
				{
					upBorderSkin = spark.skins.mobile320.assets.Button_up;
					downBorderSkin = spark.skins.mobile320.assets.Button_down;
					
					layoutGap = 10;
					layoutCornerEllipseSize = 20;
					layoutPaddingLeft = 20;
					layoutPaddingRight = 20;
					layoutPaddingTop = 20;
					layoutPaddingBottom = 20;
					layoutBorderSize = 2;
					measuredDefaultWidth = 64;
					measuredDefaultHeight = 86;
					
					break;
				}
				case DPIClassification.DPI_240:
				{
					upBorderSkin = spark.skins.mobile240.assets.Button_up;
					downBorderSkin = spark.skins.mobile240.assets.Button_down;
					
					layoutGap = 7;
					layoutCornerEllipseSize = 15;
					layoutPaddingLeft = 15;
					layoutPaddingRight = 15;
					layoutPaddingTop = 15;
					layoutPaddingBottom = 15;
					layoutBorderSize = 1;
					measuredDefaultWidth = 48;
					measuredDefaultHeight = 65;
					
					break;
				}
				default:
				{
					// default DPI_160
					upBorderSkin = com.supermap.maps.skins.mobile160.Button_up_in;
					downBorderSkin = com.supermap.maps.skins.mobile160.Button_down_in;
					
					layoutGap = 5;
					layoutCornerEllipseSize = 10;
					layoutPaddingLeft = 13;
					layoutPaddingRight = 18;
					layoutPaddingTop = 10;
					layoutPaddingBottom = 10;
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