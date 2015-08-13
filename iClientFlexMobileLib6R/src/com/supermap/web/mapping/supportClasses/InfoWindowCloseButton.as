package com.supermap.web.mapping.supportClasses
{
    import spark.components.Button;

	/**
	 * @private 
	 * @author zyn
	 * 
	 */	
    public class InfoWindowCloseButton extends Button
    {	
        public function InfoWindowCloseButton()
        {
			this.setStyle("skinClass", InfowindowCloseButtonSkin);
        }

    }
}
