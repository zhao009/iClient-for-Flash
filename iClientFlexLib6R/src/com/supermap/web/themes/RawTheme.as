package com.supermap.web.themes
{
	import com.supermap.web.sm_internal;

	use namespace sm_internal;
	
	/*
	 * RawTheme主题风格类,在使用时对map的theme属性进行设置.原则上,如果map的theme属性不为空,则设置为本主题的风格,反之,设置为以前的风格.
	 * 目前涉及范围为所有的action类,FeatureDataGrid中用到的颜色值的设置
	 */
	/**
	 * ${themes_RawTheme_Title}.
	 * <p>${themes_RawTheme_Description}</p> 
	 * 
	 */	
	public class RawTheme extends Theme
	{   
		/**
		 * ${themes_RawTheme_constructor_D} 
		 * 
		 */		
		public function RawTheme()
		{  
			super();   
			/*fillColor = 0x4272d7;
			lineColor = 0x5082e5;
			weight = 2;
			alpha = 1;
			fillAlpha = 0.156;
			pointColor = 0x4272d7;
			size = 12; 
			hlPointColor = 0xc2c2c2;
			hlLineColor = 0xff0000;
			hlFillColor = 0xeaeef0;
			snapColor = 0x2f61b2; */
	 	}
        
	}
}

 
