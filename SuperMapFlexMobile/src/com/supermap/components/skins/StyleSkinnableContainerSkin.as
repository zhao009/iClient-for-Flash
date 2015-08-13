package com.supermap.components.skins
{
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	import spark.skins.mobile.SkinnableContainerSkin;
	
	public class StyleSkinnableContainerSkin extends SkinnableContainerSkin
	{
		public function StyleSkinnableContainerSkin()
		{
			super();
		}
		
		override protected function drawBackground(unscaledWidth:Number, unscaledHeight:Number):void
		{
			var topLeftRadius:int = 0;
			var topRightRadius:int = 0;
			var bottomLeftRadius:int = 0;
			var bottomRightRadius:int = 0;
			if(!isNaN(getStyle("cornorRadius")))
			{
				topLeftRadius = topRightRadius = bottomLeftRadius = bottomRightRadius = getStyle("cornorRadius");
			}
			//边角获取
			topLeftRadius = isNaN(getStyle("topLeftRadius")) ? topLeftRadius : getStyle("topLeftRadius");
			topRightRadius = isNaN(getStyle("topRightRadius")) ? topRightRadius : getStyle("topRightRadius");
			bottomLeftRadius = isNaN(getStyle("bottomLeftRadius")) ? bottomLeftRadius : getStyle("bottomLeftRadius");
			bottomRightRadius = isNaN(getStyle("bottomRightRadius")) ? bottomRightRadius : getStyle("bottomRightRadius");
			
			//线型，边框
			if(true == getStyle("borderVisible"))
			{
				var thickness:Number = isNaN(getStyle("borderWeight")) ? 1 : getStyle("borderWeight");
				var color:Number = isNaN(getStyle("borderColor")) ? 0x000000 : getStyle("borderColor");
				var alpha:Number = isNaN(getStyle("borderAlpha")) ? 1 : getStyle("borderAlpha");
				graphics.lineStyle(thickness, color, alpha);
			}
				
			//填充
//			if(true == getStyle("borderVisible"));
			var fillcolors:Array = [];
			if( !isNaN(getStyle("firstBackColor")))
			{
				fillcolors.push(getStyle("firstBackColor"));
			}
			if(!isNaN(getStyle("secondBackColor")))
			{
				fillcolors.push(getStyle("secondBackColor"));
			}
			if(fillcolors.length < 2)
			{
				if(fillcolors.length == 1)
				{
					fillcolors.push(fillcolors[0]);
				}
				if(fillcolors.length == 0)
				{
					if(true != getStyle("borderVisible"))
						return;
					else
						fillcolors = [0xFFFFFF, 0xFFFFFF];
				}
			}
			
			var fillalphas:Array = [];
			if(!isNaN(getStyle("firstBackAlpha")))
			{
				fillalphas.push(getStyle("firstBackAlpha"));
			}
			else
				fillalphas.push(1);
			if(!isNaN(getStyle("secondBackAlpha")))
			{
				fillalphas.push(getStyle("secondBackAlpha"));
			}
			else
				fillalphas.push(1);
			
			var matrix:Matrix = new Matrix;
			matrix.createGradientBox(unscaledWidth,unscaledHeight, Math.PI/2 ,0,0);
			graphics.beginGradientFill(GradientType.LINEAR, fillcolors, fillalphas, [0,255],matrix);
			graphics.drawRoundRectComplex(0, 0, unscaledWidth, unscaledHeight, topLeftRadius, topRightRadius, bottomLeftRadius, bottomRightRadius);
			graphics.endFill();

		}
	}
}